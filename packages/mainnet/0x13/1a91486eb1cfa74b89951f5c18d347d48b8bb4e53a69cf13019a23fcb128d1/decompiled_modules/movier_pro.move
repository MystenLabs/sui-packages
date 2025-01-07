module 0x131a91486eb1cfa74b89951f5c18d347d48b8bb4e53a69cf13019a23fcb128d1::movier_pro {
    struct MOVIER_PRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVIER_PRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVIER_PRO>(arg0, 9, b"MOVIER_PRO", b"Movier", b"Movier is a cat that makes cool cuts from top films for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90f98fdd-0a0b-42d7-8afe-a217c6389611.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVIER_PRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVIER_PRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

