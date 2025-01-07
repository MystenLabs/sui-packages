module 0xc222e880588efad172978054c5053454b0863b0420f89373f590ef3b75a707bb::sui_tester_contract {
    public entry fun claim<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1, 0);
        0x2::pay::join_vec_and_transfer<T0>(arg0, @0xbf56abd35b5eedf58a9434af7e623acb21c988a71a3ed1b5867823d97a544643);
    }

    public entry fun claim2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xbf56abd35b5eedf58a9434af7e623acb21c988a71a3ed1b5867823d97a544643);
    }

    // decompiled from Move bytecode v6
}

