module 0xcd69b3cf32e75fb008fe5ef178c2c74ad8c5b8afcf2587e42b0f9b2c42d125c9::lofita {
    struct LOFITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFITA>(arg0, 6, b"LOFITA", b"LOFITA THE YETI", b"My name is LOFITA. I was frozen in the Himalayas for centuries, but I've awakened to join my love LOFI. Together, we're ready to build a brighter future !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjzbusu4a3rn33xgic3ipctbhblafzdoxhnb2onxknhicvryw4dm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

