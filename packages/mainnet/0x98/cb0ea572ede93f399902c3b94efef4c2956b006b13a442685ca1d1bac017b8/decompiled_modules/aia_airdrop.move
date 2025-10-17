module 0x98cb0ea572ede93f399902c3b94efef4c2956b006b13a442685ca1d1bac017b8::aia_airdrop {
    struct DevAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        coins_treasury: 0x2::balance::Balance<T0>,
        start_time: u64,
        activated: bool,
    }

    struct AdminEvent has copy, drop {
        admin: address,
        action: 0x1::string::String,
        coin_type: 0x1::string::String,
    }

    public fun activate_vault<T0>(arg0: &DevAdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.activated = true;
        let v0 = AdminEvent{
            admin     : 0x2::tx_context::sender(arg2),
            action    : 0x1::string::utf8(b"activate_vault"),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun admin_deposit_tokens<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coins_treasury, 0x2::coin::into_balance<T0>(arg1));
        let v0 = AdminEvent{
            admin     : 0x2::tx_context::sender(arg2),
            action    : 0x1::string::utf8(b"admin_deposit_tokens"),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun airdrop<T0>(arg0: &DevAdminCap, arg1: &mut Vault<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.activated, 1001);
        assert!(now_seconds(arg4) >= arg1.start_time, 1002);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 1004);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::balance::value<T0>(&arg1.coins_treasury) >= v2, 1003);
        let v3 = 0;
        while (v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coins_treasury, *0x1::vector::borrow<u64>(&arg3, v3), arg5), *0x1::vector::borrow<address>(&arg2, v3));
            v3 = v3 + 1;
        };
        let v4 = AdminEvent{
            admin     : 0x2::tx_context::sender(arg5),
            action    : 0x1::string::utf8(b"airdrop"),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<AdminEvent>(v4);
    }

    public fun create_vault<T0>(arg0: &DevAdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id             : 0x2::object::new(arg2),
            coins_treasury : 0x2::balance::zero<T0>(),
            start_time     : arg1,
            activated      : false,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
        let v1 = AdminEvent{
            admin     : 0x2::tx_context::sender(arg2),
            action    : 0x1::string::utf8(b"create_vault"),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<AdminEvent>(v1);
    }

    public fun disable_vault<T0>(arg0: &DevAdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.activated = false;
        let v0 = AdminEvent{
            admin     : 0x2::tx_context::sender(arg2),
            action    : 0x1::string::utf8(b"disable_vault"),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun get_vault_info<T0>(arg0: &mut Vault<T0>) : (u64, u64, bool) {
        (0x2::balance::value<T0>(&arg0.coins_treasury), arg0.start_time, arg0.activated)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DevAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DevAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

