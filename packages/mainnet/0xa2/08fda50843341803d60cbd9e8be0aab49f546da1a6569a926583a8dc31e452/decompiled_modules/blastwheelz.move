module 0xa208fda50843341803d60cbd9e8be0aab49f546da1a6569a926583a8dc31e452::blastwheelz {
    struct BLASTWHEELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTWHEELZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa208fda50843341803d60cbd9e8be0aab49f546da1a6569a926583a8dc31e452::cap::AdminCap>(0xa208fda50843341803d60cbd9e8be0aab49f546da1a6569a926583a8dc31e452::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLASTWHEELZ>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

