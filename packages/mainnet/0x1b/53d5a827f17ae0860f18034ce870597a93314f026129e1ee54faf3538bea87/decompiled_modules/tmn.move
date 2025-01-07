module 0x1b53d5a827f17ae0860f18034ce870597a93314f026129e1ee54faf3538bea87::tmn {
    struct TMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMN>(arg0, 9, b"TMN", b"TIMNAS", b"Persatuan sepak bola indonesia yg selalu akan berkembang.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac51c5bf-6ef2-49ba-ba95-e5525c0e762a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

