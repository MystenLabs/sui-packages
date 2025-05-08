module 0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::executor {
    struct RequestForExecution has copy, drop {
        quoter_address: vector<u8>,
        amt_paid: u64,
        dst_chain: u16,
        dst_addr: address,
        refund_addr: address,
        signed_quote: vector<u8>,
        request_bytes: vector<u8>,
        relay_instructions: vector<u8>,
    }

    public fun request_execution(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u16, arg3: address, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        let v0 = 0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::cursor::new<u8>(arg5);
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::take_bytes(&mut v0, 4);
        assert!(0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::take_u16_be(&mut v0) == 21, 0);
        assert!(0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::take_u16_be(&mut v0) == arg2, 1);
        assert!(0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::take_u64_be(&mut v0) > 0x2::clock::timestamp_ms(arg1) / 1000, 2);
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::cursor::take_rest<u8>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::address::from_bytes(0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::take_bytes(&mut v0, 32)));
        let v1 = RequestForExecution{
            quoter_address     : 0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::take_bytes(&mut v0, 20),
            amt_paid           : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            dst_chain          : arg2,
            dst_addr           : arg3,
            refund_addr        : arg4,
            signed_quote       : arg5,
            request_bytes      : arg6,
            relay_instructions : arg7,
        };
        0x2::event::emit<RequestForExecution>(v1);
    }

    // decompiled from Move bytecode v6
}

