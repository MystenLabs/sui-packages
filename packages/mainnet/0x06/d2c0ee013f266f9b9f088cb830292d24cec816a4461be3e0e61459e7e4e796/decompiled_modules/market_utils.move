module 0x6d2c0ee013f266f9b9f088cb830292d24cec816a4461be3e0e61459e7e4e796::market_utils {
    public entry fun claimCap<T0: store + key>(arg0: &mut 0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun migrateVersion(arg0: &0x6d2c0ee013f266f9b9f088cb830292d24cec816a4461be3e0e61459e7e4e796::version::VerAdminCap, arg1: &mut 0x6d2c0ee013f266f9b9f088cb830292d24cec816a4461be3e0e61459e7e4e796::version::Version, arg2: u64) {
        0x6d2c0ee013f266f9b9f088cb830292d24cec816a4461be3e0e61459e7e4e796::version::migrate(arg0, arg1, arg2);
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

