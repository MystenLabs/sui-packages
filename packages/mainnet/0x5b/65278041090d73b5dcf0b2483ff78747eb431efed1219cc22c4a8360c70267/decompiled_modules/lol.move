module 0x5b65278041090d73b5dcf0b2483ff78747eb431efed1219cc22c4a8360c70267::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"MetaLoL on sui", b"Welcome to the world of legendary champions! Together with MetaLoL, we will write emotional Esports stories.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_09_14_10_25_953c689a1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

