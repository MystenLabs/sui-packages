module 0xbb40504003ab3645f526dd2051808f2ed4fdf3265e6dc10627732876b9a13710::membership {
    struct MembershipCard has store, key {
        id: 0x2::object::UID,
        point: u64,
        last_added_at: u64,
    }

    struct PointAdded has copy, drop {
        card_id: 0x2::object::ID,
    }

    public fun add_point(arg0: &mut MembershipCard, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PointAdded{card_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<PointAdded>(v0);
        arg0.point = arg0.point + 1;
        arg0.last_added_at = 0x2::tx_context::epoch(arg1);
    }

    public fun last_added_at(arg0: &MembershipCard) : u64 {
        arg0.last_added_at
    }

    public fun new_membership_card(arg0: &mut 0x2::tx_context::TxContext) : MembershipCard {
        MembershipCard{
            id            : 0x2::object::new(arg0),
            point         : 0,
            last_added_at : 0,
        }
    }

    public fun point(arg0: &MembershipCard) : u64 {
        arg0.point
    }

    public fun uid(arg0: &MembershipCard) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut MembershipCard) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

