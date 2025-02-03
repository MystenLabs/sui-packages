module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault {
    struct PT_TOKEN<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VaultConfig has store {
        started_epoch: u64,
        maturity_epoch: u64,
        vault_apy: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64,
        staked_sui: vector<0x3::staking_pool::StakedSui>,
        debt_balance: u64,
        enable_mint: bool,
        enable_exit: bool,
        enable_redeem: bool,
    }

    struct VaultReserve<phantom T0> has store {
        pt_supply: 0x2::balance::Supply<PT_TOKEN<T0>>,
    }

    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Global has key {
        id: 0x2::object::UID,
        staking_pools: vector<address>,
        staking_pool_ids: vector<0x2::object::ID>,
        vault_list: vector<0x1::string::String>,
        vault_config: 0x2::table::Table<0x1::string::String, VaultConfig>,
        vault_reserves: 0x2::bag::Bag,
        pending_withdrawal: 0x2::balance::Balance<0x2::sui::SUI>,
        deposit_cap: 0x1::option::Option<u64>,
        first_epoch_of_the_year: u64,
        exit_fee: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64,
    }

    public entry fun attach_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: address, arg3: 0x2::object::ID) {
        assert!(!0x1::vector::contains<address>(&arg0.staking_pools, &arg2), 101);
        0x1::vector::push_back<address>(&mut arg0.staking_pools, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.staking_pool_ids, arg3);
    }

    fun check_vault_order<T0, T1>(arg0: &Global) {
        let v0 = token_to_name<T0>();
        let v1 = token_to_name<T1>();
        let (v2, v3) = 0x1::vector::index_of<0x1::string::String>(&arg0.vault_list, &v0);
        assert!(v2, 104);
        let (v4, v5) = 0x1::vector::index_of<0x1::string::String>(&arg0.vault_list, &v1);
        assert!(v4, 104);
        assert!(v5 > v3, 114);
    }

    public entry fun detach_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.staking_pools, &arg2);
        assert!(v0, 102);
        0x1::vector::remove<address>(&mut arg0.staking_pools, v1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.staking_pool_ids, v1);
    }

    public entry fun disable<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u8) {
        assert!(arg2 > 0 && arg2 <= 3, 103);
        let v0 = &mut arg0.vault_config;
        if (arg2 == 1) {
            get_vault_config<T0>(v0).enable_mint = false;
        } else if (arg2 == 2) {
            get_vault_config<T0>(v0).enable_exit = false;
        } else {
            get_vault_config<T0>(v0).enable_redeem = false;
        };
    }

    public entry fun enable<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u8) {
        assert!(arg2 > 0 && arg2 <= 3, 103);
        let v0 = &mut arg0.vault_config;
        if (arg2 == 1) {
            get_vault_config<T0>(v0).enable_mint = true;
        } else if (arg2 == 2) {
            get_vault_config<T0>(v0).enable_exit = true;
        } else {
            get_vault_config<T0>(v0).enable_redeem = true;
        };
    }

    public entry fun exit<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x2::coin::Coin<PT_TOKEN<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<PT_TOKEN<T0>>(&arg2) >= 1000000000, 107);
        let v0 = &mut arg1.vault_config;
        let v1 = get_vault_config<T0>(v0);
        assert!(v1.enable_exit == true, 115);
        assert!(v1.maturity_epoch - 3 > 0x2::tx_context::epoch(arg3), 108);
        let v2 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::calculate_exit_amount(v1.vault_apy, 0x2::tx_context::epoch(arg3), v1.maturity_epoch, 0x2::coin::value<PT_TOKEN<T0>>(&arg2));
        prepare_withdrawal(arg0, arg1, v2, arg3);
        let v3 = (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((v2 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), arg1.exit_fee)) as u64);
        let v4 = withdraw_sui(arg1, v3, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg3));
        let v5 = &mut arg1.vault_reserves;
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::exit_event(token_to_name<T0>(), 0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut get_vault_reserve<T0>(v5).pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(arg2)), v3, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    fun find_combination(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &vector<0x1::string::String>, arg2: &0x2::table::Table<0x1::string::String, VaultConfig>, arg3: u64, arg4: u64) : (vector<0x1::string::String>, vector<u64>) {
        let (v0, v1, v2) = normalize_into_ratio(arg0, arg1, arg2, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        let v9 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(1, 2);
        while (v8 <= 10000) {
            let (v10, v11) = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::matching_asset_to_ratio(v5, v9);
            let v12 = v11;
            let v13 = v10;
            if (0x1::option::is_some<u64>(&v12)) {
                let v14 = *0x1::option::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>(&v13);
                let v15 = *0x1::option::borrow<u64>(&v12);
                if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::greater_or_equal(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), v14)) {
                    v9 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), v14);
                    0x1::vector::swap_remove<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>(&mut v5, v15);
                    0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::vector::swap_remove<0x1::string::String>(&mut v3, v15));
                    0x1::vector::push_back<u64>(&mut v7, 0x1::vector::swap_remove<u64>(&mut v4, v15));
                    v8 = v8 + 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128(10000, v14);
                };
            } else {
                break
            };
        };
        (v6, v7)
    }

    fun find_one_with_minimal_excess(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &vector<0x1::string::String>, arg2: &0x2::table::Table<0x1::string::String, VaultConfig>, arg3: u64, arg4: u64) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<u64>) {
        let v0 = longest_length(arg1, arg2);
        let v1 = 0x1::option::none<0x1::string::String>();
        let v2 = 0x1::option::none<u64>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::string::String>(arg1)) {
                let v5 = *0x1::vector::borrow<0x1::string::String>(arg1, v4);
                let v6 = 0x2::table::borrow<0x1::string::String, VaultConfig>(arg2, v5);
                if (0x1::vector::length<0x3::staking_pool::StakedSui>(&v6.staked_sui) > v3) {
                    let v7 = 0x1::vector::borrow<0x3::staking_pool::StakedSui>(&v6.staked_sui, v3);
                    if (arg4 > 0x3::staking_pool::stake_activation_epoch(v7)) {
                        if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::get_amount_with_rewards(arg0, v7, arg4) > arg3) {
                            v1 = 0x1::option::some<0x1::string::String>(v5);
                            v2 = 0x1::option::some<u64>(v3);
                            v3 = v0;
                            break
                        };
                    };
                };
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun get_pending_withdrawal_amount(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal)
    }

    public fun get_random_validator_address(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : address {
        *0x1::vector::borrow<address>(&arg0, (100 + 0x2::tx_context::epoch(arg1)) % 0x1::vector::length<address>(&arg0))
    }

    public fun get_vault_config<T0>(arg0: &mut 0x2::table::Table<0x1::string::String, VaultConfig>) : &mut VaultConfig {
        let v0 = token_to_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, VaultConfig>(arg0, v0), 104);
        0x2::table::borrow_mut<0x1::string::String, VaultConfig>(arg0, v0)
    }

    public fun get_vault_info<T0>(arg0: &Global) : u64 {
        let v0 = token_to_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, VaultConfig>(&arg0.vault_config, v0), 104);
        0x2::table::borrow<0x1::string::String, VaultConfig>(&arg0.vault_config, v0).maturity_epoch
    }

    public fun get_vault_reserve<T0>(arg0: &mut 0x2::bag::Bag) : &mut VaultReserve<T0> {
        let v0 = token_to_name<T0>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, VaultReserve<T0>>(arg0, v0), 104);
        0x2::bag::borrow_mut<0x1::string::String, VaultReserve<T0>>(arg0, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Global{
            id                      : 0x2::object::new(arg0),
            staking_pools           : 0x1::vector::empty<address>(),
            staking_pool_ids        : 0x1::vector::empty<0x2::object::ID>(),
            vault_list              : 0x1::vector::empty<0x1::string::String>(),
            vault_config            : 0x2::table::new<0x1::string::String, VaultConfig>(arg0),
            vault_reserves          : 0x2::bag::new(arg0),
            pending_withdrawal      : 0x2::balance::zero<0x2::sui::SUI>(),
            deposit_cap             : 0x1::option::none<u64>(),
            first_epoch_of_the_year : 264,
            exit_fee                : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_raw_value(553402322211286548),
        };
        0x2::transfer::share_object<Global>(v1);
    }

    fun longest_length(arg0: &vector<0x1::string::String>, arg1: &0x2::table::Table<0x1::string::String, VaultConfig>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = v1;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            let v3 = 0x1::vector::length<0x3::staking_pool::StakedSui>(&0x2::table::borrow<0x1::string::String, VaultConfig>(arg1, *0x1::vector::borrow<0x1::string::String>(arg0, v0)).staked_sui);
            if (v3 > v1) {
                v2 = v3;
            };
            v0 = v0 + 1;
        };
        v2
    }

    public entry fun migrate<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<PT_TOKEN<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        check_vault_order<T0, T1>(arg0);
        assert!(0x2::coin::value<PT_TOKEN<T0>>(&arg1) >= 1000000000, 107);
        let v0 = &mut arg0.vault_config;
        let v1 = get_vault_config<T0>(v0).maturity_epoch;
        let v2 = &mut arg0.vault_reserves;
        let v3 = 0x2::coin::value<PT_TOKEN<T0>>(&arg1);
        0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut get_vault_reserve<T0>(v2).pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(arg1));
        let v4 = &mut arg0.vault_config;
        let v5 = get_vault_config<T1>(v4);
        let v6 = &mut arg0.vault_reserves;
        let v7 = get_vault_reserve<T1>(v6);
        assert!(v5.maturity_epoch - 3 > 0x2::tx_context::epoch(arg2), 108);
        let v8 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::calculate_pt_debt_amount(v5.vault_apy, v1, v5.maturity_epoch, v3);
        let v9 = if (v3 >= v3) {
            v3 - v3
        } else {
            0
        };
        v5.debt_balance = v5.debt_balance + v9;
        let v10 = mint_pt<T1>(v7, v8, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PT_TOKEN<T1>>>(v10, 0x2::tx_context::sender(arg2));
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::migrate_event(token_to_name<T0>(), v3, token_to_name<T1>(), v8, 0x2::tx_context::sender(arg2), 0x2::tx_context::epoch(arg2));
    }

    public entry fun mint<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = mint_non_entry<T0>(arg0, arg1, arg2, arg3);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PT_TOKEN<T0>>>(v2, 0x2::tx_context::sender(arg3));
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::mint_event(token_to_name<T0>(), 0x3::staking_pool::staked_sui_amount(&arg2), 0x2::coin::value<PT_TOKEN<T0>>(&v2), 0x2::object::id<0x3::staking_pool::StakedSui>(&arg2), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    public entry fun mint_from_sui<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000000, 107);
        let v0 = get_random_validator_address(arg1.staking_pools, arg3);
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg0, arg2, v0, arg3);
        mint<T0>(arg0, arg1, v1, arg3);
    }

    public fun mint_non_entry<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PT_TOKEN<T0>>, u64) {
        let v0 = &mut arg1.vault_config;
        let v1 = get_vault_config<T0>(v0);
        let v2 = &mut arg1.vault_reserves;
        let v3 = get_vault_reserve<T0>(v2);
        assert!(v1.enable_mint == true, 106);
        assert!(v1.maturity_epoch - 3 > 0x2::tx_context::epoch(arg3), 108);
        assert!(0x3::staking_pool::staked_sui_amount(&arg2) >= 1000000000, 107);
        let v4 = 0x3::staking_pool::pool_id(&arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.staking_pool_ids, &v4), 109);
        let v5 = 0x3::staking_pool::staked_sui_amount(&arg2);
        if (0x1::option::is_some<u64>(&arg1.deposit_cap)) {
            assert!(*0x1::option::borrow<u64>(&arg1.deposit_cap) >= v5, 110);
            *0x1::option::borrow_mut<u64>(&mut arg1.deposit_cap) = *0x1::option::borrow<u64>(&arg1.deposit_cap) - v5;
        };
        let v6 = if (0x2::tx_context::epoch(arg3) > 0x3::staking_pool::stake_activation_epoch(&arg2)) {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stake_data_provider::earnings_from_staked_sui(arg0, &arg2, 0x2::tx_context::epoch(arg3))
        } else {
            0
        };
        0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v1.staked_sui, arg2);
        if (0x1::vector::length<0x3::staking_pool::StakedSui>(&v1.staked_sui) > 1) {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::sort_items(&mut v1.staked_sui);
        };
        let v7 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::calculate_pt_debt_amount(v1.vault_apy, 0x2::tx_context::epoch(arg3), v1.maturity_epoch, v5 + v6);
        assert!(v7 >= 1000000000, 111);
        v1.debt_balance = v1.debt_balance + v7 - v5;
        (mint_pt<T0>(v3, v7, arg3), v7 - v5 + v6)
    }

    fun mint_pt<T0>(arg0: &mut VaultReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PT_TOKEN<T0>> {
        0x2::coin::from_balance<PT_TOKEN<T0>>(0x2::balance::increase_supply<PT_TOKEN<T0>>(&mut arg0.pt_supply, arg1), arg2)
    }

    public entry fun new_vault<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64, arg3: u128, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 4, 105);
        let v0 = token_to_name<T0>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, VaultReserve<T0>>(&arg0.vault_reserves, v0), 101);
        let v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(arg3, arg4);
        let v2 = arg0.first_epoch_of_the_year + 90 * arg2;
        let v3 = VaultConfig{
            started_epoch  : 0x2::tx_context::epoch(arg5),
            maturity_epoch : v2,
            vault_apy      : v1,
            staked_sui     : 0x1::vector::empty<0x3::staking_pool::StakedSui>(),
            debt_balance   : 0,
            enable_mint    : true,
            enable_exit    : true,
            enable_redeem  : true,
        };
        let v4 = PT_TOKEN<T0>{dummy_field: false};
        let v5 = VaultReserve<T0>{pt_supply: 0x2::balance::create_supply<PT_TOKEN<T0>>(v4)};
        0x2::bag::add<0x1::string::String, VaultReserve<T0>>(&mut arg0.vault_reserves, v0, v5);
        0x2::table::add<0x1::string::String, VaultConfig>(&mut arg0.vault_config, v0, v3);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.vault_list, v0);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::new_vault_event(0x2::object::id<Global>(arg0), v0, 0x2::tx_context::epoch(arg5), v2, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::get_raw_value(v1));
    }

    fun normalize_into_ratio(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &vector<0x1::string::String>, arg2: &0x2::table::Table<0x1::string::String, VaultConfig>, arg3: u64, arg4: u64) : (vector<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>, vector<u64>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(arg1, v3);
            let v5 = 0x2::table::borrow<0x1::string::String, VaultConfig>(arg2, v4);
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&v5.staked_sui)) {
                let v7 = 0x1::vector::borrow<0x3::staking_pool::StakedSui>(&v5.staked_sui, v6);
                if (arg4 > 0x3::staking_pool::stake_activation_epoch(v7)) {
                    0x1::vector::push_back<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>(&mut v0, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::get_amount_with_rewards(arg0, v7, arg4) as u128), (arg3 as u128)));
                    0x1::vector::push_back<u64>(&mut v1, v6);
                    0x1::vector::push_back<0x1::string::String>(&mut v2, v4);
                };
                v6 = v6 + 1;
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    fun prepare_withdrawal(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal)) {
            let v0 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal);
            let (v1, v2) = find_one_with_minimal_excess(arg0, &arg1.vault_list, &arg1.vault_config, v0, 0x2::tx_context::epoch(arg3));
            let v3 = v2;
            let v4 = v1;
            if (0x1::option::is_none<u64>(&v3)) {
                let (v5, v6) = find_combination(arg0, &arg1.vault_list, &arg1.vault_config, v0, 0x2::tx_context::epoch(arg3));
                let v7 = unstake_staked_sui(arg0, arg1, v5, v6, arg3);
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_withdrawal, v7);
            } else {
                let v8 = 0x1::vector::empty<0x1::string::String>();
                let v9 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<0x1::string::String>(&mut v8, *0x1::option::borrow<0x1::string::String>(&v4));
                0x1::vector::push_back<u64>(&mut v9, *0x1::option::borrow<u64>(&v3));
                let v10 = unstake_staked_sui(arg0, arg1, v8, v9, arg3);
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_withdrawal, v10);
            };
        };
    }

    public entry fun redeem<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x2::coin::Coin<PT_TOKEN<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = redeem_non_entry<T0>(arg0, arg1, arg2, arg3);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg3));
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::redeem_event(token_to_name<T0>(), v1, 0x2::coin::value<0x2::sui::SUI>(&v2), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    public fun redeem_non_entry<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: 0x2::coin::Coin<PT_TOKEN<T0>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = &mut arg1.vault_config;
        let v1 = get_vault_config<T0>(v0);
        assert!(v1.enable_redeem == true, 106);
        assert!(0x2::tx_context::epoch(arg3) > v1.maturity_epoch, 112);
        assert!(0x2::coin::value<PT_TOKEN<T0>>(&arg2) >= 1000000000, 107);
        let v2 = 0x2::coin::value<PT_TOKEN<T0>>(&arg2);
        prepare_withdrawal(arg0, arg1, v2, arg3);
        let v3 = withdraw_sui(arg1, v2, arg3);
        let v4 = &mut arg1.vault_reserves;
        (v3, 0x2::balance::decrease_supply<PT_TOKEN<T0>>(&mut get_vault_reserve<T0>(v4).pt_supply, 0x2::coin::into_balance<PT_TOKEN<T0>>(arg2)))
    }

    public entry fun restake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: &mut ManagerCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 1000000000, 107);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal) >= arg3, 116);
        let v0 = arg1.vault_list;
        let v1 = get_random_validator_address(arg1.staking_pools, arg4);
        0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut 0x2::table::borrow_mut<0x1::string::String, VaultConfig>(&mut arg1.vault_config, *0x1::vector::borrow<0x1::string::String>(&arg1.vault_list, 0x1::vector::length<0x1::string::String>(&v0) - 1)).staked_sui, 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pending_withdrawal, arg3), arg4), v1, arg4));
    }

    public entry fun set_deposit_cap(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64) {
        if (arg2 == 0) {
            arg0.deposit_cap = 0x1::option::none<u64>();
        } else {
            arg0.deposit_cap = 0x1::option::some<u64>(arg2);
        };
    }

    public entry fun set_first_epoch(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64) {
        arg0.first_epoch_of_the_year = arg2;
    }

    public fun staking_pools(arg0: &Global) : vector<address> {
        arg0.staking_pools
    }

    fun token_to_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public entry fun topup_redemption_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_withdrawal, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun unstake_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Global, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::reduce_pool_list(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&v1, v2);
            let v4 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib::filter_asset_ids(v3, arg2, arg3);
            while (0x1::vector::length<u64>(&v4) > 0) {
                let v5 = 0x2::table::borrow_mut<0x1::string::String, VaultConfig>(&mut arg1.vault_config, v3);
                let v6 = 0x1::vector::swap_remove<0x3::staking_pool::StakedSui>(&mut v5.staked_sui, 0x1::vector::pop_back<u64>(&mut v4));
                let v7 = 0x3::staking_pool::staked_sui_amount(&v6);
                let v8 = 0x3::sui_system::request_withdraw_stake_non_entry(arg0, v6, arg4);
                let v9 = if (0x2::balance::value<0x2::sui::SUI>(&v8) >= v7) {
                    0x2::balance::value<0x2::sui::SUI>(&v8) - v7
                } else {
                    0
                };
                0x2::balance::join<0x2::sui::SUI>(&mut v0, v8);
                let v10 = if (v5.debt_balance >= v9) {
                    v5.debt_balance - v9
                } else {
                    0
                };
                v5.debt_balance = v10;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun update_exit_fee(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u128, arg3: u128) {
        arg0.exit_fee = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(arg2, arg3);
    }

    public entry fun update_vault_apy<T0>(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u128, arg3: u128) {
        let v0 = &mut arg0.vault_config;
        let v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(arg2, arg3);
        get_vault_config<T0>(v0).vault_apy = v1;
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::update_vault_apy_event(0x2::object::id<Global>(arg0), token_to_name<T0>(), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::get_raw_value(v1));
    }

    public entry fun withdraw_redemption_pool(arg0: &mut Global, arg1: &mut ManagerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun withdraw_sui(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal) >= arg1, 113);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

