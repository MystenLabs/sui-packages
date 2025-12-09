module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client {
    struct Any2SuiMessage {
        message_id: vector<u8>,
        source_chain_selector: u64,
        sender: vector<u8>,
        data: vector<u8>,
        message_receiver: address,
        token_receiver: address,
        dest_token_amounts: vector<Any2SuiTokenAmount>,
    }

    struct Any2SuiTokenAmount has copy, drop {
        token: address,
        amount: u256,
    }

    public(friend) fun consume_any2sui_message(arg0: Any2SuiMessage, arg1: address) : (vector<u8>, u64, vector<u8>, vector<u8>, address, address, vector<Any2SuiTokenAmount>) {
        let Any2SuiMessage {
            message_id            : v0,
            source_chain_selector : v1,
            sender                : v2,
            data                  : v3,
            message_receiver      : v4,
            token_receiver        : v5,
            dest_token_amounts    : v6,
        } = arg0;
        assert!(v4 == arg1, 6);
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun encode_generic_extra_args_v2(arg0: u256, arg1: bool) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"181dcf10");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u256>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<bool>(&arg1));
        v0
    }

    public fun encode_sui_extra_args_v1(arg0: u64, arg1: bool, arg2: vector<u8>, arg3: vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"21ea4ca9");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<bool>(&arg1));
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg2));
        let v1 = &arg3;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(v1, v2)) == 32, 4);
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<vector<u8>>>(&arg3));
        v0
    }

    public fun encode_svm_extra_args_v1(arg0: u32, arg1: u64, arg2: bool, arg3: vector<u8>, arg4: vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"1f3b3aba");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u32>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<bool>(&arg2));
        assert!(0x1::vector::length<u8>(&arg3) == 32, 1);
        let v1 = &arg4;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(v1, v2)) == 32, 2);
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<vector<u8>>>(&arg4));
        v0
    }

    public fun generic_extra_args_v2_tag() : vector<u8> {
        x"181dcf10"
    }

    public fun get_amount(arg0: &Any2SuiTokenAmount) : u256 {
        arg0.amount
    }

    public fun get_token(arg0: &Any2SuiTokenAmount) : address {
        arg0.token
    }

    public fun get_token_and_amount(arg0: &Any2SuiTokenAmount) : (address, u256) {
        (arg0.token, arg0.amount)
    }

    public(friend) fun new_any2sui_message(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: address, arg6: vector<Any2SuiTokenAmount>) : Any2SuiMessage {
        Any2SuiMessage{
            message_id            : arg0,
            source_chain_selector : arg1,
            sender                : arg2,
            data                  : arg3,
            message_receiver      : arg4,
            token_receiver        : arg5,
            dest_token_amounts    : arg6,
        }
    }

    public(friend) fun new_dest_token_amounts(arg0: vector<address>, arg1: vector<u256>) : vector<Any2SuiTokenAmount> {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u256>(&arg1), 5);
        let v0 = &arg0;
        let v1 = 0x1::vector::empty<Any2SuiTokenAmount>();
        let v2 = &arg1;
        let v3 = 0x1::vector::length<address>(v0);
        assert!(v3 == 0x1::vector::length<u256>(v2), 13906834822883442687);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = Any2SuiTokenAmount{
                token  : *0x1::vector::borrow<address>(v0, v4),
                amount : *0x1::vector::borrow<u256>(v2, v4),
            };
            0x1::vector::push_back<Any2SuiTokenAmount>(&mut v1, v5);
            v4 = v4 + 1;
        };
        v1
    }

    public fun sui_extra_args_v1_tag() : vector<u8> {
        x"21ea4ca9"
    }

    public fun svm_extra_args_v1_tag() : vector<u8> {
        x"1f3b3aba"
    }

    // decompiled from Move bytecode v6
}

