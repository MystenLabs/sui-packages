module 0xc4c42d407c9e479a350fe7c7ebb47fcf18e59a84e42cd04624db7b4d7d337df4::vault {
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
        capital_deployed: u64,
        total_shares: u64,
        shares: 0x2::table::Table<address, u64>,
        deposit_times: 0x2::table::Table<address, u64>,
        entry_nav: 0x2::table::Table<address, u64>,
        strategist_fees: 0x2::balance::Balance<T0>,
        margin_manager_id: address,
        position_direction: u8,
        x_handle: vector<u8>,
        paused: bool,
        guardian: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        strategist: address,
        margin_manager_id: address,
        initial_deposit: u64,
    }

    struct Deposited has copy, drop {
        vault_id: address,
        depositor: address,
        amount: u64,
        shares_minted: u64,
        nav_per_share: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: address,
        depositor: address,
        amount: u64,
        shares_burned: u64,
        performance_fee: u64,
        withdrawal_fee: u64,
    }

    struct PositionOpened has copy, drop {
        vault_id: address,
        direction: u8,
        capital_deployed: u64,
    }

    struct PositionClosed has copy, drop {
        vault_id: address,
        capital_returned: u64,
        pnl: u64,
        is_profit: bool,
    }

    public entry fun claim_fees<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.strategist, 0);
        assert!(0x2::balance::value<T0>(&arg0.strategist_fees) > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.strategist_fees), arg1), arg0.strategist);
    }

    public entry fun create_vault<T0>(arg0: &mut VaultRegistry, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 100000, 2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v2, v1, v0);
        let v3 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v3, v1, 0);
        let v4 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v4, v1, 1000000000);
        let v5 = Vault<T0>{
            id                 : 0x2::object::new(arg4),
            strategist         : v1,
            collateral         : 0x2::coin::into_balance<T0>(arg1),
            capital_deployed   : 0,
            total_shares       : v0,
            shares             : v2,
            deposit_times      : v3,
            entry_nav          : v4,
            strategist_fees    : 0x2::balance::zero<T0>(),
            margin_manager_id  : arg2,
            position_direction : 0,
            x_handle           : 0x1::vector::empty<u8>(),
            paused             : false,
            guardian           : arg3,
        };
        arg0.vault_count = arg0.vault_count + 1;
        let v6 = VaultCreated{
            vault_id          : 0x2::object::uid_to_address(&v5.id),
            strategist        : v1,
            margin_manager_id : arg2,
            initial_deposit   : v0,
        };
        0x2::event::emit<VaultCreated>(v6);
        0x2::transfer::share_object<Vault<T0>>(v5);
    }

    public fun deploy_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.collateral);
        deploy_capital<T0>(arg0, v0, arg1)
    }

    public fun deploy_capital<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.strategist, 0);
        assert!(!arg0.paused, 3);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T0>(&arg0.collateral), 5);
        arg0.capital_deployed = arg0.capital_deployed + arg1;
        let v0 = PositionOpened{
            vault_id         : 0x2::object::uid_to_address(&arg0.id),
            direction        : arg0.position_direction,
            capital_deployed : arg0.capital_deployed,
        };
        0x2::event::emit<PositionOpened>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, arg1), arg2)
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 100000, 2);
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
            nav_per_share : v2,
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

    public fun is_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.paused
    }

    public fun nav_per_share<T0>(arg0: &Vault<T0>) : u64 {
        if (arg0.total_shares == 0) {
            1000000000
        } else {
            (0x2::balance::value<T0>(&arg0.collateral) + arg0.capital_deployed) * 1000000000 / arg0.total_shares
        }
    }

    public entry fun pause<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.strategist || 0x2::tx_context::sender(arg1) == arg0.guardian, 6);
        arg0.paused = true;
    }

    public fun return_capital<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.strategist, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = if (arg2 > arg0.capital_deployed) {
            arg0.capital_deployed
        } else {
            arg2
        };
        arg0.capital_deployed = arg0.capital_deployed - v1;
        let v2 = v0 > arg2;
        let v3 = if (v2) {
            v0 - arg2
        } else {
            arg2 - v0
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        let v4 = PositionClosed{
            vault_id         : 0x2::object::uid_to_address(&arg0.id),
            capital_returned : v0,
            pnl              : v3,
            is_profit        : v2,
        };
        0x2::event::emit<PositionClosed>(v4);
    }

    public entry fun set_max_leverage(arg0: &mut VaultRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.max_leverage = arg1;
    }

    public entry fun set_position_direction<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.strategist, 0);
        arg0.position_direction = arg1;
    }

    public fun strategist<T0>(arg0: &Vault<T0>) : address {
        arg0.strategist
    }

    public fun total_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral) + arg0.capital_deployed
    }

    public entry fun unpause<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.strategist, 0);
        arg0.paused = false;
    }

    public entry fun verify_x_handle<T0>(arg0: &VaultRegistry, arg1: &mut Vault<T0>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        arg1.x_handle = arg2;
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 5);
        assert!(0x2::table::contains<address, u64>(&arg0.shares, v0), 1);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.shares, v0);
        assert!(v1 >= arg1, 1);
        if (0x2::table::contains<address, u64>(&arg0.deposit_times, v0)) {
            assert!(0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<address, u64>(&arg0.deposit_times, v0) + 3600000, 4);
        };
        let v2 = 0x2::balance::value<T0>(&arg0.collateral) + arg0.capital_deployed;
        let v3 = arg1 * v2 / arg0.total_shares;
        let v4 = v3 * 30 / 10000;
        let v5 = v2 * 1000000000 / arg0.total_shares;
        let v6 = *0x2::table::borrow<address, u64>(&arg0.entry_nav, v0);
        let v7 = if (v5 > v6) {
            arg1 * (v5 - v6) / 1000000000 * 2000 / 10000
        } else {
            0
        };
        let v8 = v4 + v7;
        let v9 = v3 - v8;
        assert!(0x2::balance::value<T0>(&arg0.collateral) >= v9 + v8, 1);
        let v10 = v1 - arg1;
        0x2::table::remove<address, u64>(&mut arg0.shares, v0);
        if (v10 > 0) {
            0x2::table::add<address, u64>(&mut arg0.shares, v0, v10);
        } else {
            if (0x2::table::contains<address, u64>(&arg0.entry_nav, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.entry_nav, v0);
            };
            if (0x2::table::contains<address, u64>(&arg0.deposit_times, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.deposit_times, v0);
            };
        };
        arg0.total_shares = arg0.total_shares - arg1;
        if (v8 > 0) {
            0x2::balance::join<T0>(&mut arg0.strategist_fees, 0x2::balance::split<T0>(&mut arg0.collateral, v8));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v9), arg3), v0);
        let v11 = Withdrawn{
            vault_id        : 0x2::object::uid_to_address(&arg0.id),
            depositor       : v0,
            amount          : v9,
            shares_burned   : arg1,
            performance_fee : v7,
            withdrawal_fee  : v4,
        };
        0x2::event::emit<Withdrawn>(v11);
    }

    // decompiled from Move bytecode v6
}

