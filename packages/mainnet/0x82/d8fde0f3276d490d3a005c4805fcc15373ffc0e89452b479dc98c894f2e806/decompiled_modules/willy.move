module 0x82d8fde0f3276d490d3a005c4805fcc15373ffc0e89452b479dc98c894f2e806::willy {
    struct WILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLY>(arg0, 9, b"WILLY", b"Willy Suwonka", b"Willy Suwonka (WILLY) is a playful meme token offering surprise rewards and \"golden ticket\" opportunities for its community. Driven by creativity and engagement, WILLY adds a fun and adventurous twist to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1769883176787185664/CM2y3fEg.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WILLY>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

