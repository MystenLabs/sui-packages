module 0xd920c9f3253cc3d6f66659ec3184caa0f0ce74969510f0f73e97f7985afba624::mrankz {
    struct MRANKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRANKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRANKZ>(arg0, 9, b"MRANKZ", b"MemeRankz", x"41206d656d65636f696e20666f722066756e20f09f988a2e20576562332066756e20636f696e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe3b66a1-a1e0-417b-8914-f856b5545ecc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRANKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRANKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

