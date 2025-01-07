module 0x1ad42808ce7339e1a79c1c52a3f440493bc71ed680913dc856c1136e0162bbf7::dasda {
    struct DASDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASDA>(arg0, 6, b"DASDA", b"312dasd", b"ADasda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731080156808.mj")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DASDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

