module 0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::operator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

