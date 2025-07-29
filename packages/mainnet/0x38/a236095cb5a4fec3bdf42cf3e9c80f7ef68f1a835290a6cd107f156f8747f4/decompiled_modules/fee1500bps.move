module 0x38a236095cb5a4fec3bdf42cf3e9c80f7ef68f1a835290a6cd107f156f8747f4::fee1500bps {
    struct FEE1500BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE1500BPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<FEE1500BPS>>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::create_fee<FEE1500BPS>(arg0, 1500, 30, arg1));
    }

    // decompiled from Move bytecode v6
}

