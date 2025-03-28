module 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard {
    struct BLIZZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_acl::new<BLIZZARD>(v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLIZZARD>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

