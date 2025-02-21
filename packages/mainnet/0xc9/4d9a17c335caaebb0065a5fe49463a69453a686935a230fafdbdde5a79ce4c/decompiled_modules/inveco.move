module 0xc94d9a17c335caaebb0065a5fe49463a69453a686935a230fafdbdde5a79ce4c::inveco {
    struct INVECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVECO>(arg0, 9, b"INVECO", b"INVESTCOIN", b"Investment coins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/753c206f-bbc0-4129-b965-9bff6fdb9c76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

