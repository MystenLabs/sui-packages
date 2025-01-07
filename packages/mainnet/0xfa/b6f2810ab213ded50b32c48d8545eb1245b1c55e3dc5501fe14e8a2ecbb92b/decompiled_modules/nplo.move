module 0xfab6f2810ab213ded50b32c48d8545eb1245b1c55e3dc5501fe14e8a2ecbb92b::nplo {
    struct NPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPLO>(arg0, 9, b"NPLO", b"napoleon", b"Napoleon I", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51099597-febe-4da2-9117-2c6d2a5dba90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

