module 0x51fc883bf010c892a8733ab90c41ba12005cd4abe8c2d54e4b8b4a4705a2a35d::remi_memo {
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

    public fun transfer_with_memo(arg0: &mut 0x2::coin::Coin<0xb4be6363c77cae1a515c0e6feaca0d5b6536aae15d5dbec8844bf3edb8a60c85::remi::REMI>, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb4be6363c77cae1a515c0e6feaca0d5b6536aae15d5dbec8844bf3edb8a60c85::remi::REMI>>(0x2::coin::split<0xb4be6363c77cae1a515c0e6feaca0d5b6536aae15d5dbec8844bf3edb8a60c85::remi::REMI>(arg0, arg1, arg4), arg2);
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

