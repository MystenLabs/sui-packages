module 0x89aa41b05b34bbc83bf9d0763e2fe7edde09d0d0f949ef0ca56481f35ae7c224::protocol_caps {
    public fun borrow_alphafi_position_cap<T0, T1: store + key>(arg0: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::Vault<T0>, arg1: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::ProtocolAccessCap) : &T1 {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut<T0, T1: store + key>(arg0: &mut 0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::Vault<T0>, arg1: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::ProtocolAccessCap) : &mut T1 {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_bucket_account<T0, T1: store + key>(arg0: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::Vault<T0>, arg1: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::ProtocolAccessCap) : &T1 {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"bucket_account")
    }

    public fun borrow_navi_account_cap<T0, T1: store + key>(arg0: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::Vault<T0>, arg1: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::ProtocolAccessCap) : &T1 {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut<T0, T1: store + key>(arg0: &mut 0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::Vault<T0>, arg1: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::ProtocolAccessCap) : &mut T1 {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_suilend_obligation_cap<T0, T1: store + key>(arg0: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::Vault<T0>, arg1: &0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::ProtocolAccessCap) : &T1 {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"suilend_obligation_cap")
    }

    // decompiled from Move bytecode v6
}

