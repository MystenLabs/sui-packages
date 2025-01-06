module 0x59914030229eb56551e75e9b5ba3e65ea258906d47230e78619022c663381258::dbtai {
    struct DBTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBTAI>(arg0, 6, b"DBTAI", b"Digital BrainTech AI", b"Digital Brain Tech AI Agent simplifies crypto asset management by optimizing transactions, portfolio tracking, and DeFi opportunities across Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736161715688.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

