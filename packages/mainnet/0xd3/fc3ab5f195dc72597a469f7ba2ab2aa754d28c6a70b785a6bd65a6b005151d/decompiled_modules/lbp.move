module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp {
    struct LBPParams has store {
        is_proj_on_x: bool,
        start_weight: u64,
        final_weight: u64,
        is_vault: bool,
        target_amount: u64,
        total_amount_collected: u64,
        enable_buy_with_pair: bool,
        enable_buy_with_vault: bool,
    }

    struct LBPStorage has store {
        coins: 0x2::bag::Bag,
        pending_in: vector<0x1::string::String>,
        pending_in_amount: u64,
    }

    public(friend) fun add_pending_in<T0>(arg0: &mut LBPStorage, arg1: 0x2::coin::Coin<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>, arg2: u64) {
        let v0 = token_to_name<T0>();
        if (!0x2::bag::contains_with_type<0x1::string::String, 0x2::balance::Balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>>(&arg0.coins, v0)) {
            let v1 = 0x2::balance::zero<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>();
            0x2::balance::join<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(&mut v1, 0x2::coin::into_balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(arg1));
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>>(&mut arg0.coins, v0, v1);
        } else {
            0x2::balance::join<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>>(&mut arg0.coins, v0), 0x2::coin::into_balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(arg1));
        };
        arg0.pending_in_amount = arg0.pending_in_amount + arg2;
        if (!0x1::vector::contains<0x1::string::String>(&arg0.pending_in, &v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.pending_in, v0);
        };
    }

    public(friend) fun construct_init_params(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : LBPParams {
        assert!(arg1 >= 5000 && arg1 < 10000, 301);
        assert!(arg2 >= 5000 && arg2 < 10000, 301);
        assert!(arg1 > arg2, 301);
        LBPParams{
            is_proj_on_x           : arg0,
            start_weight           : arg1,
            final_weight           : arg2,
            is_vault               : arg3,
            target_amount          : arg4,
            total_amount_collected : 0,
            enable_buy_with_pair   : true,
            enable_buy_with_vault  : true,
        }
    }

    public(friend) fun create_empty_storage(arg0: &mut 0x2::tx_context::TxContext) : LBPStorage {
        LBPStorage{
            coins             : 0x2::bag::new(arg0),
            pending_in        : 0x1::vector::empty<0x1::string::String>(),
            pending_in_amount : 0,
        }
    }

    public(friend) fun current_weight(arg0: &LBPParams) : (u64, u64) {
        let v0 = if (arg0.total_amount_collected >= arg0.target_amount) {
            arg0.final_weight
        } else if (10000 > arg0.total_amount_collected) {
            arg0.start_weight
        } else {
            let v1 = if (arg0.start_weight > arg0.final_weight) {
                arg0.start_weight - arg0.final_weight
            } else {
                0
            };
            assert!(v1 > 0, 301);
            let v2 = if (arg0.target_amount > arg0.total_amount_collected) {
                (arg0.total_amount_collected as u128)
            } else {
                (arg0.target_amount as u128)
            };
            arg0.start_weight - (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((v1 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(v2, (arg0.target_amount as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((arg0.final_weight as u128), (arg0.start_weight as u128)))) as u64)
        };
        if (arg0.is_proj_on_x) {
            (v0, 10000 - v0)
        } else {
            (10000 - v0, v0)
        }
    }

    public(friend) fun enable_buy_with_pair(arg0: &mut LBPParams, arg1: bool) {
        arg0.enable_buy_with_pair = arg1;
    }

    public(friend) fun enable_buy_with_vault(arg0: &mut LBPParams, arg1: bool) {
        arg0.enable_buy_with_vault = arg1;
    }

    public(friend) fun is_buy(arg0: &LBPParams) : bool {
        arg0.is_proj_on_x && false || true
    }

    public fun is_vault(arg0: &LBPParams) : bool {
        arg0.is_vault
    }

    public fun pending_in_amount(arg0: &LBPStorage) : u64 {
        arg0.pending_in_amount
    }

    public fun proj_on_x(arg0: &LBPParams) : bool {
        arg0.is_proj_on_x
    }

    public(friend) fun set_new_target_amount(arg0: &mut LBPParams, arg1: u64) {
        assert!(arg1 > arg0.total_amount_collected, 307);
        arg0.target_amount = arg1;
    }

    public fun token_to_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun total_amount_collected(arg0: &LBPParams) : u64 {
        arg0.total_amount_collected
    }

    public fun total_target_amount(arg0: &LBPParams) : u64 {
        arg0.target_amount
    }

    public(friend) fun verify_and_adjust_amount(arg0: &mut LBPParams, arg1: bool, arg2: u64, arg3: u64, arg4: bool) {
        if (arg0.target_amount > arg0.total_amount_collected) {
            if (arg1) {
                assert!(arg0.target_amount > arg2, 306);
                if (arg4) {
                    assert!(arg0.enable_buy_with_vault, 309);
                } else {
                    assert!(arg0.enable_buy_with_pair, 308);
                };
                arg0.total_amount_collected = arg0.total_amount_collected + arg2;
            };
        };
    }

    public(friend) fun withdraw_pending_in<T0>(arg0: &mut LBPStorage, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>> {
        let v0 = token_to_name<T0>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, 0x2::balance::Balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>>(&arg0.coins, v0), 304);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>>(&mut arg0.coins, v0);
        let v2 = 0x2::balance::value<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(v1);
        assert!(v2 > 0, 303);
        arg0.pending_in_amount = arg0.pending_in_amount - v2;
        0x2::coin::from_balance<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(0x2::balance::split<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(v1, v2), arg1)
    }

    // decompiled from Move bytecode v6
}

