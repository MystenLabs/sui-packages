module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::open_obligation {
    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct ObligationCreatedEvent has copy, drop {
        sender: address,
        obligation: 0x2::object::ID,
        obligation_key: 0x2::object::ID,
    }

    public fun open_obligation(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version::Version, arg1: &mut 0x2::tx_context::TxContext) : (0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::ObligationKey, ObligationHotPotato) {
        0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version::assert_current_version(arg0);
        let (v0, v1) = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationHotPotato{obligation_id: 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation>(&v3)};
        let v5 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v5);
        (v3, v2, v4)
    }

    public entry fun open_obligation_entry(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version::assert_current_version(arg0);
        let (v0, v1) = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ObligationCreatedEvent{
            sender         : 0x2::tx_context::sender(arg1),
            obligation     : 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation>(&v3),
            obligation_key : 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::ObligationKey>(&v2),
        };
        0x2::event::emit<ObligationCreatedEvent>(v4);
        0x2::transfer::public_transfer<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::ObligationKey>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation>(v3);
    }

    public fun return_obligation(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version::Version, arg1: 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg2: ObligationHotPotato) {
        0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version::assert_current_version(arg0);
        let ObligationHotPotato { obligation_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation>(&arg1), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::error::invalid_obligation_error());
        0x2::transfer::public_share_object<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation>(arg1);
    }

    // decompiled from Move bytecode v6
}

