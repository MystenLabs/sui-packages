module 0x9af98ecc2eb681a832f805e7d9858a87221b1fb6296f60dca1edf1b458e95ee1::dognald {
    struct DOGNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNALD>(arg0, 6, b"DOGNALD", b"Dognald trump on sui", b"Dognald trump on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002240_2071098e21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

