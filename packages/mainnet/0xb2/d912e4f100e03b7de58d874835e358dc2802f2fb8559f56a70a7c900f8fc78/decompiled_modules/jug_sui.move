module 0xb2d912e4f100e03b7de58d874835e358dc2802f2fb8559f56a70a7c900f8fc78::jug_sui {
    struct JUG_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUG_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUG_SUI>(arg0, 9, b"jugSUI", b"Jugemu Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://liqag.wal.app/lsts/jugSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUG_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUG_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

