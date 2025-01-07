module 0xe7a2f1f368b1e4255cddfb4f9a5fd982567db16c4a1f06ca7ebe705690ec1b06::agl {
    struct AGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGL>(arg0, 9, b"AGL", b"RWF", b"If you have any questions or ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8443d948-c17d-405e-aac0-5bb0e4a7a3ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

