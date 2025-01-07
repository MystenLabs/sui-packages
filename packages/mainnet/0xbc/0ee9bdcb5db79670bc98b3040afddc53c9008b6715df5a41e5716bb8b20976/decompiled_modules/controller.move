module 0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::controller {
    public entry fun modify_controller(arg0: &mut 0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::is_emergency(arg0), 202);
        assert!(0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::is_emergency(arg0), 203);
        assert!(0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xbc0ee9bdcb5db79670bc98b3040afddc53c9008b6715df5a41e5716bb8b20976::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

