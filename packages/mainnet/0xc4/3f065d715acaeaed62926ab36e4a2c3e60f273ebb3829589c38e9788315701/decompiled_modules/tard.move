module 0xc43f065d715acaeaed62926ab36e4a2c3e60f273ebb3829589c38e9788315701::tard {
    struct TARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARD>(arg0, 9, b"TARD", b"TAR", b"TARDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7efc81be-b0bd-4afb-b6c4-7c0fc762757a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

