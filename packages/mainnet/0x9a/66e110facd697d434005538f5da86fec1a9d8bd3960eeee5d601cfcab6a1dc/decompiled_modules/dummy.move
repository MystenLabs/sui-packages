module 0x9a66e110facd697d434005538f5da86fec1a9d8bd3960eeee5d601cfcab6a1dc::dummy {
    struct Dummy has key {
        id: 0x2::object::UID,
        movescription: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription,
    }

    public fun new(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg1: &mut 0x2::tx_context::TxContext) : Dummy {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_move_tick(&arg0);
        Dummy{
            id            : 0x2::object::new(arg1),
            movescription : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

