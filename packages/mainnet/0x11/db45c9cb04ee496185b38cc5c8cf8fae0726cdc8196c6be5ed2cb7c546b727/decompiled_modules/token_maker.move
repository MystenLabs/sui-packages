module 0x11db45c9cb04ee496185b38cc5c8cf8fae0726cdc8196c6be5ed2cb7c546b727::token_maker {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<address, TokenInfo>,
    }

    struct TokenInfo has store {
        name: vector<u8>,
        symbol: vector<u8>,
        token_id: 0x2::object::ID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        fee_collector: address,
    }

    struct TokenCreatedEvent has copy, drop {
        token_id: 0x2::object::ID,
        creator: address,
        name: vector<u8>,
        symbol: vector<u8>,
    }

    public entry fun create_token(arg0: &AdminCap, arg1: &mut TokenRegistry, arg2: &FeeConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg2.fee_amount, 1);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = TokenInfo{
            name     : arg3,
            symbol   : arg4,
            token_id : v1,
        };
        0x2::table::add<address, TokenInfo>(&mut arg1.tokens, 0x2::tx_context::sender(arg6), v2);
        let v3 = TokenCreatedEvent{
            token_id : v1,
            creator  : 0x2::tx_context::sender(arg6),
            name     : arg3,
            symbol   : arg4,
        };
        0x2::event::emit<TokenCreatedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg2.fee_collector);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = TokenRegistry{
            id     : 0x2::object::new(arg0),
            tokens : 0x2::table::new<address, TokenInfo>(arg0),
        };
        let v2 = FeeConfig{
            id            : 0x2::object::new(arg0),
            fee_amount    : 1000000000,
            fee_collector : @0x576dd55fd0976f0042f6f78e48e5063f6fca8988fb6f976a9abc1bef571873fd,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TokenRegistry>(v1);
        0x2::transfer::share_object<FeeConfig>(v2);
    }

    // decompiled from Move bytecode v6
}

