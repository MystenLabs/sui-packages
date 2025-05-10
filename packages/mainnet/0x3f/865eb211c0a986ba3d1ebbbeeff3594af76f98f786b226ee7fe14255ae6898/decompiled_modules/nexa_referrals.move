module 0x3f865eb211c0a986ba3d1ebbbeeff3594af76f98f786b226ee7fe14255ae6898::nexa_referrals {
    struct ReferralsMap has store, key {
        id: 0x2::object::UID,
        referrer: 0x2::table::Table<address, address>,
    }

    struct NexaReferralAddedEvent has copy, drop {
        referrer: address,
        referee: address,
    }

    public fun get_referrer(arg0: &ReferralsMap, arg1: address) : address {
        if (!0x2::table::contains<address, address>(&arg0.referrer, arg1)) {
            @0x0
        } else {
            *0x2::table::borrow<address, address>(&arg0.referrer, arg1)
        }
    }

    public fun initialize_referrals_map(arg0: &0x3f865eb211c0a986ba3d1ebbbeeff3594af76f98f786b226ee7fe14255ae6898::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralsMap{
            id       : 0x2::object::new(arg1),
            referrer : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::public_share_object<ReferralsMap>(v0);
    }

    public fun set_referrer(arg0: &mut ReferralsMap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 0);
        assert!(!0x2::table::contains<address, address>(&arg0.referrer, v0), 1);
        0x2::table::add<address, address>(&mut arg0.referrer, v0, arg1);
        let v1 = NexaReferralAddedEvent{
            referrer : arg1,
            referee  : v0,
        };
        0x2::event::emit<NexaReferralAddedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

