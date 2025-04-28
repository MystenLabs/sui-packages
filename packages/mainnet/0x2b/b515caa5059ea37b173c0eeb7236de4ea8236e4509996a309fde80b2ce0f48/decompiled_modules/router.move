module 0x2bb515caa5059ea37b173c0eeb7236de4ea8236e4509996a309fde80b2ce0f48::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    public fun deepbook_swap_base_to_quote_sponsored_with_return<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x94966c5c324ff7a79f0bf863b251abf37bc161331011f1defa95e6e6f67eb563::sponsored_deep::DeepPool, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1) = 0x94966c5c324ff7a79f0bf863b251abf37bc161331011f1defa95e6e6f67eb563::sponsored_deep::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        destroy_or_transfer<T0>(v0, arg5);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun deepbook_swap_quote_to_base_sponsored_with_return<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x94966c5c324ff7a79f0bf863b251abf37bc161331011f1defa95e6e6f67eb563::sponsored_deep::DeepPool, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = 0x94966c5c324ff7a79f0bf863b251abf37bc161331011f1defa95e6e6f67eb563::sponsored_deep::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        destroy_or_transfer<T1>(v1, arg5);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 < arg1) {
            abort 1
        };
        let v1 = OrderRecord{
            order_id   : arg4,
            decimal    : arg5,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        if (arg2 > 0) {
            let v2 = &mut arg0;
            let (v3, _) = split_with_percentage_for_commission<T0>(v2, arg2, arg3, arg6);
            destroy_or_transfer<T0>(v3, arg6);
            destroy_or_transfer<T0>(arg0, arg6);
        } else {
            destroy_or_transfer<T0>(arg0, arg6);
        };
    }

    public fun scallop_swap_exact_swap_a2b_with_return<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        abort 0
    }

    public fun scallop_swap_exact_swap_b2a_with_return<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        abort 0
    }

    public fun split_with_percentage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = (((v0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg0, v1, arg2), v1, 0x2::coin::split<T0>(arg0, v0 - v1, arg2), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 300, 3);
        assert!(arg1 == 0 || arg1 > 0 && arg2 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg3);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referal_address   : arg2,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

