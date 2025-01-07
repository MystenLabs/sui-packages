module 0x68ebcd9301ae8ac50145941ae688a419983da811dc2f1853fb78ce72e4900422::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 6, b"MAN", b"man man man", b"oh man ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734642417254.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

