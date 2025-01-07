module 0x93e4ad7b4f756e17685b2d4771ca9276f0d8f553e927dc8f9c7d9ed5bb37aa88::wewecat {
    struct WEWECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWECAT>(arg0, 9, b"WEWECAT", b"Wpump", b"Am bullish on WEWE token about to be launched on Sui Blockchain.I am super sure it will be massive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be2ca150-dc6a-4f5e-9d66-82d716b9c53a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

