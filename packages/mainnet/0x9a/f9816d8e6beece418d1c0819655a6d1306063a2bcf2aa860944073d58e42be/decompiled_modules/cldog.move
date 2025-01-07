module 0x9af9816d8e6beece418d1c0819655a6d1306063a2bcf2aa860944073d58e42be::cldog {
    struct CLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLDOG>(arg0, 9, b"CLDOG", b"CLDOGS", b"DOGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/732f8f59-d7f7-46da-8856-3fb435bc65cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

