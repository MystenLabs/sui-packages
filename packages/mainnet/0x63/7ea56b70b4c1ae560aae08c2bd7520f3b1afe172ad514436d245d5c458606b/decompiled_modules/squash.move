module 0x637ea56b70b4c1ae560aae08c2bd7520f3b1afe172ad514436d245d5c458606b::squash {
    struct SQUASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUASH>(arg0, 6, b"SQUASH", b"SQUASH on SUI", b"$SQUASH coin was created to stomp on everything we hate about the current market: jeets, panic sellers, and rug pulls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D6b_K5g_Wa_400x400_1b706606df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

