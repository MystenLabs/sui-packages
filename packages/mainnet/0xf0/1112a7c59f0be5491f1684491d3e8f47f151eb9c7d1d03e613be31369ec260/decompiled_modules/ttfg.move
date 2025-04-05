module 0xf01112a7c59f0be5491f1684491d3e8f47f151eb9c7d1d03e613be31369ec260::ttfg {
    struct TTFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFG>(arg0, 9, b"TTfg", b"thht", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4985a8e80a5a14b7b5fa1f051916bf6bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

