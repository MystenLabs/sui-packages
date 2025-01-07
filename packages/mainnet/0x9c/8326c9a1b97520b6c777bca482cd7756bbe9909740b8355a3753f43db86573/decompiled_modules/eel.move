module 0x9c8326c9a1b97520b6c777bca482cd7756bbe9909740b8355a3753f43db86573::eel {
    struct EEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEL>(arg0, 6, b"Eel", b"Garden eels", b"Garden eels are gregarious creatures, and we need to have a common centripetal force to hold them together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732638373702.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

