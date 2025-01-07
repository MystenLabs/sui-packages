module 0x4430c314575768e92d20d59bbd28a548eccc921e979665b674e92ded5f3e6447::fw {
    struct FW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FW>(arg0, 9, b"FW", b"Fish Wao", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da084925-384d-418a-b0b5-4173717d1e3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FW>>(v1);
    }

    // decompiled from Move bytecode v6
}

