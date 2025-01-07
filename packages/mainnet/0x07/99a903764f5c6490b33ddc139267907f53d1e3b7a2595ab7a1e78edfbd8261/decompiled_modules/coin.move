module 0x799a903764f5c6490b33ddc139267907f53d1e3b7a2595ab7a1e78edfbd8261::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"MEME", b"Sui meme", b"The first meme on Suipump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://207.148.66.213:4137/uploads/sui_asset_cfa80b7ece.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

