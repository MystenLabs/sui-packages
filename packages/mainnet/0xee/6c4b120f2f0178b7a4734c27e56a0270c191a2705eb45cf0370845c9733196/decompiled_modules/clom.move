module 0xee6c4b120f2f0178b7a4734c27e56a0270c191a2705eb45cf0370845c9733196::clom {
    struct CLOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOM>(arg0, 9, b"CLOM", b"aoes", b"khjkjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fbddf28-a6fb-4ddf-a915-de2d88462705.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

