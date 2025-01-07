module 0x4dd8c345cb6f46c13e29876e4bb7047feb758cf012f0efdfd582ee8b95816c92::padgy {
    struct PADGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PADGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PADGY>(arg0, 6, b"PADGY", b"Padgy pengun", b" $PADGY is on a moon mission!  Our penguins got the bag, the rockets fueled, and were heading straight for the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020299_0555f49dc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PADGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PADGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

