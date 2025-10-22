module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::operator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x7e2cf02c692715cbf3416df4c82360b2aee73fa07674fe87e97aafae0b64b7c2);
    }

    // decompiled from Move bytecode v6
}

