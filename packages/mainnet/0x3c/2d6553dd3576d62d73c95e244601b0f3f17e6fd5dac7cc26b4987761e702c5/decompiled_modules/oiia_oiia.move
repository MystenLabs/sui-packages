module 0x3c2d6553dd3576d62d73c95e244601b0f3f17e6fd5dac7cc26b4987761e702c5::oiia_oiia {
    struct OIIA_OIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIA_OIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIA_OIIA>(arg0, 8, b"OIIA_OIIA", b"OIIA_OIIA", b"Hello,Mr.Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/SherVite/picture/refs/heads/main/oiia.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OIIA_OIIA>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<OIIA_OIIA>>(v0);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<OIIA_OIIA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OIIA_OIIA>>(0x2::coin::mint<OIIA_OIIA>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

