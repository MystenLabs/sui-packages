module 0x38cd75c787ad6197ebc77cf8a503582d4208116218d57aba52f7d1ce4b2f2580::memek_rfi {
    struct MEMEK_RFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFI>(arg0, 6, b"MEMEKRFI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

