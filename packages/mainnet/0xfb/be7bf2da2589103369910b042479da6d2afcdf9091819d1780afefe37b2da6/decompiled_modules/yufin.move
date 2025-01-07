module 0xfbbe7bf2da2589103369910b042479da6d2afcdf9091819d1780afefe37b2da6::yufin {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        lp: 0x2::balance::Supply<LpCoin<T0, T1>>,
        protocol_fee_a: 0x2::balance::Balance<T0>,
        protocol_fee_b: 0x2::balance::Balance<T1>,
        fee_rate: u64,
        fee_scale: u64,
        protocol_fee_share: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LpCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::supply_value<LpCoin<T0, T1>>(&arg0.lp) != 0) {
            assert!(0x2::balance::value<T0>(&arg0.coin_a) * 1000000 / 0x2::balance::value<T1>(&arg0.coin_b) == 0x2::coin::value<T0>(&arg1) * 1000000 / 0x2::coin::value<T1>(&arg2), 144);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LpCoin<T0, T1>>>(0x2::coin::from_balance<LpCoin<T0, T1>>(0x2::balance::increase_supply<LpCoin<T0, T1>>(&mut arg0.lp, 0x2::math::sqrt(0x2::coin::value<T0>(&arg1)) * 0x2::math::sqrt(0x2::coin::value<T1>(&arg2))), arg3), 0x2::tx_context::sender(arg3));
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun collect_protocol_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.protocol_fee_a);
        let v1 = 0x2::balance::value<T1>(&arg1.protocol_fee_b);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_fee_a, v0), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.protocol_fee_b, v1), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun create_pool<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LpCoin<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg4),
            coin_a             : 0x2::balance::zero<T0>(),
            coin_b             : 0x2::balance::zero<T1>(),
            lp                 : 0x2::balance::create_supply<LpCoin<T0, T1>>(v0),
            protocol_fee_a     : 0x2::balance::zero<T0>(),
            protocol_fee_b     : 0x2::balance::zero<T1>(),
            fee_rate           : arg1,
            fee_scale          : arg3,
            protocol_fee_share : arg2,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LpCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LpCoin<T0, T1>>(&arg1);
        let v1 = 0x2::balance::supply_value<LpCoin<T0, T1>>(&arg0.lp);
        0x2::balance::decrease_supply<LpCoin<T0, T1>>(&mut arg0.lp, 0x2::coin::into_balance<LpCoin<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, 0x2::balance::value<T0>(&arg0.coin_a) * 1000000 / v1 * v0 / 1000000), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, 0x2::balance::value<T1>(&arg0.coin_b) * 1000000 / v1 * v0 / 1000000), arg2), 0x2::tx_context::sender(arg2));
    }

    fun safe_div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 != 0, 146);
        arg0 / arg1
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 == 0 || arg0 * arg1 / arg0 == arg1, 146);
        arg0 * arg1
    }

    public entry fun swap_to_coina<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = safe_div(safe_mul(v0, arg0.fee_rate), arg0.fee_scale);
        let v2 = v0 - v1;
        let v3 = safe_div(safe_mul(0x2::balance::value<T0>(&arg0.coin_a), v2), 0x2::balance::value<T1>(&arg0.coin_b) + v2);
        assert!(v3 >= arg2, 145);
        let v4 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.protocol_fee_b, 0x2::balance::split<T1>(&mut v4, safe_div(safe_mul(v1, arg0.protocol_fee_share), arg0.fee_scale)));
        0x2::balance::join<T1>(&mut arg0.coin_b, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v3), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_to_coinb<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = safe_div(safe_mul(v0, arg0.fee_rate), arg0.fee_scale);
        let v2 = v0 - v1;
        let v3 = safe_div(safe_mul(0x2::balance::value<T1>(&arg0.coin_b), v2), 0x2::balance::value<T0>(&arg0.coin_a) + v2);
        assert!(v3 >= arg2, 145);
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.protocol_fee_a, 0x2::balance::split<T0>(&mut v4, safe_div(safe_mul(v1, arg0.protocol_fee_share), arg0.fee_scale)));
        0x2::balance::join<T0>(&mut arg0.coin_a, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v3), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

