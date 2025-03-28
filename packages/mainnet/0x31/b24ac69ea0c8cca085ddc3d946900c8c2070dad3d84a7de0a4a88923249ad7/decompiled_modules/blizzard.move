module 0x31b24ac69ea0c8cca085ddc3d946900c8c2070dad3d84a7de0a4a88923249ad7::blizzard {
    struct BLIZZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x31b24ac69ea0c8cca085ddc3d946900c8c2070dad3d84a7de0a4a88923249ad7::blizzard_acl::new<BLIZZARD>(v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLIZZARD>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

