module 0x4498a6d4fe627984c9f8c3e4ac1d48a40eb6f8512462fae4c517177686a42c0d::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"suicide", b"RIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_removebg_preview_58_cd392b6b27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

