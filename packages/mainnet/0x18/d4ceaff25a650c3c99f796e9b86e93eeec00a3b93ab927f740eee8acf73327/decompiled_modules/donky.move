module 0x18d4ceaff25a650c3c99f796e9b86e93eeec00a3b93ab927f740eee8acf73327::donky {
    struct DONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKY>(arg0, 9, b"DONKY", b"DONKEY", b"First Donkey Meme Coin Created By Wave Wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f08a106b-723c-4d61-9a34-07ade38364c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

