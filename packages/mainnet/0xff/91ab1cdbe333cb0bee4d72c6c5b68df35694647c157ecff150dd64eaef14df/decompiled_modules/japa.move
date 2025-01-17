module 0xff91ab1cdbe333cb0bee4d72c6c5b68df35694647c157ecff150dd64eaef14df::japa {
    struct JAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAPA>(arg0, 6, b"JAPA", b"JUST APE", b"Just ape. 1 million soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_211326_892_336956143a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

