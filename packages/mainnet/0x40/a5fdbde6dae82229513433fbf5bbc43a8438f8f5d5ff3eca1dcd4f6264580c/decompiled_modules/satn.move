module 0x40a5fdbde6dae82229513433fbf5bbc43a8438f8f5d5ff3eca1dcd4f6264580c::satn {
    struct SATN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATN>(arg0, 6, b"Satn", b"Saturn", b"The project offers the exchange of cryptocurrency and fiat money, as safely as possible, quickly, and practically free of charge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731165607578.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

