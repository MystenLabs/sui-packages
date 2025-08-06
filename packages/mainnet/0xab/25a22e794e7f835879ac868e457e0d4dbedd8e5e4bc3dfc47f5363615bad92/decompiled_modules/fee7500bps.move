module 0xab25a22e794e7f835879ac868e457e0d4dbedd8e5e4bc3dfc47f5363615bad92::fee7500bps {
    struct FEE7500BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE7500BPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<FEE7500BPS>>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::create_fee<FEE7500BPS>(arg0, 7500, 150, arg1));
    }

    // decompiled from Move bytecode v6
}

