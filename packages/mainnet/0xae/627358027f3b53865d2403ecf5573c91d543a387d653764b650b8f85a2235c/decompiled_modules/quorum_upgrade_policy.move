module 0xae627358027f3b53865d2403ecf5573c91d543a387d653764b650b8f85a2235c::quorum_upgrade_policy {
    struct QuorumUpgradeCap has store, key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
        required_votes: u64,
        voters: 0x2::vec_set::VecSet<address>,
        voter_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct VotingCap has key {
        id: 0x2::object::UID,
        owner: address,
        upgrade_cap: 0x2::object::ID,
        transfers_count: u64,
        votes_issued: u64,
    }

    struct ProposedUpgrade has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::object::ID,
        proposer: address,
        digest: vector<u8>,
        current_voters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct UpgradeProposed has copy, drop {
        upgrade_cap: 0x2::object::ID,
        proposal: 0x2::object::ID,
        digest: vector<u8>,
        proposer: address,
        voters: 0x2::vec_set::VecSet<address>,
    }

    struct UpgradeVoted has copy, drop {
        proposal: 0x2::object::ID,
        digest: vector<u8>,
        voter: 0x2::object::ID,
        signer: address,
    }

    struct UpgradePerformed has copy, drop {
        upgrade_cap: 0x2::object::ID,
        proposal: 0x2::object::ID,
        digest: vector<u8>,
        proposer: address,
    }

    struct UpgradeDestroyed has copy, drop {
        upgrade_cap: 0x2::object::ID,
        proposal: 0x2::object::ID,
        digest: vector<u8>,
        proposer: address,
    }

    public fun new(arg0: 0x2::package::UpgradeCap, arg1: u64, arg2: 0x2::vec_set::VecSet<address>, arg3: &mut 0x2::tx_context::TxContext) : QuorumUpgradeCap {
        assert!(0x2::vec_set::size<address>(&arg2) > 0, 0);
        assert!(0x2::vec_set::size<address>(&arg2) <= 100, 0);
        assert!(arg1 > 0, 1);
        assert!(arg1 <= 0x2::vec_set::size<address>(&arg2), 1);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        let v2 = 0x2::vec_set::keys<address>(&arg2);
        let v3 = 0x1::vector::length<address>(v2);
        while (v3 > 0) {
            v3 = v3 - 1;
            let v4 = *0x1::vector::borrow<address>(v2, v3);
            let v5 = 0x2::object::new(arg3);
            let v6 = VotingCap{
                id              : v5,
                owner           : v4,
                upgrade_cap     : 0x2::object::uid_to_inner(&v0),
                transfers_count : 0,
                votes_issued    : 0,
            };
            0x2::transfer::transfer<VotingCap>(v6, v4);
            0x2::vec_set::insert<0x2::object::ID>(&mut v1, 0x2::object::uid_to_inner(&v5));
        };
        QuorumUpgradeCap{
            id             : v0,
            upgrade_cap    : arg0,
            required_votes : arg1,
            voters         : arg2,
            voter_caps     : v1,
        }
    }

    public fun authorize_upgrade(arg0: &mut QuorumUpgradeCap, arg1: &mut ProposedUpgrade, arg2: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert!(arg1.upgrade_cap == 0x2::object::id<QuorumUpgradeCap>(arg0), 7);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg1.current_voters) >= arg0.required_votes, 5);
        assert!(arg1.proposer != @0x0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.proposer == v0, 6);
        arg1.proposer = @0x0;
        let v1 = UpgradePerformed{
            upgrade_cap : arg1.upgrade_cap,
            proposal    : 0x2::object::id<ProposedUpgrade>(arg1),
            digest      : arg1.digest,
            proposer    : v0,
        };
        0x2::event::emit<UpgradePerformed>(v1);
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, 0x2::package::upgrade_policy(&arg0.upgrade_cap), arg1.digest)
    }

    public fun commit_upgrade(arg0: &mut QuorumUpgradeCap, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg1);
    }

    public fun current_voters(arg0: &ProposedUpgrade) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.current_voters
    }

    public fun destroy_proposed_upgrade(arg0: ProposedUpgrade, arg1: &0x2::tx_context::TxContext) {
        let ProposedUpgrade {
            id             : v0,
            upgrade_cap    : v1,
            proposer       : v2,
            digest         : v3,
            current_voters : _,
        } = arg0;
        assert!(v2 == 0x2::tx_context::sender(arg1), 6);
        let v5 = UpgradeDestroyed{
            upgrade_cap : v1,
            proposal    : 0x2::object::id<ProposedUpgrade>(&arg0),
            digest      : v3,
            proposer    : v2,
        };
        0x2::event::emit<UpgradeDestroyed>(v5);
        0x2::object::delete(v0);
    }

    public fun digest(arg0: &ProposedUpgrade) : &vector<u8> {
        &arg0.digest
    }

    public fun proposal_for(arg0: &ProposedUpgrade) : 0x2::object::ID {
        arg0.upgrade_cap
    }

    public fun propose_upgrade(arg0: &QuorumUpgradeCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<QuorumUpgradeCap>(arg0);
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = UpgradeProposed{
            upgrade_cap : v0,
            proposal    : 0x2::object::uid_to_inner(&v1),
            digest      : arg1,
            proposer    : v2,
            voters      : arg0.voters,
        };
        0x2::event::emit<UpgradeProposed>(v3);
        let v4 = ProposedUpgrade{
            id             : v1,
            upgrade_cap    : v0,
            proposer       : v2,
            digest         : arg1,
            current_voters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ProposedUpgrade>(v4);
    }

    public fun proposer(arg0: &ProposedUpgrade) : address {
        arg0.proposer
    }

    public fun required_votes(arg0: &QuorumUpgradeCap) : u64 {
        arg0.required_votes
    }

    public fun upgrade_cap(arg0: &QuorumUpgradeCap) : &0x2::package::UpgradeCap {
        &arg0.upgrade_cap
    }

    public fun vote(arg0: &mut ProposedUpgrade, arg1: &mut VotingCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.proposer != @0x0, 2);
        assert!(arg0.upgrade_cap == arg1.upgrade_cap, 3);
        let v0 = 0x2::object::id<VotingCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.current_voters, &v0), 4);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.current_voters, v0);
        arg1.votes_issued = arg1.votes_issued + 1;
        let v1 = UpgradeVoted{
            proposal : 0x2::object::id<ProposedUpgrade>(arg0),
            digest   : arg0.digest,
            voter    : v0,
            signer   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UpgradeVoted>(v1);
    }

    public fun voters(arg0: &QuorumUpgradeCap) : &0x2::vec_set::VecSet<address> {
        &arg0.voters
    }

    // decompiled from Move bytecode v6
}

