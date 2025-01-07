module 0xd1a97bae8526eaa6e42cb08744c31618687ce1ba75de5d16e26d32d07682ad9c::pzar {
    struct PZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZAR>(arg0, 9, b"PZAR", b"pizza", x"45766572796f6e652773206661766f7269746520666f6f640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5002062c-f476-4d10-84e9-b1c9537c0618.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

