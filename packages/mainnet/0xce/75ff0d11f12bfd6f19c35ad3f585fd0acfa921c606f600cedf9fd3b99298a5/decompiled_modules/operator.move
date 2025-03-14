module 0xce75ff0d11f12bfd6f19c35ad3f585fd0acfa921c606f600cedf9fd3b99298a5::operator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

