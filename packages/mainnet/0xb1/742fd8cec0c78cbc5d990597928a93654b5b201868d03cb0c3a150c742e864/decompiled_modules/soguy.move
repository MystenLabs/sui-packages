module 0xb1742fd8cec0c78cbc5d990597928a93654b5b201868d03cb0c3a150c742e864::soguy {
    struct SOGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGUY>(arg0, 6, b"SOGUY", b"Sonic Guy", b"Sonic speed, Sonic a gains! SONICGUY is launching exclusively on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011162_8706b90ac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

