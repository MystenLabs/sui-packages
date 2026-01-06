module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::token_authority {
    struct RegisteredToken<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RateLimitKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ValidMintRecipient<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenAuthority<phantom T0> has key {
        id: 0x2::object::UID,
        ledger_token: 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token::LedgerToken<T0>,
        tokens: 0x2::object_bag::ObjectBag,
        roles: 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::Roles,
        version: u16,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCapV2<T0>, arg2: 0x2::coin_registry::MetadataCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : TokenAuthority<T0> {
        TokenAuthority<T0>{
            id           : 0x2::object::new(arg3),
            ledger_token : 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token::new<T0>(arg0, arg1, arg2, arg3),
            tokens       : 0x2::object_bag::new(arg3),
            roles        : 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::new(arg3),
            version      : 1,
        }
    }

    public(friend) fun roles<T0>(arg0: &TokenAuthority<T0>) : &0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::Roles {
        &arg0.roles
    }

    public(friend) fun assert_is_valid_version<T0>(arg0: &TokenAuthority<T0>) {
        assert!(arg0.version == 1, 13835340191684034564);
    }

    public(friend) fun is_token_registered<T0, T1>(arg0: &TokenAuthority<T0>) : bool {
        assert_is_valid_version<T0>(arg0);
        let v0 = RegisteredToken<T1>{dummy_field: false};
        0x2::object_bag::contains<RegisteredToken<T1>>(&arg0.tokens, v0)
    }

    public(friend) fun is_valid_stablecoin_mint_recipient<T0, T1>(arg0: &mut TokenAuthority<T0>, arg1: address) : bool {
        assert_is_valid_version<T0>(arg0);
        if (!is_token_registered<T0, T1>(arg0)) {
            return false
        };
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::mint_recipient_exists<T0, T1>(stablecoin_mut<T0, T1>(arg0), arg1)
    }

    public(friend) fun ledger_token_mut<T0>(arg0: &mut TokenAuthority<T0>) : &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token::LedgerToken<T0> {
        assert_is_valid_version<T0>(arg0);
        &mut arg0.ledger_token
    }

    public(friend) fun register_stablecoin<T0, T1>(arg0: &mut TokenAuthority<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x2::coin::DenyCapV2<T1>, arg3: 0x2::coin_registry::MetadataCap<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_valid_version<T0>(arg0);
        let v0 = RegisteredToken<T1>{dummy_field: false};
        0x2::object_bag::add<RegisteredToken<T1>, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::Stablecoin<T0, T1>>(&mut arg0.tokens, v0, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::new<T0, T1>(arg1, arg2, arg3, arg4));
    }

    public(friend) fun roles_mut<T0>(arg0: &mut TokenAuthority<T0>) : &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles::Roles {
        assert_is_valid_version<T0>(arg0);
        &mut arg0.roles
    }

    public(friend) fun set_version<T0>(arg0: &mut TokenAuthority<T0>, arg1: u16) {
        arg0.version = arg1;
    }

    public fun share<T0>(arg0: TokenAuthority<T0>) {
        assert_is_valid_version<T0>(&arg0);
        0x2::transfer::share_object<TokenAuthority<T0>>(arg0);
    }

    public(friend) fun stablecoin_mut<T0, T1>(arg0: &mut TokenAuthority<T0>) : &mut 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::Stablecoin<T0, T1> {
        assert_is_valid_version<T0>(arg0);
        let v0 = RegisteredToken<T1>{dummy_field: false};
        0x2::object_bag::borrow_mut<RegisteredToken<T1>, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::Stablecoin<T0, T1>>(&mut arg0.tokens, v0)
    }

    public(friend) fun unregister_stablecoin<T0, T1>(arg0: &mut TokenAuthority<T0>) : (0x2::coin::TreasuryCap<T1>, 0x2::coin::DenyCapV2<T1>, 0x2::coin_registry::MetadataCap<T1>) {
        assert_is_valid_version<T0>(arg0);
        let v0 = RegisteredToken<T1>{dummy_field: false};
        assert!(0x2::object_bag::contains<RegisteredToken<T1>>(&arg0.tokens, v0), 13835058639397781506);
        let v1 = RegisteredToken<T1>{dummy_field: false};
        0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::destroy<T0, T1>(0x2::object_bag::remove<RegisteredToken<T1>, 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::stablecoin::Stablecoin<T0, T1>>(&mut arg0.tokens, v1))
    }

    public(friend) fun version<T0>(arg0: &TokenAuthority<T0>) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

