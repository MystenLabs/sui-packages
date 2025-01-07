module 0x7dbf4b35c8f11397f47507f9cd8dada3593677f976d588338f34ce98ff5c63a5::octos {
    struct OCTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOS>(arg0, 6, b"OCTOS", b"OCTO SUI", b"A thousand octopuses are invading SUI Tentacles everywhere prepare for a slippery, inky chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dadax_1_d605140f62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

