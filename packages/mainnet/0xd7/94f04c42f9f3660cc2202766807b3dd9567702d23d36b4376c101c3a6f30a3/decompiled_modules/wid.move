module 0xd794f04c42f9f3660cc2202766807b3dd9567702d23d36b4376c101c3a6f30a3::wid {
    struct WID has drop {
        dummy_field: bool,
    }

    fun init(arg0: WID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WID>(arg0, 6, b"WID", b"Tiger wid DownSyndrome by SuiAI", b"First Tiger Wid Down Syndrome on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6738_29839e7dfb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

