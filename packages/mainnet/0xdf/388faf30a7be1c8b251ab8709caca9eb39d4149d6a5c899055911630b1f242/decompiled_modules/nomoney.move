module 0xdf388faf30a7be1c8b251ab8709caca9eb39d4149d6a5c899055911630b1f242::nomoney {
    struct NOMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMONEY>(arg0, 9, b"NOMONEY", b"No money", b"So poor need airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/961823ad-1bcf-4700-8374-bd5cf971a0d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

