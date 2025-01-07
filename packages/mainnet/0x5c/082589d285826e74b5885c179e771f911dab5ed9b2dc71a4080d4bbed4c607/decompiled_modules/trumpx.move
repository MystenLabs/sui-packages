module 0x5c082589d285826e74b5885c179e771f911dab5ed9b2dc71a4080d4bbed4c607::trumpx {
    struct TRUMPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPX>(arg0, 6, b"TRUMPX", b"Trumpverse", b"$TRUMPX is a meme coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BG_Logo_4e09571818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

