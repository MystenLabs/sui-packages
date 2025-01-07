module 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role {
    struct TwoStepRole<phantom T0> has store {
        active_address: address,
        pending_address: 0x1::option::Option<address>,
    }

    struct RoleTransferStarted<phantom T0> has copy, drop {
        old_address: address,
        new_address: address,
    }

    struct RoleTransferred<phantom T0> has copy, drop {
        old_address: address,
        new_address: address,
    }

    public fun accept_role<T0>(arg0: &mut TwoStepRole<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_address), 1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::contains<address>(&arg0.pending_address, &v0), 2);
        arg0.active_address = 0x1::option::extract<address>(&mut arg0.pending_address);
        let v1 = RoleTransferred<T0>{
            old_address : arg0.active_address,
            new_address : arg0.active_address,
        };
        0x2::event::emit<RoleTransferred<T0>>(v1);
    }

    public fun active_address<T0>(arg0: &TwoStepRole<T0>) : address {
        arg0.active_address
    }

    public fun assert_sender_is_active_role<T0>(arg0: &TwoStepRole<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.active_address == 0x2::tx_context::sender(arg1), 0);
    }

    public fun begin_role_transfer<T0>(arg0: &mut TwoStepRole<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_sender_is_active_role<T0>(arg0, arg2);
        arg0.pending_address = 0x1::option::some<address>(arg1);
        let v0 = RoleTransferStarted<T0>{
            old_address : arg0.active_address,
            new_address : arg1,
        };
        0x2::event::emit<RoleTransferStarted<T0>>(v0);
    }

    public fun destroy<T0>(arg0: TwoStepRole<T0>) {
        let TwoStepRole {
            active_address  : _,
            pending_address : _,
        } = arg0;
    }

    public fun new<T0: drop>(arg0: T0, arg1: address) : TwoStepRole<T0> {
        TwoStepRole<T0>{
            active_address  : arg1,
            pending_address : 0x1::option::none<address>(),
        }
    }

    public fun pending_address<T0>(arg0: &TwoStepRole<T0>) : 0x1::option::Option<address> {
        arg0.pending_address
    }

    // decompiled from Move bytecode v6
}

