module 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::protocol_caps {
    public fun borrow_alphafi_position_cap<T0, T1: store + key>(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap) : &T1 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut<T0, T1: store + key>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap) : &mut T1 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_bucket_account<T0, T1: store + key>(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap) : &T1 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"bucket_account")
    }

    public fun borrow_navi_account_cap<T0, T1: store + key>(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap) : &T1 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut<T0, T1: store + key>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap) : &mut T1 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_suilend_obligation_cap<T0, T1: store + key>(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap) : &T1 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"suilend_obligation_cap")
    }

    // decompiled from Move bytecode v6
}

