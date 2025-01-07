module 0xecbad9d90b0505fd78b05dc720b108ce030ba14ba02d0bc987bf533725e31b40::ecco {
    struct ECCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECCO>(arg0, 6, b"ECCO", b"Ecco Wave SUI", b"In a world full of static, one dolphin swims against the tide. When reality glitched, Ecco swam through the noise. Will you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_103039_304_13f3844aee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

