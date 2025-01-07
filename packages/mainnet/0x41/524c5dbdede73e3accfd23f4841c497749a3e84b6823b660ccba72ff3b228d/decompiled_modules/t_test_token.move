module 0x41524c5dbdede73e3accfd23f4841c497749a3e84b6823b660ccba72ff3b228d::t_test_token {
    struct MyToken has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64,
    }

    public fun create_token(arg0: &signer, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MyToken {
        MyToken{
            id           : 0x2::object::new(arg4),
            name         : arg1,
            symbol       : arg2,
            total_supply : arg3,
        }
    }

    public fun transfer_token(arg0: &signer, arg1: address, arg2: MyToken) {
        0x2::transfer::transfer<MyToken>(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

