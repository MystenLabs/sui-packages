module 0xcb2c29b7d86accc636e0fe5d3054ceee71a534d39ebec5ec13deabdcef5c98aa::broge {
    struct BROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROGE>(arg0, 6, b"BROGE", b"BROGE ON SUI", x"4d6565742042524f47452c20746865206c6169642d6261636b206d656d6520746f6b656e206f6e20235355492e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dwcm_Hejz_400x400_66aad60451.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

