module 0x38392f79127691172486d0a9d66b61745a0aedf03eab9088e78171f7735852bb::genesis {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<GENESIS>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

