module 0x4748091f9f14ab5736bdb94abf68b509ea63be3044ba09b83a68515ca7838858::bby {
    struct BBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBY>(arg0, 9, b"BBY", b"Bboy Coin ", b"The Bboys coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70741272-5996-43a7-8bbb-d9f6a2e62e38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

