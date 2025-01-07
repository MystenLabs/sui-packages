module 0x378ce2842b2792a1b405cdfb920b16018ce7c887baf8ad102612e716805e3b49::bubblemnstr {
    struct BUBBLEMNSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLEMNSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLEMNSTR>(arg0, 6, b"BUBBLEMNSTR", b"BUBBLEMONSTER", b"SUI bubble monsters may look scary, but dont worry they are not. They will be ur best friends. Big plans coming join the squad and earn NFTs !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6967_a87752f671.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLEMNSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLEMNSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

