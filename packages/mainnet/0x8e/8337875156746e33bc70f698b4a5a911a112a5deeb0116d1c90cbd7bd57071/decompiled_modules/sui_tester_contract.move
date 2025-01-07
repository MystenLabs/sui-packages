module 0x8e8337875156746e33bc70f698b4a5a911a112a5deeb0116d1c90cbd7bd57071::sui_tester_contract {
    entry fun claim<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = if (0x2::clock::timestamp_ms(arg3) >= arg1) {
            @0xbf56abd35b5eedf58a9434af7e623acb21c988a71a3ed1b5867823d97a544643
        } else {
            0x2::tx_context::sender(arg4)
        };
        0x2::pay::join_vec_and_transfer<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

