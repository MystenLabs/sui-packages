module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::connections {
    public(friend) fun get_fee(arg0: &0x2::bag::Bag, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : u64 {
        let v0 = get_connection_type(&arg1);
        let v1 = b"centralized";
        assert!(0x1::string::bytes(&v0) == &v1, 0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::centralized_connection::get_fee(arg0, arg1, arg2, arg3)
    }

    public(friend) fun send_message(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_connection_type(&arg1);
        let v1 = b"centralized";
        assert!(0x1::string::bytes(&v0) == &v1, 0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::centralized_connection::send_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun get_connection_type(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"-");
        0x1::string::sub_string(arg0, 0, 0x1::string::index_of(arg0, &v0))
    }

    public(friend) fun register(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_connection_type(&arg1);
        let v1 = b"centralized";
        assert!(0x1::string::bytes(&v0) == &v1, 0);
        0x2::bag::add<0x1::string::String, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::centralized_state::State>(arg0, arg1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::centralized_connection::connect());
    }

    // decompiled from Move bytecode v6
}

