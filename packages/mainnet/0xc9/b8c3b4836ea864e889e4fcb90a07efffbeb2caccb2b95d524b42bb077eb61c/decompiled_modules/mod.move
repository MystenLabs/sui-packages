module 0xc9b8c3b4836ea864e889e4fcb90a07efffbeb2caccb2b95d524b42bb077eb61c::mod {
    struct MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOD>(arg0, 9, b"MOD", b"mood", x"4c69667420796f757220737069726974732077697468204d6f6f64436f696e20f09f8cac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40669122-d70b-43da-a1f3-3f24ec6d3b71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

