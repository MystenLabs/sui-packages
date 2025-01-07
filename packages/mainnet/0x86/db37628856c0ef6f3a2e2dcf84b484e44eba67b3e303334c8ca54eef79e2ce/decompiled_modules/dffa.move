module 0x86db37628856c0ef6f3a2e2dcf84b484e44eba67b3e303334c8ca54eef79e2ce::dffa {
    struct DFFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFA>(arg0, 9, b"DFFA", b"KJHASF", b"BBCzcx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f075c26f-170b-4e87-84ca-c766fc4ab9a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

