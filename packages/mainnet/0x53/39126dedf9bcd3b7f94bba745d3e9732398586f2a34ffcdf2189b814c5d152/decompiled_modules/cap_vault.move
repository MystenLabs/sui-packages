module 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::cap_vault {
    struct CAP_VAULT has drop {
        dummy_field: bool,
    }

    struct CapVault<T0: key> has store, key {
        id: 0x2::object::UID,
        admin_cap: 0x1::option::Option<T0>,
        new_owner: 0x1::option::Option<address>,
        og_owner: 0x1::option::Option<address>,
    }

    public fun claim_cap<T0: store + key>(arg0: &mut CapVault<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        assert!(0x1::option::is_some<address>(&arg0.new_owner) && *0x1::option::borrow<address>(&arg0.new_owner) == 0x2::tx_context::sender(arg1), 7000);
        0x1::option::extract<address>(&mut arg0.og_owner);
        0x1::option::extract<address>(&mut arg0.new_owner);
        0x1::option::extract<T0>(&mut arg0.admin_cap)
    }

    public fun createVault<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CapVault<T0>{
            id        : 0x2::object::new(arg0),
            admin_cap : 0x1::option::none<T0>(),
            new_owner : 0x1::option::none<address>(),
            og_owner  : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<CapVault<T0>>(v0);
    }

    fun init(arg0: CAP_VAULT, arg1: &0x2::tx_context::TxContext) {
    }

    public fun revoke_cap<T0: store + key>(arg0: &mut CapVault<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        assert!(0x1::option::is_some<address>(&arg0.og_owner) && *0x1::option::borrow<address>(&arg0.og_owner) == 0x2::tx_context::sender(arg1), 7000);
        0x1::option::extract<address>(&mut arg0.og_owner);
        0x1::option::extract<address>(&mut arg0.new_owner);
        0x1::option::extract<T0>(&mut arg0.admin_cap)
    }

    public fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x1::option::fill<T0>(&mut arg2.admin_cap, arg0);
        0x1::option::fill<address>(&mut arg2.new_owner, arg1);
        0x1::option::fill<address>(&mut arg2.og_owner, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

