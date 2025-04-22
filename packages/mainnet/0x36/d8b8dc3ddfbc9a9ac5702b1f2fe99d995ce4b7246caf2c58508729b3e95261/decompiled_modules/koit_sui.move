module 0x36d8b8dc3ddfbc9a9ac5702b1f2fe99d995ce4b7246caf2c58508729b3e95261::koit_sui {
    struct KOIT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIT_SUI>(arg0, 9, b"koitSUI", b"Koit Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liqag.wal.app/lsts/koitSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOIT_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIT_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

