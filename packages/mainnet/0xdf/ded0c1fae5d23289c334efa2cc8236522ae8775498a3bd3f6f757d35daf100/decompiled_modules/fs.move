module 0xdfded0c1fae5d23289c334efa2cc8236522ae8775498a3bd3f6f757d35daf100::fs {
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

