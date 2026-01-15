module 0x2::authenticator_state {
    struct AuthenticatorState has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AuthenticatorStateInner has store {
        version: u64,
        active_jwks: vector<ActiveJwk>,
    }

    struct JWK has copy, drop, store {
        kty: 0x1::string::String,
        e: 0x1::string::String,
        n: 0x1::string::String,
        alg: 0x1::string::String,
    }

    struct JwkId has copy, drop, store {
        iss: 0x1::string::String,
        kid: 0x1::string::String,
    }

    struct ActiveJwk has copy, drop, store {
        jwk_id: JwkId,
        jwk: JWK,
        epoch: u64,
    }

    fun active_jwk_equal(arg0: &ActiveJwk, arg1: &ActiveJwk) : bool {
        jwk_equal(&arg0.jwk, &arg1.jwk) && jwk_id_equal(&arg0.jwk_id, &arg1.jwk_id)
    }

    fun check_sorted(arg0: &vector<ActiveJwk>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ActiveJwk>(arg0) - 1) {
            assert!(jwk_lt(0x1::vector::borrow<ActiveJwk>(arg0, v0), 0x1::vector::borrow<ActiveJwk>(arg0, v0 + 1)), 2);
            v0 = v0 + 1;
        };
    }

    fun create(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = 1;
        let v1 = AuthenticatorStateInner{
            version     : v0,
            active_jwks : 0x1::vector::empty<ActiveJwk>(),
        };
        let v2 = AuthenticatorState{
            id      : 0x2::object::authenticator_state(),
            version : v0,
        };
        0x2::dynamic_field::add<u64, AuthenticatorStateInner>(&mut v2.id, v0, v1);
        0x2::transfer::share_object<AuthenticatorState>(v2);
    }

    fun deduplicate(arg0: vector<ActiveJwk>) : vector<ActiveJwk> {
        let v0 = 0x1::vector::empty<ActiveJwk>();
        let v1 = 0;
        let v2 = 0x1::option::none<JwkId>();
        while (v1 < 0x1::vector::length<ActiveJwk>(&arg0)) {
            let v3 = 0x1::vector::borrow<ActiveJwk>(&arg0, v1);
            if (0x1::option::is_none<JwkId>(&v2)) {
                0x1::option::fill<JwkId>(&mut v2, v3.jwk_id);
            } else {
                if (jwk_id_equal(0x1::option::borrow<JwkId>(&v2), &v3.jwk_id)) {
                    v1 = v1 + 1;
                    continue
                };
                *0x1::option::borrow_mut<JwkId>(&mut v2) = v3.jwk_id;
            };
            0x1::vector::push_back<ActiveJwk>(&mut v0, *v3);
            v1 = v1 + 1;
        };
        v0
    }

    fun expire_jwks(arg0: &mut AuthenticatorState, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 0);
        let v0 = load_inner_mut(arg0);
        let v1 = 0x1::vector::length<ActiveJwk>(&v0.active_jwks);
        let v2 = vector[];
        let v3 = 0;
        let v4 = 0x1::option::none<0x1::string::String>();
        while (v3 < v1) {
            let v5 = 0x1::vector::borrow<ActiveJwk>(&v0.active_jwks, v3);
            let v6 = &v5.jwk_id.iss;
            if (0x1::option::is_none<0x1::string::String>(&v4)) {
                0x1::option::fill<0x1::string::String>(&mut v4, *v6);
                0x1::vector::push_back<u64>(&mut v2, v5.epoch);
            } else if (v6 == 0x1::option::borrow<0x1::string::String>(&v4)) {
                let v7 = 0x1::vector::borrow_mut<u64>(&mut v2, 0x1::vector::length<u64>(&v2) - 1);
                *v7 = 0x1::u64::max(*v7, v5.epoch);
            } else {
                *0x1::option::borrow_mut<0x1::string::String>(&mut v4) = *v6;
                0x1::vector::push_back<u64>(&mut v2, v5.epoch);
            };
            v3 = v3 + 1;
        };
        let v8 = 0x1::vector::empty<ActiveJwk>();
        let v9 = 0x1::option::none<0x1::string::String>();
        let v10 = 0;
        let v11 = 0;
        while (v10 < v1) {
            let v12 = 0x1::vector::borrow<ActiveJwk>(&v0.active_jwks, v10);
            let v13 = &v12.jwk_id.iss;
            if (0x1::option::is_none<0x1::string::String>(&v9)) {
                0x1::option::fill<0x1::string::String>(&mut v9, *v13);
            } else if (v13 != 0x1::option::borrow<0x1::string::String>(&v9)) {
                *0x1::option::borrow_mut<0x1::string::String>(&mut v9) = *v13;
                v11 = v11 + 1;
            };
            if (*0x1::vector::borrow<u64>(&v2, v11) < arg1 || v12.epoch >= arg1) {
                0x1::vector::push_back<ActiveJwk>(&mut v8, *v12);
            };
            v10 = v10 + 1;
        };
        v0.active_jwks = v8;
    }

    fun get_active_jwks(arg0: &AuthenticatorState, arg1: &0x2::tx_context::TxContext) : vector<ActiveJwk> {
        assert!(0x2::tx_context::sender(arg1) == @0x0, 0);
        load_inner(arg0).active_jwks
    }

    fun jwk_equal(arg0: &JWK, arg1: &JWK) : bool {
        if (&arg0.kty == &arg1.kty) {
            if (&arg0.e == &arg1.e) {
                if (&arg0.n == &arg1.n) {
                    &arg0.alg == &arg1.alg
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun jwk_id_equal(arg0: &JwkId, arg1: &JwkId) : bool {
        &arg0.iss == &arg1.iss && &arg0.kid == &arg1.kid
    }

    fun jwk_lt(arg0: &ActiveJwk, arg1: &ActiveJwk) : bool {
        if (&arg0.jwk_id.iss != &arg1.jwk_id.iss) {
            return string_bytes_lt(&arg0.jwk_id.iss, &arg1.jwk_id.iss)
        };
        if (&arg0.jwk_id.kid != &arg1.jwk_id.kid) {
            return string_bytes_lt(&arg0.jwk_id.kid, &arg1.jwk_id.kid)
        };
        if (&arg0.jwk.kty != &arg1.jwk.kty) {
            return string_bytes_lt(&arg0.jwk.kty, &arg1.jwk.kty)
        };
        if (&arg0.jwk.e != &arg1.jwk.e) {
            return string_bytes_lt(&arg0.jwk.e, &arg1.jwk.e)
        };
        if (&arg0.jwk.n != &arg1.jwk.n) {
            return string_bytes_lt(&arg0.jwk.n, &arg1.jwk.n)
        };
        string_bytes_lt(&arg0.jwk.alg, &arg1.jwk.alg)
    }

    fun load_inner(arg0: &AuthenticatorState) : &AuthenticatorStateInner {
        let v0 = arg0.version;
        assert!(v0 == 1, 1);
        let v1 = 0x2::dynamic_field::borrow<u64, AuthenticatorStateInner>(&arg0.id, arg0.version);
        assert!(v1.version == v0, 1);
        v1
    }

    fun load_inner_mut(arg0: &mut AuthenticatorState) : &mut AuthenticatorStateInner {
        let v0 = arg0.version;
        assert!(v0 == 1, 1);
        let v1 = 0x2::dynamic_field::borrow_mut<u64, AuthenticatorStateInner>(&mut arg0.id, arg0.version);
        assert!(v1.version == v0, 1);
        v1
    }

    fun string_bytes_lt(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::string::as_bytes(arg1);
        if (0x1::vector::length<u8>(v0) < 0x1::vector::length<u8>(v1)) {
            true
        } else if (0x1::vector::length<u8>(v0) > 0x1::vector::length<u8>(v1)) {
            false
        } else {
            let v3 = 0;
            while (v3 < 0x1::vector::length<u8>(v0)) {
                let v4 = *0x1::vector::borrow<u8>(v0, v3);
                let v5 = *0x1::vector::borrow<u8>(v1, v3);
                if (v4 < v5) {
                    return true
                };
                if (v4 > v5) {
                    return false
                };
                v3 = v3 + 1;
            };
            false
        }
    }

    fun update_authenticator_state(arg0: &mut AuthenticatorState, arg1: vector<ActiveJwk>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 0);
        check_sorted(&arg1);
        let v0 = deduplicate(arg1);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x1::vector::empty<ActiveJwk>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x1::vector::length<ActiveJwk>(&v1.active_jwks);
        let v6 = 0x1::vector::length<ActiveJwk>(&v0);
        while (v3 < v5 && v4 < v6) {
            let v7 = 0x1::vector::borrow<ActiveJwk>(&v1.active_jwks, v3);
            let v8 = 0x1::vector::borrow<ActiveJwk>(&v0, v4);
            if (active_jwk_equal(v7, v8)) {
                let v9 = *v7;
                v9.epoch = 0x1::u64::max(v7.epoch, v8.epoch);
                0x1::vector::push_back<ActiveJwk>(&mut v2, v9);
                v3 = v3 + 1;
                v4 = v4 + 1;
                continue
            };
            if (jwk_id_equal(&v7.jwk_id, &v8.jwk_id)) {
                0x1::vector::push_back<ActiveJwk>(&mut v2, *v7);
                v3 = v3 + 1;
                v4 = v4 + 1;
                continue
            };
            if (jwk_lt(v7, v8)) {
                0x1::vector::push_back<ActiveJwk>(&mut v2, *v7);
                v3 = v3 + 1;
                continue
            };
            0x1::vector::push_back<ActiveJwk>(&mut v2, *v8);
            v4 = v4 + 1;
        };
        while (v3 < v5) {
            0x1::vector::push_back<ActiveJwk>(&mut v2, *0x1::vector::borrow<ActiveJwk>(&v1.active_jwks, v3));
            v3 = v3 + 1;
        };
        while (v4 < v6) {
            0x1::vector::push_back<ActiveJwk>(&mut v2, *0x1::vector::borrow<ActiveJwk>(&v0, v4));
            v4 = v4 + 1;
        };
        v1.active_jwks = v2;
    }

    // decompiled from Move bytecode v6
}

