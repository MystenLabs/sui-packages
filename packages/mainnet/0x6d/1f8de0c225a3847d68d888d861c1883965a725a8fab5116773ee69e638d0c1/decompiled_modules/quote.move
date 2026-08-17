module 0x170fece09f519e982f5c9b17a18293efe7328dd685818b3082d12912b89ff490::quote {
    public fun metastable_afsui_deposit<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg3: u8) {
        metastable_record_deposit<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, arg2, arg3);
    }

    public fun metastable_afsui_withdraw<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg3: u8) {
        metastable_record_withdraw<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, arg2, arg3);
    }

    public fun metastable_deposit<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg3: u8) {
        metastable_record_deposit<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun metastable_deposit_out<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, T1>(arg1, arg0);
        let v1 = v0;
        if (v0 == 0) {
            return 0
        };
        let v2 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::exchange_rate_one_to_one();
        if (!0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::is_yield_bearing<T0>(arg0) && v0 > v2) {
            v1 = v2;
        };
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::multiply_and_divide(arg2, v1, v2)
    }

    fun metastable_record_deposit<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, metastable_deposit_out<T0, T1>(arg1, arg2, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun metastable_record_withdraw<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, metastable_withdraw_out<T0, T1>(arg1, arg2, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun metastable_withdraw<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg3: u8) {
        metastable_record_withdraw<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun metastable_withdraw_out<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, T1>(arg1, arg0);
        let v1 = v0;
        if (v0 == 0) {
            return 0
        };
        let v2 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::exchange_rate_one_to_one();
        if (!0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::is_yield_bearing<T0>(arg0) && v0 < v2) {
            v1 = v2;
        };
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::multiply_and_divide(arg2, v2, v1)
    }

    // decompiled from Move bytecode v7
}

