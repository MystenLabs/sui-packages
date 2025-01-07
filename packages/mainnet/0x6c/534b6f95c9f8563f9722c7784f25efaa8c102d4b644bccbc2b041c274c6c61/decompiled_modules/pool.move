module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pair_price_feed_value: 0x1::string::String,
        pair_price_feed_type: 0x1::string::String,
        bet_coins_info: 0x2::table::Table<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>,
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        Pool<T0>{
            id                    : 0x2::object::new(arg3),
            name                  : arg0,
            pair_price_feed_value : arg1,
            pair_price_feed_type  : arg2,
            bet_coins_info        : 0x2::table::new<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(arg3),
        }
    }

    public(friend) fun add_bet_coin_info<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::PriceFeedState, arg2: &0x2::coin::CoinMetadata<T1>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = 0x1::string::from_ascii(0x2::coin::get_symbol<T1>(arg2));
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>();
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::update_price_feed_state(arg1, v1, arg3, arg4);
        0x2::table::add<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(&mut arg0.bet_coins_info, v0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::new(v0, v1, 0x2::coin::get_decimals<T1>(arg2), arg4));
    }

    public fun bet_coin_info<T0>(arg0: &Pool<T0>, arg1: 0x1::string::String) : &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo {
        0x2::table::borrow<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(&arg0.bet_coins_info, arg1)
    }

    public fun bet_coin_type<T0>(arg0: &Pool<T0>, arg1: 0x1::string::String) : 0x1::string::String {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::coin_type(0x2::table::borrow<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(&arg0.bet_coins_info, arg1))
    }

    public fun contains_bet_coin<T0, T1>(arg0: &Pool<T0>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(&arg0.bet_coins_info, arg1) && 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>() == bet_coin_type<T0>(arg0, arg1)
    }

    public fun name<T0>(arg0: &Pool<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun pair_price_feed_type<T0>(arg0: &Pool<T0>) : 0x1::string::String {
        arg0.pair_price_feed_type
    }

    public fun pair_price_feed_value<T0>(arg0: &Pool<T0>) : 0x1::string::String {
        arg0.pair_price_feed_value
    }

    public(friend) fun remove_bet_coin_info<T0, T1>(arg0: &mut Pool<T0>, arg1: &0x2::coin::CoinMetadata<T1>) {
        0x2::table::remove<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(&mut arg0.bet_coins_info, 0x1::string::from_ascii(0x2::coin::get_symbol<T1>(arg1)));
    }

    public(friend) fun share<T0>(arg0: Pool<T0>) {
        0x2::transfer::public_share_object<Pool<T0>>(arg0);
    }

    public(friend) fun update<T0>(arg0: &mut Pool<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg0.name = arg1;
        arg0.pair_price_feed_value = arg2;
        arg0.pair_price_feed_type = arg3;
    }

    public(friend) fun update_bet_coin_info<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::PriceFeedState, arg2: &0x2::coin::CoinMetadata<T1>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::update_price_feed_state(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>(), arg3, arg4);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::update_coin_info(0x2::table::borrow_mut<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo>(&mut arg0.bet_coins_info, 0x1::string::from_ascii(0x2::coin::get_symbol<T1>(arg2))), arg4);
    }

    // decompiled from Move bytecode v6
}

