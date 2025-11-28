module 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::session {
    public fun deposit_into_extension<T0, T1, T2>(arg0: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::SessionCap<T0>, arg1: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::SessionCap<T1>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>> {
        let v0 = 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::create_extension_key();
        let v1 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::deposit<T1, T2>(arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::borrow_mut_extension<T0, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionKey, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionMetadataV1>(arg0, v0);
        0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::crank_unlocks<T1>(v2, arg4);
        0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::join<T1>(v2, v1, 0x2::coin::value<T1>(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::borrow<0x2::coin::Coin<T1>>(&v1)), arg4);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::deposit_into_extension<T0, T2, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionKey>(arg0, arg2, &v0, &arg3, arg4, arg5)
    }

    public fun crank_unlocks<T0, T1>(arg0: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::SessionCap<T0>, arg1: &0x2::clock::Clock) {
        0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::crank_unlocks<T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::borrow_mut_extension<T0, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionKey, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionMetadataV1>(arg0, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::create_extension_key()), arg1);
    }

    public fun withdraw_from_extension<T0, T1, T2>(arg0: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::SessionCap<T0>, arg1: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::ForceWithdrawCap<T0, T2>, arg2: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::SessionCap<T1>, arg3: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::create_extension_key();
        let v1 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::borrow_mut_extension<T0, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionKey, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionMetadataV1>(arg0, v0);
        0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::crank_unlocks<T1>(v1, arg5);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::force_withdraw_from_extension<T0, T2, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::ExtensionKey>(arg0, arg1, arg3, v0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::session::withdraw<T1, T2>(arg2, arg3, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state::split<T1>(v1, arg4, arg6), arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

