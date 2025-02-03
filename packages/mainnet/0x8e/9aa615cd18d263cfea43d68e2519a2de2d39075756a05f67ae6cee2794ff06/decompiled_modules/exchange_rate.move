module 0x8e9aa615cd18d263cfea43d68e2519a2de2d39075756a05f67ae6cee2794ff06::exchange_rate {
    struct MetaVaultSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultSuiIntegration) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::authorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0>(arg0: &MetaVaultSuiIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, 0x2::sui::SUI> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_deposit_cap<T0, 0x2::sui::SUI>(&arg0.id, arg1, 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, 0x2::sui::SUI>(arg2, arg1))
    }

    public fun create_withdraw_cap<T0>(arg0: &MetaVaultSuiIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, 0x2::sui::SUI> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_withdraw_cap<T0, 0x2::sui::SUI>(&arg0.id, arg1, 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, 0x2::sui::SUI>(arg2, arg1))
    }

    public fun deauthorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultSuiIntegration) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultSuiIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

