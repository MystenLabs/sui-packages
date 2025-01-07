module 0xf4c5838670cd07c46f369f45226ec6db82ddc6c6d670ae54c4b8f11b48c6663c::sber {
    struct SBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBER>(arg0, 6, b"SBER", b"SUICTOBER", x"4f63746f6265722c205570636f746265722c205375690a517569636b206d617468200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suictober_fb17c56206.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

