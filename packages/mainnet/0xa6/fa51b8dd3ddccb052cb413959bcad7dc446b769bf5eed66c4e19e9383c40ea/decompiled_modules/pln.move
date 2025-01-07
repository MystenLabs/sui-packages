module 0xa6fa51b8dd3ddccb052cb413959bcad7dc446b769bf5eed66c4e19e9383c40ea::pln {
    struct PLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLN>(arg0, 9, b"PLN", b"planet", b"Various planets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/101f3c0c-e191-44c7-aaa8-8a84e7c61f87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

