module 0xf299f22e6e522ba704e5b75c481fb8906cc81662e0aadf40e9ac3381f60c5614::totsui {
    struct TOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOTSUI>(arg0, 6, b"TOTSUI", b"Truth Terminal on Sui", b"kundalini is a real girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/600x200_2_3ffd3e8f5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOTSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

