// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsuranceClaims {
    struct Policy {
        address policyHolder;
        uint policyID;
        bool isActive;
        uint coverageAmount;
    }

    struct Claim {
        uint claimID;
        uint policyID;
        uint claimAmount;
        string status; // "Pending", "Approved", "Rejected"
        string reason;
    }

    mapping(uint => Policy) public policies;
    mapping(uint => Claim) public claims;

    uint public claimCounter;
    uint public policyCounter;

    // Add a new policy
    function addPolicy(
        address policyHolder,
        uint policyID,
        uint coverageAmount
    ) public {
        policies[policyID] = Policy(policyHolder, policyID, true, coverageAmount);
    }

    // Submit a new claim
    function submitClaim(uint policyID, uint claimAmount) public returns (uint) {
        require(policies[policyID].isActive, "Policy is inactive");
        claimCounter++;
        claims[claimCounter] = Claim(claimCounter, policyID, claimAmount, "Pending", "");
        return claimCounter;
    }

    // Process a claim
    function processClaim(
        uint claimID,
        bool isApproved,
        string memory reason
    ) public {
        require(claims[claimID].policyID != 0, "Claim does not exist");
        if (isApproved) {
            claims[claimID].status = "Approved";
        } else {
            claims[claimID].status = "Rejected";
            claims[claimID].reason = reason;
        }
    }
}
