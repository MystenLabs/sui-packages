module 0xbbcb8c0a204538b436ce012c154a877411ab3a4d47b456e34bba9b10a1c9e2d9::suiboat {
    struct SUIBOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOAT>(arg0, 9, b"SUIBOAT", b"SUI BOAT", b"The SUI Boat used to catch seafood which turns into $ocean in Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0279ced-9a7b-4153-9c33-6a76fd9c067e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

