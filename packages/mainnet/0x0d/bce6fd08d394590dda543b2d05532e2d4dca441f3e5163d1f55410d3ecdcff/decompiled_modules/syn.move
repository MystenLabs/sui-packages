module 0xdbce6fd08d394590dda543b2d05532e2d4dca441f3e5163d1f55410d3ecdcff::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYN>(arg0, 6, b"SYN", b"Suiyan", b"It's the Super Suiyan cycle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953436345.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

