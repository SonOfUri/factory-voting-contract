// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Factory contract to create new VotingPoll instances
contract VotingPollFactory {
    // Array to store addresses of all created polls
    address[] public polls;

    // Function to create a new VotingPoll instance
    function createVotingPoll(string memory _question, string[] memory _options) public {
        // Create a new VotingPoll instance and store its address
        address newPoll = address(new VotingPoll(_question, _options, msg.sender));
        polls.push(newPoll); // Add the new poll address to the polls array
    }

    // Function to get all created poll addresses
    function getPolls() public view returns (address[] memory) {
        return polls; // Return the array of poll addresses
    }
}

// Contract to handle a single voting poll
contract VotingPoll {
    // Struct to represent a voter
    struct Voter {
        bool voted; // Flag to indicate if the voter has voted
        uint256 voteIndex; // Index of the option the voter voted for
    }

    // Struct to represent an option in the poll
    struct Option {
        string name; // Name of the option
        uint256 voteCount; // Number of votes received for the option
    }

    address public owner; // Address of the poll creator
    string public question; // Question of the poll
    Option[] public options; // Array of options in the poll
    mapping(address => Voter) public voters; // Mapping of address to Voter struct

    // Constructor to initialize the poll with question, options, and owner
    constructor(string memory _question, string[] memory _options, address _owner) {
        owner = _owner; // Set the owner of the poll
        question = _question; // Set the question of the poll
        // Initialize options array with options and zero vote counts
        for (uint256 i = 0; i < _options.length; i++) {
            options.push(Option({
                name: _options[i],
                voteCount: 0
            }));
        }
    }

    // Function for a user to vote for an option
    function vote(uint256 _optionIndex) public {
        // Check if the user has already voted
        require(!voters[msg.sender].voted, "You have already voted.");
        // Check if the option index is valid
        require(_optionIndex < options.length, "Invalid option index.");

        // Mark the user as voted and record the vote index
        voters[msg.sender].voted = true;
        voters[msg.sender].voteIndex = _optionIndex;
        // Increment the vote count for the selected option
        options[_optionIndex].voteCount++;
    }

    // Function to get the current vote counts for all options
    function getResults() public view returns (Option[] memory) {
        return options; // Return the array of options with their respective vote counts
    }
}
