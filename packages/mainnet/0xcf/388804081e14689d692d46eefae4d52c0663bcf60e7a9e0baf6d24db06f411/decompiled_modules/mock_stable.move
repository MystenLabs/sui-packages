module 0xcf388804081e14689d692d46eefae4d52c0663bcf60e7a9e0baf6d24db06f411::mock_stable {
    struct MOCK_STABLE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_STABLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_STABLE>>(0x2::coin::mint<MOCK_STABLE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_STABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOCK_STABLE>(arg0, 6, 0x1::string::utf8(b"TSTABLE"), 0x1::string::utf8(b"Test Stable"), 0x1::string::utf8(b"Mock stable coin for testnet DAO testing"), 0x1::string::utf8(b"https://cryptologos.cc/logos/usd-coin-usdc-logo.png"), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MOCK_STABLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MOCK_STABLE>>(0x2::coin_registry::finalize<MOCK_STABLE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

