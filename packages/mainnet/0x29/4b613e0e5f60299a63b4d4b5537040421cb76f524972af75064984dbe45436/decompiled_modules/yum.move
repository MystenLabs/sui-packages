module 0x294b613e0e5f60299a63b4d4b5537040421cb76f524972af75064984dbe45436::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"SuiSauce", x"546861742059756d2059756d2053617563650a54686520736175636520746861742065766572796f6e65206c6f76657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_c4cde5d718.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

