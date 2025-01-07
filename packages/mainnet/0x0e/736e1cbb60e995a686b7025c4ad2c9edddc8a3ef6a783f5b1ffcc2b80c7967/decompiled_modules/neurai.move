module 0xe736e1cbb60e995a686b7025c4ad2c9edddc8a3ef6a783f5b1ffcc2b80c7967::neurai {
    struct NEURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURAI>(arg0, 6, b"NEURAI", b"NEURATECH", b"Join us ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neuratech_12fdcb2600.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

