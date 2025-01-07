module 0x3c91e360d3a2be18416db8079bc2543c915e0bd710340025d114996221c7bce2::macsui {
    struct MACSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACSUI>(arg0, 6, b"MACSUI", b"MacNCheese", b"Mac & Cheese has arrived to Sui/MovePump!  Come Join our Telegram https://t.me/MNCSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/665675_be1fb90515.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

