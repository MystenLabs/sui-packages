module 0x46ae0ca8763fa6286d1ecfdc4ccb6fc06ccd1a93ec7545910687f86c37c07dbd::dasf {
    struct DASF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASF>(arg0, 6, b"DASF", b"894", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASF>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DASF>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

