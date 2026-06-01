module 0xb590a235a69b1f124fd95598ee50a642f2c1b4721d345cd540c011d67041465c::spcx {
    struct SPCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPCX>(arg0, 6, b"SPCX", b"SPCX69420", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPCX>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPCX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPCX>>(v2);
    }

    // decompiled from Move bytecode v6
}

