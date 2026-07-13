module 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config {
    struct TokenRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        tokens: 0x2::table::Table<0x1::type_name::TypeName, TokenInfo>,
        hourly_limit_usd: u64,
        last_hour: u64,
        last_hour_usd: u64,
    }

    struct TokenInfo has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        price_decimals: u8,
        token_decimals: u8,
        enabled: bool,
    }

    public fun add_token<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut TokenRegistry, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_token_role(arg0, 0x2::tx_context::sender(arg6));
        validate_decimals(arg4, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg1.tokens, v0), 2001);
        let v1 = TokenInfo{
            name           : arg2,
            price          : arg3,
            price_decimals : arg4,
            token_decimals : arg5,
            enabled        : true,
        };
        0x2::table::add<0x1::type_name::TypeName, TokenInfo>(&mut arg1.tokens, v0, v1);
    }

    public(friend) fun amount_to_usd(arg0: &TokenInfo, arg1: u64) : u64 {
        let v0 = (arg0.price_decimals as u64);
        let v1 = (arg0.token_decimals as u64);
        let v2 = if (v0 + v1 >= 8) {
            (arg1 as u128) * (arg0.price as u128) / (0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::pow10(v0 + v1 - 8) as u128)
        } else {
            (arg1 as u128) * (arg0.price as u128) * (0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::pow10(8 - v0 - v1) as u128)
        };
        assert!(v2 <= 18446744073709551615, 2004);
        (v2 as u64)
    }

    public(friend) fun assert_token_supported<T0>(arg0: &TokenRegistry) {
        get_token_info<T0>(arg0);
    }

    fun assert_version(arg0: &TokenRegistry) {
        assert!(arg0.version == 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(), 2006);
    }

    public fun disable_token<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut TokenRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg1.tokens, v0), 2002);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, TokenInfo>(&mut arg1.tokens, v0);
        assert!(v1.name == arg2, 2003);
        v1.enabled = false;
    }

    public fun enable_token<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut TokenRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg1.tokens, v0), 2002);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, TokenInfo>(&mut arg1.tokens, v0);
        assert!(v1.name == arg2, 2003);
        v1.enabled = true;
    }

    public(friend) fun get_token_info<T0>(arg0: &TokenRegistry) : &TokenInfo {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.tokens, v0), 2002);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, TokenInfo>(&arg0.tokens, v0);
        assert!(v1.enabled, 2002);
        v1
    }

    public(friend) fun hourly_limit_usd(arg0: &TokenRegistry) : u64 {
        arg0.hourly_limit_usd
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id               : 0x2::object::new(arg0),
            version          : 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(),
            tokens           : 0x2::table::new<0x1::type_name::TypeName, TokenInfo>(arg0),
            hourly_limit_usd : 0,
            last_hour        : 0,
            last_hour_usd    : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    public(friend) fun is_hourly_limit_reached<T0>(arg0: &TokenRegistry, arg1: u64, arg2: &0x2::clock::Clock) : (bool, u64) {
        let v0 = amount_to_usd(get_token_info<T0>(arg0), arg1);
        let v1 = if (arg0.last_hour == 0x2::clock::timestamp_ms(arg2) / 3600000) {
            arg0.last_hour_usd
        } else {
            0
        };
        let v2 = v1 > arg0.hourly_limit_usd || v0 > arg0.hourly_limit_usd - v1;
        (v2, v0)
    }

    public(friend) fun migrate(arg0: &mut TokenRegistry) {
        if (arg0.version < 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current()) {
            arg0.version = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current();
        };
    }

    public(friend) fun record_withdrawal(arg0: &mut TokenRegistry, arg1: u64, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 3600000;
        if (arg0.last_hour == v0) {
            arg0.last_hour_usd = arg0.last_hour_usd + arg1;
        } else {
            arg0.last_hour = v0;
            arg0.last_hour_usd = arg1;
        };
    }

    public fun remove_token<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut TokenRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg1.tokens, v0), 2002);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, TokenInfo>(&arg1.tokens, v0).name == arg2, 2003);
        0x2::table::remove<0x1::type_name::TypeName, TokenInfo>(&mut arg1.tokens, v0);
    }

    public fun set_hourly_limit(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut TokenRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.hourly_limit_usd = arg2;
    }

    public fun set_token_price<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut TokenRegistry, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg1.tokens, v0), 2002);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, TokenInfo>(&mut arg1.tokens, v0);
        assert!(v1.name == arg2, 2003);
        validate_decimals(arg4, v1.token_decimals);
        v1.price = arg3;
        v1.price_decimals = arg4;
    }

    public(friend) fun token_decimals(arg0: &TokenInfo) : u8 {
        arg0.token_decimals
    }

    public(friend) fun token_name(arg0: &TokenInfo) : &0x1::string::String {
        &arg0.name
    }

    fun validate_decimals(arg0: u8, arg1: u8) {
        let v0 = (arg1 as u64);
        let v1 = (arg0 as u64);
        assert!(v0 <= 18, 2005);
        assert!(v1 <= 18, 2005);
        assert!(v0 + v1 < 8 || v0 + v1 - 8 <= 18, 2005);
    }

    // decompiled from Move bytecode v7
}

