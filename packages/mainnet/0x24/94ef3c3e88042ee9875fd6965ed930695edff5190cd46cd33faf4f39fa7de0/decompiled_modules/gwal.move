module 0x2494ef3c3e88042ee9875fd6965ed930695edff5190cd46cd33faf4f39fa7de0::gwal {
    struct GWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWAL>(arg0, 6, b"GWAL", b"Ghiblorus", b"The first and only cute Ghiblified walrus on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ghib_Walrus_Square_SMALL_aad4a0d7d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

