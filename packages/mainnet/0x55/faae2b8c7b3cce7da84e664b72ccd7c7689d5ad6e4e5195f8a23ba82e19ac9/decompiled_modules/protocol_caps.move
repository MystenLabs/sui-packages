module 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::protocol_caps {
    public fun borrow_alphafi_position_cap<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::ProtocolAccessCap) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut<T0, T1: store + key>(arg0: &mut 0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::ProtocolAccessCap) : &mut T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut_v2<T0, T1: store + key>(arg0: &mut 0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::StrategyRegistry) : &mut T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap_mut<T0, T1>(arg0, 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::borrow_protocol_access_cap(arg1), b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_v2<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::StrategyRegistry) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::borrow_protocol_access_cap(arg1), b"alphafi_position_cap")
    }

    public fun borrow_bucket_account<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::ProtocolAccessCap) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"bucket_account")
    }

    public fun borrow_bucket_account_v2<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::StrategyRegistry) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::borrow_protocol_access_cap(arg1), b"bucket_account")
    }

    public fun borrow_navi_account_cap<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::ProtocolAccessCap) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut<T0, T1: store + key>(arg0: &mut 0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::ProtocolAccessCap) : &mut T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut_v2<T0, T1: store + key>(arg0: &mut 0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::StrategyRegistry) : &mut T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap_mut<T0, T1>(arg0, 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::borrow_protocol_access_cap(arg1), b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_v2<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::StrategyRegistry) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::borrow_protocol_access_cap(arg1), b"navi_account_cap")
    }

    public fun borrow_suilend_obligation_cap<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::ProtocolAccessCap) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"suilend_obligation_cap")
    }

    public fun borrow_suilend_obligation_cap_v2<T0, T1: store + key>(arg0: &0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::Vault<T0>, arg1: &0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::StrategyRegistry) : &T1 {
        0x9023300062a83c5474a273ff78c67fc207f4e33a40914f52bfb40ce328d2e623::vault::borrow_protocol_cap<T0, T1>(arg0, 0x55faae2b8c7b3cce7da84e664b72ccd7c7689d5ad6e4e5195f8a23ba82e19ac9::strategy::borrow_protocol_access_cap(arg1), b"suilend_obligation_cap")
    }

    // decompiled from Move bytecode v6
}

