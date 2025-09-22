module 0x6ba21b5e6d9932f7d28e8e5bbdced47a2b882f6ecac7a17ddaab7c4ad158650::working_cetus_integration {
    struct FeeCollectorConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        burn_percentage: u64,
        marketing_percentage: u64,
        reflection_percentage: u64,
        marketing_wallet: address,
        reflection_wallet: address,
    }

    public fun calculate_cetus_position_fees(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : (u64, u64) {
        let (v0, v1, v2, v3) = get_cetus_pool_state(arg0, arg2);
        let (v4, v5, v6, v7, v8) = get_cetus_position_info(arg1);
        let v9 = v4 * (calculate_fee_growth_inside(v0, v5, v6, v1, true) - v7) / (1 << 128);
        let v10 = v4 * (calculate_fee_growth_inside(v0, v5, v6, v2, false) - v8) / (1 << 128);
        let v11 = (v3 as u128);
        (((v9 - v9 * v11 / 10000) as u64), ((v10 - v10 * v11 / 10000) as u64))
    }

    fun calculate_fee_growth_inside(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: bool) : u128 {
        let v0 = sqrt_price_to_tick(arg0);
        if (v0 < arg1) {
            return 0
        };
        if (v0 >= arg2) {
            return 0
        };
        arg3
    }

    public fun call_cetus_collect_fee<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = calculate_cetus_position_fees(arg1, arg2, arg0);
        let v2 = extract_fees_from_cetus_pool<T0>(arg1, v0, arg3);
        (v2, extract_fees_from_cetus_pool<T1>(arg1, v1, arg3))
    }

    public entry fun collect_and_distribute_cetus_lp_fees<T0, T1>(arg0: &FeeCollectorConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.burn_percentage + arg0.marketing_percentage + arg0.reflection_percentage == 100, 0);
        let (v0, v1) = call_cetus_collect_fee<T0, T1>(arg1, arg2, arg3, arg4);
        let v2 = 0x2::coin::from_balance<T0>(v0, arg4);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg4);
        if (0x2::coin::value<T0>(&v2) > 0) {
            distribute_token<T0>(v2, arg0, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (0x2::coin::value<T1>(&v3) > 0) {
            distribute_token<T1>(v3, arg0, arg4);
        } else {
            0x2::coin::destroy_zero<T1>(v3);
        };
    }

    public entry fun distribute_cetus_fees_simple<T0, T1>(arg0: &FeeCollectorConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.burn_percentage + arg0.marketing_percentage + arg0.reflection_percentage == 100, 0);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            distribute_token<T0>(arg1, arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            distribute_token<T1>(arg2, arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
    }

    fun distribute_token<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &FeeCollectorConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg1.burn_percentage / 100, arg2), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg1.marketing_percentage / 100, arg2), arg1.marketing_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg1.reflection_percentage / 100, arg2), arg1.reflection_wallet);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun extract_fees_from_cetus_pool<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (arg1 > 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun get_cetus_package_address() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    fun get_cetus_pool_state(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : (u128, u128, u128, u64) {
        (79228162514264337593543950336, 1000000000000000, 2000000000000000, 300)
    }

    fun get_cetus_position_info(arg0: 0x2::object::ID) : (u128, u64, u64, u128, u128) {
        (1000000000000000000, 100, 200, 500000000000000, 1000000000000000)
    }

    public fun get_config(arg0: &FeeCollectorConfig) : (u64, u64, u64, address, address) {
        (arg0.burn_percentage, arg0.marketing_percentage, arg0.reflection_percentage, arg0.marketing_wallet, arg0.reflection_wallet)
    }

    public fun has_collectible_fees(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : bool {
        let (v0, v1) = calculate_cetus_position_fees(arg0, arg1, 0x2::object::id_from_address(@0x0));
        v0 > 0 || v1 > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorConfig{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            burn_percentage       : 50,
            marketing_percentage  : 30,
            reflection_percentage : 20,
            marketing_wallet      : @0x68518b69e0deeda44f738fc6986e9cf5ff810f78011ec6674bbe9a32770e8f5c,
            reflection_wallet     : @0x9bddab4e436885512b4d03ef64ca6ddaa87b00ec8c605cbcb680d29fbf60af9,
        };
        0x2::transfer::share_object<FeeCollectorConfig>(v0);
    }

    fun sqrt_price_to_tick(arg0: u128) : u64 {
        150
    }

    public entry fun update_config(arg0: &mut FeeCollectorConfig, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 3);
        assert!(arg1 + arg2 + arg3 == 100, 0);
        arg0.burn_percentage = arg1;
        arg0.marketing_percentage = arg2;
        arg0.reflection_percentage = arg3;
        arg0.marketing_wallet = arg4;
        arg0.reflection_wallet = arg5;
    }

    // decompiled from Move bytecode v6
}

