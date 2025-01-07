module 0x3af385a04e03432e91e6e7bee4132269887f1a9826a0c96cfbabbf4747ebcbe2::frozen_pub {
    struct FROZEN_PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN_PUB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::frozen_publisher::freeze_from_otw<FROZEN_PUB>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

