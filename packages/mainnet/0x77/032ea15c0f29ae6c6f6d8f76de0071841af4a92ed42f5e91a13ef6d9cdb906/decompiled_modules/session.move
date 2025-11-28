module 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session {
    struct SessionCap<phantom T0> {
        vault: 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>,
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

    public fun swap<T0, T1, T2>(arg0: &mut SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::swap<T0, T1, T2>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg3)
    }

    public(friend) fun assert_can_be_mutated_by<T0, T1>(arg0: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::assert_can_be_mutated_by<T0, T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow<T0>(arg0), arg1);
    }

    public fun begin_force_withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ForceWithdrawCap<T0, T1> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        let (v0, v1, v2, v3, v4, v5) = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::begin_force_withdraw<T0, T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg0.total_value, arg3, arg4);
        ForceWithdrawCap<T0, T1>{
            lp_coin         : v0,
            coin_out        : v1,
            coin_out_amount : v2,
            coin_out_value  : v3,
            coin_out_index  : v4,
            recipient       : v5,
        }
    }

    public fun begin_session_tx<T0>(arg0: 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg3: &vector<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage>, arg4: &0x2::clock::Clock) : SessionCap<T0> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        let (v0, v1) = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::begin_session_tx<T0>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow<T0>(&arg0), arg2, arg3, arg4);
        SessionCap<T0>{
            vault       : arg0,
            total_value : v1,
            prices      : v0,
        }
    }

    public fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &SessionCap<T0>, arg1: T1) : &T2 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::borrow_extension<T0, T1, T2>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow<T0>(&arg0.vault), arg1)
    }

    public fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut SessionCap<T0>, arg1: T1) : &mut T2 {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::borrow_mut_extension<T0, T1, T2>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg1)
    }

    public fun coin_out_amount<T0, T1>(arg0: &ForceWithdrawCap<T0, T1>) : u64 {
        arg0.coin_out_amount
    }

    public fun deposit<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        let (v0, v1) = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::deposit<T0, T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg0.total_value, arg3, arg4);
        arg0.total_value = arg0.total_value + v1;
        v0
    }

    public fun deposit_into_extension<T0, T1, T2: copy + drop + store>(arg0: &mut SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: &T2, arg3: &0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        let (v0, v1) = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::deposit_into_extension<T0, T1, T2>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg2, arg3, &arg0.prices, arg0.total_value, arg4, arg5);
        arg0.total_value = arg0.total_value + v1;
        v0
    }

    public fun end_session_tx<T0>(arg0: SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        let SessionCap {
            vault       : v0,
            total_value : _,
            prices      : _,
        } = arg0;
        0x2::transfer::public_share_object<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>>(v0);
    }

    public fun end_update_liquidity_cache_and_begin_session_tx<T0>(arg0: 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg1: 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg4: &vector<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage>, arg5: &0x2::clock::Clock) : SessionCap<T0> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        let (v0, v1) = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::end_update_liquidity_cache_and_begin_session_tx<T0>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0), arg3, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::destroy<T0>(arg1), arg4, arg5);
        SessionCap<T0>{
            vault       : arg0,
            total_value : v1,
            prices      : v0,
        }
    }

    public fun finish_force_withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: ForceWithdrawCap<T0, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
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
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::finish_force_withdraw<T0, T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), v0, v6, v4, v5);
        arg0.total_value = arg0.total_value - v3;
    }

    public fun force_withdraw_from_extension<T0, T1, T2: copy + drop + store>(arg0: &mut SessionCap<T0>, arg1: &mut ForceWithdrawCap<T0, T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: T2, arg4: 0x2::coin::Coin<T1>) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg2);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::force_withdraw_from_extension<T0, T1, T2>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg3, &arg4);
        0x2::coin::join<T1>(&mut arg1.coin_out, arg4);
    }

    public(friend) fun prices<T0>(arg0: &SessionCap<T0>) : &vector<u256> {
        &arg0.prices
    }

    public fun process_pending_withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        arg0.total_value = arg0.total_value - 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::process_pending_withdraw<T0, T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), &arg0.prices, arg0.total_value, arg2);
    }

    public fun remaining_amount<T0, T1>(arg0: &ForceWithdrawCap<T0, T1>) : u64 {
        let v0 = 0x2::coin::value<T1>(&arg0.coin_out);
        if (v0 >= arg0.coin_out_amount) {
            0
        } else {
            arg0.coin_out_amount - v0
        }
    }

    public(friend) fun total_value<T0>(arg0: &SessionCap<T0>) : u256 {
        arg0.total_value
    }

    public fun withdraw<T0, T1>(arg0: &mut SessionCap<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::assert_package_version(arg1);
        let (v0, v1) = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::state::withdraw<T0, T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_mut<T0>(&mut arg0.vault), arg2, &arg0.prices, arg0.total_value, arg3, arg4);
        arg0.total_value = arg0.total_value - v1;
        v0
    }

    // decompiled from Move bytecode v6
}

