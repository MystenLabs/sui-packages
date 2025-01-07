module 0x8d93ee635bbcd2b4dc7ce74440169c195a25d3c55b30f9e45a8f3b46c774c7b4::publb {
    struct PUBLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBLB>(arg0, 9, b"PUBLB", b"fici", b"ykbp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/236f7b22-365f-4ef8-a317-97d13381ec91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUBLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

