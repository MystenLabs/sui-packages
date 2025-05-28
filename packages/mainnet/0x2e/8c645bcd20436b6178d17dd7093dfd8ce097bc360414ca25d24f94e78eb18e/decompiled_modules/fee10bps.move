module 0x2e8c645bcd20436b6178d17dd7093dfd8ce097bc360414ca25d24f94e78eb18e::fee10bps {
    struct FEE10BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE10BPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<FEE10BPS>>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::create_fee<FEE10BPS>(arg0, 10, 1, arg1));
    }

    // decompiled from Move bytecode v6
}

