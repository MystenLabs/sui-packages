module 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::token_registry {
    struct TOKEN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct SY_TOKEN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct TokenRegistrationWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
    }

    struct TokenUnregistrationWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
    }

    struct TokenMintWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
        amount: u64,
    }

    struct TokenBurnWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
        amount: u64,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        token_table: 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::WitTable<SY_TOKEN_REGISTRY, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    public(friend) fun burn_with_expiry<T0: drop, T1: drop>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut State) : u64 {
        assert!(is_token_bind_with_expiry<T0, T1>(arg2, arg1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_not_supported());
        let v0 = TokenBurnWithExpiryEvent<T0, T1>{
            expiry : arg1,
            amount : 0x2::coin::value<T1>(&arg0),
        };
        0x2::event::emit<TokenBurnWithExpiryEvent<T0, T1>>(v0);
        0x2::coin::burn<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg2.id, 0x1::type_name::with_defining_ids<T1>()), arg0)
    }

    fun calc_token_id<T0: drop>(arg0: u64) : 0x1::string::String {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::utils::vector_to_hex_string(0x1::hash::sha2_256(v0))
    }

    fun init(arg0: TOKEN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SY_TOKEN_REGISTRY{dummy_field: false};
        let v1 = State{
            id          : 0x2::object::new(arg1),
            token_table : 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::wit_table::new<SY_TOKEN_REGISTRY, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, true, arg1),
        };
        0x2::transfer::share_object<State>(v1);
    }

    public fun is_token_bind_with_expiry<T0: drop, T1: drop>(arg0: &State, arg1: u64) : bool {
        if (is_token_registered_with_expiry<T0>(arg0, arg1)) {
            let v1 = 0x1::type_name::with_defining_ids<T1>();
            0x2::dynamic_field::borrow<0x1::string::String, 0x1::type_name::TypeName>(&arg0.id, calc_token_id<T0>(arg1)) == &v1
        } else {
            false
        }
    }

    public fun is_token_registered_with_expiry<T0: drop>(arg0: &State, arg1: u64) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, calc_token_id<T0>(arg1))
    }

    public(friend) fun mint_with_expiry<T0: drop, T1: drop>(arg0: u64, arg1: u64, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_token_bind_with_expiry<T0, T1>(arg2, arg1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_not_supported());
        assert!(arg0 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_zero_deposit());
        let v0 = TokenMintWithExpiryEvent<T0, T1>{
            expiry : arg1,
            amount : arg0,
        };
        0x2::event::emit<TokenMintWithExpiryEvent<T0, T1>>(v0);
        0x2::coin::mint<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg2.id, 0x1::type_name::with_defining_ids<T1>()), arg0, arg3)
    }

    public fun register_token_with_expiry<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: u64, arg3: 0x2::coin::TreasuryCap<T1>, arg4: &mut State, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_invalid_sender());
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg4.id, calc_token_id<T0>(arg2)), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_type_already_registered());
        register_token_with_expiry_internal<T0, T1>(arg2, arg4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg4.id, 0x1::type_name::with_defining_ids<T1>(), arg3);
    }

    fun register_token_with_expiry_internal<T0: drop, T1: drop>(arg0: u64, arg1: &mut State) {
        0x2::dynamic_field::add<0x1::string::String, 0x1::type_name::TypeName>(&mut arg1.id, calc_token_id<T0>(arg0), 0x1::type_name::with_defining_ids<T1>());
        let v0 = TokenRegistrationWithExpiryEvent<T0, T1>{expiry: arg0};
        0x2::event::emit<TokenRegistrationWithExpiryEvent<T0, T1>>(v0);
    }

    public fun unregister_token_with_expiry<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: u64, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T1> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_invalid_sender());
        let v0 = calc_token_id<T0>(arg2);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg3.id, v0), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::register_sy_type_not_registered());
        0x2::dynamic_field::remove<0x1::string::String, 0x1::type_name::TypeName>(&mut arg3.id, v0);
        let v1 = TokenUnregistrationWithExpiryEvent<T0, T1>{expiry: arg2};
        0x2::event::emit<TokenUnregistrationWithExpiryEvent<T0, T1>>(v1);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg3.id, 0x1::type_name::with_defining_ids<T1>())
    }

    // decompiled from Move bytecode v6
}

