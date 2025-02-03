module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation {
    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        obligation: 0x2::object::ID,
        obligation_key: 0x2::object::ID,
    }

    public fun open_obligation(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0x2::tx_context::TxContext) : (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ObligationHotPotato) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationHotPotato{obligation_id: 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(&v3)};
        let v5 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v5);
        (v3, v2, v4)
    }

    public entry fun open_obligation_entry(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v4);
        0x2::transfer::public_transfer<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(v3);
    }

    public fun return_obligation(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: ObligationHotPotato) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        let ObligationHotPotato { obligation_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(&arg1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::invalid_obligation_error());
        0x2::transfer::public_share_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1);
    }

    // decompiled from Move bytecode v6
}

