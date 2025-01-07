module 0xe2a117b7be1509e352e388c2975b8496facc7d7c0c38bf284239891d6ad10209::bigtinpo {
    struct BIGTINPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGTINPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGTINPO>(arg0, 9, b"BIGTINPO", b"tinp0", b"sexSymbol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b677b3b4-8589-4b49-95bf-2efc9935ba7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGTINPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGTINPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

