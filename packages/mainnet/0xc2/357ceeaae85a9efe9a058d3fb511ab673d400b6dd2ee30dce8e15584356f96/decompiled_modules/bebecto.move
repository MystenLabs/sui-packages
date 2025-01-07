module 0xc2357ceeaae85a9efe9a058d3fb511ab673d400b6dd2ee30dce8e15584356f96::bebecto {
    struct BEBECTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBECTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBECTO>(arg0, 9, b"BEBECTO", b"BEBE", b"BeBeCTO - Memecoin TOP 1 SUI Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2178c34-3167-40a2-81f0-5ecb2b3d30eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBECTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBECTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

