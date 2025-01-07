module 0x385a303f74ab0f768d61dbd3880f5e870bf01cb92a4c05fe0b11918b8097858b::money {
    struct MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEY>(arg0, 9, b"MONEY", b"money", b"billion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ba560ca-1e25-46b8-81a1-567ea0e7a769.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

