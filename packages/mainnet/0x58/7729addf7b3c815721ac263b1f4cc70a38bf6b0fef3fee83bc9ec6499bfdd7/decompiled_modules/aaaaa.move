module 0x587729addf7b3c815721ac263b1f4cc70a38bf6b0fef3fee83bc9ec6499bfdd7::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAA>(arg0, 6, b"AAAAA", b"aaa trump", b"AAAAAAA Can't stop, won't stop (loving Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BG_Logo_284af4900f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

