module 0x50505cffa9c83db2f5ad38cd75a888ba7fc95bc659d5261a893806667112f420::arfg {
    struct ARFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARFG>(arg0, 9, b"ARFG", b"erret", b"fdgdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1df7589d-fa3c-433b-bd51-7dca5be220a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

