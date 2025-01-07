module 0xf51e6755b9ef9efd9d8ad1f421ce91a79871d91bf49a17d74974eb0e556d64bb::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGUY>(arg0, 6, b"CHILLGUY", b"Just a chill guy on sui", b"I'm just a chill guy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_61_949a931710.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

