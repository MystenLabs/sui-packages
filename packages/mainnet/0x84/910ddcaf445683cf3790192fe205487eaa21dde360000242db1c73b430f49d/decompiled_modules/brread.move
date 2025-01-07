module 0x84910ddcaf445683cf3790192fe205487eaa21dde360000242db1c73b430f49d::brread {
    struct BRREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRREAD>(arg0, 6, b"BRREAD", b"BREADSUI", b"bread", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hero2_247a4b8825.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

