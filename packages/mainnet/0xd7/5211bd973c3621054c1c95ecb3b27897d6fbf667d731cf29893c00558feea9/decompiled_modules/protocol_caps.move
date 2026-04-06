module 0x1222e054f9dff4d12dabbfd3b61103e5439ea56d390f49d813b163c20ebddd9a::protocol_caps {
    public fun borrow_alphafi_position_cap<T0, T1: store + key>(arg0: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::Vault<T0>, arg1: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::ProtocolAccessCap) : &T1 {
        0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut<T0, T1: store + key>(arg0: &mut 0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::Vault<T0>, arg1: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::ProtocolAccessCap) : &mut T1 {
        0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_bucket_account<T0, T1: store + key>(arg0: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::Vault<T0>, arg1: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::ProtocolAccessCap) : &T1 {
        0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"bucket_account")
    }

    public fun borrow_navi_account_cap<T0, T1: store + key>(arg0: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::Vault<T0>, arg1: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::ProtocolAccessCap) : &T1 {
        0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut<T0, T1: store + key>(arg0: &mut 0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::Vault<T0>, arg1: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::ProtocolAccessCap) : &mut T1 {
        0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_suilend_obligation_cap<T0, T1: store + key>(arg0: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::Vault<T0>, arg1: &0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::ProtocolAccessCap) : &T1 {
        0xb15e15f9541a3eb12989d950a319e037c71e3d422065221687372e7c36c70897::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"suilend_obligation_cap")
    }

    // decompiled from Move bytecode v6
}

