module 0xd62673e2487e57cab8426c303e74b8d5f4ebf40dab892e4eb490eb634b5a8ff4::trumpmoon {
    struct TRUMPMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMOON>(arg0, 9, b"TRUMPMOON", b"TRUMPUMP", x"4d656d6520636f696e207768696368206d616b6520796f752072696368206e6f772c20646f6ee2809974206d697373206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8391bbfd-690f-41e3-bb84-ef7d849c376e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

