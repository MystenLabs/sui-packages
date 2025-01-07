module 0x403ae0a341eef7c2be827b2ea7fcb31340d0fa88f78f7886c0fd58b22d743d3c::wwwwweeeee {
    struct WWWWWEEEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWWWWEEEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWWWWEEEEE>(arg0, 9, b"WWWWWEEEEE", b"Wewe", b"For Comunity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d9101c3-da11-4514-b088-29e0053ea26c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWWWWEEEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWWWWEEEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

