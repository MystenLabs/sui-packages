module 0x20421b6a5e006ec5fef43511843eb4ef1dbbd2c4ca4af3d71d7acab079135c4e::eub_memo {
    struct EUB_MEMO has drop {
        dummy_field: bool,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        message: 0x1::string::String,
    }

    fun init(arg0: EUB_MEMO, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun transfer_with_memo(arg0: &mut 0x2::coin::Coin<0x1e244ea6370e05954d8e77256452fe942c9e94619a943ef3724d7e93676c6b7e::eub::EUB>, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1e244ea6370e05954d8e77256452fe942c9e94619a943ef3724d7e93676c6b7e::eub::EUB>>(0x2::coin::split<0x1e244ea6370e05954d8e77256452fe942c9e94619a943ef3724d7e93676c6b7e::eub::EUB>(arg0, arg1, arg4), arg2);
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

