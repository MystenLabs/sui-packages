module 0x57398e422450ed6c5df8f18588da5464b25f5b3da3f805145cfcc47dbb3e6f44::hchch {
    struct HCHCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCHCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCHCH>(arg0, 9, b"HCHCH", b"Utuf", b"Yfhch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/743cf84d-0b00-4929-ac6a-ab837a387667.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCHCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCHCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

