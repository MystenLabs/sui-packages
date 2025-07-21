module 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        allowed_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        max_price_delta_pips: u64,
        max_output_delta_pips: u64,
        fee_configs: vector<FeeConfig>,
        fee_balances: 0x2::bag::Bag,
        fee_wallet: address,
    }

    struct FeeConfig has drop, store {
        rebalance_fee_pips: u64,
        compound_fee_pips: u64,
        zap_fee_pips: u64,
        max_pool_fee: u64,
    }

    struct FeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        fee_source: 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::FeeSource,
        fee_token: 0x1::type_name::TypeName,
        fee_amount: u64,
    }

    fun type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun assert_output(arg0: &Registry, arg1: u64, arg2: u64) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        assert!(0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::safe_math::mul_div_u64(v0, 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips(), arg1) <= arg0.max_output_delta_pips, 4);
    }

    public fun assert_price(arg0: &Registry, arg1: u128, arg2: u128) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        assert!((0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::safe_math::mul_div_u128(v0, 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips_u128(), arg1) as u64) <= arg0.max_price_delta_pips, 3);
    }

    public(friend) fun assert_witness<T0>(arg0: &Registry) {
        assert!(arg0.version <= 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::current_version(), 0);
        let v0 = type_name<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_witnesses, &v0), 1);
    }

    public fun claim_fees<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.fee_wallet == 0x2::tx_context::sender(arg1), 5);
        let v0 = type_name<T0>();
        let v1 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balances, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balances, v0)
        } else {
            0x2::balance::zero<T0>()
        };
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    public fun collect_fees<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::FeeSource, arg3: &mut 0x2::balance::Balance<T0>, arg4: u64) {
        let v0 = 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::safe_math::mul_div_u64(0x2::balance::value<T0>(arg3), arg4, 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips());
        let v1 = type_name<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balances, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balances, v1), 0x2::balance::split<T0>(arg3, v0));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balances, v1, 0x2::balance::split<T0>(arg3, v0));
        };
        let v2 = FeeCollected{
            pool_id    : arg1,
            fee_source : arg2,
            fee_token  : v1,
            fee_amount : v0,
        };
        0x2::event::emit<FeeCollected>(v2);
    }

    public fun compound_fee_pips(arg0: &Registry, arg1: u64) : u64 {
        find_fee_config(arg0, arg1).compound_fee_pips
    }

    fun find_fee_config(arg0: &Registry, arg1: u64) : &FeeConfig {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeConfig>(&arg0.fee_configs)) {
            let v1 = 0x1::vector::borrow<FeeConfig>(&arg0.fee_configs, v0);
            if (arg1 <= v1.max_pool_fee) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                    : 0x2::object::new(arg0),
            version               : 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::current_version(),
            allowed_witnesses     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            max_price_delta_pips  : 25000,
            max_output_delta_pips : 500,
            fee_configs           : 0x1::vector::empty<FeeConfig>(),
            fee_balances          : 0x2::bag::new(arg0),
            fee_wallet            : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun insert_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, type_name<T0>());
    }

    public fun rebalance_fee_pips(arg0: &Registry, arg1: u64) : u64 {
        find_fee_config(arg0, arg1).rebalance_fee_pips
    }

    public fun remove_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        let v0 = type_name<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, &v0);
    }

    public fun update_fee_configs(arg0: &mut Registry, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &AdminCap) {
        let v0 = 0;
        let v1 = 0;
        arg0.fee_configs = 0x1::vector::empty<FeeConfig>();
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = if (*0x1::vector::borrow<u64>(&arg1, v1) < 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips()) {
                if (*0x1::vector::borrow<u64>(&arg2, v1) < 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips()) {
                    *0x1::vector::borrow<u64>(&arg3, v1) < 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips()
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 2);
            assert!(v0 < *0x1::vector::borrow<u64>(&arg4, v1) && *0x1::vector::borrow<u64>(&arg4, v1) < 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips(), 2);
            v0 = *0x1::vector::borrow<u64>(&arg4, v1);
            let v3 = FeeConfig{
                rebalance_fee_pips : *0x1::vector::borrow<u64>(&arg1, v1),
                compound_fee_pips  : *0x1::vector::borrow<u64>(&arg2, v1),
                zap_fee_pips       : *0x1::vector::borrow<u64>(&arg3, v1),
                max_pool_fee       : *0x1::vector::borrow<u64>(&arg4, v1),
            };
            0x1::vector::push_back<FeeConfig>(&mut arg0.fee_configs, v3);
            v1 = v1 + 1;
        };
    }

    public fun update_fee_wallet(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        arg0.fee_wallet = arg1;
    }

    public fun update_max_output_delta_pips(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 < 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips(), 2);
        arg0.max_output_delta_pips = arg1;
    }

    public fun update_max_price_delta_pips(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 < 0x73f83d41b277f91013af77fcaba98d66b5c4952afb3c43a432e2efd9815c6cf7::constants::scaling_pips(), 2);
        arg0.max_price_delta_pips = arg1;
    }

    public fun update_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    public fun zap_fee_pips(arg0: &Registry, arg1: u64) : u64 {
        find_fee_config(arg0, arg1).zap_fee_pips
    }

    // decompiled from Move bytecode v6
}

