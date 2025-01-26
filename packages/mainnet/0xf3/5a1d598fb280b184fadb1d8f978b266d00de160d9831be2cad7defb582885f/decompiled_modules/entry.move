module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::entry {
    struct Buy<phantom T0> has copy, drop {
        account: address,
        referrer: 0x1::option::Option<address>,
        coin_type: 0x1::ascii::String,
        count: u64,
        payment: u64,
        is_rebuy: bool,
    }

    public fun buy<T0, T1>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg5: u64, arg6: &mut 0x2::coin::Coin<T1>, arg7: 0x1::option::Option<address>) {
        if (arg5 == 0) {
            err_buy_nothing();
        };
        let v0 = arg5 * 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::price<T0, T1>(arg2, arg3);
        let v1 = v0;
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg4);
        let v3 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::try_get_referrer<T0>(arg1, v2);
        if (0x1::option::is_some<address>(&v3) || 0x1::option::is_some<address>(&arg7)) {
            v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::referral_factor<T0>(arg0), v0));
        };
        if (v1 > 0x2::coin::value<T1>(arg6)) {
            err_payment_not_enough();
        };
        buy_internal<T0, T1>(arg0, arg1, arg2, arg3, v2, arg5, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg6), v1), arg7, false);
    }

    fun buy_internal<T0, T1>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: address, arg5: u64, arg6: 0x2::balance::Balance<T1>, arg7: 0x1::option::Option<address>, arg8: bool) {
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::assert_valid_package_version<T0>(arg0);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::assert_game_is_started<T0>(arg1, arg3);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::assert_game_is_not_ended<T0>(arg1, arg3);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_final<T0>(arg1, arg0, arg3, arg4, arg5);
        let v0 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::try_get_referrer<T0>(arg1, arg4);
        if (0x1::option::is_some<address>(&v0)) {
            arg7 = v0;
        };
        let v1 = 0x2::balance::value<T1>(&arg6);
        let v2 = if (0x1::option::is_some<address>(&arg7)) {
            let v3 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::holders_ratio<T0>(arg0), v1));
            let v4 = 0x2::balance::split<T1>(&mut arg6, v3);
            let v5 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::referrer_ratio<T0>(arg0), v1));
            0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut arg6, v5));
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::deposit<T0, T1>(arg2, 0x2::balance::split<T1>(&mut arg6, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::final_ratio<T0>(arg0), v1))), v4, arg6);
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_holders<T0, T1>(arg1, arg4, arg5, v3);
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_referrer<T0, T1>(arg1, arg0, arg4, arg7, v5)
        } else {
            let v6 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::div_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::referrer_ratio<T0>(arg0), 2);
            let v7 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::holders_ratio<T0>(arg0), v6), v1));
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::deposit<T0, T1>(arg2, 0x2::balance::split<T1>(&mut arg6, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::final_ratio<T0>(arg0), v6), v1))), 0x2::balance::split<T1>(&mut arg6, v7), arg6);
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_holders<T0, T1>(arg1, arg4, arg5, v7);
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_referrer<T0, T1>(arg1, arg0, arg4, arg7, 0)
        };
        let v8 = Buy<T0>{
            account   : arg4,
            referrer  : v2,
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            count     : arg5,
            payment   : v1,
            is_rebuy  : arg8,
        };
        0x2::event::emit<Buy<T0>>(v8);
    }

    fun err_buy_nothing() {
        abort 0
    }

    fun err_invalid_voucher() {
        abort 2
    }

    fun err_payment_not_enough() {
        abort 1
    }

    public fun rebuy<T0, T1>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg5: u64, arg6: 0x1::option::Option<address>) {
        if (arg5 == 0) {
            err_buy_nothing();
        };
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg4);
        let v1 = arg5 * 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::price<T0, T1>(arg2, arg3);
        let v2 = v1;
        let v3 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::try_get_referrer<T0>(arg1, v0);
        if (0x1::option::is_some<address>(&v3) || 0x1::option::is_some<address>(&arg6)) {
            v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::referral_factor<T0>(arg0), v1));
        };
        let v4 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::claim<T0, T1>(arg2, arg0, arg1, v0, v2);
        buy_internal<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, v4, arg6, true);
    }

    public fun redeem<T0, T1: store + key>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &0x2::clock::Clock, arg3: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg4: T1) {
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::assert_valid_package_version<T0>(arg0);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::assert_game_is_started<T0>(arg1, arg2);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::assert_game_is_not_ended<T0>(arg1, arg2);
        if (!0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::is_valid_voucher<T0, T1>(arg1)) {
            err_invalid_voucher();
        };
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg3);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_final<T0>(arg1, arg0, arg2, v0, 1);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::handle_redeem<T0, T1>(arg1, v0);
        let v1 = Buy<T0>{
            account   : v0,
            referrer  : 0x1::option::none<address>(),
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            count     : 1,
            payment   : 0,
            is_rebuy  : false,
        };
        0x2::event::emit<Buy<T0>>(v1);
        let v2 = 0x2::object::id<0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>>(arg1);
        0x2::transfer::public_transfer<T1>(arg4, 0x2::object::id_to_address(&v2));
    }

    // decompiled from Move bytecode v6
}

