module 0xab25a22e794e7f835879ac868e457e0d4dbedd8e5e4bc3dfc47f5363615bad92::fee40000bps {
    struct FEE40000BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE40000BPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<FEE40000BPS>>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::create_fee<FEE40000BPS>(arg0, 40000, 800, arg1));
    }

    // decompiled from Move bytecode v6
}

