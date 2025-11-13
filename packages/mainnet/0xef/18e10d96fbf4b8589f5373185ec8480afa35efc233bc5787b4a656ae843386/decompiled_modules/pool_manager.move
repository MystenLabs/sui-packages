module 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::pool_manager {
    struct SuiPoolManager has store, key {
        id: 0x2::object::UID,
        original_sui_amount: u64,
        vsui_balance: 0x2::balance::Balance<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>,
        temp_sui_balance: 0x2::bag::Bag,
        enabled_manage: bool,
        target_sui_amount: u64,
        vsui_stake_pool: 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::StakePool,
        vsui_metadata: 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::Metadata<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>,
    }

    struct FundUpdated has copy, drop {
        original_sui_amount: u64,
        current_sui_amount: u64,
        vsui_balance_amount: u64,
        target_sui_amount: u64,
    }

    struct SuiKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::StakePool, arg1: 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::Metadata<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : SuiPoolManager {
        let v0 = SuiPoolManager{
            id                  : 0x2::object::new(arg4),
            original_sui_amount : arg2,
            vsui_balance        : 0x2::balance::zero<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(),
            temp_sui_balance    : 0x2::bag::new(arg4),
            enabled_manage      : false,
            target_sui_amount   : arg3,
            vsui_stake_pool     : arg0,
            vsui_metadata       : arg1,
        };
        let v1 = SuiKey{dummy_field: false};
        0x2::bag::add<SuiKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.temp_sui_balance, v1, 0x2::balance::zero<0x2::sui::SUI>());
        v0
    }

    public(friend) fun disable_manage(arg0: &mut SuiPoolManager, arg1: u64) {
        assert!(arg0.enabled_manage == true, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::paused());
        assert!(arg1 >= arg0.original_sui_amount, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::insufficient_balance());
        arg0.enabled_manage = false;
    }

    public(friend) fun enable_manage(arg0: &mut SuiPoolManager) {
        assert!(arg0.enabled_manage == false, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::paused());
        arg0.enabled_manage = true;
    }

    public(friend) fun get_treasury_sui_amount(arg0: &SuiPoolManager, arg1: u64) : u64 {
        let v0 = arg1 + 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::lst_amount_to_sui_amount(&arg0.vsui_stake_pool, &arg0.vsui_metadata, 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&arg0.vsui_balance));
        if (v0 > arg0.original_sui_amount) {
            return v0 - arg0.original_sui_amount
        };
        0
    }

    public(friend) fun prepare_before_withdraw<T0>(arg0: &mut SuiPoolManager, arg1: u64, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = &mut arg0.vsui_balance;
        let v1 = &mut arg0.vsui_stake_pool;
        let v2 = &mut arg0.vsui_metadata;
        if (!arg0.enabled_manage || arg2 >= arg1) {
            return 0x2::balance::zero<T0>()
        };
        0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::refresh(v1, v2, arg3, arg4);
        let v3 = 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::sui_amount_to_lst_amount(v1, v2, 0x1::u64::max(arg1 - arg2, 1000000000) + 1000);
        let v4 = v3;
        if (v3 + 1000000000 > 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v0)) {
            v4 = 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v0);
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::unstake(v1, v2, arg3, 0x2::coin::from_balance<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(0x2::balance::split<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v0, v4), arg4), arg4));
        let v6 = SuiKey{dummy_field: false};
        0x2::balance::join<0x2::sui::SUI>(0x2::bag::borrow_mut<SuiKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.temp_sui_balance, v6), v5);
        let v7 = SuiKey{dummy_field: false};
        let v8 = FundUpdated{
            original_sui_amount : arg0.original_sui_amount,
            current_sui_amount  : arg2,
            vsui_balance_amount : 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&arg0.vsui_balance),
            target_sui_amount   : arg0.target_sui_amount,
        };
        0x2::event::emit<FundUpdated>(v8);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<SuiKey, 0x2::balance::Balance<T0>>(&mut arg0.temp_sui_balance, v7), 0x2::balance::value<0x2::sui::SUI>(&v5))
    }

    public(friend) fun refresh_stake(arg0: &mut SuiPoolManager, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg0.enabled_manage) {
            return
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg1);
        let v1 = &mut arg0.vsui_balance;
        let v2 = 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v1);
        let v3 = &mut arg0.vsui_stake_pool;
        let v4 = &mut arg0.vsui_metadata;
        0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::refresh(v3, v4, arg2, arg3);
        let v5 = if (arg0.original_sui_amount > arg0.target_sui_amount) {
            arg0.target_sui_amount
        } else {
            arg0.original_sui_amount
        };
        if (v0 + 1000000000 < v5) {
            let v6 = 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::sui_amount_to_lst_amount(v3, v4, v5 - v0);
            let v7 = v6;
            if (v6 > v2) {
                v7 = v2;
            };
            if (v7 > 1000000000) {
                if (0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v1) < v7 + 1000000000) {
                    v7 = 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v1);
                };
                0x2::balance::join<0x2::sui::SUI>(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::unstake(v3, v4, arg2, 0x2::coin::from_balance<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(0x2::balance::split<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v1, v7), arg3), arg3)));
            };
        } else if (v0 > v5 + 1000000000) {
            0x2::balance::join<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v1, 0x2::coin::into_balance<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::stake(v3, v4, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, v0 - v5), arg3), arg3)));
        };
        let v8 = FundUpdated{
            original_sui_amount : arg0.original_sui_amount,
            current_sui_amount  : 0x2::balance::value<0x2::sui::SUI>(arg1),
            vsui_balance_amount : 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(v1),
            target_sui_amount   : arg0.target_sui_amount,
        };
        0x2::event::emit<FundUpdated>(v8);
    }

    public(friend) fun set_target_sui_amount(arg0: &mut SuiPoolManager, arg1: u64) {
        arg0.target_sui_amount = arg1;
    }

    public(friend) fun set_validator_weights_vsui(arg0: &mut SuiPoolManager, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::OperatorCap, arg3: 0x2::vec_map::VecMap<address, u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::set_validator_weights(&mut arg0.vsui_stake_pool, &mut arg0.vsui_metadata, arg1, arg2, arg3, arg4);
    }

    public(friend) fun take_vsui_from_treasury(arg0: &mut SuiPoolManager, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT> {
        0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::refresh(&mut arg0.vsui_stake_pool, &arg0.vsui_metadata, arg2, arg3);
        let v0 = 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::sui_amount_to_lst_amount(&arg0.vsui_stake_pool, &arg0.vsui_metadata, get_treasury_sui_amount(arg0, arg1));
        let v1 = v0;
        if (v0 > 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&arg0.vsui_balance)) {
            v1 = 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&arg0.vsui_balance);
        };
        assert!(0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&arg0.vsui_balance) == 0 || 0x2::balance::value<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&arg0.vsui_balance) > 1000000000, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::insufficient_balance());
        0x2::balance::split<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>(&mut arg0.vsui_balance, v1)
    }

    public(friend) fun unstake_vsui(arg0: &mut SuiPoolManager, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::cert::CERT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::stake_pool::unstake(&mut arg0.vsui_stake_pool, &mut arg0.vsui_metadata, arg1, arg2, arg3)
    }

    public(friend) fun update_deposit(arg0: &mut SuiPoolManager, arg1: u64) {
        arg0.original_sui_amount = arg0.original_sui_amount + arg1;
    }

    public(friend) fun update_withdraw(arg0: &mut SuiPoolManager, arg1: u64) {
        arg0.original_sui_amount = arg0.original_sui_amount - arg1;
    }

    // decompiled from Move bytecode v6
}

