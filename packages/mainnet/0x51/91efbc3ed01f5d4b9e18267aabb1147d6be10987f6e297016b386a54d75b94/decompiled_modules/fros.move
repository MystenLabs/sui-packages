module 0x5191efbc3ed01f5d4b9e18267aabb1147d6be10987f6e297016b386a54d75b94::fros {
    struct FROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROS>(arg0, 6, b"FROS", b"Frosmoth On Sui", b"Like the cold air that Frosmoth loves, Sui Network provides a clean and efficient environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhor44dbk7itpqmmn3nzncquvhlvksij7z4er55wr2f26pb2c3i4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

