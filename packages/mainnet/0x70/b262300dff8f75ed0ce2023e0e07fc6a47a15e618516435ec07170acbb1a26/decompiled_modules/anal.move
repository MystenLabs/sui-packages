module 0x70b262300dff8f75ed0ce2023e0e07fc6a47a15e618516435ec07170acbb1a26::anal {
    struct ANAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANAL>(arg0, 6, b"ANAL", b"SOLANAL", x"42696767657374204153536574200a50554d5020495420444f4e27542044554d50204954200a23646565706761696e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SOLANAL_c9710f70ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

