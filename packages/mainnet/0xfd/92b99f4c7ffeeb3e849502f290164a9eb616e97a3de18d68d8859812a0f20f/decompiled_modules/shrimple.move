module 0xfd92b99f4c7ffeeb3e849502f290164a9eb616e97a3de18d68d8859812a0f20f::shrimple {
    struct SHRIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMPLE>(arg0, 6, b"SHRIMPLE", b"Shrimple", b"It's as shrimple as that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_21_19_13_f7fa68a22c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

