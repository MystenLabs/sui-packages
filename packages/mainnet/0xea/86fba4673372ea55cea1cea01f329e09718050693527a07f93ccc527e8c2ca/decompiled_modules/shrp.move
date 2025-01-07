module 0xea86fba4673372ea55cea1cea01f329e09718050693527a07f93ccc527e8c2ca::shrp {
    struct SHRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRP>(arg0, 9, b"SHRP", b"Shooroop", x"42736a6a6a646f204a656e6e6965e2809973206a736a6a6e6e7362677973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fefa1d0-15c1-4786-ad09-4f5e5c2e907b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

