module 0x3eba700de5b3ce01a1a8c244f0541112558f6ffd6e3ab26f3427b658e9a1e378::jfo {
    struct JFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFO>(arg0, 6, b"JFO", b"Jelly UFO", b"Who knows what kind of jellies lurk in deep space?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_17_41_56_af50e9bb36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

