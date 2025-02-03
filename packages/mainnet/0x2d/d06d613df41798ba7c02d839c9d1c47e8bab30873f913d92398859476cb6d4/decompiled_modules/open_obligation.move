module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::open_obligation {
    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        obligation: 0x2::object::ID,
        obligation_key: 0x2::object::ID,
    }

    public fun open_obligation(arg0: &mut 0x2::tx_context::TxContext) : (0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::ObligationKey, ObligationHotPotato) {
        let (v0, v1) = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationHotPotato{obligation_id: 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(&v3)};
        let v5 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg0),
            obligation     : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v5);
        (v3, v2, v4)
    }

    public entry fun open_obligation_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg0),
            obligation     : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v4);
        0x2::transfer::public_transfer<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::ObligationKey>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(v3);
    }

    public fun return_obligation(arg0: 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, arg1: ObligationHotPotato) {
        let ObligationHotPotato { obligation_id: v0 } = arg1;
        assert!(v0 == 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(&arg0), 327681);
        0x2::transfer::public_share_object<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(arg0);
    }

    // decompiled from Move bytecode v6
}

