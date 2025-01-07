module 0x4adc817cf16b1b5de93ca7d8803753fa0f102f92e1f940f2df5bb6f4c3edf28c::sirml {
    struct SIRML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRML>(arg0, 9, b"SIRML", b"SirMullich", b"Token for member of Heroes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23243617-0756-4e3c-bfaf-104f4b20f9c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIRML>>(v1);
    }

    // decompiled from Move bytecode v6
}

