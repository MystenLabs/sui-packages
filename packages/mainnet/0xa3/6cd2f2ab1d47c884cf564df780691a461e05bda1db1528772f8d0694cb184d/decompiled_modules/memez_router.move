module 0x7cb654d8ae22bd18fff08f322d99fdf9d1673712812329b127430b155dc44ff::memez_router {
    public fun dump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T0, T1>, arg1: &mut 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::MemezWalletRegistry, arg2: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: u64, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = get_referrer_wallet(arg1, arg4, arg7);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::dump<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg7)
    }

    fun get_referrer_wallet(arg0: &mut 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::MemezWalletRegistry, arg1: 0x1::option::Option<address>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        if (0x1::option::is_none<address>(&arg1)) {
            arg1
        } else {
            get_wallet(arg0, 0x1::option::destroy_some<address>(arg1), arg2)
        }
    }

    fun get_wallet(arg0: &mut 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::MemezWalletRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        let v0 = 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::wallet_address(arg0, arg1);
        if (0x1::option::is_some<address>(&v0)) {
            v0
        } else {
            let v2 = 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::new(arg0, arg1, arg2);
            0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::share(v2);
            0x1::option::some<address>(0x2::object::id_address<0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::MemezWallet>(&v2))
        }
    }

    public fun new_with_developer_stake_holder<T0, T1, T2, T3>(arg0: &mut 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::MemezWalletRegistry, arg1: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::MemezConfig, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::PumpConfig, arg5: 0x2::coin::Coin<T1>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_metadata::MemezMetadata, arg7: bool, arg8: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : (0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T0, T1>, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = get_wallet(arg0, v0, arg9);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, 0x1::option::destroy_some<address>(v1));
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::new<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, v2, arg7, v0, arg8, arg9)
    }

    public fun pump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T0, T1>, arg1: &mut 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet::MemezWalletRegistry, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = get_referrer_wallet(arg1, arg3, arg7);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::pump<T0, T1>(arg0, arg2, v0, arg4, arg5, arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

