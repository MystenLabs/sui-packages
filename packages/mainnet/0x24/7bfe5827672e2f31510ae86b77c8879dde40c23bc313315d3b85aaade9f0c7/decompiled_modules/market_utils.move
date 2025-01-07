module 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::market_utils {
    public entry fun claimCap<T0: store + key>(arg0: &mut 0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::PolicyVaultCap>(0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy::createPolicy<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun migrateVersion(arg0: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::VerAdminCap, arg1: &mut 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg2: u64) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::migrate(arg0, arg1, arg2);
    }

    public entry fun register<T0>(arg0: &mut 0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::archieve::UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::archieve::registerArch<T0>(arg0, arg1);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

