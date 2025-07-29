module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard {
    struct BLIZZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::new<BLIZZARD>(v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLIZZARD>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

