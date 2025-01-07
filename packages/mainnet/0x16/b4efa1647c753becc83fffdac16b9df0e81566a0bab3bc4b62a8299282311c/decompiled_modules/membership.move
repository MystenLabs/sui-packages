module 0x16b4efa1647c753becc83fffdac16b9df0e81566a0bab3bc4b62a8299282311c::membership {
    struct MembershipCard has key {
        id: 0x2::object::UID,
        point: u64,
        last_added_at: u64,
    }

    struct PointAdded has copy, drop {
        card_id: 0x2::object::ID,
    }

    public fun increment_point(arg0: &mut MembershipCard, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.last_added_at < 0x2::tx_context::epoch(arg1), 1);
        let v0 = PointAdded{card_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<PointAdded>(v0);
        arg0.point = arg0.point + 1;
        arg0.last_added_at = 0x2::tx_context::epoch(arg1);
    }

    public fun last_added_at(arg0: &MembershipCard) : u64 {
        arg0.last_added_at
    }

    public fun new_membership_card(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MembershipCard{
            id            : 0x2::object::new(arg0),
            point         : 0,
            last_added_at : 0,
        };
        let v1 = &mut v0;
        increment_point(v1, arg0);
        0x2::transfer::transfer<MembershipCard>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun point(arg0: &MembershipCard) : u64 {
        arg0.point
    }

    // decompiled from Move bytecode v6
}

