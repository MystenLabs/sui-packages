module 0xb924dd4ca619fdb3199f9e96129328da0bb7df1f57054dcc765debb360282726::fee1000bps {
    struct FEE1000BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE1000BPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<FEE1000BPS>>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::create_fee<FEE1000BPS>(arg0, 1000, 20, arg1));
    }

    // decompiled from Move bytecode v6
}

