module 0x7df532f9346e2e68c4390e80a0aebd4965c254249f93ba3a2f741e89b0fea741::gigl {
    struct GIGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGL>(arg0, 9, b"GIGL", b"GiggleCoin", b"GiggleCoin is designed to bring laughter to the blockchain! Every time a user shares a meme, they earn GiggleCoins based on engagement and shares. Users can also trade their coins for hilarious rewards. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/394f0f89-b41b-4eb3-9124-a282a14717f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

