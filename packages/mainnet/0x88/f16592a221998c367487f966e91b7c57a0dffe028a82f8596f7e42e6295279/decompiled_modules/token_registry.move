module 0x2b71664477755b90f9fb71c9c944d5d0d3832fec969260e3f18efc7d855f57c4::token_registry {
    struct TOKEN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct SY_TOKEN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct TokenRegistrationEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        dummy_field: bool,
    }

    struct TokenRegistrationWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
    }

    struct TokenUnregistrationEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        dummy_field: bool,
    }

    struct TokenUnregistrationWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
    }

    struct TokenMintEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        amount: u64,
    }

    struct TokenMintWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
        amount: u64,
    }

    struct TokenBurnEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        amount: u64,
    }

    struct TokenBurnWithExpiryEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        expiry: u64,
        amount: u64,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        token_table: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<SY_TOKEN_REGISTRY, 0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    public(friend) fun burn<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: 0x2::coin::Coin<T1>, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public(friend) fun mint<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: u64, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public(friend) fun burn_with_expiry<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(is_token_bind_with_expiry<T0, T1>(arg3, arg2), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_not_supported());
        let v0 = TokenBurnWithExpiryEvent<T0, T1>{
            expiry : arg2,
            amount : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<TokenBurnWithExpiryEvent<T0, T1>>(v0);
        0x2::coin::burn<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg3.id, 0x1::type_name::get<T1>()), arg1)
    }

    fun calc_token_id<T0: drop>(arg0: u64) : 0x1::string::String {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        let v1 = 0x1::type_name::get<T0>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::utils::vector_to_hex_string(0x1::hash::sha2_256(v0))
    }

    fun init(arg0: TOKEN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SY_TOKEN_REGISTRY{dummy_field: false};
        let v1 = State{
            id          : 0x2::object::new(arg1),
            token_table : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<SY_TOKEN_REGISTRY, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, true, arg1),
        };
        0x2::transfer::share_object<State>(v1);
    }

    public fun init_registry(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg2), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::register_sy_invalid_sender());
        let v0 = SY_TOKEN_REGISTRY{dummy_field: false};
        let v1 = State{
            id          : 0x2::object::new(arg2),
            token_table : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<SY_TOKEN_REGISTRY, 0x1::type_name::TypeName, 0x1::type_name::TypeName>(v0, true, arg2),
        };
        0x2::transfer::share_object<State>(v1);
    }

    public fun is_token_bind<T0: drop, T1: drop>(arg0: &State) : bool {
        abort 0
    }

    public fun is_token_bind_with_expiry<T0: drop, T1: drop>(arg0: &mut State, arg1: u64) : bool {
        if (is_token_registered_with_expiry<T0>(arg0, arg1)) {
            let v1 = 0x1::type_name::get<T1>();
            0x2::dynamic_field::borrow<0x1::string::String, 0x1::type_name::TypeName>(&mut arg0.id, calc_token_id<T0>(arg1)) == &v1
        } else {
            false
        }
    }

    public fun is_token_registered<T0: drop>(arg0: &State) : bool {
        abort 0
    }

    public fun is_token_registered_with_expiry<T0: drop>(arg0: &State, arg1: u64) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, calc_token_id<T0>(arg1))
    }

    public(friend) fun mint_with_expiry<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: u64, arg2: u64, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(is_token_bind_with_expiry<T0, T1>(arg3, arg2), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_not_supported());
        assert!(arg1 > 0, 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::sy_zero_deposit());
        let v0 = TokenMintWithExpiryEvent<T0, T1>{
            expiry : arg2,
            amount : arg1,
        };
        0x2::event::emit<TokenMintWithExpiryEvent<T0, T1>>(v0);
        0x2::coin::mint<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg3.id, 0x1::type_name::get<T1>()), arg1, arg4)
    }

    public fun register_token<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::coin::TreasuryCap<T1>, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun register_token_internal<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg1: &mut State, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun register_token_with_expiry<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: u64, arg3: 0x2::coin::TreasuryCap<T1>, arg4: &mut State, arg5: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        register_token_with_expiry_internal<T0, T1>(arg1, arg2, arg4, arg5);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg4.id, 0x1::type_name::get<T1>(), arg3);
    }

    fun register_token_with_expiry_internal<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg1: u64, arg2: &mut State, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg0, 0x2::tx_context::sender(arg3), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::register_sy_invalid_sender());
        let v0 = calc_token_id<T0>(arg1);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&mut arg2.id, v0), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::register_sy_type_already_registered());
        0x2::dynamic_field::add<0x1::string::String, 0x1::type_name::TypeName>(&mut arg2.id, v0, 0x1::type_name::get<T1>());
        let v1 = TokenRegistrationWithExpiryEvent<T0, T1>{expiry: arg1};
        0x2::event::emit<TokenRegistrationWithExpiryEvent<T0, T1>>(v1);
    }

    public fun unregister_token<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T1> {
        abort 0
    }

    public fun unregister_token_with_expiry<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: u64, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T1> {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::register_sy_invalid_sender());
        let v0 = calc_token_id<T0>(arg2);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&mut arg3.id, v0), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::register_sy_type_not_registered());
        0x2::dynamic_field::remove<0x1::string::String, 0x1::type_name::TypeName>(&mut arg3.id, v0);
        let v1 = TokenUnregistrationWithExpiryEvent<T0, T1>{expiry: arg2};
        0x2::event::emit<TokenUnregistrationWithExpiryEvent<T0, T1>>(v1);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg3.id, 0x1::type_name::get<T1>())
    }

    // decompiled from Move bytecode v6
}

