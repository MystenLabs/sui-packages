module 0xfd0c9328abb8776942756391c8e12a5894c6e7df4225f19bd3fc17028e25c928::hawk {
    struct HAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWK>(arg0, 6, b"Hawk", b"HawkSui", b"SPUIT ON THAT THING $HAWKSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3053_65e2d11f17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

