module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::registry {
    struct TokenRegistry has key {
        id: 0x2::object::UID,
        registered_tokens: 0x2::vec_map::VecMap<0x1::type_name::TypeName, TokenInfo>,
        admin: address,
        enabled: bool,
    }

    struct TokenInfo has copy, drop, store {
        symbol: 0x1::string::String,
        decimals: u8,
        is_active: bool,
        min_payment_amount: u64,
        max_payment_amount: u64,
        daily_limit: u64,
        registered_at: u64,
    }

    public fun get_admin(arg0: &TokenRegistry) : address {
        arg0.admin
    }

    public fun get_daily_limit<T0>(arg0: &TokenRegistry) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        0x2::vec_map::get<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0).daily_limit
    }

    public fun get_max_payment_amount<T0>(arg0: &TokenRegistry) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        0x2::vec_map::get<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0).max_payment_amount
    }

    public fun get_min_payment_amount<T0>(arg0: &TokenRegistry) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        0x2::vec_map::get<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0).min_payment_amount
    }

    public fun get_token_info<T0>(arg0: &TokenRegistry) : TokenInfo {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        *0x2::vec_map::get<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0)
    }

    public fun get_total_tokens(arg0: &TokenRegistry) : u64 {
        0x2::vec_map::size<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id                : 0x2::object::new(arg0),
            registered_tokens : 0x2::vec_map::empty<0x1::type_name::TypeName, TokenInfo>(),
            admin             : 0x2::tx_context::sender(arg0),
            enabled           : true,
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    public fun is_registry_enabled(arg0: &TokenRegistry) : bool {
        arg0.enabled
    }

    public fun is_token_active<T0>(arg0: &TokenRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        0x2::vec_map::get<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0).is_active
    }

    public fun is_token_supported<T0>(arg0: &TokenRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0)
    }

    public entry fun register_token<T0>(arg0: &mut TokenRegistry, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 999);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 301);
        let v1 = TokenInfo{
            symbol             : arg1,
            decimals           : arg2,
            is_active          : true,
            min_payment_amount : arg3,
            max_payment_amount : arg4,
            daily_limit        : arg5,
            registered_at      : 0x2::tx_context::epoch(arg6),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, TokenInfo>(&mut arg0.registered_tokens, v0, v1);
    }

    public entry fun remove_token<T0>(arg0: &mut TokenRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 999);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, TokenInfo>(&mut arg0.registered_tokens, &v0);
    }

    public entry fun toggle_token_status<T0>(arg0: &mut TokenRegistry, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 999);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, TokenInfo>(&mut arg0.registered_tokens, &v0).is_active = arg1;
    }

    public entry fun update_token_config<T0>(arg0: &mut TokenRegistry, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 999);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.registered_tokens, &v0), 300);
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, TokenInfo>(&mut arg0.registered_tokens, &v0);
        v1.min_payment_amount = arg1;
        v1.max_payment_amount = arg2;
        v1.daily_limit = arg3;
    }

    // decompiled from Move bytecode v6
}

