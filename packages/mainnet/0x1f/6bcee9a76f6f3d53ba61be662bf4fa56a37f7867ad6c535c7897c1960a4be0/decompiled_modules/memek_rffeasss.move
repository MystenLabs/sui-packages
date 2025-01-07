module 0x1f6bcee9a76f6f3d53ba61be662bf4fa56a37f7867ad6c535c7897c1960a4be0::memek_rffeasss {
    struct MEMEK_RFFEASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFFEASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFFEASSS>(arg0, 6, b"MEMEKRFFEASSS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFFEASSS>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFFEASSS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFFEASSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

