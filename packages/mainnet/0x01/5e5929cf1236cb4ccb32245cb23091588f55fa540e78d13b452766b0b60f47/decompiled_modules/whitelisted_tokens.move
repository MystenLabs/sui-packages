module 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens {
    struct EventWhitelistToken has copy, drop, store {
        sender: address,
        token: 0x1::type_name::TypeName,
        listed: bool,
    }

    struct WhitelistedToken {
        voter: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
    }

    struct WhitelistManager has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
        is_whitelisted_token: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        bag: 0x2::bag::Bag,
    }

    struct WhitelistManagerCap has store, key {
        id: 0x2::object::UID,
        whitelist_manager: 0x2::object::ID,
    }

    public fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (WhitelistManager, WhitelistManagerCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = WhitelistManager{
            id                   : v0,
            voter                : arg0,
            is_whitelisted_token : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            bag                  : 0x2::bag::new(arg1),
        };
        let v2 = WhitelistManagerCap{
            id                : 0x2::object::new(arg1),
            whitelist_manager : 0x2::object::uid_to_inner(&v0),
        };
        (v1, v2)
    }

    fun create_proof<T0>(arg0: &WhitelistManager) : WhitelistedToken {
        WhitelistedToken{
            voter : arg0.voter,
            token : 0x1::type_name::get<T0>(),
        }
    }

    public fun is_whitelisted_token<T0>(arg0: &WhitelistManager) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.is_whitelisted_token, 0x1::type_name::get<T0>())
    }

    public fun prove_token_whitelisted<T0>(arg0: &WhitelistManager) : WhitelistedToken {
        assert!(is_whitelisted_token<T0>(arg0), 555057717258834400);
        create_proof<T0>(arg0)
    }

    public fun validate<T0>(arg0: WhitelistedToken, arg1: 0x2::object::ID) {
        let WhitelistedToken {
            voter : v0,
            token : v1,
        } = arg0;
        assert!(v0 == arg1, 9223372260193075199);
        if (v1 != 0x1::type_name::get<T0>()) {
            abort 9223372268783140867
        };
    }

    public fun validate_manager_cap(arg0: &WhitelistManagerCap, arg1: 0x2::object::ID) {
        assert!(arg0.whitelist_manager == arg1, 190299737184899550);
    }

    public fun whitelist_token(arg0: &mut WhitelistManager, arg1: &WhitelistManagerCap, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: address) {
        validate_manager_cap(arg1, 0x2::object::id<WhitelistManager>(arg0));
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.is_whitelisted_token, arg2)) {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.is_whitelisted_token, arg2);
        };
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.is_whitelisted_token, arg2, arg3);
        let v0 = EventWhitelistToken{
            sender : arg4,
            token  : arg2,
            listed : arg3,
        };
        0x2::event::emit<EventWhitelistToken>(v0);
    }

    // decompiled from Move bytecode v6
}

