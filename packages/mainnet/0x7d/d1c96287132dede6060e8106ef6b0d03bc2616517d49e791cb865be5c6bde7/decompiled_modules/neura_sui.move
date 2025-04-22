module 0x7dd1c96287132dede6060e8106ef6b0d03bc2616517d49e791cb865be5c6bde7::neura_sui {
    struct NEURA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURA_SUI>(arg0, 9, b"neuraSUI", b"OpenNeura Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liqag.wal.app/lsts/neuraSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEURA_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURA_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

