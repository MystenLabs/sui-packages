module 0xfd276569b06ceba352240493e93e24b2806c7a7b624f2945d92f7922090dcdad::cbrett {
    struct CBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBRETT>(arg0, 6, b"CBRETT", b"CAPTAIN BRETT", b"Set sail with Captain Brett as he trades Wall Street for the high seas on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_02_14_40_6b53ccfd55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

