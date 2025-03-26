module 0xc105b4947fa3670f9a168b1a6ee8314598f12885adfb31ff5cc1c36592390bf0::bankr {
    struct BANKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANKR>(arg0, 6, b"Bankr", b"Boa Bankr", b"Celebrating 2 new exciting components on sui chain. Bankr launchpad on movepump. Coming together to make BOA bankr on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9096_74902896ff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

