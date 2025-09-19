module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade {
    struct QuorumUpgrade has store, key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
        required_votes: u64,
        voters: 0x2::vec_set::VecSet<address>,
        proposals: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    public fun new(arg0: 0x2::package::UpgradeCap, arg1: u64, arg2: 0x2::vec_set::VecSet<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13906834337552138241);
        assert!(0x2::vec_set::length<address>(&arg2) >= arg1, 13906834341847236611);
        let v0 = QuorumUpgrade{
            id             : 0x2::object::new(arg3),
            upgrade_cap    : arg0,
            required_votes : arg1,
            voters         : arg2,
            proposals      : 0x2::table_vec::empty<0x2::object::ID>(arg3),
        };
        0x2::transfer::share_object<QuorumUpgrade>(v0);
    }

    public(friend) fun authorize_upgrade(arg0: &mut QuorumUpgrade, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, 0x2::package::upgrade_policy(&arg0.upgrade_cap), arg1)
    }

    public fun commit_upgrade(arg0: &mut QuorumUpgrade, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg1);
    }

    public(friend) fun add_voter(arg0: &mut QuorumUpgrade, arg1: address) {
        0x2::vec_set::insert<address>(&mut arg0.voters, arg1);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_voter_added_event(0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    public(friend) fun relinquish_quorum(arg0: QuorumUpgrade, arg1: address) {
        let QuorumUpgrade {
            id             : v0,
            upgrade_cap    : v1,
            required_votes : _,
            voters         : _,
            proposals      : v4,
        } = arg0;
        let v5 = v0;
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_quorum_relinquished_event(0x2::object::uid_to_inner(&v5));
        0x2::object::delete(v5);
        0x2::table_vec::drop<0x2::object::ID>(v4);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v1, arg1);
    }

    public(friend) fun remove_voter(arg0: &mut QuorumUpgrade, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.voters, &arg1);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_voter_removed_event(0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    public fun replace_self(arg0: &mut QuorumUpgrade, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        replace_voter(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public(friend) fun replace_voter(arg0: &mut QuorumUpgrade, arg1: address, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.voters, &arg1), 13906834526530961413);
        assert!(!0x2::vec_set::contains<address>(&arg0.voters, &arg2), 13906834530826059783);
        0x2::vec_set::remove<address>(&mut arg0.voters, &arg1);
        0x2::vec_set::insert<address>(&mut arg0.voters, arg2);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_voter_replaced_event(0x2::object::uid_to_inner(&arg0.id), arg1, arg2);
    }

    public fun required_votes(arg0: &QuorumUpgrade) : u64 {
        arg0.required_votes
    }

    public(friend) fun update_threshold(arg0: &mut QuorumUpgrade, arg1: u64) {
        arg0.required_votes = arg1;
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events::emit_threshold_updated_event(0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    public fun voters(arg0: &QuorumUpgrade) : &0x2::vec_set::VecSet<address> {
        &arg0.voters
    }

    // decompiled from Move bytecode v6
}

