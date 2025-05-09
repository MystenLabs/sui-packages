module 0x4276b3b27d48d0cf2ef4aa994a23657a980f92cceebd9b3666ed7b2a40cd6336::drago {
    struct DRAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGO>(arg0, 6, b"DRAGO", b"DRAGONIECE", b"The evolution of meme tokens begins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsperl25xbefa4gq2uteiqzbuc4p6xvikugehxwbdltdsg4l66gu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

