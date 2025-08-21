module 0xb0e80b6599870cd6309bafc32bc62591c573ade53761bf7682173eea03547a28::The_orange_era {
    struct THE_ORANGE_ERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE_ORANGE_ERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE_ORANGE_ERA>(arg0, 9, b"ORANGE", b"The orange era", b"In my orange era.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1956736206944747520/oq1OcUU__400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THE_ORANGE_ERA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE_ORANGE_ERA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

