module 0xe95ba97a341e1d42eb89d98e79141cabb439e1f02148a0cd102da3b0b5110053::exp_sui {
    struct EXP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXP_SUI>(arg0, 9, b"expSUI", b"Exp Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liqag.wal.app/lsts/expSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXP_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXP_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

