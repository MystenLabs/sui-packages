module 0xe8f612c2b8e0d4c08f0bbbba150508962d8eb70629fb43e7a5bbe9f6edc80369::whale_tracker {
    struct WhaleTransferEvent has copy, drop {
        token_type: 0x1::string::String,
        sender: address,
        receiver: address,
        amount: u64,
        tx_digest: vector<u8>,
    }

    public fun track_whale_transfer<T0>(arg0: &0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 > arg2 / 100) {
            let v1 = WhaleTransferEvent{
                token_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
                sender     : 0x2::tx_context::sender(arg3),
                receiver   : arg1,
                amount     : v0,
                tx_digest  : *0x2::tx_context::digest(arg3),
            };
            0x2::event::emit<WhaleTransferEvent>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

