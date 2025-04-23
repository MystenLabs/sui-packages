module 0x55b62a33f171581912a7d833fa856e38dd09e855f6d130051c230e59d4c1b382::fl_sui {
    struct FL_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL_SUI>(arg0, 9, b"flSUI", b"FlowX Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liqag.wal.app/lsts/flSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

