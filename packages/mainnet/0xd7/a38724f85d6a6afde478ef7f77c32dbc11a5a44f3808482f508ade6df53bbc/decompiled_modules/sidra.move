module 0xd7a38724f85d6a6afde478ef7f77c32dbc11a5a44f3808482f508ade6df53bbc::sidra {
    struct SIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDRA>(arg0, 9, b"SIDRA", b"Chain", b"Sidra meme token. Buy sidra meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6132037-3668-492a-9e7f-c609c8c1fe12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

