module 0xccb722381f2105c9ebdc6db3c0b4f40c2b6c607d5e4bff0a3d59294d4e61791a::stars {
    struct STARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARS>(arg0, 6, b"STARS", b"STARS SUI", b"Stars launch on moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigtd22xo7zy6pext55mpuz42omjz2nfvosgirvnrij4kwsff65hji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STARS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

