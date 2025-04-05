module 0xaa0f9222d7e82936b6937e1207dab21537cc90f4b04300e695c7ae839ad173e4::ttfhg {
    struct TTFHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFHG>(arg0, 9, b"TTfhg", b"eht", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/759470a14ad1120294a3b31b21eb4a3fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFHG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFHG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

