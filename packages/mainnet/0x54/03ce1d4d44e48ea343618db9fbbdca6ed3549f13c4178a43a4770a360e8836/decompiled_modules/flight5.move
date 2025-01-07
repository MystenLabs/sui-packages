module 0x5403ce1d4d44e48ea343618db9fbbdca6ed3549f13c4178a43a4770a360e8836::flight5 {
    struct FLIGHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIGHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIGHT5>(arg0, 6, b"Flight5", b"$Flight5", b"Flight5 flies into space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1251728833324_pic_ed9f2da5aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIGHT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIGHT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

