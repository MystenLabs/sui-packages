module 0x12eac8486d0120f0964f1bbcb5bba3decefa341d83cdf94850c21d2533527ed3::lollipop {
    struct LOLLIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLIPOP>(arg0, 6, b"LOLLIPOP", b"Lollipop", x"f09f8dad205377656574657374206d656d6520746f6b656e206f6e205375692120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731187855351.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLIPOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLIPOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

