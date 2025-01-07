module 0x4da27f430cadc8f76e072cf2dc1f4286f57ee544c5e5c34d8ffc520a7b6dced7::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"SCUBA Dog", x"5468652063757465737420736375626120646976696e6720706f6f636820686173206c616e646564206f6e205375692120f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731062837860.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

