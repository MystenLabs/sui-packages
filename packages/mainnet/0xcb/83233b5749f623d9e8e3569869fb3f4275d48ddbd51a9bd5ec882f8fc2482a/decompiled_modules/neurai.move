module 0xcb83233b5749f623d9e8e3569869fb3f4275d48ddbd51a9bd5ec882f8fc2482a::neurai {
    struct NEURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURAI>(arg0, 6, b"NEURAI", b"NEURATECH NEW PONZI JOIN US", b"Join us  , new ponzi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neuratech_12fdcb2600.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

