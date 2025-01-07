module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets {
    struct LendingParams<phantom T0, phantom T1, phantom T2> {
        scallop_params: 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_vault_interface::ScallopVaultParams<T0, T1>,
    }

    public fun total_lending_assets<T0, T1, T2>(arg0: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: &mut LendingParams<T0, T1, T2>) : u64 {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_vault_interface::total_assets<T0, T1>(&mut arg1.scallop_params)
    }

    // decompiled from Move bytecode v6
}

