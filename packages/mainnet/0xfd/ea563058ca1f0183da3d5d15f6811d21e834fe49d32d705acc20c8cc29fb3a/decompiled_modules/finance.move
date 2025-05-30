module 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance {
    struct FinanceCap has key {
        id: 0x2::object::UID,
    }

    struct Finance has store, key {
        id: 0x2::object::UID,
        pcs: 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::ProfitCS,
        users: 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::UserPool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        investment_id: u64,
        investment_table: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>,
        version: u64,
    }

    struct UserInfo has copy, drop {
        root: address,
        user: address,
        inviter: address,
    }

    struct BindInviter has copy, drop {
        index: u64,
        user: address,
        inviter: address,
    }

    struct Stake has copy, drop {
        id: u64,
        amount: u64,
        amount_gold: u64,
        sender: address,
    }

    struct Claim has copy, drop {
        stake_id: u64,
        claim_reward: u64,
        claim_amount: u64,
        subsidy: u64,
        claim_fee: u64,
        sender: address,
    }

    struct Unstake has copy, drop {
        id: u64,
        recover_amount: u64,
        sender: address,
    }

    struct UnstakeV2 has copy, drop {
        id: u64,
        recover_amount: u64,
        recover_amount_fee: u64,
        sender: address,
    }

    struct InvtInfo has copy, drop {
        id: u64,
        amount: u64,
        fee_rate: u64,
        profit_rate: u64,
        lock_period: u64,
        claimable_reward: u64,
        claim_fee: u64,
        lock_time: u64,
        start_release_time: u64,
    }

    public entry fun bind_inviter(arg0: &mut Finance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!valid_user(arg0, v0), 6);
        let v1 = BindInviter{
            index   : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::bind_inviter(&mut arg0.users, v0, arg1),
            user    : v0,
            inviter : arg1,
        };
        0x2::event::emit<BindInviter>(v1);
    }

    public entry fun bind_inviter_by_cap(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(!valid_user(arg1, arg2), 6);
        let v0 = BindInviter{
            index   : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::bind_inviter(&mut arg1.users, arg2, arg3),
            user    : arg2,
            inviter : arg3,
        };
        0x2::event::emit<BindInviter>(v0);
    }

    fun check_version(arg0: &Finance) {
        assert!(arg0.version == 9, 12);
    }

    public entry fun claim<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    fun claim_internal<T0>(arg0: address, arg1: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::ProfitCS, arg2: &mut 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment, arg3: &0x2::clock::Clock, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg5: bool) : (u64, u64) {
        let v0 = 0;
        let (v1, v2, v3, v4, v5) = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::calculate_rewards(arg2, arg1, 0x2::clock::timestamp_ms(arg3));
        let (v6, _, _, _) = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::profit_config_value(v5);
        if (arg5) {
            assert!(v1 > 0, 4);
        };
        if (v1 > 0) {
            0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::claim_reward(arg2, v4);
            let v10 = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice::get_amount_out_v2<T0>(arg4, arg3, v1 - v2, false);
            v0 = v10;
            let v11 = Claim{
                stake_id     : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::investment_id(arg2),
                claim_reward : v1,
                claim_amount : v10,
                subsidy      : v3,
                claim_fee    : v2,
                sender       : arg0,
            };
            0x2::event::emit<Claim>(v11);
        };
        (v0, v6)
    }

    public entry fun claim_v2<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(valid_user(arg0, v0), 13);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg0.investment_table, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&mut arg0.investment_table, v0);
        assert!(0x2::linked_table::contains<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v1, arg1), 7);
        let v2 = 0x2::linked_table::borrow_mut<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v1, arg1);
        let (v3, _) = claim_internal<T0>(v0, &arg0.pcs, v2, arg2, arg3, true);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v3, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg4), v0);
    }

    public entry fun fix_invt_value(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: u64, arg3: u64, arg4: address) {
        check_version(arg1);
        assert!(valid_user(arg1, arg4), 13);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg1.investment_table, arg4), 2);
        let v0 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&mut arg1.investment_table, arg4);
        assert!(0x2::linked_table::contains<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v0, arg2), 7);
        0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::fix_investment_value(0x2::linked_table::borrow_mut<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v0, arg2), arg3);
    }

    public entry fun fix_invt_value_batch(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<address>) {
        check_version(arg1);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 == 0x1::vector::length<address>(&arg4), 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = *0x1::vector::borrow<address>(&arg4, v1);
            assert!(valid_user(arg1, v3), 13);
            assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg1.investment_table, v3), 2);
            let v4 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&mut arg1.investment_table, v3);
            assert!(0x2::linked_table::contains<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v4, v2), 7);
            0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::fix_investment_value(0x2::linked_table::borrow_mut<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v4, v2), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xdea9b48962a9256fc05c28a760a80054ae366f976a73d9fc01564118c9d26f3e;
        let v1 = FinanceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FinanceCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Finance{
            id               : 0x2::object::new(arg0),
            pcs              : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::create_profit_cs(86400000),
            users            : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::create_user_pool(v0, arg0),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            investment_id    : 0,
            investment_table : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(arg0),
            version          : 9,
        };
        0x2::transfer::public_share_object<Finance>(v2);
        let v3 = BindInviter{
            index   : 1,
            user    : v0,
            inviter : @0x0,
        };
        0x2::event::emit<BindInviter>(v3);
    }

    public entry fun init_investment_list(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        check_version(arg1);
        let v0 = if (0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3)) {
            if (0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4)) {
                0x1::vector::length<u64>(&arg4) == 0x1::vector::length<u64>(&arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = &mut arg1.pcs;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::add_profict_config(v1, *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2), *0x1::vector::borrow<u64>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2));
            v2 = v2 + 1;
        };
    }

    public entry fun invt_info(arg0: &Finance, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg0.investment_table, arg1), 8);
        let v0 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg0.investment_table, arg1);
        assert!(0x2::linked_table::contains<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v0, arg2), 9);
        let v1 = 0x2::linked_table::borrow<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v0, arg2);
        let (v2, v3, v4, v5, _) = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::investment_value(v1);
        let (v7, v8, _, v10, v11) = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::calculate_rewards(v1, &arg0.pcs, 0x2::clock::timestamp_ms(arg3));
        let (v12, v13, _, _) = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::profit_config_value(v11);
        let v16 = InvtInfo{
            id                 : v2,
            amount             : v3,
            fee_rate           : v12,
            profit_rate        : v13,
            lock_period        : v10,
            claimable_reward   : v7,
            claim_fee          : v8,
            lock_time          : v4,
            start_release_time : v5,
        };
        0x2::event::emit<InvtInfo>(v16);
    }

    public entry fun migrate(arg0: &mut FinanceCap, arg1: &mut Finance) {
        assert!(arg1.version < 9, 11);
        arg1.version = 9;
    }

    public entry fun recharge_balance_pool(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun reward(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 5);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, *0x1::vector::borrow<u64>(&arg3, v1)), arg4), *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun stake<T0>(arg0: &mut Finance, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun stake_v2<T0>(arg0: &mut Finance, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(valid_user(arg0, v0), 13);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        };
        let v1 = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice::get_amount_out_v2<T0>(arg4, arg3, arg1, true);
        let v2 = arg0.investment_id + 1;
        arg0.investment_id = v2;
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg0.investment_table, v0)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&mut arg0.investment_table, v0, 0x2::linked_table::new<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(arg5));
        };
        0x2::linked_table::push_back<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&mut arg0.investment_table, v0), v2, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::create_investment(v2, v1, &arg0.pcs, 0x2::clock::timestamp_ms(arg3)));
        let v3 = Stake{
            id          : v2,
            amount      : arg1,
            amount_gold : v1,
            sender      : v0,
        };
        0x2::event::emit<Stake>(v3);
    }

    public entry fun unstake<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun unstake_force<T0>(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun unstake_force_v2<T0>(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        unstake_internal<T0>(arg1, arg2, arg3, arg4, arg6, 0x1::option::some<address>(arg5));
    }

    fun unstake_internal<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg4: &mut 0x2::tx_context::TxContext, arg5: 0x1::option::Option<address>) {
        check_version(arg0);
        let v0 = if (0x1::option::is_none<address>(&arg5)) {
            0x2::tx_context::sender(arg4)
        } else {
            0x1::option::extract<address>(&mut arg5)
        };
        assert!(valid_user(arg0, v0), 13);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&arg0.investment_table, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>>(&mut arg0.investment_table, v0);
        assert!(0x2::linked_table::contains<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v1, arg1), 9);
        let v2 = 0x2::linked_table::borrow_mut<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v1, arg1);
        let (v3, v4) = claim_internal<T0>(v0, &arg0.pcs, v2, arg2, arg3, false);
        let (v5, v6, _, _, _) = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::investment_value(v2);
        0x2::linked_table::remove<u64, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment::Investment>(v1, v5);
        let v10 = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice::get_amount_out_v2<T0>(arg3, arg2, v6, false);
        let v11 = v10 * v4 / 10000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v3 + v10 - v11, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3 + v10 - v11), arg4), v0);
        let v12 = Unstake{
            id             : arg1,
            recover_amount : v10,
            sender         : v0,
        };
        0x2::event::emit<Unstake>(v12);
        let v13 = UnstakeV2{
            id                 : arg1,
            recover_amount     : v10,
            recover_amount_fee : v11,
            sender             : v0,
        };
        0x2::event::emit<UnstakeV2>(v13);
    }

    public entry fun unstake_v2<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        unstake_internal<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<address>());
    }

    public fun user_info(arg0: &Finance, arg1: address) {
        check_version(arg0);
        let v0 = UserInfo{
            root    : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::root(&arg0.users),
            user    : arg1,
            inviter : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::find_inviter(&arg0.users, arg1),
        };
        0x2::event::emit<UserInfo>(v0);
    }

    public fun valid_user(arg0: &Finance, arg1: address) : bool {
        check_version(arg0);
        0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::invite::valid_user(&arg0.users, arg1)
    }

    // decompiled from Move bytecode v6
}

