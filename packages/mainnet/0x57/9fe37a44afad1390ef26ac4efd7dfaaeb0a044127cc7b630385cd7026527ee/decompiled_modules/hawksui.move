module 0x579fe37a44afad1390ef26ac4efd7dfaaeb0a044127cc7b630385cd7026527ee::hawksui {
    struct HAWKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKSUI>(arg0, 6, b"HawkSui", b"Hawk", b"SPUIT ON THAT THING $HAWKSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3053_badacc9e91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

