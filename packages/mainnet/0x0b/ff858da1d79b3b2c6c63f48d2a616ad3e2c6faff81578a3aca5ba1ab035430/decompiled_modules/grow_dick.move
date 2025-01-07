module 0xbff858da1d79b3b2c6c63f48d2a616ad3e2c6faff81578a3aca5ba1ab035430::grow_dick {
    struct Dick has store, key {
        id: 0x2::object::UID,
        owner: address,
        length: u64,
        width: u64,
        color: vector<u8>,
    }

    public fun grow_dick(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Dick, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.length = arg1.length + 0x2::coin::value<0x2::sui::SUI>(&arg0);
        arg1.width = arg1.width + 0x2::coin::value<0x2::sui::SUI>(&arg0) / 4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x6b3707e2360849c69f9438d124c80b6cb3f76aec03dc7316f3537f1b04b5bf40);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun mint_dick(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Dick{
            id     : 0x2::object::new(arg1),
            owner  : 0x2::tx_context::sender(arg1),
            length : 13,
            width  : 4,
            color  : arg0,
        };
        0x2::transfer::transfer<Dick>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

