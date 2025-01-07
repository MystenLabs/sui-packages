module 0xdbb7c51d34b25d83c2690ddd26d63d183d5d7b4fa5c99c29f87b1d5976f10dec::sui_tester {
    struct Claimeable has key {
        id: 0x2::object::UID,
    }

    entry fun claim<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = if (0x2::clock::timestamp_ms(arg3) >= arg1) {
            @0xbf56abd35b5eedf58a9434af7e623acb21c988a71a3ed1b5867823d97a544643
        } else {
            0x2::tx_context::sender(arg4)
        };
        0x2::pay::join_vec_and_transfer<T0>(arg0, v0);
    }

    public entry fun claim2(arg0: u64, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0, 0);
        let v0 = Claimeable{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<Claimeable>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

