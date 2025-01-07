module 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Request has drop, store {
        sender: address,
        amount: u64,
        epoch: u64,
    }

    struct Priority has drop, store {
        staking_pool: address,
        quota_amount: u64,
    }

    struct VaultReserve has store {
        lp_supply: 0x2::balance::Supply<VAULT>,
        staked_sui: 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>,
        min_liquidity: 0x2::balance::Balance<VAULT>,
    }

    struct VaultConfig has store {
        staking_pools: vector<address>,
        staking_pool_ids: vector<0x2::object::ID>,
        priority_list: vector<Priority>,
        deposit_cap: 0x1::option::Option<u64>,
        min_amount: u64,
        unstake_delay: u64,
        batch_amount: u64,
        enable_mint: bool,
        enable_redeem: bool,
        enable_auto_stake: bool,
    }

    struct VaultGlobal has key {
        id: 0x2::object::UID,
        config: VaultConfig,
        reserve: VaultReserve,
        pending_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_withdrawal: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_fulfil: 0x2::balance::Balance<0x2::sui::SUI>,
        request_list: vector<Request>,
        current_balance_with_rewards: u64,
        total_lp_amount: u64,
    }

    public entry fun add_priority(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: address, arg3: u64) {
        assert!(0x1::vector::contains<address>(&arg0.config.staking_pools, &arg2), 8);
        assert!(arg3 >= arg0.config.min_amount, 5);
        let v0 = Priority{
            staking_pool : arg2,
            quota_amount : arg3,
        };
        0x1::vector::push_back<Priority>(&mut arg0.config.priority_list, v0);
    }

    public entry fun attach_pool(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: address, arg3: 0x2::object::ID) {
        assert!(!0x1::vector::contains<address>(&arg0.config.staking_pools, &arg2), 3);
        0x1::vector::push_back<address>(&mut arg0.config.staking_pools, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.config.staking_pool_ids, arg3);
    }

    fun current_balance_with_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::table_vec::length<0x3::staking_pool::StakedSui>(arg1)) {
            let v2 = 0x2::table_vec::borrow<0x3::staking_pool::StakedSui>(arg1, v0);
            if (arg2 > 0x3::staking_pool::stake_activation_epoch(v2)) {
                let v3 = v1 + 0x3::staking_pool::staked_sui_amount(v2);
                v1 = v3 + 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::stake_data_provider::earnings_from_staked_sui(arg0, v2, arg2);
            } else {
                v1 = v1 + 0x3::staking_pool::staked_sui_amount(v2);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun detach_pool(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.config.staking_pools, &arg2);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.config.staking_pools, v1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.config.staking_pool_ids, v1);
    }

    public entry fun enable_auto_stake(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: bool) {
        arg0.config.enable_auto_stake = arg2;
    }

    public entry fun enable_mint(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: bool) {
        arg0.config.enable_mint = arg2;
    }

    public entry fun enable_redeem(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: bool) {
        arg0.config.enable_redeem = arg2;
    }

    public entry fun fulfil_request(arg0: &mut VaultGlobal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<Request>(&arg0.request_list) > 0, 12);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<Request>(&arg0.request_list)) {
            if (0x2::tx_context::epoch(arg1) >= 0x1::vector::borrow<Request>(&arg0.request_list, v0).epoch + arg0.config.unstake_delay) {
                0x1::vector::push_back<u64>(&mut v1, v0);
            };
            v0 = v0 + 1;
        };
        while (0x1::vector::length<u64>(&v1) > 0) {
            let v2 = 0x1::vector::swap_remove<Request>(&mut arg0.request_list, 0x1::vector::pop_back<u64>(&mut v1));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_fulfil, v2.amount), arg1), v2.sender);
            0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::event::redeem_event(0x2::object::id<VaultGlobal>(arg0), v2.amount, v2.sender, 0x2::tx_context::epoch(arg1));
        };
    }

    public fun get_amounts(arg0: &VaultGlobal) : (u64, u64) {
        (arg0.current_balance_with_rewards, arg0.total_lp_amount)
    }

    public fun get_pending_withdrawal_amount(arg0: &VaultGlobal) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"LV-SUI", b"Legato Vault Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.tamago.finance/legato-logo-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT>>(v2);
        let v3 = VaultConfig{
            staking_pools     : 0x1::vector::empty<address>(),
            staking_pool_ids  : 0x1::vector::empty<0x2::object::ID>(),
            priority_list     : 0x1::vector::empty<Priority>(),
            deposit_cap       : 0x1::option::none<u64>(),
            min_amount        : 100000000,
            unstake_delay     : 1,
            batch_amount      : 10000000000,
            enable_mint       : true,
            enable_redeem     : true,
            enable_auto_stake : false,
        };
        let v4 = VaultReserve{
            lp_supply     : 0x2::coin::treasury_into_supply<VAULT>(v1),
            staked_sui    : 0x2::table_vec::empty<0x3::staking_pool::StakedSui>(arg1),
            min_liquidity : 0x2::balance::zero<VAULT>(),
        };
        let v5 = VaultGlobal{
            id                           : 0x2::object::new(arg1),
            config                       : v3,
            reserve                      : v4,
            pending_stake                : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_withdrawal           : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_fulfil               : 0x2::balance::zero<0x2::sui::SUI>(),
            request_list                 : 0x1::vector::empty<Request>(),
            current_balance_with_rewards : 0,
            total_lp_amount              : 0,
        };
        0x2::transfer::share_object<VaultGlobal>(v5);
    }

    public entry fun mint_from_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_non_entry(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(v0, 0x2::tx_context::sender(arg3));
        0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::event::mint_event(0x2::object::id<VaultGlobal>(arg1), 0x2::coin::value<0x2::sui::SUI>(&arg2), 0x2::coin::value<VAULT>(&v0), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    fun mint_lp(arg0: &mut VaultReserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT> {
        0x2::coin::from_balance<VAULT>(0x2::balance::increase_supply<VAULT>(&mut arg0.lp_supply, arg1), arg2)
    }

    public fun mint_non_entry(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT> {
        assert!(arg1.config.enable_mint == true, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.config.min_amount, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_stake, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (0x1::option::is_some<u64>(&arg1.config.deposit_cap)) {
            assert!(*0x1::option::borrow<u64>(&arg1.config.deposit_cap) >= v0, 9);
            *0x1::option::borrow_mut<u64>(&mut arg1.config.deposit_cap) = *0x1::option::borrow<u64>(&arg1.config.deposit_cap) - v0;
        };
        let v1 = 0x2::balance::supply_value<VAULT>(&arg1.reserve.lp_supply);
        let v2 = current_balance_with_rewards(arg0, &arg1.reserve.staked_sui, 0x2::tx_context::epoch(arg3));
        let v3 = if (v1 == 0) {
            assert!(v0 > 1000, 10);
            0x2::balance::join<VAULT>(&mut arg1.reserve.min_liquidity, 0x2::balance::increase_supply<VAULT>(&mut arg1.reserve.lp_supply, 1000));
            v0 - 1000
        } else {
            (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v1 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v0 as u128), (v2 as u128))) as u64)
        };
        arg1.current_balance_with_rewards = v2 + v0;
        arg1.total_lp_amount = v1 + v3;
        if (arg1.config.enable_auto_stake == true) {
            transfer_stake(arg0, arg1, arg3);
        };
        let v4 = &mut arg1.reserve;
        mint_lp(v4, v3, arg3)
    }

    fun next_validator(arg0: &mut VaultGlobal, arg1: u64, arg2: &0x2::tx_context::TxContext) : address {
        if (0x1::vector::length<Priority>(&arg0.config.priority_list) > 0) {
            let v1 = 0x1::vector::borrow_mut<Priority>(&mut arg0.config.priority_list, 0);
            let v2 = if (v1.quota_amount > arg1) {
                v1.quota_amount - arg1
            } else {
                0
            };
            v1.quota_amount = v2;
            if (v2 == 0) {
                0x1::vector::swap_remove<Priority>(&mut arg0.config.priority_list, 0);
            };
            v1.staking_pool
        } else {
            random_validator_address(arg0.config.staking_pools, arg2)
        }
    }

    fun prepare_withdrawal(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal)) {
            let v0 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal);
            let v1 = 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault_lib::find_one_with_minimal_excess(arg0, &arg1.reserve.staked_sui, v0, 0x2::tx_context::epoch(arg3));
            if (0x1::option::is_none<u64>(&v1)) {
                let v2 = 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault_lib::find_combination(arg0, &arg1.reserve.staked_sui, v0, 0x2::tx_context::epoch(arg3));
                assert!(0x1::vector::length<u64>(&v2) > 0, 11);
                0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault_lib::sort_u64(&mut v2);
                let v3 = &mut v2;
                let v4 = unstake_staked_sui(arg0, arg1, v3, arg3);
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_withdrawal, v4);
            } else {
                let v5 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v5, *0x1::option::borrow<u64>(&v1));
                let v6 = &mut v5;
                let v7 = unstake_staked_sui(arg0, arg1, v6, arg3);
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_withdrawal, v7);
            };
        };
    }

    fun random_validator_address(arg0: vector<address>, arg1: &0x2::tx_context::TxContext) : address {
        *0x1::vector::borrow<address>(&arg0, (100 + 0x2::tx_context::epoch(arg1)) % 0x1::vector::length<address>(&arg0))
    }

    public entry fun remove_priority(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: u64) {
        assert!(0x1::vector::length<Priority>(&arg0.config.priority_list) > arg2, 2);
        0x1::vector::swap_remove<Priority>(&mut arg0.config.priority_list, arg2);
    }

    public entry fun request_redeem(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: 0x2::coin::Coin<VAULT>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<VAULT>(&arg2) >= arg1.config.min_amount, 5);
        assert!(arg1.config.enable_redeem == true, 7);
        let v0 = 0x2::coin::value<VAULT>(&arg2);
        let v1 = current_balance_with_rewards(arg0, &arg1.reserve.staked_sui, 0x2::tx_context::epoch(arg3));
        let v2 = (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v0 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v1 as u128), (0x2::balance::supply_value<VAULT>(&arg1.reserve.lp_supply) as u128))) as u64);
        prepare_withdrawal(arg0, arg1, v2, arg3);
        let v3 = withdraw_sui(arg1, v2, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_fulfil, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v4 = Request{
            sender : 0x2::tx_context::sender(arg3),
            amount : v2,
            epoch  : 0x2::tx_context::epoch(arg3),
        };
        0x1::vector::push_back<Request>(&mut arg1.request_list, v4);
        0x2::balance::decrease_supply<VAULT>(&mut arg1.reserve.lp_supply, 0x2::coin::into_balance<VAULT>(arg2));
        0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::event::request_redeem_event(0x2::object::id<VaultGlobal>(arg1), v0, v2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch(arg3));
    }

    public entry fun restake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: &mut ManagerCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg1.config.min_amount, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal) >= arg3, 6);
        let v0 = next_validator(arg1, arg3, arg4);
        0x2::table_vec::push_back<0x3::staking_pool::StakedSui>(&mut arg1.reserve.staked_sui, 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pending_withdrawal, arg3), arg4), v0, arg4));
    }

    public entry fun set_deposit_cap(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: u64) {
        if (arg2 == 0) {
            arg0.config.deposit_cap = 0x1::option::none<u64>();
        } else {
            arg0.config.deposit_cap = 0x1::option::some<u64>(arg2);
        };
    }

    public fun staking_pools(arg0: &VaultGlobal) : vector<address> {
        arg0.config.staking_pools
    }

    public entry fun topup_redemption_pool(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_withdrawal, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun transfer_stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_stake);
        if (v0 >= arg1.config.batch_amount) {
            let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.pending_stake, v0);
            let v2 = next_validator(arg1, v0, arg2);
            0x2::table_vec::push_back<0x3::staking_pool::StakedSui>(&mut arg1.reserve.staked_sui, 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), v2, arg2));
            if (0x2::table_vec::length<0x3::staking_pool::StakedSui>(&arg1.reserve.staked_sui) > 1) {
                0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault_lib::sort_items(&mut arg1.reserve.staked_sui);
            };
            arg1.config.batch_amount = 0;
        };
    }

    fun unstake_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: &mut vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::length<u64>(arg2) > 0) {
            let v1 = 0x2::table_vec::swap_remove<0x3::staking_pool::StakedSui>(&mut arg1.reserve.staked_sui, 0x1::vector::pop_back<u64>(arg2));
            0x3::staking_pool::staked_sui_amount(&v1);
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg0, v1, arg3));
        };
        v0
    }

    public entry fun update_amounts(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VaultGlobal, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.current_balance_with_rewards = current_balance_with_rewards(arg0, &arg1.reserve.staked_sui, 0x2::tx_context::epoch(arg2));
        arg1.total_lp_amount = 0x2::balance::supply_value<VAULT>(&arg1.reserve.lp_supply);
    }

    public entry fun update_batch_amount(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: u64) {
        assert!(arg2 > 0, 1);
        arg0.config.batch_amount = arg2;
    }

    public entry fun update_min_amount(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: u64) {
        assert!(arg2 > 0, 1);
        arg0.config.min_amount = arg2;
    }

    public entry fun update_unstake_delay(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: u64) {
        assert!(30 >= arg2, 2);
        arg0.config.unstake_delay = arg2;
    }

    public entry fun withdraw_redemption_pool(arg0: &mut VaultGlobal, arg1: &mut ManagerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun withdraw_sui(arg0: &mut VaultGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal) >= arg1, 2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

