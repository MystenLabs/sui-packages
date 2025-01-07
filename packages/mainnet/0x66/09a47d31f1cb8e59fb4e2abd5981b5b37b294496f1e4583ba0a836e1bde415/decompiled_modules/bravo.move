module 0x6609a47d31f1cb8e59fb4e2abd5981b5b37b294496f1e4583ba0a836e1bde415::bravo {
    struct BRAVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAVO>(arg0, 6, b"BRAVO", b"Johnny Bravo", x"24425241564f20e2809320546f6f20436f6f6c20666f72205574696c6974792120f09f988ef09f92aaf09f8fbc20426967206d7573636c65732c20626967676572206368617269736d61202620656e646c657373206f6e2d636861696e20666c6578696e672e2020486f7020696e20707265747479206d616d6120e28094204a6f686e6e792069732074616b696e6720796f7520666f72206120726964652120f09f9a80f09f8f8eefb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736224713413.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAVO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAVO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

