module 0x4d5c10a6654c8c33eb2fb0cbb9d68776cbcf1135928f8cf43db99dcb52e5c5a::nogod {
    struct NOGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGOD>(arg0, 9, b"NOGOD", b"NO GOD", b"Atheism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ae93881-190a-4b61-8d30-53b4f5154c86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

