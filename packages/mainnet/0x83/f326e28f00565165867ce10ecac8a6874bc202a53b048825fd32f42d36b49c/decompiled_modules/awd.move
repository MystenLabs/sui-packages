module 0x83f326e28f00565165867ce10ecac8a6874bc202a53b048825fd32f42d36b49c::awd {
    struct AWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWD>(arg0, 6, b"AWD", b"AWDa", b"awdaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747050688565.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

