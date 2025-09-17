module 0x3477510fc35345cf6bc6abe09698da2b3907f138e9d4d104721bc18445a08f50::testing_tests {
    struct VaultRate has copy, drop {
        rate: u64,
    }

    entry fun fetch_vault_rate<T0, T1>(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>) {
        let v0 = VaultRate{rate: 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg0)};
        0x2::event::emit<VaultRate>(v0);
    }

    // decompiled from Move bytecode v6
}

