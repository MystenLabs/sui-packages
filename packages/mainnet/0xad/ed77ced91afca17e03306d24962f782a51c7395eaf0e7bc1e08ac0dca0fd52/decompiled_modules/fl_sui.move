module 0xaded77ced91afca17e03306d24962f782a51c7395eaf0e7bc1e08ac0dca0fd52::fl_sui {
    struct FL_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL_SUI>(arg0, 9, b"flSUI", b"FlowX Staked SUI", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liqag.wal.app/lsts/flSUI.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FL_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

