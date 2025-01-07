module 0x183c9c23f4841e0ded6d9758a2ece568a3e6a3149eadb3dfd0569215861812b9::edr {
    struct EDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDR>(arg0, 9, b"EDR", b"TIRED", b"there is no talk of buying my meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7999791-1f5f-4f8a-ae1a-811f6deed90e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

