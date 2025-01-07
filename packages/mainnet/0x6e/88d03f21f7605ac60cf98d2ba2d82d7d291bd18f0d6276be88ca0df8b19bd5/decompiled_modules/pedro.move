module 0x6e88d03f21f7605ac60cf98d2ba2d82d7d291bd18f0d6276be88ca0df8b19bd5::pedro {
    struct PEDRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDRO>(arg0, 6, b"PEDRO", b"Pedro sui bull", b"Pedro is a bull living on the Sui World. Love the nature, relax and peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pedrohead_1c872ef913_745cc05359.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

