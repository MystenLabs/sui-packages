module 0xe6052ef9c24566781ffe9f5a93f9d9dc4833c8f7dc59ea4179ddb58deb50eff4::gogimeme {
    struct GOGIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGIMEME>(arg0, 9, b"GOGIMEME", b"Gogi Meme ", b"Gogi Meme in A Meme Coin It's For Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d67615f4-adaf-4c0f-8c7f-1a25483f5e98-Screenshot_20240928-123641_1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

