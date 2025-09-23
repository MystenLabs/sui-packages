module 0x4fce1d37229d9e3bf504e39df77d0dcd8bd424e24fea90b928ed025fa3fdd72b::yzi {
    struct YZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YZI>(arg0, 6, b"YZI", b"YZI Labs", b"YZi Labs invests in ventures at every stage, prioritizing those with solid fundamentals in Web3, AI, and biotech", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758635557909.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YZI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YZI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

