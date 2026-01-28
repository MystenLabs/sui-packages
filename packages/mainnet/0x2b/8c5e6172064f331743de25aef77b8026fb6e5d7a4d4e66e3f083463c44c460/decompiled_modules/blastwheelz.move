module 0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::blastwheelz {
    struct BLASTWHEELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTWHEELZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cap::AdminCap>(0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLASTWHEELZ>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

