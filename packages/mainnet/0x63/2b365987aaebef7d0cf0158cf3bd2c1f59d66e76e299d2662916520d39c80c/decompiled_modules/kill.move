module 0x632b365987aaebef7d0cf0158cf3bd2c1f59d66e76e299d2662916520d39c80c::kill {
    struct KILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILL>(arg0, 6, b"kILL", b"Killer whales sui ocean", b"A whale trying to swallow up the Sui ecosystem and rise to the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_BD_9_AD_11_CD_01_4_DC_2_836_D_D2_C18_C512515_588d2bcb64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

