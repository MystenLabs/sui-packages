module 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::tokens {
    struct TokenWhitelistedEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        whitelisted_by: address,
        whitelisted_at: u64,
    }

    struct TokenRemovedEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        removed_by: address,
        removed_at: u64,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        whitelisted_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct TOKENS has drop {
        dummy_field: bool,
    }

    public(friend) fun get_whitelisted_tokens(arg0: &TokenRegistry) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.whitelisted_tokens
    }

    fun init(arg0: TOKENS, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<TOKENS>(&arg0), 2);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<0x2::sui::SUI>());
        let v1 = TokenRegistry{
            id                 : 0x2::object::new(arg1),
            whitelisted_tokens : 0x2::vec_set::from_keys<0x1::type_name::TypeName>(v0),
        };
        0x2::transfer::share_object<TokenRegistry>(v1);
    }

    public(friend) fun is_token_whitelisted(arg0: &TokenRegistry, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_tokens, arg1)
    }

    public(friend) entry fun remove_token<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg1: &mut TokenRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelisted_tokens, &v0), 1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.whitelisted_tokens, &v0);
        let v1 = TokenRemovedEvent{
            token_type : v0,
            removed_by : 0x2::tx_context::sender(arg3),
            removed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenRemovedEvent>(v1);
    }

    public(friend) entry fun whitelist_token<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg1: &mut TokenRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelisted_tokens, &v0), 0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.whitelisted_tokens, v0);
        let v1 = TokenWhitelistedEvent{
            token_type     : v0,
            whitelisted_by : 0x2::tx_context::sender(arg3),
            whitelisted_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenWhitelistedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

