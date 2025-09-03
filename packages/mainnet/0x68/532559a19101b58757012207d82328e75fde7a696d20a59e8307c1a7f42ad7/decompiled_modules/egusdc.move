module 0x68532559a19101b58757012207d82328e75fde7a696d20a59e8307c1a7f42ad7::egusdc {
    struct EGUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGUSDC>(arg0, 6, b"egUSDC", b"Ember Gamma USDC", b"This receipt token represents the shares a user has of the Gamma USDC Vault on Ember", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/egUSDC.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

