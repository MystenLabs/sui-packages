module 0x2bbcbaa194debfc6d84ebcd3756346d1f684e2cd40ca40472cc9847afff039bc::market_utils {
    public entry fun claimCap<T0: store + key>(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0x2bbcbaa194debfc6d84ebcd3756346d1f684e2cd40ca40472cc9847afff039bc::version::VerAdminCap, arg1: &mut 0x2bbcbaa194debfc6d84ebcd3756346d1f684e2cd40ca40472cc9847afff039bc::version::Version, arg2: u64) {
        0x2bbcbaa194debfc6d84ebcd3756346d1f684e2cd40ca40472cc9847afff039bc::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register<T0>(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::registerArch<T0>(arg0, arg1);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

