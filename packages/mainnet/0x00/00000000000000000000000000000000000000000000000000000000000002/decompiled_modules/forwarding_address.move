module 0x2::forwarding_address {
    struct ForwardingAddressRegistry has key {
        id: 0x2::object::UID,
    }

    fun create(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 13835058162656346113);
        let v0 = ForwardingAddressRegistry{id: 0x2::object::forwarding_address_registry()};
        0x2::transfer::share_object<ForwardingAddressRegistry>(v0);
    }

    // decompiled from Move bytecode v7
}

