module 0xfeb1cbdff6bbaec567778e25d4b3cc50eb328e1b3737192a0b0580f0833967a8::sen {
    struct SEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEN>(arg0, 9, b"SEN", b"senpai", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEN>(&mut v2, 8000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

