module 0x1df5d5d392036a1c2ff33d23c12c2a4bfc7f7ace44736a7ca2932ca4b25b22ad::mock_asset {
    struct MOCK_ASSET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_ASSET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_ASSET>>(0x2::coin::mint<MOCK_ASSET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_ASSET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOCK_ASSET>(arg0, 9, 0x1::string::utf8(b"TASSET"), 0x1::string::utf8(b"Test Asset"), 0x1::string::utf8(b"Mock asset coin for testnet DAO testing"), 0x1::string::utf8(b"https://raw.githubusercontent.com/govex-dao/docs/main/govex-icon.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_ASSET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MOCK_ASSET>>(0x2::coin_registry::finalize<MOCK_ASSET>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

