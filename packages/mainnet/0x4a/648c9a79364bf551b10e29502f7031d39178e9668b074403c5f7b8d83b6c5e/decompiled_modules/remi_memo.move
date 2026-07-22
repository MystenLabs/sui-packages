module 0x4a648c9a79364bf551b10e29502f7031d39178e9668b074403c5f7b8d83b6c5e::remi_memo {
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

    public fun transfer_with_memo(arg0: &mut 0x2::coin::Coin<0x7abf9a97b56161a712eed81a79aed3aaa856afeffce3f9eaa1c69d11869a168c::remi::REMI>, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7abf9a97b56161a712eed81a79aed3aaa856afeffce3f9eaa1c69d11869a168c::remi::REMI>>(0x2::coin::split<0x7abf9a97b56161a712eed81a79aed3aaa856afeffce3f9eaa1c69d11869a168c::remi::REMI>(arg0, arg1, arg4), arg2);
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

