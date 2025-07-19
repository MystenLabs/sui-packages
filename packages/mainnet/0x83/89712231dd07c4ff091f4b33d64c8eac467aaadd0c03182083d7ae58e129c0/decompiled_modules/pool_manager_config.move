module 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::pool_manager_config {
    struct PoolManagerConfig has key {
        id: 0x2::object::UID,
        ltv: u128,
        recovery_ltv: u128,
        liquidation_threshold: u128,
        buffer: u128,
        liquidation_bonus_rate: u128,
        base_interest_rate: u128,
        premium_interest_rate: u128,
        usda: 0x1::option::Option<0x1::type_name::TypeName>,
        usda_decimal: u8,
        usda_minter_cap: vector<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>,
        usda_burner_cap: vector<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap>,
        collateral_token: 0x1::option::Option<0x1::type_name::TypeName>,
        collateral_decimal: u8,
        token_oracle_price_id: vector<u8>,
    }

    struct PoolManagerConfigView has copy, drop {
        ltv: u128,
        recovery_ltv: u128,
        liquidation_threshold: u128,
        buffer: u128,
        liquidation_bonus_rate: u128,
        base_interest_rate: u128,
        premium_interest_rate: u128,
        usda: 0x1::string::String,
        collateral_token: 0x1::string::String,
        token_oracle_price_id: vector<u8>,
    }

    struct TokenSet has copy, drop {
        token_type: 0x1::string::String,
        new_token: 0x1::string::String,
    }

    struct LtvSet has copy, drop {
        new_ltv: u128,
    }

    struct RecoveryLtvSet has copy, drop {
        new_recovery_ltv: u128,
    }

    struct LiquidationThresholdSet has copy, drop {
        new_threshold: u128,
    }

    struct BufferSet has copy, drop {
        new_buffer: u128,
    }

    struct LiquidationBonusRateSet has copy, drop {
        new_bonus_rate: u128,
    }

    struct BaseInterestRateSet has copy, drop {
        new_rate: u128,
    }

    struct PremiumInterestRateSet has copy, drop {
        new_rate: u128,
    }

    public entry fun set_max_age_secs(arg0: u64, arg1: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg2: &mut 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle::OracleConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg1);
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle::set_max_age_secs(arg0, arg2);
    }

    public entry fun set_pyth_oracle<T0>(arg0: vector<u8>, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle::OracleConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg6), arg2);
        arg1.token_oracle_price_id = arg0;
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle::set_pyth_oracle(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))), arg0, arg4, arg5);
    }

    public entry fun unset_oracle<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle::OracleConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle::unset_oracle(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))), arg1);
    }

    public fun base_interest_rate(arg0: &PoolManagerConfig) : u128 {
        arg0.base_interest_rate
    }

    public fun buffer(arg0: &PoolManagerConfig) : u128 {
        arg0.buffer
    }

    public fun collateral_address(arg0: &PoolManagerConfig) : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::get_address(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.collateral_token))))
    }

    public fun collateral_decimal(arg0: &PoolManagerConfig) : u8 {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.collateral_token), 2);
        arg0.collateral_decimal
    }

    public fun collateral_name(arg0: &PoolManagerConfig) : 0x1::string::String {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.collateral_token), 2);
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.collateral_token))))
    }

    public fun get_pool_mananger_config(arg0: &PoolManagerConfig) : PoolManagerConfigView {
        PoolManagerConfigView{
            ltv                    : arg0.ltv,
            recovery_ltv           : arg0.recovery_ltv,
            liquidation_threshold  : arg0.liquidation_threshold,
            buffer                 : arg0.buffer,
            liquidation_bonus_rate : arg0.liquidation_bonus_rate,
            base_interest_rate     : arg0.base_interest_rate,
            premium_interest_rate  : arg0.premium_interest_rate,
            usda                   : usda_address(arg0),
            collateral_token       : collateral_address(arg0),
            token_oracle_price_id  : arg0.token_oracle_price_id,
        }
    }

    public(friend) fun get_usda_burner_cap(arg0: &PoolManagerConfig) : &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap {
        assert!(0x1::vector::length<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap>(&arg0.usda_burner_cap) == 1, 0);
        0x1::vector::borrow<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap>(&arg0.usda_burner_cap, 0)
    }

    public(friend) fun get_usda_minter_cap(arg0: &PoolManagerConfig) : &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap {
        assert!(0x1::vector::length<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>(&arg0.usda_minter_cap) == 1, 0);
        0x1::vector::borrow<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>(&arg0.usda_minter_cap, 0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerConfig{
            id                     : 0x2::object::new(arg0),
            ltv                    : 6000,
            recovery_ltv           : 7500,
            liquidation_threshold  : 8500,
            buffer                 : 1000,
            liquidation_bonus_rate : 200,
            base_interest_rate     : 800,
            premium_interest_rate  : 0,
            usda                   : 0x1::option::none<0x1::type_name::TypeName>(),
            usda_decimal           : 0,
            usda_minter_cap        : 0x1::vector::empty<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>(),
            usda_burner_cap        : 0x1::vector::empty<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap>(),
            collateral_token       : 0x1::option::none<0x1::type_name::TypeName>(),
            collateral_decimal     : 0,
            token_oracle_price_id  : b"",
        };
        0x2::transfer::share_object<PoolManagerConfig>(v0);
    }

    public(friend) fun initial_base_interest_rate() : u128 {
        800
    }

    public fun liquidation_bonus_rate(arg0: &PoolManagerConfig) : u128 {
        arg0.liquidation_bonus_rate
    }

    public fun liquidation_threshold(arg0: &PoolManagerConfig) : u128 {
        arg0.liquidation_threshold
    }

    public fun ltv(arg0: &PoolManagerConfig) : u128 {
        arg0.ltv
    }

    public fun premium_interest_rate(arg0: &PoolManagerConfig) : u128 {
        arg0.premium_interest_rate
    }

    public fun recovery_ltv(arg0: &PoolManagerConfig) : u128 {
        arg0.recovery_ltv
    }

    public(friend) fun set_base_interest_rate(arg0: u128, arg1: &mut PoolManagerConfig) {
        assert!(arg0 < 2000, 0);
        assert!(arg1.base_interest_rate != arg0, 1);
        arg1.base_interest_rate = arg0;
        let v0 = BaseInterestRateSet{new_rate: arg0};
        0x2::event::emit<BaseInterestRateSet>(v0);
    }

    public entry fun set_buffer(arg0: u128, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        assert!(arg1.buffer != arg0, 1);
        arg1.buffer = arg0;
        let v0 = BufferSet{new_buffer: arg0};
        0x2::event::emit<BufferSet>(v0);
    }

    public entry fun set_collateral<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x1::option::is_none<0x1::type_name::TypeName>(&arg1.collateral_token)) {
            assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg1.collateral_token) != &v0, 1);
        };
        let v1 = 0x2::coin::get_name<T0>(arg0);
        assert!(!0x1::string::is_empty(&v1), 0);
        assert!(0x2::coin::get_decimals<T0>(arg0) != 0, 0);
        arg1.collateral_token = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg1.collateral_decimal = 0x2::coin::get_decimals<T0>(arg0);
        let v2 = TokenSet{
            token_type : 0x1::string::utf8(b"collateral_token"),
            new_token  : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(v0))),
        };
        0x2::event::emit<TokenSet>(v2);
    }

    public entry fun set_liquidation_bonus_rate(arg0: u128, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        assert!(arg1.liquidation_bonus_rate != arg0, 1);
        arg1.liquidation_bonus_rate = arg0;
        let v0 = LiquidationBonusRateSet{new_bonus_rate: arg0};
        0x2::event::emit<LiquidationBonusRateSet>(v0);
    }

    public entry fun set_liquidation_threshold(arg0: u128, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        assert!(arg1.liquidation_threshold != arg0, 1);
        assert!(arg0 > arg1.recovery_ltv, 0);
        assert!(arg0 < 10000, 0);
        arg1.liquidation_threshold = arg0;
        let v0 = LiquidationThresholdSet{new_threshold: arg0};
        0x2::event::emit<LiquidationThresholdSet>(v0);
    }

    public entry fun set_ltv(arg0: u128, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        assert!(arg1.ltv != arg0, 1);
        assert!(arg0 < arg1.recovery_ltv, 0);
        arg1.ltv = arg0;
        let v0 = LtvSet{new_ltv: arg0};
        0x2::event::emit<LtvSet>(v0);
    }

    public entry fun set_premium_interest_rate(arg0: u128, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        assert!(arg1.premium_interest_rate != arg0, 1);
        assert!(arg0 < 2000, 0);
        arg1.premium_interest_rate = arg0;
        let v0 = PremiumInterestRateSet{new_rate: arg0};
        0x2::event::emit<PremiumInterestRateSet>(v0);
    }

    public entry fun set_recovery_ltv(arg0: u128, arg1: &mut PoolManagerConfig, arg2: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg3), arg2);
        assert!(arg1.recovery_ltv != arg0, 1);
        assert!(arg0 > arg1.ltv, 0);
        assert!(arg0 < arg1.liquidation_threshold, 0);
        arg1.recovery_ltv = arg0;
        let v0 = RecoveryLtvSet{new_recovery_ltv: arg0};
        0x2::event::emit<RecoveryLtvSet>(v0);
    }

    public entry fun set_usda(arg0: &0x2::coin::CoinMetadata<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::usda::USDA>, arg1: 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap, arg2: 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap, arg3: &mut 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig, arg4: &mut PoolManagerConfig, arg5: &0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::AccessConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control::assert_admin_role(0x2::tx_context::sender(arg6), arg5);
        let v0 = 0x1::type_name::get<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::usda::USDA>();
        if (!0x1::option::is_none<0x1::type_name::TypeName>(&arg4.usda)) {
            assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg4.usda) != &v0, 1);
        };
        let v1 = 0x2::coin::get_name<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::usda::USDA>(arg0);
        assert!(!0x1::string::is_empty(&v1), 0);
        assert!(0x2::coin::get_decimals<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::usda::USDA>(arg0) != 0, 0);
        arg4.usda = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg4.usda_decimal = 0x2::coin::get_decimals<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::usda::USDA>(arg0);
        if (0x1::vector::length<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>(&arg4.usda_minter_cap) != 0) {
            0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::destroy_minter_cap(0x1::vector::remove<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>(&mut arg4.usda_minter_cap, 0), arg3);
            0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::destroy_burner_cap(0x1::vector::remove<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap>(&mut arg4.usda_burner_cap, 0), arg3);
        };
        0x1::vector::push_back<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap>(&mut arg4.usda_minter_cap, arg1);
        0x1::vector::push_back<0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap>(&mut arg4.usda_burner_cap, arg2);
        let v2 = TokenSet{
            token_type : 0x1::string::utf8(b"usda"),
            new_token  : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(v0))),
        };
        0x2::event::emit<TokenSet>(v2);
    }

    public fun usda_address(arg0: &PoolManagerConfig) : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::get_address(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.usda))))
    }

    public fun usda_decimal(arg0: &PoolManagerConfig) : u8 {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.usda), 2);
        arg0.usda_decimal
    }

    public fun usda_name(arg0: &PoolManagerConfig) : 0x1::string::String {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.usda), 2);
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.usda))))
    }

    // decompiled from Move bytecode v6
}

