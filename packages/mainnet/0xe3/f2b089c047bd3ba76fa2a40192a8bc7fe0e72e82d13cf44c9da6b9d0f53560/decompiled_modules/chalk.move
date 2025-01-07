module 0xe3f2b089c047bd3ba76fa2a40192a8bc7fe0e72e82d13cf44c9da6b9d0f53560::chalk {
    struct CHALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHALK>(arg0, 6, b"CHALK", b"CHALK BOY", x"6a7573742061206368616c6b2064756465206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chalk_sui_COMPRESS_f3f4a33643.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

