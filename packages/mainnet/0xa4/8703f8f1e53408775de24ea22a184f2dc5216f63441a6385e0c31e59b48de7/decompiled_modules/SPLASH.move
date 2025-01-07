module 0xa48703f8f1e53408775de24ea22a184f2dc5216f63441a6385e0c31e59b48de7::SPLASH {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"SPLASH", b"moving through the blockchain one splash at a time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splashermainpic_e1a0a88a87.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPLASH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPLASH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

