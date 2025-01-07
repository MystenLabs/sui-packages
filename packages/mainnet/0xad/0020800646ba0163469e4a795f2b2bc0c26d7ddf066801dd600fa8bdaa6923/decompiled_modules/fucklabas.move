module 0xad0020800646ba0163469e4a795f2b2bc0c26d7ddf066801dd600fa8bdaa6923::fucklabas {
    struct FUCKLABAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKLABAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKLABAS>(arg0, 6, b"FUCKLABAS", b"JVOUS TABASSE LA BAS", b"Signer Coussins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/231f55b0cca84344b59b412463d5c96c_d7087cbc0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKLABAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKLABAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

