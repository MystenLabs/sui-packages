module 0xeaef995fe51ff13070ab209d4cee8d6ddecb97b3088973e7e99ac84e34c851eb::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 9, b"man", b"mkon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAN>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

