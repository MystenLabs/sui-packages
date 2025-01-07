module 0x3541d699d20c5d6cc4f6c78a9e66324fd014068b4aae98f6e23f114b3848658b::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"SCUBA Dog", x"5468652063757465737420736375626120646976696e6720706f6f636820686173206c616e646564206f6e205375692120f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731178568115.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

