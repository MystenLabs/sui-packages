module 0x27e5677f29a8b2c24097e7c097abdaf9c723e50e36e005efeb42068fbe46dd7d::freak {
    struct FREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAK>(arg0, 6, b"FREAK", b"FREAK ON SUI", b"Just a freak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2059_a1574e286d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

