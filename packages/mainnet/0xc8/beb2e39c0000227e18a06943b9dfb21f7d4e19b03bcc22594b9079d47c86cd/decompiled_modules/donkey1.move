module 0xc8beb2e39c0000227e18a06943b9dfb21f7d4e19b03bcc22594b9079d47c86cd::donkey1 {
    struct DONKEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY1>(arg0, 9, b"DONKEY1", b"Donkey ", b"For", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5093eba5-05ad-42da-8068-903b2f629612.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKEY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

