module 0xbeb04dc5de82dbf0bd4c93f05765760b8ff4023adb1601c67e858f5f629c9812::fs {
    struct FS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FS>(arg0, 6, b"FS", b"fish", b"so god fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241009_000248560_05a43ffc14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FS>>(v1);
    }

    // decompiled from Move bytecode v6
}

