module 0xa38629b96f630bbc24e5d69e0655418195b00bca88bbc75281488d260abbeae4::foster {
    struct FOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOSTER>(arg0, 6, b"FOSTER", b"Foster coin", b"$Foster thought in his head for a success and the most successful memento ever in sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736034857789.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOSTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOSTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

