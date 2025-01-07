module 0x6d864e46acc841c3fb5316d3af9e11c3783162693e1a02cf25608058509cabaa::onion {
    struct ONION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONION>(arg0, 6, b"Onion", b"Sui Onion", b"My wallet is like an onion, opening it makes me cry ....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Onion_1f569b112b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONION>>(v1);
    }

    // decompiled from Move bytecode v6
}

