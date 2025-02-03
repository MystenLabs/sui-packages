module 0xf9b2124c650ce066963a5fa3a5d632f4680ce5ff24cdb0ec4e38fe6fdedf797f::exchange_rate {
    struct MetaVaultVSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun update_exchange_rate(arg0: &MetaVaultVSuiIntegration, arg1: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::update_exchange_rate<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg0.id, arg1, vsui_to_sui_exchange_rate(arg2, arg3));
    }

    public fun authorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultVSuiIntegration) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultVSuiIntegration) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun add_support_for_new_coin<T0>(arg0: &MetaVaultVSuiIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::coin::CoinMetadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg11: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg12: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg13: &mut 0x2::tx_context::TxContext) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::add_support_for_new_coin<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg13);
        update_exchange_rate(arg0, arg10, arg11, arg12);
    }

    public fun create_deposit_cap<T0>(arg0: &MetaVaultVSuiIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_deposit_cap<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg0.id, arg1, 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg2, arg1))
    }

    public fun create_withdraw_cap<T0>(arg0: &MetaVaultVSuiIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_withdraw_cap<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg0.id, arg1, 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg2, arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultVSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultVSuiIntegration>(v0);
    }

    fun vsui_to_sui_exchange_rate(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) : u128 {
        (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::exchange_rate_one_to_one() as u128) / (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::get_ratio(arg0, arg1) as u128)
    }

    // decompiled from Move bytecode v6
}

