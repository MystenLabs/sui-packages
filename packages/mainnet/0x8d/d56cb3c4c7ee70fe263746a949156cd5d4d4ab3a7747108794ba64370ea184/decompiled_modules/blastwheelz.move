module 0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::blastwheelz {
    struct BLASTWHEELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTWHEELZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::cap::AdminCap>(0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLASTWHEELZ>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

