module 0x7f486f9911ad26dea0d0b9259bb2c5f1f796154a721dc431057d3814f8e5dc0::peanut10 {
    struct PEANUT10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT10>(arg0, 6, b"Peanut10", b"peanut", b"peanut peanut peanut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730896320466.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT10>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT10>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

