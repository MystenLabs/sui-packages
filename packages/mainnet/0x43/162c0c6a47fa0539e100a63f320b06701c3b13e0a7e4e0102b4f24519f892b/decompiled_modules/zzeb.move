module 0x43162c0c6a47fa0539e100a63f320b06701c3b13e0a7e4e0102b4f24519f892b::zzeb {
    struct ZZEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZEB>(arg0, 6, b"ZZEB", b"ZIPPY ZEBRA", b"Racing through the meme savanna with its striking stripes. Zippy Zebra is fast, fun, and fabulous.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_032703762_7c2efbee22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

