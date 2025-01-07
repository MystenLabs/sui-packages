module 0x9d374dd1c434580bb8101b4c2f6dd94370858e4154fde09040f0b2c16e0f64a4::itty {
    struct ITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITTY>(arg0, 9, b"ITTY", b"THE ITTY BITTY KITTY", b"$ITTY Bitty Kitty is the tiniest, cutest, but also the toughest cat on Sui. The CTO was initiated by an organized group of community members following days of thoughtful deliberation and diligent planning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ITTY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

