module 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct ASSISTANT has drop {
        dummy_field: bool,
    }

    struct PAUSE_GUARDIAN has drop {
        dummy_field: bool,
    }

    struct MARKET_KEEPER has drop {
        dummy_field: bool,
    }

    struct FEE_RECIPIENT has drop {
        dummy_field: bool,
    }

    struct GAME_KEEPER has drop {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        for_id: 0x2::object::ID,
    }

    struct AuthKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun assert_admin(arg0: 0x2::object::ID, arg1: &AuthorityCap<PACKAGE, ADMIN>) {
        assert!(arg1.for_id == arg0, 13835058291505364993);
    }

    public fun assert_role<T0: drop>(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: &AuthorityCap<PACKAGE, T0>) {
        assert!(arg2.for_id == arg1, 13835058308685234177);
        let v0 = AuthKey{id: 0x2::object::id<AuthorityCap<PACKAGE, T0>>(arg2)};
        assert!(0x2::dynamic_field::exists_<AuthKey>(arg0, v0), 13835058312980201473);
    }

    public fun cap_for<T0, T1>(arg0: &AuthorityCap<T0, T1>) : 0x2::object::ID {
        arg0.for_id
    }

    public(friend) fun mint_admin(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AuthorityCap<PACKAGE, ADMIN> {
        AuthorityCap<PACKAGE, ADMIN>{
            id     : 0x2::object::new(arg1),
            for_id : arg0,
        }
    }

    public(friend) fun mint_role<T0: drop>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : AuthorityCap<PACKAGE, T0> {
        let v0 = AuthorityCap<PACKAGE, T0>{
            id     : 0x2::object::new(arg2),
            for_id : arg1,
        };
        let v1 = AuthKey{id: 0x2::object::id<AuthorityCap<PACKAGE, T0>>(&v0)};
        0x2::dynamic_field::add<AuthKey, bool>(arg0, v1, true);
        v0
    }

    public(friend) fun revoke(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = AuthKey{id: arg1};
        if (0x2::dynamic_field::exists_<AuthKey>(arg0, v0)) {
            let v1 = AuthKey{id: arg1};
            0x2::dynamic_field::remove<AuthKey, bool>(arg0, v1);
        };
    }

    // decompiled from Move bytecode v7
}

