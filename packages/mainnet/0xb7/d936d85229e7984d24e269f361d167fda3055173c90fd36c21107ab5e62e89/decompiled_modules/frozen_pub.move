module 0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::frozen_pub {
    struct FROZEN_PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN_PUB, arg1: &mut 0x2::tx_context::TxContext) {
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::freeze_from_otw<FROZEN_PUB>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

