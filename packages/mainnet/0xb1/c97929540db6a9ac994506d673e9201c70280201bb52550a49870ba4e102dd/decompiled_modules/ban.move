module 0xb1c97929540db6a9ac994506d673e9201c70280201bb52550a49870ba4e102dd::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"BAN", b"ban", b"BAN PUNMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751943457786.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

