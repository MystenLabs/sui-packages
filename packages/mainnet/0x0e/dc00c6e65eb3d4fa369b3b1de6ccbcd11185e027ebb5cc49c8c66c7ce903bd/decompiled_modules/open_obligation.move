module 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::open_obligation {
    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        obligation: 0x2::object::ID,
        obligation_key: 0x2::object::ID,
    }

    public fun open_obligation(arg0: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::Version, arg1: &mut 0x2::tx_context::TxContext) : (0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::ObligationKey, ObligationHotPotato) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::assert_current_version(arg0);
        let (v0, v1) = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationHotPotato{obligation_id: 0x2::object::id<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation>(&v3)};
        let v5 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v5);
        (v3, v2, v4)
    }

    public entry fun open_obligation_entry(arg0: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::assert_current_version(arg0);
        let (v0, v1) = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v4);
        0x2::transfer::public_transfer<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::ObligationKey>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation>(v3);
    }

    public fun return_obligation(arg0: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::Version, arg1: 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation, arg2: ObligationHotPotato) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::assert_current_version(arg0);
        let ObligationHotPotato { obligation_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation>(&arg1), 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::error::invalid_obligation_error());
        0x2::transfer::public_share_object<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation>(arg1);
    }

    // decompiled from Move bytecode v6
}

