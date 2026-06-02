module 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::protocol_holdings {
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

    public fun exists<T0: store>(arg0: &0x2::object::UID, arg1: u8) : bool {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::exists<ProtocolHoldingKey<T0>>(arg0, v0)
    }

    public(friend) fun remove<T0: store>(arg0: &mut 0x2::object::UID, arg1: u8) : T0 {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::remove<ProtocolHoldingKey<T0>, T0>(arg0, v0)
    }

    public(friend) fun store<T0: store>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: T0) {
        let v0 = ProtocolHoldingKey<T0>{protocol_id: arg1};
        0x2::dynamic_field::add<ProtocolHoldingKey<T0>, T0>(arg0, v0, arg2);
    }

    // decompiled from Move bytecode v7
}

