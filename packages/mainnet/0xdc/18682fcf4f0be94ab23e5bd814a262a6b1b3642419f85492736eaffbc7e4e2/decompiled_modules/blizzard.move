module 0xdc18682fcf4f0be94ab23e5bd814a262a6b1b3642419f85492736eaffbc7e4e2::blizzard {
    struct BLIZZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xdc18682fcf4f0be94ab23e5bd814a262a6b1b3642419f85492736eaffbc7e4e2::blizzard_acl::new<BLIZZARD>(v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLIZZARD>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

