module 0xdbf0e70175143784ad64f3d7d54c43d84431e14f25cd0e54f9efe53ff5d53196::crottoken {
    struct CROTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROTTOKEN>(arg0, 9, b"CROTTOKEN", b"CROT", b"Crot meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17fa1ddf-5b1b-46cc-849a-dff7874eaa3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROTTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

