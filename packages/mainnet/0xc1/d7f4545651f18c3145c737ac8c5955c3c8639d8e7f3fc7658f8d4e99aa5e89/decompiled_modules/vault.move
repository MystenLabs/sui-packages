module 0xc1d7f4545651f18c3145c737ac8c5955c3c8639d8e7f3fc7658f8d4e99aa5e89::vault {
    struct VaultRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        vault_count: u64,
        max_leverage: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        strategist: address,
        collateral: 0x2::balance::Balance<T0>,
        total_shares: u64,
        shares: 0x2::table::Table<address, u64>,
        deposit_times: 0x2::table::Table<address, u64>,
        entry_nav: 0x2::table::Table<address, u64>,
        capital_deployed: u64,
        strategist_fees: 0x2::balance::Balance<T0>,
        x_handle: vector<u8>,
        paused: bool,
        guardian: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        strategist: address,
        initial_deposit: u64,
    }

    struct Deposited has copy, drop {
        vault_id: address,
        depositor: address,
        amount: u64,
        shares_minted: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: address,
        depositor: address,
        amount: u64,
        shares_burned: u64,
        fee_taken: u64,
    }

    struct CapitalDeployed has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct CapitalReturned has copy, drop {
        vault_id: address,
        amount: u64,
    }

    public entry fun claim_fees<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.strategist, 0);
        assert!(0x2::balance::value<T0>(&arg0.strategist_fees) > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.strategist_fees), arg1), arg0.strategist);
    }

    public entry fun create_vault<T0>(arg0: &mut VaultRegistry, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000, 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = v0 * 1000000000 / v0;
        let v3 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v3, v1, v2);
        let v4 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v4, v1, 0);
        let v5 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v5, v1, 1000000000);
        let v6 = Vault<T0>{
            id               : 0x2::object::new(arg3),
            strategist       : v1,
            collateral       : 0x2::coin::into_balance<T0>(arg1),
            total_shares     : v2,
            shares           : v3,
            deposit_times    : v4,
            entry_nav        : v5,
            capital_deployed : 0,
            strategist_fees  : 0x2::balance::zero<T0>(),
            x_handle         : 0x1::vector::empty<u8>(),
            paused           : false,
            guardian         : arg2,
        };
        arg0.vault_count = arg0.vault_count + 1;
        let v7 = VaultCreated{
            vault_id        : 0x2::object::uid_to_address(&v6.id),
            strategist      : v1,
            initial_deposit : v0,
        };
        0x2::event::emit<VaultCreated>(v7);
        0x2::transfer::share_object<Vault<T0>>(v6);
    }

    public entry fun deploy_capital<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.strategist, 0);
        assert!(!arg0.paused, 3);
        assert!(arg1 > 0, 5);
        arg0.capital_deployed = arg0.capital_deployed + arg1;
        let v0 = CapitalDeployed{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            amount   : arg1,
        };
        0x2::event::emit<CapitalDeployed>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, arg1), arg2)
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000, 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = if (arg0.total_shares == 0) {
            1000000000
        } else {
            (0x2::balance::value<T0>(&arg0.collateral) + arg0.capital_deployed) * 1000000000 / arg0.total_shares
        };
        let v3 = v0 * 1000000000 / v2;
        if (0x2::table::contains<address, u64>(&arg0.shares, v1)) {
            let v4 = 0x2::table::remove<address, u64>(&mut arg0.shares, v1);
            0x2::table::add<address, u64>(&mut arg0.shares, v1, v4 + v3);
            0x2::table::add<address, u64>(&mut arg0.entry_nav, v1, (0x2::table::remove<address, u64>(&mut arg0.entry_nav, v1) * v4 + v2 * v3) / (v4 + v3));
        } else {
            0x2::table::add<address, u64>(&mut arg0.shares, v1, v3);
            0x2::table::add<address, u64>(&mut arg0.entry_nav, v1, v2);
        };
        if (0x2::table::contains<address, u64>(&arg0.deposit_times, v1)) {
            0x2::table::remove<address, u64>(&mut arg0.deposit_times, v1);
        };
        0x2::table::add<address, u64>(&mut arg0.deposit_times, v1, 0x2::clock::timestamp_ms(arg2));
        arg0.total_shares = arg0.total_shares + v3;
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        let v5 = Deposited{
            vault_id      : 0x2::object::uid_to_address(&arg0.id),
            depositor     : v1,
            amount        : v0,
            shares_minted : v3,
        };
        0x2::event::emit<Deposited>(v5);
    }

    public fun depositor_shares<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            vault_count  : 0,
            max_leverage : 3,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun nav_per_share<T0>(arg0: &Vault<T0>) : u64 {
        if (arg0.total_shares == 0) {
            1000000000
        } else {
            (0x2::balance::value<T0>(&arg0.collateral) + arg0.capital_deployed) * 1000000000 / arg0.total_shares
        }
    }

    public entry fun pause_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.strategist || 0x2::tx_context::sender(arg1) == arg0.guardian, 6);
        arg0.paused = true;
    }

    public entry fun return_capital<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.strategist, 0);
        if (arg2 > arg0.capital_deployed) {
            arg0.capital_deployed = 0;
        } else {
            arg0.capital_deployed = arg0.capital_deployed - arg2;
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        let v0 = CapitalReturned{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CapitalReturned>(v0);
    }

    public entry fun set_max_leverage(arg0: &mut VaultRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.max_leverage = arg1;
    }

    public entry fun unpause_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.strategist, 0);
        arg0.paused = false;
    }

    public fun vault_info<T0>(arg0: &Vault<T0>) : (address, u64, u64, u64, bool) {
        (arg0.strategist, 0x2::balance::value<T0>(&arg0.collateral), arg0.capital_deployed, arg0.total_shares, arg0.paused)
    }

    public entry fun verify_x_handle<T0>(arg0: &VaultRegistry, arg1: &mut Vault<T0>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg1.x_handle = arg2;
    }

    public entry fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 5);
        assert!(0x2::table::contains<address, u64>(&arg0.shares, v0), 1);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.shares, v0);
        assert!(v1 >= arg1, 1);
        if (0x2::table::contains<address, u64>(&arg0.deposit_times, v0)) {
            assert!(0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<address, u64>(&arg0.deposit_times, v0) + 3600000, 4);
        };
        let v2 = 0x2::balance::value<T0>(&arg0.collateral) + arg0.capital_deployed;
        let v3 = *0x2::table::borrow<address, u64>(&arg0.entry_nav, v0);
        let v4 = v2 * 1000000000 / arg0.total_shares;
        let v5 = if (v4 > v3) {
            arg1 * (v4 - v3) / 1000000000 * 2000 / 10000
        } else {
            0
        };
        let v6 = arg1 * v2 / arg0.total_shares - v5;
        assert!(0x2::balance::value<T0>(&arg0.collateral) >= v6 + v5, 1);
        let v7 = v1 - arg1;
        0x2::table::remove<address, u64>(&mut arg0.shares, v0);
        if (v7 > 0) {
            0x2::table::add<address, u64>(&mut arg0.shares, v0, v7);
        } else {
            if (0x2::table::contains<address, u64>(&arg0.entry_nav, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.entry_nav, v0);
            };
            if (0x2::table::contains<address, u64>(&arg0.deposit_times, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.deposit_times, v0);
            };
        };
        arg0.total_shares = arg0.total_shares - arg1;
        if (v5 > 0) {
            0x2::balance::join<T0>(&mut arg0.strategist_fees, 0x2::balance::split<T0>(&mut arg0.collateral, v5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v6), arg3), v0);
        let v8 = Withdrawn{
            vault_id      : 0x2::object::uid_to_address(&arg0.id),
            depositor     : v0,
            amount        : v6,
            shares_burned : arg1,
            fee_taken     : v5,
        };
        0x2::event::emit<Withdrawn>(v8);
    }

    // decompiled from Move bytecode v6
}

