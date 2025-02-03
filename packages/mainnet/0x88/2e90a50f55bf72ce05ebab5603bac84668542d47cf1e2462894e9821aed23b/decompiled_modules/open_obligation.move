module 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::open_obligation {
    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        obligation: 0x2::object::ID,
        obligation_key: 0x2::object::ID,
    }

    public fun open_obligation(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: &mut 0x2::tx_context::TxContext) : (0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::ObligationKey, ObligationHotPotato) {
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::assert_current_version(arg0);
        let (v0, v1) = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationHotPotato{obligation_id: 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(&v3)};
        let v5 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v5);
        (v3, v2, v4)
    }

    public entry fun open_obligation_entry(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::assert_current_version(arg0);
        let (v0, v1) = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v4);
        0x2::transfer::public_transfer<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::ObligationKey>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(v3);
    }

    public fun return_obligation(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation, arg2: ObligationHotPotato) {
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::assert_current_version(arg0);
        let ObligationHotPotato { obligation_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(&arg1), 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::error::invalid_obligation_error());
        0x2::transfer::public_share_object<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(arg1);
    }

    // decompiled from Move bytecode v6
}

