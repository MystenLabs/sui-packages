module 0xa57858b17a0300db2e9a8ba881382166f9c2fd525c6047bf849f754d4da2781c::golden_whale {
    struct GOLDEN_WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN_WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN_WHALE>(arg0, 6, b"GOLDEN WHALE", b"The Golden Whale", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDEN_WHALE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDEN_WHALE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOLDEN_WHALE>>(v2);
    }

    // decompiled from Move bytecode v6
}

