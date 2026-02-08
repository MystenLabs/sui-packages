module 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::protocol_holdings {
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

