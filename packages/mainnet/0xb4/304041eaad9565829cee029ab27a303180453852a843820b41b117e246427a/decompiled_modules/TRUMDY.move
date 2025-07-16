module 0xb4304041eaad9565829cee029ab27a303180453852a843820b41b117e246427a::TRUMDY {
    struct TRUMDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMDY>(arg0, 6, b"Trump Daddy", b"TRUMDY", b"Trump rizz W", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

