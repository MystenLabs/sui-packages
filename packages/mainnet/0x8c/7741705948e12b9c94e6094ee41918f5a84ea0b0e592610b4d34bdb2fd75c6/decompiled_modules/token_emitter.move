module 0x8c7741705948e12b9c94e6094ee41918f5a84ea0b0e592610b4d34bdb2fd75c6::token_emitter {
    struct NewTokenEvent has copy, drop, store {
        token_type: 0x1::ascii::String,
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        icon_url: 0x1::ascii::String,
        decimals: u8,
        treasury_cap_id: 0x2::object::ID,
        coin_metadata_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop, store {
        token_type: 0x1::ascii::String,
        amount: u64,
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::url::Url, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x2::url::Url>(arg5), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = NewTokenEvent{
            token_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            name             : 0x1::ascii::string(arg3),
            symbol           : 0x1::ascii::string(arg2),
            icon_url         : 0x2::url::inner_url(&arg5),
            decimals         : arg1,
            treasury_cap_id  : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v3),
            coin_metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&v2),
        };
        0x2::event::emit<NewTokenEvent>(v4);
        (v3, v2)
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = MintEvent{
            token_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount     : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::coin::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

