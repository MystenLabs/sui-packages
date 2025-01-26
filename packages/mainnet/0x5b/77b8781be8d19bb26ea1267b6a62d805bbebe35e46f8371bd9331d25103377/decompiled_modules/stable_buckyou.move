module 0x5b77b8781be8d19bb26ea1267b6a62d805bbebe35e46f8371bd9331d25103377::stable_buckyou {
    struct StableBuckyou<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun buy<T0, T1>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::Pool<T0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &0x2::clock::Clock, arg4: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg5: u64, arg6: &mut 0x2::coin::Coin<T1>, arg7: 0x1::option::Option<address>, arg8: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg9: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        let v0 = arg5 * 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::price<T0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg2, arg3);
        let v1 = v0;
        let v2 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::try_get_referrer<T0>(arg1, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg4));
        if (0x1::option::is_some<address>(&v2) || 0x1::option::is_some<address>(&arg7)) {
            v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::referral_factor<T0>(arg0), v0));
        };
        let v3 = v1 / 1000 + 1;
        if (0x2::coin::value<T1>(arg6) < v3) {
            err_payment_not_enough();
        };
        let v4 = StableBuckyou<T0>{dummy_field: false};
        let v5 = 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::charge_reservoir_by_partner<T1, StableBuckyou<T0>>(arg8, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg6), v3), v4), arg10);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::entry::buy<T0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, arg2, arg3, arg9, arg5, &mut v5, arg7);
        v5
    }

    fun err_payment_not_enough() {
        abort 0
    }

    // decompiled from Move bytecode v6
}

