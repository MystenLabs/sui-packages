module 0x2b17239b7b63aa5d88b8970e80aa09ff7625fa8454957176a7ef4ab79a2c90a6::harambe {
    struct HARAMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARAMBE>(arg0, 6, b"Harambe", b"HARAMBE", b"it lives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/harambe_e2a56cddb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARAMBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

