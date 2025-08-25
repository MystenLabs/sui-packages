module 0x18c815edb99030944a5812fb66a72bd5980db23134c655d1c23becd46c3cf00d::slippage {
    struct SlippageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SlippageConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        positiveThreshold: vector<u64>,
        positiveMaxTake: vector<u64>,
        fee: 0x2::bag::Bag,
    }

    struct SwapEvent<phantom T0, phantom T1> has copy, drop {
        amount_in: u64,
        amount_out: u64,
        min_amount_out: u64,
        referral_code: u64,
    }

    struct SwapWithReferralEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        swap_initializer_address: address,
        receiver_address: address,
        from_coin_price: u64,
        from_coin_amount: u64,
        to_coin_price: u64,
        to_coin_amount: u64,
        reward_amount: u64,
        rewards_ratio: u64,
        referral_id: u64,
    }

    struct ExSwapWithReferralEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        swap_initializer_address: address,
        receiver_address: address,
        from_coin_price: u64,
        from_coin_amount: u128,
        to_coin_price: u64,
        to_coin_amount: u128,
        reward_amount: u128,
        rewards_ratio: u64,
        referral_id: u64,
    }

    struct PositiveSlippageEvent<phantom T0, phantom T1> has copy, drop {
        amount_in: u64,
        amount_in_value: u64,
        amount_out: u64,
        expected_amount_out: u64,
        take_amount: u64,
    }

    public fun calculate_max_take(arg0: &SlippageConfig, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.positiveThreshold)) {
            if (arg1 <= *0x1::vector::borrow<u64>(&arg0.positiveThreshold, v0)) {
                break
            };
            v0 = v0 + 1;
        };
        if (v0 == 0x1::vector::length<u64>(&arg0.positiveThreshold)) {
            v0 = v0 - 1;
        };
        *0x1::vector::borrow<u64>(&arg0.positiveMaxTake, v0) * arg2 / 10000
    }

    public fun check_slippage_v2<T0, T1>(arg0: &0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::coin::value<T1>(arg0) >= arg1, 10001);
        let v0 = SwapEvent<T0, T1>{
            amount_in      : arg2,
            amount_out     : 0x2::coin::value<T1>(arg0),
            min_amount_out : arg1,
            referral_code  : arg3,
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v0);
    }

    public fun check_slippage_v3<T0, T1>(arg0: &mut SlippageConfig, arg1: bool, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_slippage_v2<T0, T1>(arg2, arg3, arg5, arg7);
        let v0 = 0x2::coin::value<T1>(arg2);
        if (!arg1 || v0 <= arg4) {
            return
        };
        let v1 = v0 - arg4;
        let v2 = v1;
        let v3 = calculate_max_take(arg0, arg6, v0);
        if (v1 > v3) {
            v2 = v3;
        };
        let v4 = 0x1::type_name::get<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee, v4)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.fee, v4, 0x2::balance::zero<T1>());
        };
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.fee, v4), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v2, arg8)));
        let v5 = PositiveSlippageEvent<T0, T1>{
            amount_in           : arg5,
            amount_in_value     : arg6,
            amount_out          : v0,
            expected_amount_out : arg4,
            take_amount         : v2,
        };
        0x2::event::emit<PositiveSlippageEvent<T0, T1>>(v5);
    }

    fun convert_amount(arg0: u64, arg1: u8, arg2: u8) : u64 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public fun emit_referral_event<T0, T1, T2>(arg0: &0x2::coin::Coin<T1>, arg1: &0x2::coin::Coin<T2>, arg2: address, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        let v0 = ExSwapWithReferralEvent<T0, T1, T2>{
            swap_initializer_address : 0x2::tx_context::sender(arg11),
            receiver_address         : arg2,
            from_coin_price          : arg7,
            from_coin_amount         : ex_convert_amount((arg6 as u128), arg3, 9),
            to_coin_price            : arg8,
            to_coin_amount           : ex_convert_amount((0x2::coin::value<T1>(arg0) as u128), arg4, 9),
            reward_amount            : ex_convert_amount((0x2::coin::value<T2>(arg1) as u128), arg5, 9),
            rewards_ratio            : arg9,
            referral_id              : arg10,
        };
        0x2::event::emit<ExSwapWithReferralEvent<T0, T1, T2>>(v0);
    }

    fun ex_convert_amount(arg0: u128, arg1: u8, arg2: u8) : u128 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public fun get_config(arg0: &SlippageConfig) : (&vector<u64>, &vector<u64>, &0x2::bag::Bag) {
        (&arg0.positiveThreshold, &arg0.positiveMaxTake, &arg0.fee)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlippageConfig{
            id                : 0x2::object::new(arg0),
            version           : 1,
            positiveThreshold : 0x1::vector::empty<u64>(),
            positiveMaxTake   : 0x1::vector::empty<u64>(),
            fee               : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<SlippageConfig>(v0);
        let v1 = SlippageAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SlippageAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun init_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(arg0);
        assert!(@0x0 == 0x2::object::id_to_address(&v0), 1);
        let v1 = SlippageConfig{
            id                : 0x2::object::new(arg1),
            version           : 1,
            positiveThreshold : 0x1::vector::empty<u64>(),
            positiveMaxTake   : 0x1::vector::empty<u64>(),
            fee               : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<SlippageConfig>(v1);
        let v2 = SlippageAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SlippageAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun set_positive_ratio(arg0: &mut SlippageConfig, arg1: &SlippageAdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 1);
        assert!(0x1::vector::length<u64>(&arg2) > 0, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            if (v0 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg2, v0 - 1) < *0x1::vector::borrow<u64>(&arg2, v0), 1);
                assert!(*0x1::vector::borrow<u64>(&arg3, v0 - 1) > *0x1::vector::borrow<u64>(&arg3, v0), 1);
            };
            assert!(*0x1::vector::borrow<u64>(&arg3, v0) <= 200, 1);
            v0 = v0 + 1;
        };
        arg0.positiveThreshold = arg2;
        arg0.positiveMaxTake = arg3;
    }

    public fun withdraw_fee<T0>(arg0: &mut SlippageConfig, arg1: &SlippageAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee, 0x1::type_name::get<T0>())), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

