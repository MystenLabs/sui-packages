module 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::cap::AdminCap>(0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::Counter>(0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::new(arg1));
    }

    // decompiled from Move bytecode v6
}

