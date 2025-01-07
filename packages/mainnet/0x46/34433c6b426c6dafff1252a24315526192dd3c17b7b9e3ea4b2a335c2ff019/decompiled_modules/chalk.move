module 0x4634433c6b426c6dafff1252a24315526192dd3c17b7b9e3ea4b2a335c2ff019::chalk {
    struct CHALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHALK>(arg0, 6, b"CHALK", b"Chalk Boy", x"6a7573742061206368616c6b2064756465206f6e205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chalk_sui_COMPRESS_f3f4a33643_0139f198df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

