module 0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::entries {
    public entry fun claimCap<T0: store + key>(arg0: &mut 0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::version::VerAdminCap, arg1: &mut 0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::version::Version, arg2: u64) {
        0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::version::migrate(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xe4e7e581e13fbea7675eff691ac07fcc4941708c5ad48a5323d9cc688df6020c::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

