module 0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop {
    struct STPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STPOP>(arg0, 9, b"stPOP", b"stPOP", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STPOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STPOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STPOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STPOP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

