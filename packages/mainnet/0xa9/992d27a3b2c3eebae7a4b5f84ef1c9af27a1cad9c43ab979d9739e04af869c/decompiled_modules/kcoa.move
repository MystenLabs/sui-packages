module 0xa9992d27a3b2c3eebae7a4b5f84ef1c9af27a1cad9c43ab979d9739e04af869c::kcoa {
    struct KCOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCOA>(arg0, 9, b"KCOA", b"Kecoa", b"Kecoa terbang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82fa1b4e-6456-4b7f-918b-b662c3e50815.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

