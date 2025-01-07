module 0xf78d9023155aa4144caf1d005bf0346dca9652a5762e9b5925aefa8f634f92ed::me {
    struct ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ME>(arg0, 9, b"ME", b"Meow", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43732d5b-3fbd-4c08-a72f-2b6b9ec630dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ME>>(v1);
    }

    // decompiled from Move bytecode v6
}

