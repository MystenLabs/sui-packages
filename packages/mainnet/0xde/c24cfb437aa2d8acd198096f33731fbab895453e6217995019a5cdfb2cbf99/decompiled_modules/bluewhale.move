module 0xdec24cfb437aa2d8acd198096f33731fbab895453e6217995019a5cdfb2cbf99::bluewhale {
    struct BLUEWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEWHALE>(arg0, 6, b"BLUEWHALE", b"Sui Blue Whale", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEWHALE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEWHALE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEWHALE>>(v2);
    }

    // decompiled from Move bytecode v6
}

