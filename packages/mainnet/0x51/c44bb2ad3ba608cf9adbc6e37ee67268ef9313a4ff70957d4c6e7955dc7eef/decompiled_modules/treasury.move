module 0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        balance: 0x2::balance::Balance<T0>,
        total_collected: u64,
        total_withdrawn: u64,
        created_at: u64,
    }

    fun assert_version<T0>(arg0: &Treasury<T0>) {
        assert!(arg0.version == 1, 7);
    }

    public fun accept_admin_transfer<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 9);
        assert!(*0x1::option::borrow<address>(&arg0.pending_admin) == 0x2::tx_context::sender(arg1), 6);
        arg0.admin = 0x2::tx_context::sender(arg1);
        arg0.pending_admin = 0x1::option::none<address>();
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_admin_transfer_accepted(arg0.admin, 0x2::tx_context::sender(arg1));
    }

    public fun admin<T0>(arg0: &Treasury<T0>) : address {
        arg0.admin
    }

    public fun collect_fee<T0>(arg0: &mut Treasury<T0>, arg1: &0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::Config, arg2: &mut 0x2::coin::Coin<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version<T0>(arg0);
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::assert_version(arg1);
        assert!(!0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::is_paused(arg1), 1);
        assert!(arg3 <= 2, 3);
        let v0 = 0x2::coin::value<T0>(arg2);
        assert!(v0 > 0, 2);
        let v1 = (((v0 as u128) * (0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::fee_rate(arg1, arg3) as u128) / 10000) as u64);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), v1));
            arg0.total_collected = arg0.total_collected + v1;
            0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_fee_collected(0x2::tx_context::sender(arg4), arg3, v1, v0);
        };
        v1
    }

    public fun create_treasury<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id              : 0x2::object::new(arg1),
            version         : 1,
            admin           : 0x2::tx_context::sender(arg1),
            pending_admin   : 0x1::option::none<address>(),
            balance         : 0x2::balance::zero<T0>(),
            total_collected : 0,
            total_withdrawn : 0,
            created_at      : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun migrate_treasury<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 6);
        arg0.version = 1;
    }

    public fun propose_admin_transfer<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_admin_transfer_proposed(0x2::tx_context::sender(arg2), arg1);
    }

    public fun total_collected<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.total_collected
    }

    public fun treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun withdraw_fees<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 5);
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_fees_withdrawn(arg1, 0x2::tx_context::sender(arg2), arg0.total_withdrawn);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

