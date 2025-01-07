module 0xbebe51b7fc02e417997800151c61b6458c92739979148e99aead9658c7792b70::z97 {
    struct Z97 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z97, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z97>(arg0, 9, b"Z97", b"Zack 97", x"546869c3aa6e206cc3bd20c6a169", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f232612-1e9f-41f4-8d9f-a11d628fb5e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z97>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z97>>(v1);
    }

    // decompiled from Move bytecode v6
}

