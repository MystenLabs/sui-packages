module 0x101bdbe94e75b1b4cbe8441b44caaac5c2924b6ea758b2e20ea3241b40582311::baaa {
    struct BAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAAA>(arg0, 6, b"BAAA", b"B-AAA", b"B-AAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baa_logo_cuadrado_f4240914cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

