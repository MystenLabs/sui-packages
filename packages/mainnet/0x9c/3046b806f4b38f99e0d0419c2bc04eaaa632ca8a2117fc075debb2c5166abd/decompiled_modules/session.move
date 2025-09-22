module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::session {
    struct SessionCap<phantom T0> {
        vault: 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::Vault<T0>,
        total_value: u256,
        prices: vector<u256>,
    }

    struct ForceWithdrawCap<phantom T0, phantom T1> {
        lp_coin: 0x2::coin::Coin<T0>,
        coin_out: 0x2::coin::Coin<T1>,
        coin_out_amount: u64,
        coin_out_value: u256,
        coin_out_index: u64,
        recipient: address,
    }

    public(friend) fun assert_can_be_mutated_by<T0, T1>(arg0: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::assert_can_be_mutated_by<T0, T1>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow<T0>(arg0), arg1);
    }

    public fun begin_force_withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ForceWithdrawCap<T0, T1> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        let (v0, v1, v2, v3, v4, v5) = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::begin_force_withdraw<T0, T1>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg0.total_value, arg3, arg4);
        ForceWithdrawCap<T0, T1>{
            lp_coin         : v0,
            coin_out        : v1,
            coin_out_amount : v2,
            coin_out_value  : v3,
            coin_out_index  : v4,
            recipient       : v5,
        }
    }

    public fun begin_session_tx<T0>(arg0: 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::Vault<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: &vector<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>, arg3: &0x2::clock::Clock) : SessionCap<T0> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        let (v0, v1) = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::begin_session_tx<T0>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow<T0>(&arg0), arg2, arg3);
        SessionCap<T0>{
            vault       : arg0,
            total_value : v1,
            prices      : v0,
        }
    }

    public(friend) fun borrow_extension_key<T0, T1: copy + drop + store, T2: store + key>(arg0: &SessionCap<T0>, arg1: T1) : &T2 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::borrow_extension<T0, T1, T2>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow<T0>(&arg0.vault), arg1)
    }

    public(friend) fun borrow_mut_extension_key<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut SessionCap<T0>, arg1: T1) : &mut T2 {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::borrow_mut_extension<T0, T1, T2>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), arg1)
    }

    public fun coin_out_amount<T0, T1>(arg0: &ForceWithdrawCap<T0, T1>) : u64 {
        arg0.coin_out_amount
    }

    public fun deposit<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked::Locked<0x2::coin::Coin<T0>> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        let (v0, v1) = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::deposit<T0, T1>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg0.total_value, arg3, arg4);
        arg0.total_value = arg0.total_value + v1;
        v0
    }

    public fun end_session_tx<T0>(arg0: SessionCap<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        let SessionCap {
            vault       : v0,
            total_value : _,
            prices      : _,
        } = arg0;
        0x2::transfer::public_share_object<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::Vault<T0>>(v0);
    }

    public fun end_update_liquidity_cache_and_begin_session_tx<T0>(arg0: 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::Vault<T0>, arg1: 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: &vector<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>, arg4: &0x2::clock::Clock) : SessionCap<T0> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        let (v0, v1) = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::end_update_liquidity_cache_and_begin_session_tx<T0>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0), 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::cache::destroy<T0>(arg1), arg3, arg4);
        SessionCap<T0>{
            vault       : arg0,
            total_value : v1,
            prices      : v0,
        }
    }

    public fun finish_force_withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: ForceWithdrawCap<T0, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        let ForceWithdrawCap {
            lp_coin         : v0,
            coin_out        : v1,
            coin_out_amount : v2,
            coin_out_value  : v3,
            coin_out_index  : v4,
            recipient       : v5,
        } = arg1;
        let v6 = v1;
        assert!(0x2::coin::value<T1>(&v6) == v2, 0);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::finish_force_withdraw<T0, T1>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), v0, v6, v4, v5, arg3);
        arg0.total_value = arg0.total_value - v3;
    }

    public fun force_deposit_funds_into_extension<T0, T1, T2: copy + drop + store>(arg0: &mut SessionCap<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: &T2, arg3: &0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked::Locked<0x2::coin::Coin<T0>> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        let (v0, v1) = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::force_deposit_funds_into_extension<T0, T1, T2>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), arg2, arg3, &arg0.prices, arg0.total_value, arg4, arg5);
        arg0.total_value = arg0.total_value + v1;
        v0
    }

    public fun force_withdraw_funds<T0, T1, T2: copy + drop + store>(arg0: &mut SessionCap<T0>, arg1: &mut ForceWithdrawCap<T0, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: T2, arg4: 0x2::coin::Coin<T1>) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg2);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::force_withdraw_funds<T0, T1, T2>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), arg3, &arg4);
        0x2::coin::join<T1>(&mut arg1.coin_out, arg4);
    }

    public(friend) fun prices<T0>(arg0: &SessionCap<T0>) : &vector<u256> {
        &arg0.prices
    }

    public fun process_pending_withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        arg0.total_value = arg0.total_value - 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::process_pending_withdraw<T0, T1>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), &arg0.prices, arg0.total_value, arg2);
    }

    public(friend) fun total_value<T0>(arg0: &SessionCap<T0>) : u256 {
        arg0.total_value
    }

    public fun withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_package_version(arg1);
        let (v0, v1) = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state::withdraw<T0, T1>(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg0.total_value, arg3, arg4);
        arg0.total_value = arg0.total_value - v1;
        v0
    }

    // decompiled from Move bytecode v6
}

