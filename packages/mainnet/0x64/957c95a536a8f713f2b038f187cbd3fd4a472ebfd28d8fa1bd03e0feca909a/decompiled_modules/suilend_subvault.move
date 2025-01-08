module 0x64957c95a536a8f713f2b038f187cbd3fd4a472ebfd28d8fa1bd03e0feca909a::suilend_subvault {
    struct SuilendVault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        reserve_array_index: u64,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        deposits_open: bool,
    }

    // decompiled from Move bytecode v6
}

