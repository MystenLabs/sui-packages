module 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::pramb_cover {
    struct Config has store, key {
        id: 0x2::object::UID,
        current_version: u64,
        current_id: u64,
        protocols: 0x2::table::Table<0x1::ascii::String, Protocol>,
        admin: address,
    }

    struct EscrowCoins<phantom T0> has store, key {
        id: 0x2::object::UID,
        coins: 0x2::coin::Coin<T0>,
    }

    struct Protocol has store {
        name: 0x1::ascii::String,
        user_covers: 0x2::table::Table<u64, UserCover>,
        rate_per_day: u64,
        max_capacity_tokens: 0x2::table::Table<0x1::ascii::String, TokenCapacity>,
    }

    struct UserCover has drop, store {
        cover_id: u64,
        addr: address,
        amount: u64,
        cost: u64,
        coin_type: 0x1::ascii::String,
        start_time: u64,
        end_time: u64,
    }

    struct TokenCapacity has drop, store {
        token_type: 0x1::ascii::String,
        capacity: u64,
        max_capacity: u64,
    }

    struct CreateProtocolEvent has copy, drop, store {
        name: 0x1::ascii::String,
        rate: u64,
    }

    struct AddTokenCoverEvent has copy, drop, store {
        token_type: 0x1::ascii::String,
        max_capacity_token: u64,
    }

    struct CreateUserCoverEvent has copy, drop, store {
        cover_id: u64,
        user_addr: address,
        protocol_name: 0x1::ascii::String,
        token_type: 0x1::ascii::String,
        amount: u64,
        cost: u64,
        start_time: u64,
        end_time: u64,
        current_capacity: u64,
    }

    struct ExtendUserCoverEvent has copy, drop, store {
        cover_id: u64,
        user_addr: address,
        protocol_name: 0x1::ascii::String,
        token_type: 0x1::ascii::String,
        amount: u64,
        cost: u64,
        start_time: u64,
        end_time: u64,
    }

    public entry fun add_token_cover<T0>(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 101);
        assert!(0x2::table::contains<0x1::ascii::String, Protocol>(&arg0.protocols, arg1), 102);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Protocol>(&mut arg0.protocols, arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::table::contains<0x1::ascii::String, TokenCapacity>(&v0.max_capacity_tokens, v1), 104);
        let v2 = TokenCapacity{
            token_type   : v1,
            capacity     : 0,
            max_capacity : arg2,
        };
        0x2::table::add<0x1::ascii::String, TokenCapacity>(&mut v0.max_capacity_tokens, v1, v2);
        let v3 = AddTokenCoverEvent{
            token_type         : v1,
            max_capacity_token : arg2,
        };
        0x2::event::emit<AddTokenCoverEvent>(v3);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 108);
    }

    public entry fun buy_cover<T0>(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<0x1::ascii::String, Protocol>(&arg0.protocols, arg1), 102);
        assert!(arg4 <= 365, 109);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Protocol>(&mut arg0.protocols, arg1);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, TokenCapacity>(&v1.max_capacity_tokens, v2), 105);
        assert_version(arg0.current_version);
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v2)) {
            let v3 = EscrowCoins<T0>{
                id    : 0x2::object::new(arg6),
                coins : 0x2::coin::zero<T0>(arg6),
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, EscrowCoins<T0>>(&mut arg0.id, v2, v3);
        };
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, EscrowCoins<T0>>(&mut arg0.id, v2);
        let v5 = 0x2::table::borrow_mut<0x1::ascii::String, TokenCapacity>(&mut v1.max_capacity_tokens, v2);
        let v6 = v5.capacity + arg2;
        assert!(v6 <= v5.max_capacity, 106);
        let v7 = arg0.current_id + 1;
        let v8 = 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::as_u64(0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::div(0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::mul(0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::from_u64(arg2), 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::from_u64(v1.rate_per_day * arg4)), 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::from_u64(1000000)));
        assert!(v8 == 0x2::coin::value<T0>(&arg3), 100);
        let v9 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v10 = v9 + arg4 * 86400;
        let v11 = UserCover{
            cover_id   : v7,
            addr       : v0,
            amount     : arg2,
            cost       : v8,
            coin_type  : v2,
            start_time : v9,
            end_time   : v10,
        };
        0x2::table::add<u64, UserCover>(&mut v1.user_covers, v7, v11);
        arg0.current_id = v7;
        v5.capacity = v6;
        0x2::pay::join<T0>(&mut v4.coins, arg3);
        let v12 = CreateUserCoverEvent{
            cover_id         : v7,
            user_addr        : v0,
            protocol_name    : arg1,
            token_type       : v2,
            amount           : arg2,
            cost             : v8,
            start_time       : v9,
            end_time         : v10,
            current_capacity : v6,
        };
        0x2::event::emit<CreateUserCoverEvent>(v12);
    }

    public entry fun create_protocol(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 101);
        let v0 = Protocol{
            name                : arg1,
            user_covers         : 0x2::table::new<u64, UserCover>(arg3),
            rate_per_day        : arg2,
            max_capacity_tokens : 0x2::table::new<0x1::ascii::String, TokenCapacity>(arg3),
        };
        0x2::table::add<0x1::ascii::String, Protocol>(&mut arg0.protocols, arg1, v0);
        let v1 = CreateProtocolEvent{
            name : arg1,
            rate : arg2,
        };
        0x2::event::emit<CreateProtocolEvent>(v1);
    }

    public entry fun deposit_treasure<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 105);
        0x2::pay::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, EscrowCoins<T0>>(&mut arg0.id, v0).coins, arg1);
    }

    public entry fun extend_user_cover<T0>(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Protocol>(&arg0.protocols, arg1), 102);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Protocol>(&mut arg0.protocols, arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, TokenCapacity>(&v0.max_capacity_tokens, v1), 105);
        assert!(0x2::table::contains<u64, UserCover>(&v0.user_covers, arg2), 107);
        assert_version(arg0.current_version);
        let v2 = 0x2::table::borrow_mut<u64, UserCover>(&mut v0.user_covers, arg2);
        let v3 = v2.end_time + arg3 * 86400;
        assert!((v3 - v2.start_time) / 86400 <= 365, 109);
        let v4 = 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::as_u64(0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::div(0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::mul(0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::from_u64(v2.amount), 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::from_u64(v0.rate_per_day * arg3)), 0x18d6649865e699901a559e72281e2fa10840b50711a2a59b48b1b09c53714b0::u256::from_u64(1000000)));
        assert!(v4 == 0x2::coin::value<T0>(&arg4), 100);
        v2.end_time = v3;
        v2.cost = v4;
        0x2::pay::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, EscrowCoins<T0>>(&mut arg0.id, v1).coins, arg4);
        let v5 = ExtendUserCoverEvent{
            cover_id      : arg2,
            user_addr     : 0x2::tx_context::sender(arg5),
            protocol_name : arg1,
            token_type    : v1,
            amount        : v2.amount,
            cost          : v4,
            start_time    : v2.start_time,
            end_time      : v3,
        };
        0x2::event::emit<ExtendUserCoverEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id              : 0x2::object::new(arg0),
            current_version : 1,
            current_id      : 0,
            protocols       : 0x2::table::new<0x1::ascii::String, Protocol>(arg0),
            admin           : @0x1937f2c5ce1cbab08893b63945c20cde349e4a7850eea317b965ff8da383c80e,
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    fun migrate_version_contract(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 101);
        arg0.current_version = arg1;
    }

    public entry fun update_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 101);
        arg0.admin = arg1;
    }

    public entry fun update_max_capacity_token_protocol<T0>(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 101);
        assert!(0x2::table::contains<0x1::ascii::String, Protocol>(&arg0.protocols, arg1), 102);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Protocol>(&mut arg0.protocols, arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, TokenCapacity>(&v0.max_capacity_tokens, v1), 105);
        0x2::table::borrow_mut<0x1::ascii::String, TokenCapacity>(&mut v0.max_capacity_tokens, v1).max_capacity = arg2;
    }

    public entry fun update_rate_protocol(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 101);
        assert!(0x2::table::contains<0x1::ascii::String, Protocol>(&arg0.protocols, arg1), 102);
        0x2::table::borrow_mut<0x1::ascii::String, Protocol>(&mut arg0.protocols, arg1).rate_per_day = arg2;
    }

    public entry fun withdraw_treasure<T0>(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == @0x1937f2c5ce1cbab08893b63945c20cde349e4a7850eea317b965ff8da383c80e || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 101);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v1), 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, EscrowCoins<T0>>(&mut arg0.id, v1).coins, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

