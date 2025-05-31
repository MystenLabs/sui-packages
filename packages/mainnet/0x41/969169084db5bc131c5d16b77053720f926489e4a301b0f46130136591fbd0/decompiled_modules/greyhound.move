module 0x41969169084db5bc131c5d16b77053720f926489e4a301b0f46130136591fbd0::greyhound {
    struct GREYHOUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREYHOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREYHOUND>(arg0, 6, b"Greyhound", b"Greyhound Research", b"Greyhound Research is a Global, Award-Winning, Technology Research, Advisory, Consulting & Education Firm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie76qkgwwlowaqr76ngnh6f44vg2aevyawqn6ug3rlfl3vqrzjvxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREYHOUND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GREYHOUND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

