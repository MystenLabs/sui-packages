module 0xb563e5b824d03e5c5bf0952c20861a1f8c1941470f4e6ae03c265a0adf2825fb::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"DMN", b"Damon", b"LET'S GO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43611db4-3d3b-428c-a60a-02397b1f4158.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

