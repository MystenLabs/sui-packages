module 0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::secure_vault {
    struct SecureVault<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun create_secure_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SecureVault<T0>{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SecureVault<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

