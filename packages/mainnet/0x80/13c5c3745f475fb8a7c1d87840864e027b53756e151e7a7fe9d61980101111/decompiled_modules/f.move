module 0x8013c5c3745f475fb8a7c1d87840864e027b53756e151e7a7fe9d61980101111::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 9, b"F", b"Face", b"This coin is awarded as a reward to artists who design faces using different techniques", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bdcbb21-b376-4634-9c05-e80952bd3abc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
    }

    // decompiled from Move bytecode v6
}

