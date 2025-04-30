module 0x8172028d40f6ad4b47d0dc083a75e281238740fe67b9d32021c12d1df190c8f9::tt_sui {
    struct TT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT_SUI>(arg0, 9, b"ttSUI", b"TT Staked SUI", b"TT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvnPODAr46ju6SZAQ61TLDcYn70t2gr2pwtA&s")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

