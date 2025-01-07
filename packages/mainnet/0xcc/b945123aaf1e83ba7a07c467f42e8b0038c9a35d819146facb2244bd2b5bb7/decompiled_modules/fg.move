module 0xccb945123aaf1e83ba7a07c467f42e8b0038c9a35d819146facb2244bd2b5bb7::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 9, b"FG", b"CZX", b"CZx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82ce0b07-c4a4-47f0-99e8-0dc2207ac342.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FG>>(v1);
    }

    // decompiled from Move bytecode v6
}

