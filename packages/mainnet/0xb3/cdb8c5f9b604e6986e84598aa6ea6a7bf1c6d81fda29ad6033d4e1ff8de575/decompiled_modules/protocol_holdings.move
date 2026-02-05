module 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings {
    struct ProtocolHoldingKey<phantom T0> has copy, drop, store {
        protocol_id: u8,
    }

    public fun borrow<T0: store>(arg0: &0x2::object::UID, arg1: u8) : &T0 {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::borrow<ProtocolHoldingKey<T0>, T0>(arg0, v0)
    }

    public(friend) fun borrow_mut<T0: store>(arg0: &mut 0x2::object::UID, arg1: u8) : &mut T0 {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::borrow_mut<ProtocolHoldingKey<T0>, T0>(arg0, v0)
    }

    public fun exists_<T0: store>(arg0: &0x2::object::UID, arg1: u8) : bool {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::exists_<ProtocolHoldingKey<T0>>(arg0, v0)
    }

    public(friend) fun remove<T0: store>(arg0: &mut 0x2::object::UID, arg1: u8) : T0 {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::remove<ProtocolHoldingKey<T0>, T0>(arg0, v0)
    }

    public(friend) fun store<T0: store>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: T0) {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::add<ProtocolHoldingKey<T0>, T0>(arg0, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

