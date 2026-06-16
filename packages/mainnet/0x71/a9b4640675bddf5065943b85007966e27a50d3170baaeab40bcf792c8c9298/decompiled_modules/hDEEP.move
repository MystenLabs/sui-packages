module 0x71a9b4640675bddf5065943b85007966e27a50d3170baaeab40bcf792c8c9298::hDEEP {
    struct HDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDEEP>(arg0, 6, b"hDEEP", b"hDEEP Coin", b"hDEEP Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/images/deep_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDEEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

