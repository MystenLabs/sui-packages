module 0xdd0653dbedd2fe39b772ec21a4df51cec6aa65d6cde93aefb4aa95f39aa09005::anakinrm_coin {
    struct ANAKINRM_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAKINRM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANAKINRM_COIN>(arg0, 9, b"AnakinRM", b"ARM", b"this is a coin minted by AnakinRM", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANAKINRM_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAKINRM_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANAKINRM_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANAKINRM_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

