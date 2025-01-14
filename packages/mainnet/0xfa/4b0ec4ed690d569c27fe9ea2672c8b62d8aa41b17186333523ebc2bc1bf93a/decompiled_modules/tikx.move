module 0xfa4b0ec4ed690d569c27fe9ea2672c8b62d8aa41b17186333523ebc2bc1bf93a::tikx {
    struct TIKX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKX>(arg0, 6, b"TIKX", b"TIKTOK X", b"Tiktok x Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0004_f0c4c0228c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIKX>>(v1);
    }

    // decompiled from Move bytecode v6
}

