module 0xd22999c1229cb6b3a03a7549219914fb5aa8d0925da7c617a0836f6c8d93d667::beepo {
    struct BEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEPO>(arg0, 6, b"BEEPO", b"BEEPO THE PANDA", b"$BEEPO: a sailing fisherpanda and also your captain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1210_aff4058e5b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

