module 0x8c6601fe6f8d8b6e2a5fb0a0efa1b7e03316b2a750d11965f195bcb30a63c06b::agg_test {
    struct SecureSwapReceipt {
        amount_withdrawn: u64,
        min_output_required: u64,
        deadline_ms: u64,
        token_in_price: u64,
        token_out_price: u64,
    }

    struct TestEvent has copy, drop, store {
        amount_step_2: u64,
        receiver: address,
    }

    struct TestStringEvent has copy, drop, store {
        message: 0x1::ascii::String,
    }

    entry fun message_1() {
        let v0 = TestStringEvent{message: 0x1::ascii::string(b"")};
        0x2::event::emit<TestStringEvent>(v0);
    }

    entry fun message_2(arg0: 0x2::object::ID) {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        let v1 = TestStringEvent{message: to_hex_ascii(&v0)};
        0x2::event::emit<TestStringEvent>(v1);
    }

    fun nibble_to_hex_char(arg0: u8) : 0x1::ascii::Char {
        if (arg0 < 10) {
            0x1::ascii::char(48 + arg0)
        } else {
            0x1::ascii::char(97 + arg0 - 10)
        }
    }

    public fun step_1<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SecureSwapReceipt) {
        let v0 = SecureSwapReceipt{
            amount_withdrawn    : arg1,
            min_output_required : 0,
            deadline_ms         : 0x2::clock::timestamp_ms(arg2),
            token_in_price      : 0,
            token_out_price     : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        (0x2::coin::split<T0>(&mut arg0, arg1, arg3), v0)
    }

    public fun step_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: SecureSwapReceipt, arg2: address, arg3: &0x2::clock::Clock) {
        let SecureSwapReceipt {
            amount_withdrawn    : _,
            min_output_required : _,
            deadline_ms         : _,
            token_in_price      : _,
            token_out_price     : _,
        } = arg1;
        let v5 = TestEvent{
            amount_step_2 : 0x2::coin::value<T0>(&arg0),
            receiver      : arg2,
        };
        0x2::event::emit<TestEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    fun to_hex_ascii(arg0: &vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::ascii::string(b"");
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            0x1::ascii::push_char(&mut v0, nibble_to_hex_char(v2 >> 4 & 15));
            0x1::ascii::push_char(&mut v0, nibble_to_hex_char(v2 & 15));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

