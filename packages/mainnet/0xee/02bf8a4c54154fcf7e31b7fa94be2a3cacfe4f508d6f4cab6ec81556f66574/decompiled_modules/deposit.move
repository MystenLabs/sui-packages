module 0xee02bf8a4c54154fcf7e31b7fa94be2a3cacfe4f508d6f4cab6ec81556f66574::deposit {
    struct FluxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenData has copy, drop, store {
        symbol: vector<u8>,
        decimals: u8,
        max_deposit: u64,
        min_deposit: u64,
        max_deposit_usd: u64,
        min_deposit_usd: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        treasury: address,
        version: u64,
        supported_tokens: 0x2::vec_map::VecMap<0x1::type_name::TypeName, TokenData>,
    }

    struct BridgeDepositEvent has copy, drop {
        sender: address,
        recipient: 0x1::string::String,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun deposit<T0>(arg0: &Registry, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        let v1 = 0x1::type_name::get<T0>();
        let v2 = supported_token(arg0, &v1);
        assert!(0x1::option::is_some<TokenData>(&v2), 3);
        assert!(v0 >= 0x1::option::borrow<TokenData>(&v2).min_deposit, 2);
        let v3 = 0x1::type_name::get<T0>();
        assert_token_supported(arg0, &v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
        let v4 = BridgeDepositEvent{
            sender       : 0x2::tx_context::sender(arg4),
            recipient    : arg2,
            token_type   : 0x1::type_name::get<T0>(),
            amount       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BridgeDepositEvent>(v4);
    }

    fun assert_token_supported(arg0: &Registry, arg1: &0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenData>(&arg0.supported_tokens, arg1), 3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id               : 0x2::object::new(arg0),
            treasury         : 0x2::tx_context::sender(arg0),
            version          : 1,
            supported_tokens : 0x2::vec_map::empty<0x1::type_name::TypeName, TokenData>(),
        };
        let v1 = FluxAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FluxAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun register_supported_token<T0>(arg0: &mut Registry, arg1: &FluxAdminCap, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenData{
            symbol          : arg2,
            decimals        : arg3,
            max_deposit     : arg4,
            min_deposit     : arg5,
            max_deposit_usd : arg6,
            min_deposit_usd : arg7,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, TokenData>(&mut arg0.supported_tokens, 0x1::type_name::get<T0>(), v0);
    }

    public(friend) fun supported_token(arg0: &Registry, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<TokenData> {
        0x2::vec_map::try_get<0x1::type_name::TypeName, TokenData>(&arg0.supported_tokens, arg1)
    }

    public fun update_supported_token<T0>(arg0: &mut Registry, arg1: &FluxAdminCap, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = TokenData{
            symbol          : arg2,
            decimals        : arg3,
            max_deposit     : arg4,
            min_deposit     : arg5,
            max_deposit_usd : arg6,
            min_deposit_usd : arg7,
        };
        assert_token_supported(arg0, &v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, TokenData>(&mut arg0.supported_tokens, v0, v1);
    }

    public fun update_treasury(arg0: &mut Registry, arg1: &FluxAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

