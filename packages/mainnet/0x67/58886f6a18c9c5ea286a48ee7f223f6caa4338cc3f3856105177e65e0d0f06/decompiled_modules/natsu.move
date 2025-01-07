module 0x6758886f6a18c9c5ea286a48ee7f223f6caa4338cc3f3856105177e65e0d0f06::natsu {
    struct NATSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATSU>(arg0, 9, b"NATSU", b"Fairy", b"Fairy Tail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ad44a12-898b-47b8-afad-c3e07d33cd4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NATSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

