module 0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::frozen_pub {
    struct FROZEN_PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN_PUB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::frozen_publisher::freeze_from_otw<FROZEN_PUB>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

