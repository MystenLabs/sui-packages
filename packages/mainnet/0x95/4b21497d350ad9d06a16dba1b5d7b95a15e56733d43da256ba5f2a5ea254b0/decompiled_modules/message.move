module 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message {
    struct Message has copy, drop, store {
        message: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32,
    }

    public fun data(arg0: &Message) : vector<u8> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::data(&arg0.message)
    }

    public fun new(arg0: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) : Message {
        Message{message: arg0}
    }

    public fun add_sender(arg0: &Message, arg1: &0x2::object::ID) : Message {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, data(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg1));
        let v1 = 0x2::hash::keccak256(&v0);
        *0x1::vector::borrow_mut<u8>(&mut v1, 0) = chain_from(arg0);
        *0x1::vector::borrow_mut<u8>(&mut v1, 1) = chain_to(arg0);
        from_bytes(v1)
    }

    public fun chain_from(arg0: &Message) : u8 {
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::data(&arg0.message);
        *0x1::vector::borrow<u8>(&v0, 0)
    }

    public fun chain_to(arg0: &Message) : u8 {
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::data(&arg0.message);
        *0x1::vector::borrow<u8>(&v0, 1)
    }

    public fun from_args(arg0: u64, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg2: u8, arg3: u8, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg5: u256, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::MessengerProtocol) : Message {
        let v0 = (arg0 as u256);
        let v1 = 0x2::bcs::to_bytes<u256>(&v0);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = (arg2 as u256);
        let v3 = 0x2::bcs::to_bytes<u256>(&v2);
        0x1::vector::reverse<u8>(&mut v3);
        let v4 = 0x2::bcs::to_bytes<u256>(&arg5);
        0x1::vector::reverse<u8>(&mut v4);
        let v5 = b"";
        0x1::vector::append<u8>(&mut v5, v1);
        0x1::vector::append<u8>(&mut v5, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::data(&arg1));
        0x1::vector::append<u8>(&mut v5, v3);
        0x1::vector::append<u8>(&mut v5, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::data(&arg4));
        0x1::vector::append<u8>(&mut v5, v4);
        0x1::vector::push_back<u8>(&mut v5, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::id(&arg6));
        let v6 = 0x2::hash::keccak256(&v5);
        *0x1::vector::borrow_mut<u8>(&mut v6, 0) = arg2;
        *0x1::vector::borrow_mut<u8>(&mut v6, 1) = arg3;
        from_bytes(v6)
    }

    public fun from_args_with_sender(arg0: u64, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg2: u8, arg3: u8, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg5: u256, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::MessengerProtocol, arg7: &0x2::object::ID) : Message {
        let v0 = from_args(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        add_sender(&v0, arg7)
    }

    public fun from_bytes(arg0: vector<u8>) : Message {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        Message{message: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::new(arg0)}
    }

    public fun to_hex(arg0: &Message) : 0x1::ascii::String {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_ascii_hex(&arg0.message)
    }

    // decompiled from Move bytecode v6
}

