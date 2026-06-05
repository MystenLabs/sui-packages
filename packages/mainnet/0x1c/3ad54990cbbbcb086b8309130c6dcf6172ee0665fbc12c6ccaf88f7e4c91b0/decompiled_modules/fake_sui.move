module 0x1c3ad54990cbbbcb086b8309130c6dcf6172ee0665fbc12c6ccaf88f7e4c91b0::fake_sui {
    struct FAKE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_SUI>(arg0, 9, b"SUI", b"Sui", b"Test-only fake SUI metadata probe. Coin type is not 0x2::sui::SUI.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_SUI>>(v1);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<FAKE_SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_SUI>>(0x2::coin::mint<FAKE_SUI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

