module 0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::deposit {
    public entry fun deposit<T0, T1, T2>(arg0: &mut 0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::version::assert_current_version(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7), 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

