module 0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::token_validator {
    struct TOKEN_VALIDATOR has drop {
        dummy_field: bool,
    }

    struct TokenDetails has copy, drop, store {
        precision: u8,
        decimal_precision_diff: u8,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<0x1::type_name::TypeName, TokenDetails>,
    }

    struct TokenAdded has copy, drop {
        coin_type: 0x1::ascii::String,
        precision: u8,
        decimal_precision_diff: u8,
    }

    struct TokenRemoved has copy, drop {
        coin_type: 0x1::ascii::String,
    }

    public fun add_token<T0>(arg0: &0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::access_control::AdminCap, arg1: &0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::access_control::CapabilityRegistry, arg2: &mut TokenRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::access_control::assert_admin_active(arg0, arg1);
        assert!(arg4 > 0, 501);
        let v0 = 0x2::coin::get_decimals<T0>(arg3);
        assert!(v0 >= arg4, 502);
        let v1 = v0 - arg4;
        let v2 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, TokenDetails>(&arg2.tokens, v2)) {
            let v3 = TokenDetails{
                precision              : arg4,
                decimal_precision_diff : v1,
            };
            0x2::table::add<0x1::type_name::TypeName, TokenDetails>(&mut arg2.tokens, v2, v3);
            let v4 = TokenAdded{
                coin_type              : 0x1::type_name::into_string(v2),
                precision              : arg4,
                decimal_precision_diff : v1,
            };
            0x2::event::emit<TokenAdded>(v4);
        };
    }

    public fun assert_whitelisted<T0>(arg0: &TokenRegistry) {
        assert!(is_whitelisted<T0>(arg0), 500);
    }

    public fun get_token_details<T0>(arg0: &TokenRegistry) : (u8, u8) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenDetails>(&arg0.tokens, v0), 500);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, TokenDetails>(&arg0.tokens, v0);
        (v1.precision, v1.decimal_precision_diff)
    }

    fun init(arg0: TOKEN_VALIDATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id     : 0x2::object::new(arg1),
            tokens : 0x2::table::new<0x1::type_name::TypeName, TokenDetails>(arg1),
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    public fun is_whitelisted<T0>(arg0: &TokenRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, TokenDetails>(&arg0.tokens, 0x1::type_name::with_original_ids<T0>())
    }

    public fun remove_token<T0>(arg0: &0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::access_control::AdminCap, arg1: &0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::access_control::CapabilityRegistry, arg2: &mut TokenRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0x6c72f51d002f9c4f4f0e1551c39416e3bac81c8a0f04d9c10a3c4254562a7199::access_control::assert_admin_active(arg0, arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenDetails>(&arg2.tokens, v0), 500);
        0x2::table::remove<0x1::type_name::TypeName, TokenDetails>(&mut arg2.tokens, v0);
        let v1 = TokenRemoved{coin_type: 0x1::type_name::into_string(v0)};
        0x2::event::emit<TokenRemoved>(v1);
    }

    // decompiled from Move bytecode v6
}

