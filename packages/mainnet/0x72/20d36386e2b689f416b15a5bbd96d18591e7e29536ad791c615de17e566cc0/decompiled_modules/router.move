module 0x7220d36386e2b689f416b15a5bbd96d18591e7e29536ad791c615de17e566cc0::router {
    struct Commission has copy, drop {
        rate: u16,
        direction: bool,
        amount: u64,
        recipient: address,
        token_type: 0x1::ascii::String,
    }

    struct SwapRecord has copy, drop {
        dex: 0x1::string::String,
        token_in: 0x1::ascii::String,
        token_out: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
    }

    struct SwapLog has copy, drop {
        user: address,
        amount_in: u64,
        amount_out: u64,
        token_in: 0x1::ascii::String,
        token_out: 0x1::ascii::String,
    }

    public fun bluefin_spot_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), true, true, v0, 1, 4295048017);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg4);
        destroy_or_transfer<T0>(0x2::coin::from_balance<T0>(v1, arg4), arg4);
        let v4 = SwapRecord{
            dex        : 0x1::string::utf8(b"bluefin_spot"),
            token_in   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            token_out  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            amount_in  : v0,
            amount_out : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<SwapRecord>(v4);
        v3
    }

    public fun bluefin_spot_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), false, true, v0, 1, 79226673515401279992447579054);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg4);
        destroy_or_transfer<T1>(0x2::coin::from_balance<T1>(v2, arg4), arg4);
        let v4 = SwapRecord{
            dex        : 0x1::string::utf8(b"bluefin_spot"),
            token_in   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            token_out  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount_in  : v0,
            amount_out : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<SwapRecord>(v4);
        v3
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize_swap<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u16, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = (((0x2::coin::value<T1>(&arg0) as u128) * (arg3 as u128) / 10000) as u64);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0, v0, arg5), arg4);
            let v1 = Commission{
                rate       : arg3,
                direction  : false,
                amount     : v0,
                recipient  : arg4,
                token_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<Commission>(v1);
        };
        let v2 = 0x2::coin::value<T1>(&arg0);
        let v3 = SwapLog{
            user       : 0x2::tx_context::sender(arg5),
            amount_in  : arg1,
            amount_out : v2,
            token_in   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            token_out  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<SwapLog>(v3);
        assert!(v2 >= arg2, 4);
        arg0
    }

    public fun prepare_input_coins<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<u64>, arg3: u16, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(arg1 > 0, 0);
        assert!(arg3 <= 10000, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        let v0 = (((arg1 as u128) * (arg3 as u128) / 10000) as u64);
        let v1 = v0;
        0x1::vector::reverse<u64>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            v1 = v1 + 0x1::vector::pop_back<u64>(&mut arg2);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        assert!(v1 <= arg1, 3);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0, arg5), arg4);
            let v3 = Commission{
                rate       : arg3,
                direction  : true,
                amount     : v0,
                recipient  : arg4,
                token_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            };
            0x2::event::emit<Commission>(v3);
        };
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::reverse<u64>(&mut arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, 0x2::coin::split<T0>(&mut arg0, 0x1::vector::pop_back<u64>(&mut arg2), arg5));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        destroy_or_transfer<T0>(arg0, arg5);
        v4
    }

    public fun split_coin_with_weight<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64), arg2)
    }

    // decompiled from Move bytecode v6
}

