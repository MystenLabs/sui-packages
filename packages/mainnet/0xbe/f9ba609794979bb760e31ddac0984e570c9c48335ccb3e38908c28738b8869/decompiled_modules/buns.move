module 0xbef9ba609794979bb760e31ddac0984e570c9c48335ccb3e38908c28738b8869::buns {
    struct BUNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNS>(arg0, 6, b"BUNS", b"BunS", b"The cheekiest crypto on sui network! Join the rise of the $BUNS and lets bake a brighter future together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034612_9c5828811d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

