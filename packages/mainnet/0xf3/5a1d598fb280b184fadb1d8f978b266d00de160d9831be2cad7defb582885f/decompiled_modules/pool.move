module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool {
    struct PoolBalances<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        final_balance: u64,
        holders_balance: u64,
        dev_balance: u64,
    }

    struct FinalWinners<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        winners: vector<address>,
        prizes: vector<u64>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        price: u64,
        timestamp: u64,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        final_balance: 0x2::balance::Balance<T1>,
        holders_balance: 0x2::balance::Balance<T1>,
        dev_balance: 0x2::balance::Balance<T1>,
    }

    public fun new<T0, T1>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = Pool<T0, T1>{
            id              : 0x2::object::new(arg2),
            price           : 0,
            timestamp       : 0,
            rules           : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            final_balance   : 0x2::balance::zero<T1>(),
            holders_balance : 0x2::balance::zero<T1>(),
            dev_balance     : 0x2::balance::zero<T1>(),
        };
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::add_pool<T0>(arg1, 0x1::type_name::get<T1>(), 0x2::object::id<Pool<T0, T1>>(&v0));
        emit_pool_balances<T0, T1>(&v0);
        v0
    }

    public fun add_rule<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rules, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rules, v0);
        };
    }

    public(friend) fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg3: address, arg4: u64) : 0x2::balance::Balance<T1> {
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::assert_valid_package_version<T0>(arg1);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::update_user_state<T0>(arg2, arg3, 0x1::option::none<address>());
        if (!0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::user_profiles<T0>(arg2), arg3)) {
            err_account_not_found();
        };
        let v0 = 0x1::type_name::get<T1>();
        let (_, _) = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::claim(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states_mut(0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::user_profiles_mut<T0>(arg2), arg3)), &v0), arg4);
        emit_pool_balances<T0, T1>(arg0);
        0x2::balance::split<T1>(&mut arg0.holders_balance, arg4)
    }

    public fun claim_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg3: &0x2::clock::Clock, arg4: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::assert_game_is_ended<T0>(arg2, arg3);
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg4);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::realtime_holders_reward<T0>(arg2, v0, &v1) + 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::realtime_referral_reward<T0>(arg2, v0, &v1);
        0x2::coin::from_balance<T1>(claim<T0, T1>(arg0, arg1, arg2, v0, v2), arg5)
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.final_balance, arg1);
        0x2::balance::join<T1>(&mut arg0.holders_balance, arg2);
        0x2::balance::join<T1>(&mut arg0.dev_balance, arg3);
        emit_pool_balances<T0, T1>(arg0);
    }

    public fun dev_claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        emit_pool_balances<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.dev_balance), arg2)
    }

    entry fun dev_claim_to<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(dev_claim<T0, T1>(arg0, arg1, arg3), arg2);
    }

    fun emit_pool_balances<T0, T1>(arg0: &Pool<T0, T1>) {
        let v0 = PoolBalances<T0, T1>{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            final_balance   : 0x2::balance::value<T1>(&arg0.final_balance),
            holders_balance : 0x2::balance::value<T1>(&arg0.holders_balance),
            dev_balance     : 0x2::balance::value<T1>(&arg0.dev_balance),
        };
        0x2::event::emit<PoolBalances<T0, T1>>(v0);
    }

    fun err_account_not_found() {
        abort 2
    }

    fun err_final_pool_not_enough_to_settle() {
        abort 3
    }

    fun err_invalid_update_price_rule() {
        abort 0
    }

    fun err_price_feed_outdated() {
        abort 1
    }

    public fun final_balance<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.final_balance
    }

    public fun holders_balance<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.holders_balance
    }

    public fun price<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.timestamp != 0x2::clock::timestamp_ms(arg1)) {
            err_price_feed_outdated();
        };
        arg0.price
    }

    public fun remove_rule<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
        };
    }

    public fun settle_winners<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::assert_valid_package_version<T0>(arg1);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::assert_game_is_ended<T0>(arg2, arg3);
        let v0 = vector[];
        let v1 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::winners<T0>(arg2);
        let v2 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::winner_distribution<T0>(arg1);
        let v3 = 0x1::vector::length<address>(v1);
        assert!(v3 == 0x1::vector::length<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(v2), 9223372788474052607);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(*0x1::vector::borrow<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(v2, v4), 0x2::balance::value<T1>(&arg0.final_balance)));
            if (v5 == 0) {
                err_final_pool_not_enough_to_settle();
            };
            0x1::vector::push_back<u64>(&mut v0, v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.final_balance, v5), arg4), *0x1::vector::borrow<address>(v1, v4));
            v4 = v4 + 1;
        };
        emit_pool_balances<T0, T1>(arg0);
        let v6 = FinalWinners<T0, T1>{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg0),
            winners : *0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::winners<T0>(arg2),
            prizes  : v0,
        };
        0x2::event::emit<FinalWinners<T0, T1>>(v6);
    }

    public fun supply<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.final_balance, 0x2::coin::into_balance<T1>(arg1));
        emit_pool_balances<T0, T1>(arg0);
    }

    public fun update_price<T0, T1, T2: drop>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: T2, arg3: u64) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rules, &v0)) {
            err_invalid_update_price_rule();
        };
        arg0.price = arg3;
        arg0.timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

