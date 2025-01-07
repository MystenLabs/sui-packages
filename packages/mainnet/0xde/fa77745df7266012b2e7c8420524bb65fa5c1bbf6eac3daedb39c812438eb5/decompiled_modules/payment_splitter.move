module 0xdefa77745df7266012b2e7c8420524bb65fa5c1bbf6eac3daedb39c812438eb5::payment_splitter {
    struct BlockusPaymentSplitterDoneEvent has copy, drop {
        executed_by: address,
        amount: u64,
        recipients: vector<address>,
        splitting: vector<u64>,
        external_id: vector<u8>,
    }

    struct BlockusPaymentDoneEvent has copy, drop {
        executed_by: address,
        amount: u64,
        recipient: address,
        external_id: vector<u8>,
    }

    struct PAYMENT_SPLITTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYMENT_SPLITTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAYMENT_SPLITTER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun make_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0x2::coin::value<0x2::sui::SUI>(&arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v0 = BlockusPaymentDoneEvent{
            executed_by : 0x2::tx_context::sender(arg4),
            amount      : arg2,
            recipient   : arg1,
            external_id : arg3,
        };
        0x2::event::emit<BlockusPaymentDoneEvent>(v0);
    }

    public entry fun split_payment(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        while (!0x1::vector::is_empty<address>(&arg1) && !0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg2);
            assert!(v0 > 0, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, v0, arg4), 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v1 = BlockusPaymentSplitterDoneEvent{
            executed_by : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<0x2::sui::SUI>(arg0),
            recipients  : arg1,
            splitting   : arg2,
            external_id : arg3,
        };
        0x2::event::emit<BlockusPaymentSplitterDoneEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

