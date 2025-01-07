module 0x941aba41faba6b8bb5677e1d4f318c67f19b5d2efbb18c0e841a760123b7a165::zmb {
    struct ZMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMB>(arg0, 9, b"ZMB", b"ZOMBIE", b"Zombies gonna conquest the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/130e933f-f0ef-40d7-af45-2e2e0cff459c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

