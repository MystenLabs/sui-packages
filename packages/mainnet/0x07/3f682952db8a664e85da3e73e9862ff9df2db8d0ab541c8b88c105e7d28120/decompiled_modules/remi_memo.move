module 0x73f682952db8a664e85da3e73e9862ff9df2db8d0ab541c8b88c105e7d28120::remi_memo {
    struct REMI_MEMO has drop {
        dummy_field: bool,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        message: 0x1::string::String,
    }

    fun init(arg0: REMI_MEMO, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun transfer_with_memo(arg0: &mut 0x2::coin::Coin<0x1014a90a0c6e03123a601360098f7a470185b947c68598d76613318c993c41b5::remi::REMI>, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1014a90a0c6e03123a601360098f7a470185b947c68598d76613318c993c41b5::remi::REMI>>(0x2::coin::split<0x1014a90a0c6e03123a601360098f7a470185b947c68598d76613318c993c41b5::remi::REMI>(arg0, arg1, arg4), arg2);
        let v0 = TransferEvent{
            from    : 0x2::tx_context::sender(arg4),
            to      : arg2,
            amount  : arg1,
            message : arg3,
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

