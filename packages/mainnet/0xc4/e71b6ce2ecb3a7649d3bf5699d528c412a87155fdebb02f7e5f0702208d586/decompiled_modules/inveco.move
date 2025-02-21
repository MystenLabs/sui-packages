module 0xc4e71b6ce2ecb3a7649d3bf5699d528c412a87155fdebb02f7e5f0702208d586::inveco {
    struct INVECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVECO>(arg0, 9, b"INVECO", b"INVESTCOIN", b"Investment coins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38bc1192-a868-404f-87a8-7a80eedbba29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

