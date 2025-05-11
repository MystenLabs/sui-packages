module 0xc385d2fc90a84ea64c6c7ad3da14d0bcb0180b58961343646a8fb2058552db00::memusui {
    struct MEMUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMUSUI>(arg0, 6, b"MEMUSUI", b"MEMU SUI", b"MEMU - The unidentified new species of water type Pokemon. Jolly and joyous ready to emerge in SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigiw7u52van55xpxu67qbtrautvu7vmpx4cjvk373jfmlduvaxfga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMUSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

