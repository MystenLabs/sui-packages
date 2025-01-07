module 0x6894100503424a50a0704f7545627486c8bdb3ed4c2ede192af6bfcd0d74b8b9::coup {
    struct COUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUP>(arg0, 6, b"COUP", b"COUPON", x"436f75706f6e2028434f5550292069732061206d656d65636f696e20776974682061206d697373696f6e3a20746f207265776172642065766572792063727970746f20656e7468757369617374206f6e207468652053554920626c6f636b636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/COUPON_dbb2cb77de.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

