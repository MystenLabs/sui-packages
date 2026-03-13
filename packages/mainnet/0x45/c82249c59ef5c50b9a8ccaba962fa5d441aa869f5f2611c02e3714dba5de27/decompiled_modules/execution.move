module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::execution {
    struct ExecutionReceipt {
        intent_owner: address,
    }

    public fun begin_execution<T0>(arg0: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::ProtocolConfig, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ExecutionReceipt) {
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_type(0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<T0>(arg0), 0)) == arg2, 240);
        let (v0, v1, v2) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::execute_intent<T0>(arg0, arg1, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::treasury(arg1));
        let v3 = ExecutionReceipt{intent_owner: 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::owner<T0>(arg0)};
        (v0, v3)
    }

    public fun end_execution<T0>(arg0: ExecutionReceipt, arg1: 0x2::coin::Coin<T0>) {
        let ExecutionReceipt { intent_owner: v0 } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
    }

    public fun end_execution_no_output(arg0: ExecutionReceipt) {
        let ExecutionReceipt {  } = arg0;
    }

    public fun intent_owner(arg0: &ExecutionReceipt) : address {
        arg0.intent_owner
    }

    // decompiled from Move bytecode v6
}

