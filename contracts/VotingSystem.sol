// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingSystem {
    struct Proposal {
        string description;
        uint256 votes;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;

    function createProposal(string memory _desc) external {
        proposals.push(Proposal({
            description: _desc,
            votes: 0
        }));
    }

    function vote(uint256 proposalId) external {
        require(!hasVoted[msg.sender], "Already voted");
        require(proposalId < proposals.length, "Invalid ID");

        proposals[proposalId].votes += 1;
        hasVoted[msg.sender] = true;
    }

    function getProposals() external view returns (Proposal[] memory) {
        return proposals;
    }
}
