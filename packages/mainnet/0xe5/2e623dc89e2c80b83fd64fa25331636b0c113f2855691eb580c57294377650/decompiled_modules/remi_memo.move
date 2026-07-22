module 0xe52e623dc89e2c80b83fd64fa25331636b0c113f2855691eb580c57294377650::remi_memo {
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

    public fun transfer_with_memo(arg0: &mut 0x2::coin::Coin<0x566fe663544d581e135d919d6837967432ae898ee36db7b84e7f2dbf14b817c8::remi::REMI>, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x566fe663544d581e135d919d6837967432ae898ee36db7b84e7f2dbf14b817c8::remi::REMI>>(0x2::coin::split<0x566fe663544d581e135d919d6837967432ae898ee36db7b84e7f2dbf14b817c8::remi::REMI>(arg0, arg1, arg4), arg2);
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

