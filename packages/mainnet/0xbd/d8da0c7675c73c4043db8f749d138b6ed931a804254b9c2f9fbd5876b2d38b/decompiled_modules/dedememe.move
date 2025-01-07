module 0xbdd8da0c7675c73c4043db8f749d138b6ed931a804254b9c2f9fbd5876b2d38b::dedememe {
    struct DEDEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEDEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEDEMEME>(arg0, 6, b"DEDEMEME", b"DEAD MEMES", b"Every meme has its moment: it rises, makes us laugh, then fades.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Iaj0_Hkeo_400x400_2e0af398a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEDEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEDEMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

