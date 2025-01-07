module 0x681cab36f3a31ba08ffe64cd77b79c012ca1cd05a45b643070fcf60f879cc5d9::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGER>(arg0, 6, b"TIGER", b"Blue Eyed Tiger", b"The TRUE (and blue) King of the Jungle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tiger_e0e31e72fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

