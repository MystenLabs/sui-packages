module 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_swap {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        reserve_meme: 0x2::balance::Balance<T0>,
        reserve_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        lock: bool,
    }

    struct CreatePoolEvent has copy, drop {
        account: address,
        pool_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        reserve_meme: u64,
        reserve_sui: u64,
    }

    struct SwapEvent has copy, drop {
        account: address,
        pool_id: 0x2::object::ID,
        meme_in_amount: u64,
        meme_out_amount: u64,
        sui_in_amount: u64,
        sui_out_amount: u64,
        reserve_meme: u64,
        reserve_sui: u64,
    }

    public entry fun buy_meme_coin<T0>(arg0: &mut Pool<T0>, arg1: &0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let (v1, v2) = get_reserves<T0>(arg0);
        let (v3, v4) = 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config::get_swap_fee(arg1);
        assert!(v0 > 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config::get_minimum_swap_amount(arg1), 0);
        let v5 = 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_utils::compute_amount_out(v0, v2, v1, v4, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_meme, v5), arg3), arg3);
        let v6 = SwapEvent{
            account         : 0x2::tx_context::sender(arg3),
            pool_id         : 0x2::object::id<Pool<T0>>(arg0),
            meme_in_amount  : 0,
            meme_out_amount : v5,
            sui_in_amount   : v0,
            sui_out_amount  : 0,
            reserve_meme    : v1,
            reserve_sui     : v2,
        };
        0x2::event::emit<SwapEvent>(v6);
    }

    entry fun create_pool<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 100000000000000000, 1);
        let v0 = Pool<T0>{
            id           : 0x2::object::new(arg4),
            reserve_meme : 0x2::coin::into_balance<T0>(arg2),
            reserve_sui  : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            lock         : false,
        };
        let v1 = CreatePoolEvent{
            account      : 0x2::tx_context::sender(arg4),
            pool_id      : 0x2::object::id<Pool<T0>>(&v0),
            treasury_id  : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg0),
            metadata_id  : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1),
            reserve_meme : 0x2::balance::value<T0>(&v0.reserve_meme),
            reserve_sui  : 0x2::balance::value<0x2::sui::SUI>(&v0.reserve_sui),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        0x2::event::emit<CreatePoolEvent>(v1);
    }

    public fun get_reserves<T0>(arg0: &Pool<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_meme), 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui))
    }

    public entry fun sell_meme_coin<T0>(arg0: &mut Pool<T0>, arg1: &0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2) = get_reserves<T0>(arg0);
        let (v3, v4) = 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config::get_swap_fee(arg1);
        assert!(v0 > 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config::get_minimum_swap_amount(arg1), 0);
        let v5 = 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_utils::compute_amount_out(v0, v1, v2, v4, v3);
        0x2::balance::join<T0>(&mut arg0.reserve_meme, 0x2::coin::into_balance<T0>(arg2));
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve_sui, v5), arg3), arg3);
        let v6 = SwapEvent{
            account         : 0x2::tx_context::sender(arg3),
            pool_id         : 0x2::object::id<Pool<T0>>(arg0),
            meme_in_amount  : v0,
            meme_out_amount : 0,
            sui_in_amount   : 0,
            sui_out_amount  : v5,
            reserve_meme    : v1,
            reserve_sui     : v2,
        };
        0x2::event::emit<SwapEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

