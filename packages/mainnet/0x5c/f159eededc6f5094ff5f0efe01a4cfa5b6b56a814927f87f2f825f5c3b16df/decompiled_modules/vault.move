module 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault {
    struct PT_TOKEN<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct PoolConfig has store {
        started_epoch: u64,
        maturity_epoch: u64,
        vault_apy: u64,
        deposit_items: vector<0x3::staking_pool::StakedSui>,
        debt_balance: u64,
        exit_conversion_rate: 0x1::option::Option<u64>,
        enable_mint: bool,
        enable_exit: bool,
        enable_redeem: bool,
    }

    struct PoolReserve<phantom T0> has store {
        pt_supply: 0x2::balance::Supply<PT_TOKEN<T0>>,
        pending_burn: 0x2::balance::Balance<PT_TOKEN<T0>>,
    }

    struct Global has key {
        id: 0x2::object::UID,
        staking_pools: vector<address>,
        staking_pool_ids: vector<0x2::object::ID>,
        pool_list: vector<0x1::string::String>,
        pools: 0x2::table::Table<0x1::string::String, PoolConfig>,
        pool_reserves: 0x2::bag::Bag,
        yt_supply: 0x2::balance::Supply<VAULT>,
        yt_in_circulation: 0x2::table::Table<0x1::string::String, u64>,
        pending_withdrawal: 0x2::balance::Balance<0x2::sui::SUI>,
        deposit_cap: 0x1::option::Option<u64>,
    }

    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_yt_circulation<T0>(arg0: &mut Global, arg1: &mut 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::AMMGlobal, arg2: &mut ManagerCap, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.yt_in_circulation, v0)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.yt_in_circulation, v0) = *0x2::table::borrow<0x1::string::String, u64>(&arg0.yt_in_circulation, v0) + arg4;
        } else {
            assert!(0x2::table::length<0x1::string::String, u64>(&arg0.yt_in_circulation) == 0, 23);
            0x2::table::add<0x1::string::String, u64>(&mut arg0.yt_in_circulation, v0, arg4);
        };
        if (0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::is_order<VAULT, T0>()) {
            0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::add_liquidity<VAULT, T0>(arg1, 0x2::coin::from_balance<VAULT>(0x2::balance::increase_supply<VAULT>(&mut arg0.yt_supply, arg4), arg5), 1, arg3, 1, arg5);
        } else {
            0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::add_liquidity<T0, VAULT>(arg1, arg3, 1, 0x2::coin::from_balance<VAULT>(0x2::balance::increase_supply<VAULT>(&mut arg0.yt_supply, arg4), arg5), 1, arg5);
        };
    }

    public entry fun attach_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: address, arg3: 0x2::object::ID) {
        assert!(!0x1::vector::contains<address>(&arg0.staking_pools, &arg2), 1);
        0x1::vector::push_back<address>(&mut arg0.staking_pools, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.staking_pool_ids, arg3);
    }

    fun check_not_paused(arg0: &Global, arg1: u64) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0.pool_list) > 1, 6);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0.pool_list);
        assert!(0x2::table::borrow<0x1::string::String, PoolConfig>(&arg0.pools, *0x1::vector::borrow<0x1::string::String>(&arg0.pool_list, v0 - 1)).maturity_epoch >= arg1, 6);
        assert!(0x2::table::borrow<0x1::string::String, PoolConfig>(&arg0.pools, *0x1::vector::borrow<0x1::string::String>(&arg0.pool_list, v0 - 2)).maturity_epoch >= arg1, 6);
    }

    fun check_vault_order<T0, T1>(arg0: &Global) {
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        let v1 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>();
        let (v2, v3) = 0x1::vector::index_of<0x1::string::String>(&arg0.pool_list, &v0);
        assert!(v2, 11);
        let (v4, v5) = 0x1::vector::index_of<0x1::string::String>(&arg0.pool_list, &v1);
        assert!(v4, 11);
        assert!(v5 > v3, 13);
    }

    public entry fun detach_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.staking_pools, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg0.staking_pools, v1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.staking_pool_ids, v1);
    }

    public entry fun disable_exit<T0>(arg0: &mut Global, arg1: &mut ManagerCap) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).enable_exit = false;
    }

    public entry fun disable_mint<T0>(arg0: &mut Global, arg1: &mut ManagerCap) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).enable_mint = false;
    }

    public entry fun disable_redeem<T0>(arg0: &mut Global, arg1: &mut ManagerCap) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).enable_redeem = false;
    }

    public entry fun emergency_topup_redemption_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_withdrawal, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun emergency_withdraw_redemption_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun enable_exit<T0>(arg0: &mut Global, arg1: &mut ManagerCap) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).enable_exit = true;
    }

    public entry fun enable_mint<T0>(arg0: &mut Global, arg1: &mut ManagerCap) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).enable_mint = true;
    }

    public entry fun enable_redeem<T0>(arg0: &mut Global, arg1: &mut ManagerCap) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).enable_redeem = true;
    }

    public entry fun exit<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: &mut 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::AMMGlobal, arg3: u64, arg4: 0x2::coin::Coin<PT_TOKEN<T0>>, arg5: 0x2::coin::Coin<VAULT>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.pools;
        let v1 = get_vault_config<T0>(v0);
        let v2 = &mut arg1.pool_reserves;
        let v3 = get_vault_reserve<T0>(v2);
        assert!(v1.enable_exit == true, 16);
        assert!(v1.maturity_epoch - 3 > 0x2::tx_context::epoch(arg6), 8);
        assert!(0x1::vector::length<0x3::staking_pool::StakedSui>(&v1.deposit_items) > arg3, 17);
        assert!(0x1::option::is_some<u64>(&v1.exit_conversion_rate), 26);
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg1.yt_in_circulation, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>()), 24);
        let v4 = 0x1::vector::swap_remove<0x3::staking_pool::StakedSui>(&mut v1.deposit_items, arg3);
        let v5 = 0x3::staking_pool::staked_sui_amount(&v4) + 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::apy_reader::earnings_from_staked_sui(arg0, &v4, 0x2::tx_context::epoch(arg6));
        let (v6, v7, _) = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::get_reserves_size<VAULT, T1>(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::get_mut_pool<VAULT, T1>(arg2, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::is_order<VAULT, T1>()));
        let v9 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::get_amount_out(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::calculate_pt_debt_from_epoch(v1.vault_apy, 0x2::tx_context::epoch(arg6), v1.maturity_epoch, v5), *0x1::option::borrow<u64>(&v1.exit_conversion_rate), 1000000000), v6, v7);
        let v10 = v9;
        if (1000000 > v9) {
            v10 = 1000000;
        };
        let v11 = 0x2::coin::value<PT_TOKEN<T0>>(&arg4);
        let v12 = 0x2::coin::value<VAULT>(&arg5);
        assert!(v11 >= v5, 18);
        assert!(v12 >= v10, 18);
        if (v11 == v5) {
            0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut v3.pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(arg4));
        } else {
            0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut v3.pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(0x2::coin::split<PT_TOKEN<T0>>(&mut arg4, v5, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<PT_TOKEN<T0>>>(arg4, 0x2::tx_context::sender(arg6));
        };
        if (v12 == v10) {
            0x2::balance::decrease_supply<VAULT>(&mut arg1.yt_supply, 0x2::coin::into_balance<VAULT>(arg5));
        } else {
            0x2::balance::decrease_supply<VAULT>(&mut arg1.yt_supply, 0x2::coin::into_balance<VAULT>(0x2::coin::split<VAULT>(&mut arg5, v10, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(arg5, 0x2::tx_context::sender(arg6));
        };
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(v4, 0x2::tx_context::sender(arg6));
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::exit_event(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), arg3, 0x2::object::id<0x3::staking_pool::StakedSui>(&v4), v5, v10, 0x2::tx_context::sender(arg6), 0x2::tx_context::epoch(arg6));
    }

    public fun get_vault_config<T0>(arg0: &mut 0x2::table::Table<0x1::string::String, PoolConfig>) : &mut PoolConfig {
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, PoolConfig>(arg0, v0), 11);
        0x2::table::borrow_mut<0x1::string::String, PoolConfig>(arg0, v0)
    }

    public fun get_vault_epochs<T0>(arg0: &0x2::table::Table<0x1::string::String, PoolConfig>) : (u64, u64) {
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, PoolConfig>(arg0, v0), 11);
        let v1 = 0x2::table::borrow<0x1::string::String, PoolConfig>(arg0, v0);
        (v1.started_epoch, v1.maturity_epoch)
    }

    public fun get_vault_reserve<T0>(arg0: &mut 0x2::bag::Bag) : &mut PoolReserve<T0> {
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, PoolReserve<T0>>(arg0, v0), 11);
        0x2::bag::borrow_mut<0x1::string::String, PoolReserve<T0>>(arg0, v0)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"Legato Yield Token", b"YT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.tamago.finance/legato/legato-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT>>(v2);
        let v3 = Global{
            id                 : 0x2::object::new(arg1),
            staking_pools      : 0x1::vector::empty<address>(),
            staking_pool_ids   : 0x1::vector::empty<0x2::object::ID>(),
            pool_list          : 0x1::vector::empty<0x1::string::String>(),
            pools              : 0x2::table::new<0x1::string::String, PoolConfig>(arg1),
            pool_reserves      : 0x2::bag::new(arg1),
            yt_supply          : 0x2::coin::treasury_into_supply<VAULT>(v1),
            yt_in_circulation  : 0x2::table::new<0x1::string::String, u64>(arg1),
            pending_withdrawal : 0x2::balance::zero<0x2::sui::SUI>(),
            deposit_cap        : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Global>(v3);
    }

    fun locate_withdrawable_asset(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &vector<0x1::string::String>, arg2: &mut 0x2::table::Table<0x1::string::String, PoolConfig>, arg3: u64, arg4: u64, arg5: u64) : (vector<0x1::string::String>, vector<u64>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = arg3 - arg4;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(arg1, v0);
            let v5 = 0x2::table::borrow_mut<0x1::string::String, PoolConfig>(arg2, v4);
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&v5.deposit_items)) {
                let v7 = 0x1::vector::borrow<0x3::staking_pool::StakedSui>(&v5.deposit_items, v6);
                let v8 = 0x3::staking_pool::staked_sui_amount(v7) + 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::apy_reader::earnings_from_staked_sui(arg0, v7, arg5);
                0x1::vector::push_back<0x1::string::String>(&mut v1, v4);
                0x1::vector::push_back<u64>(&mut v2, v6);
                let v9 = if (arg3 >= v8) {
                    arg3 - v8
                } else {
                    0
                };
                v3 = v9;
                v6 = v6 + 1;
                if (v9 == 0) {
                    break
                };
            };
            v0 = v0 + 1;
            if (v3 == 0) {
                break
            };
        };
        (v1, v2)
    }

    public entry fun migrate<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<PT_TOKEN<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        check_vault_order<T0, T1>(arg0);
        assert!(0x2::coin::value<PT_TOKEN<T0>>(&arg1) >= 1000000000, 10);
        let (v0, v1) = get_vault_epochs<T0>(&arg0.pools);
        assert!(0x2::tx_context::epoch(arg2) >= v0, 9);
        let v2 = &mut arg0.pool_reserves;
        let v3 = 0x2::coin::value<PT_TOKEN<T0>>(&arg1);
        0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut get_vault_reserve<T0>(v2).pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(arg1));
        let v4 = &mut arg0.pools;
        let v5 = get_vault_config<T1>(v4);
        let v6 = &mut arg0.pool_reserves;
        let v7 = get_vault_reserve<T1>(v6);
        assert!(v5.maturity_epoch - 3 > 0x2::tx_context::epoch(arg2), 8);
        assert!(0x2::tx_context::epoch(arg2) >= v5.started_epoch, 9);
        let v8 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::calculate_pt_debt_from_epoch(v5.vault_apy, v1, v5.maturity_epoch, v3);
        let v9 = v3 + v8;
        v5.debt_balance = v5.debt_balance + v8;
        mint_pt<T1>(v7, v9, arg2);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::migrate_event(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), v3, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>(), v9, 0x2::tx_context::sender(arg2), 0x2::tx_context::epoch(arg2));
    }

    public entry fun mint<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        check_not_paused(arg1, 0x2::tx_context::epoch(arg3));
        let v0 = &mut arg1.pools;
        let v1 = get_vault_config<T0>(v0);
        let v2 = &mut arg1.pool_reserves;
        let v3 = get_vault_reserve<T0>(v2);
        assert!(v1.enable_mint == true, 7);
        assert!(v1.maturity_epoch - 3 > 0x2::tx_context::epoch(arg3), 8);
        assert!(0x2::tx_context::epoch(arg3) >= v1.started_epoch, 9);
        assert!(0x3::staking_pool::staked_sui_amount(&arg2) >= 1000000000, 10);
        let v4 = 0x3::staking_pool::pool_id(&arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.staking_pool_ids, &v4), 12);
        let v5 = 0x3::staking_pool::staked_sui_amount(&arg2);
        if (0x1::option::is_some<u64>(&arg1.deposit_cap)) {
            assert!(*0x1::option::borrow<u64>(&arg1.deposit_cap) >= v5, 21);
            *0x1::option::borrow_mut<u64>(&mut arg1.deposit_cap) = *0x1::option::borrow<u64>(&arg1.deposit_cap) - v5;
        };
        let v6 = if (0x2::tx_context::epoch(arg3) > 0x3::staking_pool::stake_activation_epoch(&arg2)) {
            0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::apy_reader::earnings_from_staked_sui(arg0, &arg2, 0x2::tx_context::epoch(arg3))
        } else {
            0
        };
        receive_staked_sui(v1, arg2);
        let v7 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::calculate_pt_debt_from_epoch(v1.vault_apy, 0x2::tx_context::epoch(arg3), v1.maturity_epoch, v5 + v6);
        let v8 = v5 + v6 + v7;
        assert!(v8 >= 1000000000, 27);
        mint_pt<T0>(v3, v8, arg3);
        v1.debt_balance = v1.debt_balance + v7;
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::mint_event(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), v4, v5, v8, 0x2::object::id<0x3::staking_pool::StakedSui>(&arg2), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    public entry fun mint_from_sui<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000000, 10);
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg0, arg2, arg3, arg4);
        mint<T0>(arg0, arg1, v0, arg4);
    }

    fun mint_pt<T0>(arg0: &mut PoolReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PT_TOKEN<T0>>>(0x2::coin::from_balance<PT_TOKEN<T0>>(0x2::balance::increase_supply<PT_TOKEN<T0>>(&mut arg0.pt_supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun new_vault<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::tx_context::epoch(arg5), 5);
        assert!(arg2 >= 0x2::tx_context::epoch(arg5), 3);
        assert!(arg3 - arg2 >= 30, 4);
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, PoolReserve<T0>>(&arg0.pool_reserves, v0), 1);
        if (0x1::vector::length<0x1::string::String>(&arg0.pool_list) > 0) {
            let v1 = 0x2::table::borrow<0x1::string::String, PoolConfig>(&arg0.pools, *0x1::vector::borrow<0x1::string::String>(&arg0.pool_list, 0x1::vector::length<0x1::string::String>(&arg0.pool_list) - 1));
            assert!(arg2 > v1.started_epoch && v1.maturity_epoch > arg2, 3);
        };
        let v2 = PoolConfig{
            started_epoch        : arg2,
            maturity_epoch       : arg3,
            vault_apy            : arg4,
            deposit_items        : 0x1::vector::empty<0x3::staking_pool::StakedSui>(),
            debt_balance         : 0,
            exit_conversion_rate : 0x1::option::none<u64>(),
            enable_mint          : true,
            enable_exit          : false,
            enable_redeem        : true,
        };
        let v3 = PT_TOKEN<T0>{dummy_field: false};
        let v4 = PoolReserve<T0>{
            pt_supply    : 0x2::balance::create_supply<PT_TOKEN<T0>>(v3),
            pending_burn : 0x2::balance::zero<PT_TOKEN<T0>>(),
        };
        0x2::bag::add<0x1::string::String, PoolReserve<T0>>(&mut arg0.pool_reserves, v0, v4);
        0x2::table::add<0x1::string::String, PoolConfig>(&mut arg0.pools, v0, v2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.pool_list, v0);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::new_vault_event(0x2::object::id<Global>(arg0), v0, 0x2::tx_context::epoch(arg5), arg2, arg3, arg4);
    }

    fun prepare_withdrawal(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal)) {
            let v0 = &mut arg1.pools;
            let (v1, v2) = locate_withdrawable_asset(arg0, &arg1.pool_list, v0, arg2, 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal), 0x2::tx_context::epoch(arg3));
            let v3 = &mut arg1.pools;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_withdrawal, unstake_staked_sui(arg0, v3, v1, v2, arg3));
        };
    }

    public entry fun rebalance<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: &mut 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::AMMGlobal, arg3: &mut ManagerCap, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 1000, 25);
        assert!(0x2::coin::value<T1>(&arg4) > 1000, 25);
        let v0 = &mut arg1.pools;
        let v1 = get_vault_config<T0>(v0);
        let v2 = &mut arg1.pool_reserves;
        let v3 = get_vault_reserve<T0>(v2);
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg1.yt_in_circulation, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>()), 24);
        let v4 = vault_rewards(arg0, v1, 0x2::tx_context::epoch(arg6));
        let v5 = v1.debt_balance;
        let v6 = if (v4 >= v5) {
            v4 - v5
        } else {
            0
        };
        assert!(v6 > 1000, 25);
        v1.debt_balance = v1.debt_balance + v6;
        0x2::balance::join<PT_TOKEN<T0>>(&mut v3.pending_burn, 0x2::balance::increase_supply<PT_TOKEN<T0>>(&mut v3.pt_supply, v6));
        let v7 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(v6, arg5, 1000000000);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm::swap<T1, VAULT>(arg2, 0x2::coin::split<T1>(&mut arg4, v7, arg6), 1, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg6));
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::rebalance_event(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), v6, v7, arg5, 0x2::tx_context::epoch(arg6));
    }

    fun receive_staked_sui(arg0: &mut PoolConfig, arg1: 0x3::staking_pool::StakedSui) {
        0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut arg0.deposit_items, arg1);
        if (0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.deposit_items) > 1) {
            0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::sort_items(&mut arg0.deposit_items);
        };
    }

    public entry fun redeem<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x2::coin::Coin<PT_TOKEN<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.pools;
        let v1 = get_vault_config<T0>(v0);
        assert!(v1.enable_redeem == true, 7);
        assert!(0x2::tx_context::epoch(arg3) > v1.maturity_epoch, 14);
        assert!(0x2::coin::value<PT_TOKEN<T0>>(&arg2) >= 1000000000, 10);
        let v2 = 0x2::coin::value<PT_TOKEN<T0>>(&arg2);
        prepare_withdrawal(arg0, arg1, v2, arg3);
        let v3 = 0x2::tx_context::sender(arg3);
        withdraw_sui(arg1, v2, v3, arg3);
        let v4 = &mut arg1.pool_reserves;
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::redeem_event(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), 0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut get_vault_reserve<T0>(v4).pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(arg2)), v2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    public entry fun set_deposit_cap(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64) {
        if (arg2 == 0) {
            arg0.deposit_cap = 0x1::option::none<u64>();
        } else {
            arg0.deposit_cap = 0x1::option::some<u64>(arg2);
        };
    }

    public entry fun set_exit_conversion_rate<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64) {
        let v0 = &mut arg0.pools;
        if (arg2 == 0) {
            get_vault_config<T0>(v0).exit_conversion_rate = 0x1::option::none<u64>();
        } else {
            get_vault_config<T0>(v0).exit_conversion_rate = 0x1::option::some<u64>(arg2);
        };
    }

    fun unstake_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x2::table::Table<0x1::string::String, PoolConfig>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::length<u64>(&arg3) > 0) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, PoolConfig>(arg1, 0x1::vector::pop_back<0x1::string::String>(&mut arg2));
            let v2 = 0x1::vector::swap_remove<0x3::staking_pool::StakedSui>(&mut v1.deposit_items, 0x1::vector::pop_back<u64>(&mut arg3));
            let v3 = 0x3::staking_pool::staked_sui_amount(&v2);
            let v4 = 0x3::sui_system::request_withdraw_stake_non_entry(arg0, v2, arg4);
            let v5 = if (0x2::balance::value<0x2::sui::SUI>(&v4) >= v3) {
                0x2::balance::value<0x2::sui::SUI>(&v4) - v3
            } else {
                0
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v4);
            let v6 = if (v1.debt_balance >= v5) {
                v1.debt_balance - v5
            } else {
                0
            };
            v1.debt_balance = v6;
        };
        v0
    }

    public entry fun update_vault_apy<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64) {
        let v0 = &mut arg0.pools;
        get_vault_config<T0>(v0).vault_apy = arg2;
    }

    fun vault_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &PoolConfig, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg1.deposit_items)) {
            let v2 = 0x1::vector::borrow<0x3::staking_pool::StakedSui>(&arg1.deposit_items, v0);
            if (arg2 > 0x3::staking_pool::stake_activation_epoch(v2)) {
                v1 = v1 + 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::apy_reader::earnings_from_staked_sui(arg0, v2, arg2);
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun withdraw_sui(arg0: &mut Global, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal) >= arg1, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

