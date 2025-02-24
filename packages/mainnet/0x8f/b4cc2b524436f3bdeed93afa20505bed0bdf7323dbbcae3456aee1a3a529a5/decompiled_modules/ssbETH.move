module 0x8fb4cc2b524436f3bdeed93afa20505bed0bdf7323dbbcae3456aee1a3a529a5::ssbETH {
    struct SSBETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSBETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSBETH>(arg0, 6, b"sysSBETH", b"SY sSBETH", b"SY scallop sSBETH", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSBETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSBETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

