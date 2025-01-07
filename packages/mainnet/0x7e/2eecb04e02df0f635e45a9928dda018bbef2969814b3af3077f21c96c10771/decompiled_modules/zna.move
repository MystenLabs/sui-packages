module 0x7e2eecb04e02df0f635e45a9928dda018bbef2969814b3af3077f21c96c10771::zna {
    struct ZNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZNA>(arg0, 9, b"ZNA", b"Zenka", b"A Precious One", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d97b8f08-17ee-4351-8f00-8c753bea6fca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

