module 0xb338d8a6bd7c2ab9de65bd28924a8879b8d0484dba395af3023c2de9c2b6e784::sUSDT {
    struct SUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDT>(arg0, 9, b"SY-sUSDT", b"SY scallop sUSDT", b"SY scallop sUSDT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

