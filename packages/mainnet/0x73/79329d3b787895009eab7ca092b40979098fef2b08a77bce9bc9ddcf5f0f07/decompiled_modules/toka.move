module 0x7379329d3b787895009eab7ca092b40979098fef2b08a77bce9bc9ddcf5f0f07::toka {
    struct TOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKA>(arg0, 9, b"TOKA", b"Tokata", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

