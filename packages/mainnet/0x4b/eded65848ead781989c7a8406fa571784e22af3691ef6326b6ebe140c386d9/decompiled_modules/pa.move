module 0x4beded65848ead781989c7a8406fa571784e22af3691ef6326b6ebe140c386d9::pa {
    struct PA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PA>(arg0, 9, b"PA", b"Prana", b"Life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d60442c4-4e0c-4002-9925-b4f6599603fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PA>>(v1);
    }

    // decompiled from Move bytecode v6
}

