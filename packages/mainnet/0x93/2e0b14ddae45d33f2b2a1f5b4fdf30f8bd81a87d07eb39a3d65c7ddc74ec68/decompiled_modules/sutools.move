module 0x932e0b14ddae45d33f2b2a1f5b4fdf30f8bd81a87d07eb39a3d65c7ddc74ec68::sutools {
    struct SUTOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTOOLS>(arg0, 6, b"SUTOOLS", b"SuiTools", x"46697273742073756920636861696e207375697363616e6e657220626f74206c697665200a0a405375695f5363616e6e65725f426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027945_c384fcb306.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

