module 0xb924dd4ca619fdb3199f9e96129328da0bb7df1f57054dcc765debb360282726::fee2500bps {
    struct FEE2500BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE2500BPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<FEE2500BPS>>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::create_fee<FEE2500BPS>(arg0, 2500, 50, arg1));
    }

    // decompiled from Move bytecode v6
}

