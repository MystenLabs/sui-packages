module 0x3c7b84ce90116b6d55b4fe06fef2e2a9df00e2fae9a50f618b1f0098e9d3b0f1::treasury {
    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        admin: address,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun add_to_whitelist(arg0: &mut TreasuryConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::table::contains<address, bool>(&arg0.whitelist, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelist, arg1, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, arg1) = true;
        };
    }

    public fun assert_admin(arg0: &TreasuryConfig, arg1: address) {
        assert!(arg0.admin == arg1, 1);
    }

    public fun assert_whitelisted(arg0: &TreasuryConfig, arg1: address) {
        assert!(arg1 == arg0.admin || 0x2::table::contains<address, bool>(&arg0.whitelist, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelist, arg1), 2);
    }

    public entry fun create_and_share_treasury<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_treasury_config(arg0);
        let v1 = Treasury<T0>{
            id        : 0x2::object::new(arg0),
            config_id : 0x2::object::id<TreasuryConfig>(&v0),
            balance   : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TreasuryConfig>(v0);
        0x2::transfer::share_object<Treasury<T0>>(v1);
    }

    public fun create_treasury<T0>(arg0: &TreasuryConfig, arg1: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        Treasury<T0>{
            id        : 0x2::object::new(arg1),
            config_id : 0x2::object::id<TreasuryConfig>(arg0),
            balance   : 0x2::balance::zero<T0>(),
        }
    }

    public fun create_treasury_config(arg0: &mut 0x2::tx_context::TxContext) : TreasuryConfig {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v1, v0, true);
        TreasuryConfig{
            id        : 0x2::object::new(arg0),
            admin     : v0,
            whitelist : v1,
        }
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::coin::value<T0>(&arg1);
        0x2::tx_context::sender(arg2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun remove_from_whitelist(arg0: &mut TreasuryConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::table::contains<address, bool>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, arg1) = false;
        };
    }

    public entry fun transfer_admin(arg0: &mut TreasuryConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.admin = arg1;
        if (!0x2::table::contains<address, bool>(&arg0.whitelist, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelist, arg1, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, arg1) = true;
        };
    }

    public fun withdraw<T0>(arg0: &TreasuryConfig, arg1: &mut Treasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_whitelisted(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

