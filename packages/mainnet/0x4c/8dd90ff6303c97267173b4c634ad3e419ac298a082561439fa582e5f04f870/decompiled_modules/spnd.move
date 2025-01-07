module 0x4c8dd90ff6303c97267173b4c634ad3e419ac298a082561439fa582e5f04f870::spnd {
    struct SPND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPND>(arg0, 9, b"SPND", b"SodaPanda", b"Sparkling returns, bear hug security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/240de94d-2f36-4f23-8c8c-baae77d91b8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPND>>(v1);
    }

    // decompiled from Move bytecode v6
}

