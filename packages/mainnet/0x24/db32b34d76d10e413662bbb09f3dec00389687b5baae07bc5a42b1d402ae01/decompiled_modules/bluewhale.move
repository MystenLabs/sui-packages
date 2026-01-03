module 0x24db32b34d76d10e413662bbb09f3dec00389687b5baae07bc5a42b1d402ae01::bluewhale {
    struct BLUEWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEWHALE>(arg0, 6, b"BLUEWHALE", b"BlueSUIWhale", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEWHALE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEWHALE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEWHALE>>(v2);
    }

    // decompiled from Move bytecode v6
}

