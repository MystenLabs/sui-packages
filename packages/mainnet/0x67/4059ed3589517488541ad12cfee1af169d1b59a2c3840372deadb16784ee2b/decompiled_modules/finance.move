module 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::finance {
    struct FinanceCap has key {
        id: 0x2::object::UID,
    }

    struct Finance has store, key {
        id: 0x2::object::UID,
        pcs: 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::ProfitCS,
        users: 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite::UserPool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        investment_id: u64,
        investment_table: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>,
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
            index   : 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite::bind_inviter(&mut arg0.users, v0, arg1),
            user    : v0,
            inviter : arg1,
        };
        0x2::event::emit<BindInviter>(v1);
    }

    fun check_version(arg0: &Finance) {
        assert!(arg0.version == 5, 12);
    }

    public entry fun claim<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&arg0.investment_table, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&mut arg0.investment_table, v0);
        assert!(0x2::linked_table::contains<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v1, arg1), 7);
        let v2 = 0x2::linked_table::borrow_mut<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v1, arg1);
        let v3 = claim_internal<T0>(v0, &arg0.pcs, v2, arg2, arg3, true);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v3, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg4), v0);
    }

    fun claim_internal<T0>(arg0: address, arg1: &0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::ProfitCS, arg2: &mut 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: bool) : u64 {
        let v0 = 0;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3, v4, _, _) = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::calculate_rewards(arg2, arg1, v1);
        if (arg5) {
            assert!(v2 > 0, 4);
        };
        if (v2 > 0) {
            0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::reset_investment_release_time(arg2, arg1, v1);
            let v7 = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::suiprice::get_amount_out<T0>(arg4, v2 - v3, false);
            v0 = v7;
            let v8 = Claim{
                stake_id     : 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::investment_id(arg2),
                claim_reward : v2,
                claim_amount : v7,
                subsidy      : v4,
                claim_fee    : v3,
                sender       : arg0,
            };
            0x2::event::emit<Claim>(v8);
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xdea9b48962a9256fc05c28a760a80054ae366f976a73d9fc01564118c9d26f3e;
        let v1 = FinanceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FinanceCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Finance{
            id               : 0x2::object::new(arg0),
            pcs              : 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::create_profit_cs(86400000),
            users            : 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite::create_user_pool(v0, arg0),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            investment_id    : 0,
            investment_table : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(arg0),
            version          : 5,
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
            0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::add_profict_config(v1, *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2), *0x1::vector::borrow<u64>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2));
            v2 = v2 + 1;
        };
    }

    public entry fun invt_info(arg0: &Finance, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&arg0.investment_table, arg1), 8);
        let v0 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&arg0.investment_table, arg1);
        assert!(0x2::linked_table::contains<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v0, arg2), 9);
        let v1 = 0x2::linked_table::borrow<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v0, arg2);
        let (v2, v3, v4, v5, _) = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::investment_value(v1);
        let (v7, v8, _, v10, v11) = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::calculate_rewards(v1, &arg0.pcs, 0x2::clock::timestamp_ms(arg3));
        let (v12, v13, _, _) = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::profit_config_value(v11);
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
        assert!(arg1.version < 5, 11);
        arg1.version = 5;
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
        check_version(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        };
        let v1 = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::suiprice::get_amount_out<T0>(arg4, arg1, true);
        let v2 = arg0.investment_id + 1;
        arg0.investment_id = v2;
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&arg0.investment_table, v0)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&mut arg0.investment_table, v0, 0x2::linked_table::new<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(arg5));
        };
        0x2::linked_table::push_back<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&mut arg0.investment_table, v0), v2, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::create_investment(v2, v1, &arg0.pcs, 0x2::clock::timestamp_ms(arg3)));
        let v3 = Stake{
            id          : v2,
            amount      : arg1,
            amount_gold : v1,
            sender      : v0,
        };
        0x2::event::emit<Stake>(v3);
    }

    public entry fun unstake<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&arg0.investment_table, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>>(&mut arg0.investment_table, v0);
        assert!(0x2::linked_table::contains<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v1, arg1), 9);
        let v2 = 0x2::linked_table::borrow_mut<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v1, arg1);
        let v3 = claim_internal<T0>(v0, &arg0.pcs, v2, arg2, arg3, false);
        let (v4, v5, _, _, _) = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::investment_value(v2);
        0x2::linked_table::remove<u64, 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment::Investment>(v1, v4);
        let v9 = 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::suiprice::get_amount_out<T0>(arg3, v5, false);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v9 + v3, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3 + v9), arg4), v0);
        let v10 = Unstake{
            id             : arg1,
            recover_amount : v9,
            sender         : v0,
        };
        0x2::event::emit<Unstake>(v10);
    }

    public fun user_info(arg0: &Finance, arg1: address) {
        check_version(arg0);
        let v0 = UserInfo{
            root    : 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite::root(&arg0.users),
            user    : arg1,
            inviter : 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite::find_inviter(&arg0.users, arg1),
        };
        0x2::event::emit<UserInfo>(v0);
    }

    public fun valid_user(arg0: &Finance, arg1: address) : bool {
        check_version(arg0);
        0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite::valid_user(&arg0.users, arg1)
    }

    // decompiled from Move bytecode v6
}

