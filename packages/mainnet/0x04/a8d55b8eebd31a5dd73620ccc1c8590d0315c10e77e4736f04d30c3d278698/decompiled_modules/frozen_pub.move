module 0x4a8d55b8eebd31a5dd73620ccc1c8590d0315c10e77e4736f04d30c3d278698::frozen_pub {
    struct FROZEN_PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN_PUB, arg1: &mut 0x2::tx_context::TxContext) {
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::freeze_from_otw<FROZEN_PUB>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

