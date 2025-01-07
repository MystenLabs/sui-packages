module 0x80a248e0c7dfc47d963cb47aeb3057744e49af24845c7135bdf9b42546bbdcb::mhz {
    struct MHZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHZ>(arg0, 9, b"MHZ", b"Mehrzad", b"Mhz the best light token in city.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22c3cfad-47f1-4900-a116-ecb0a8db0165.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

