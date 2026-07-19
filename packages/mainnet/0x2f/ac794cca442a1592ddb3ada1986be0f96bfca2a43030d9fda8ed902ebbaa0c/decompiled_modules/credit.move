module 0x2fac794cca442a1592ddb3ada1986be0f96bfca2a43030d9fda8ed902ebbaa0c::credit {
    struct ProtocolState has key {
        id: 0x2::object::UID,
        treasury: address,
        paused: bool,
        version: u64,
        revision: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
    }

    struct CollateralPolicy has store {
        reserve_index: u64,
        collateral_decimal: u8,
        enabled: bool,
    }

    struct CreditConfig has key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        debt_reserve_index: u64,
        min_draw_usdc: u64,
        revision: u64,
        collateral_policies: 0x2::table::Table<0x1::type_name::TypeName, CollateralPolicy>,
    }

    struct CreditPosition has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        borrower: address,
        card_reference: vector<u8>,
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>,
    }

    struct PositionStatusV1 has copy, drop {
        obligation_id: 0x2::object::ID,
        as_of_timestamp_ms: u64,
        debt_usdc_base_units_wad: u256,
        deposited_value_usd_wad: u256,
        allowed_borrow_value_usd_wad: u256,
        unhealthy_borrow_value_usd_wad: u256,
        unweighted_borrowed_value_usd_wad: u256,
        weighted_borrowed_value_usd_wad: u256,
        weighted_borrowed_value_upper_bound_usd_wad: u256,
        healthy: bool,
        liquidatable: bool,
    }

    struct CollateralPolicyUpdated has copy, drop {
        config_id: 0x2::object::ID,
        collateral_type: 0x1::type_name::TypeName,
        reserve_index: u64,
        enabled: bool,
        revision: u64,
    }

    struct PauseUpdated has copy, drop {
        protocol_id: 0x2::object::ID,
        paused: bool,
        version: u64,
        revision: u64,
    }

    struct TreasuryUpdated has copy, drop {
        protocol_id: 0x2::object::ID,
        previous_treasury: address,
        new_treasury: address,
        version: u64,
        revision: u64,
    }

    struct DrawMinimumUpdated has copy, drop {
        config_id: 0x2::object::ID,
        min_draw_usdc: u64,
        revision: u64,
    }

    struct CreditFunded has copy, drop {
        protocol_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        borrower: address,
        card_reference: vector<u8>,
        collateral_type: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_decimal: u8,
        requested_usdc: u64,
        gross_usdc_received: u64,
        usdc_coin_id: 0x2::object::ID,
        treasury: address,
        protocol_version: u64,
        protocol_revision: u64,
        config_revision: u64,
    }

    struct CreditRepaid has copy, drop {
        config_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        borrower: address,
        card_reference: vector<u8>,
        provided_usdc: u64,
        repaid_usdc: u64,
        remainder_usdc: u64,
    }

    struct CollateralAdded has copy, drop {
        config_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        borrower: address,
        card_reference: vector<u8>,
        collateral_type: 0x1::type_name::TypeName,
        collateral_amount: u64,
    }

    struct CollateralWithdrawn has copy, drop {
        config_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        borrower: address,
        card_reference: vector<u8>,
        collateral_type: 0x1::type_name::TypeName,
        requested_ctoken_amount: u64,
        ctoken_amount: u64,
        underlying_amount: u64,
    }

    public fun add_collateral<T0>(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_position(arg0, arg1, arg2, arg5);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 20);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CollateralPolicy>(&arg1.collateral_policies, v1), 19);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        assert!(v2 == 0x2::table::borrow<0x1::type_name::TypeName, CollateralPolicy>(&arg1.collateral_policies, v1).reserve_index, 12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v2, &arg0.obligation_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v2, arg3, arg4, arg5), arg5);
        let v3 = CollateralAdded{
            config_id         : 0x2::object::id<CreditConfig>(arg1),
            position_id       : 0x2::object::id<CreditPosition>(arg0),
            obligation_id     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap),
            borrower          : arg0.borrower,
            card_reference    : arg0.card_reference,
            collateral_type   : v1,
            collateral_amount : v0,
        };
        0x2::event::emit<CollateralAdded>(v3);
    }

    fun assert_admin(arg0: &AdminCap, arg1: &ProtocolState) {
        assert!(arg0.protocol_id == 0x2::object::id<ProtocolState>(arg1), 3);
    }

    fun assert_admin_for_config(arg0: &AdminCap, arg1: &ProtocolState, arg2: &CreditConfig) {
        assert_admin(arg0, arg1);
        assert_protocol(arg2, arg1);
    }

    fun assert_all_collateral_enabled(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0)) {
            let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v1);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v2) > 0) {
                let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_coin_type(v2);
                assert!(0x2::table::contains<0x1::type_name::TypeName, CollateralPolicy>(&arg1.collateral_policies, v3), 19);
                let v4 = 0x2::table::borrow<0x1::type_name::TypeName, CollateralPolicy>(&arg1.collateral_policies, v3);
                assert!(v4.enabled, 11);
                assert!(v4.reserve_index == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v2), 12);
            };
            v1 = v1 + 1;
        };
    }

    fun assert_current_version(arg0: &ProtocolState) {
        assert!(arg0.version == 1, 18);
    }

    fun assert_market(arg0: &CreditConfig, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        assert!(arg0.market_id == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg1), 4);
    }

    fun assert_position(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::tx_context::TxContext) {
        assert_position_binding(arg0, arg1, arg2);
        assert!(arg0.borrower == 0x2::tx_context::sender(arg3), 15);
    }

    fun assert_position_binding(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        assert!(arg0.config_id == 0x2::object::id<CreditConfig>(arg1) && arg0.market_id == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg2), 14);
        assert_market(arg1, arg2);
    }

    fun assert_protocol(arg0: &CreditConfig, arg1: &ProtocolState) {
        assert!(arg0.protocol_id == 0x2::object::id<ProtocolState>(arg1), 7);
        assert_current_version(arg1);
    }

    public fun borrower(arg0: &CreditPosition) : address {
        arg0.borrower
    }

    public fun card_reference(arg0: &CreditPosition) : vector<u8> {
        arg0.card_reference
    }

    public fun collateral_amount(arg0: &CreditFunded) : u64 {
        arg0.collateral_amount
    }

    public fun collateral_decimal(arg0: &CreditFunded) : u8 {
        arg0.collateral_decimal
    }

    fun collateral_decimal_from_reserve<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) : u8 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v0);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)), 24);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::usd_to_token_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v0, v1));
        let v3 = 1;
        let v4 = 0;
        while (v3 < v2) {
            assert!(v3 <= 18446744073709551615 / 10, 24);
            v3 = v3 * 10;
            v4 = v4 + 1;
        };
        assert!(v3 == v2, 24);
        v4
    }

    public fun collateral_enabled<T0>(arg0: &CreditConfig) : bool {
        0x2::table::borrow<0x1::type_name::TypeName, CollateralPolicy>(&arg0.collateral_policies, 0x1::type_name::with_defining_ids<T0>()).enabled
    }

    public fun collateral_reserve_index<T0>(arg0: &CreditConfig) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, CollateralPolicy>(&arg0.collateral_policies, 0x1::type_name::with_defining_ids<T0>()).reserve_index
    }

    public fun config_protocol_id(arg0: &CreditConfig) : 0x2::object::ID {
        arg0.protocol_id
    }

    public fun create_config(arg0: &AdminCap, arg1: &ProtocolState, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_admin(arg0, arg1);
        assert_current_version(arg1);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        assert!(v0 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2)), 2);
        let v1 = 0x2::object::new(arg3);
        let v2 = CreditConfig{
            id                  : v1,
            protocol_id         : 0x2::object::id<ProtocolState>(arg1),
            market_id           : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg2),
            debt_reserve_index  : v0,
            min_draw_usdc       : 1000000,
            revision            : 1,
            collateral_policies : 0x2::table::new<0x1::type_name::TypeName, CollateralPolicy>(arg3),
        };
        0x2::transfer::share_object<CreditConfig>(v2);
        0x2::object::uid_to_inner(&v1)
    }

    public fun debt_reserve_index(arg0: &CreditConfig) : u64 {
        arg0.debt_reserve_index
    }

    public fun disable_collateral<T0>(arg0: &AdminCap, arg1: &ProtocolState, arg2: &mut CreditConfig, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        assert_admin_for_config(arg0, arg1, arg2);
        assert_market(arg2, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CollateralPolicy>(&arg2.collateral_policies, v0), 19);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, CollateralPolicy>(&mut arg2.collateral_policies, v0);
        v1.enabled = false;
        arg2.revision = arg2.revision + 1;
        let v2 = CollateralPolicyUpdated{
            config_id       : 0x2::object::id<CreditConfig>(arg2),
            collateral_type : v0,
            reserve_index   : v1.reserve_index,
            enabled         : false,
            revision        : arg2.revision,
        };
        0x2::event::emit<CollateralPolicyUpdated>(v2);
    }

    fun emit_collateral_withdrawn<T0>(arg0: &CreditPosition, arg1: &CreditConfig, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CollateralWithdrawn{
            config_id               : 0x2::object::id<CreditConfig>(arg1),
            position_id             : 0x2::object::id<CreditPosition>(arg0),
            obligation_id           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap),
            borrower                : arg0.borrower,
            card_reference          : arg0.card_reference,
            collateral_type         : 0x1::type_name::with_defining_ids<T0>(),
            requested_ctoken_amount : arg2,
            ctoken_amount           : arg3,
            underlying_amount       : arg4,
        };
        0x2::event::emit<CollateralWithdrawn>(v0);
    }

    public fun enable_collateral<T0>(arg0: &AdminCap, arg1: &ProtocolState, arg2: &mut CreditConfig, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        assert_admin_for_config(arg0, arg1, arg2);
        assert_market(arg2, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 6);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3);
        assert!(v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3)), 5);
        if (0x2::table::contains<0x1::type_name::TypeName, CollateralPolicy>(&arg2.collateral_policies, v0)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, CollateralPolicy>(&mut arg2.collateral_policies, v0);
            v2.reserve_index = v1;
            v2.collateral_decimal = collateral_decimal_from_reserve<T0>(arg3);
            v2.enabled = true;
        } else {
            let v3 = CollateralPolicy{
                reserve_index      : v1,
                collateral_decimal : collateral_decimal_from_reserve<T0>(arg3),
                enabled            : true,
            };
            0x2::table::add<0x1::type_name::TypeName, CollateralPolicy>(&mut arg2.collateral_policies, v0, v3);
        };
        arg2.revision = arg2.revision + 1;
        let v4 = CollateralPolicyUpdated{
            config_id       : 0x2::object::id<CreditConfig>(arg2),
            collateral_type : v0,
            reserve_index   : v1,
            enabled         : true,
            revision        : arg2.revision,
        };
        0x2::event::emit<CollateralPolicyUpdated>(v4);
    }

    public fun fund_position<T0>(arg0: &CreditPosition, arg1: &ProtocolState, arg2: &CreditConfig, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg2, arg1);
        assert!(!arg1.paused, 8);
        assert_position(arg0, arg2, arg3, arg7);
        assert!(arg6 >= arg2.min_draw_usdc && arg6 != 18446744073709551615, 10);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 10);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CollateralPolicy>(&arg2.collateral_policies, v1), 19);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, CollateralPolicy>(&arg2.collateral_policies, v1);
        assert!(v2.enabled, 11);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3);
        assert!(v3 == v2.reserve_index, 12);
        let v4 = v2.collateral_decimal;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, v3, &arg0.obligation_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, v3, arg4, arg5, arg7), arg7);
        assert_all_collateral_enabled(arg0, arg2, arg3);
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2.debt_reserve_index, &arg0.obligation_cap, arg4, arg6, arg7);
        let v6 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v5);
        assert!(v6 == arg6, 13);
        let v7 = arg1.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v5, v7);
        let v8 = CreditFunded{
            protocol_id         : 0x2::object::id<ProtocolState>(arg1),
            config_id           : 0x2::object::id<CreditConfig>(arg2),
            position_id         : 0x2::object::id<CreditPosition>(arg0),
            obligation_id       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap),
            borrower            : arg0.borrower,
            card_reference      : arg0.card_reference,
            collateral_type     : v1,
            collateral_amount   : v0,
            collateral_decimal  : v4,
            requested_usdc      : arg6,
            gross_usdc_received : v6,
            usdc_coin_id        : 0x2::object::id<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&v5),
            treasury            : v7,
            protocol_version    : arg1.version,
            protocol_revision   : arg1.revision,
            config_revision     : arg2.revision,
        };
        0x2::event::emit<CreditFunded>(v8);
    }

    public fun funded_card_reference(arg0: &CreditFunded) : vector<u8> {
        arg0.card_reference
    }

    public fun funded_config_revision(arg0: &CreditFunded) : u64 {
        arg0.config_revision
    }

    public fun funded_protocol_revision(arg0: &CreditFunded) : u64 {
        arg0.protocol_revision
    }

    public fun funded_usdc_coin_id(arg0: &CreditFunded) : 0x2::object::ID {
        arg0.usdc_coin_id
    }

    public fun funding_treasury(arg0: &CreditFunded) : address {
        arg0.treasury
    }

    public fun gross_usdc_received(arg0: &CreditFunded) : u64 {
        arg0.gross_usdc_received
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = ProtocolState{
            id       : v0,
            treasury : 0x2::tx_context::sender(arg0),
            paused   : true,
            version  : 1,
            revision : 1,
        };
        0x2::transfer::share_object<ProtocolState>(v1);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg0),
            protocol_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun market_id(arg0: &CreditConfig) : 0x2::object::ID {
        arg0.market_id
    }

    public fun min_draw_usdc(arg0: &CreditConfig) : u64 {
        arg0.min_draw_usdc
    }

    public fun new_treasury(arg0: &TreasuryUpdated) : address {
        arg0.new_treasury
    }

    public fun obligation_id(arg0: &CreditPosition) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap)
    }

    public fun open_and_fund<T0>(arg0: &ProtocolState, arg1: &CreditConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg1, arg0);
        assert!(!arg0.paused, 8);
        assert_market(arg1, arg2);
        assert!(0x1::vector::length<u8>(&arg4) == 16, 9);
        assert!(arg6 >= arg1.min_draw_usdc && arg6 != 18446744073709551615, 10);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 10);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CollateralPolicy>(&arg1.collateral_policies, v1), 19);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, CollateralPolicy>(&arg1.collateral_policies, v1);
        assert!(v2.enabled, 11);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        assert!(v3 == v2.reserve_index, 12);
        let v4 = v2.collateral_decimal;
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v3, &v5, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v3, arg3, arg5, arg7), arg7);
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1.debt_reserve_index, &v5, arg3, arg6, arg7);
        let v7 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6);
        assert!(v7 == arg6, 13);
        let v8 = arg0.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v6, v8);
        let v9 = 0x2::tx_context::sender(arg7);
        let v10 = CreditPosition{
            id             : 0x2::object::new(arg7),
            config_id      : 0x2::object::id<CreditConfig>(arg1),
            market_id      : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg2),
            borrower       : v9,
            card_reference : arg4,
            obligation_cap : v5,
        };
        let v11 = CreditFunded{
            protocol_id         : 0x2::object::id<ProtocolState>(arg0),
            config_id           : 0x2::object::id<CreditConfig>(arg1),
            position_id         : 0x2::object::id<CreditPosition>(&v10),
            obligation_id       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&v5),
            borrower            : v9,
            card_reference      : arg4,
            collateral_type     : v1,
            collateral_amount   : v0,
            collateral_decimal  : v4,
            requested_usdc      : arg6,
            gross_usdc_received : v7,
            usdc_coin_id        : 0x2::object::id<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&v6),
            treasury            : v8,
            protocol_version    : arg0.version,
            protocol_revision   : arg0.revision,
            config_revision     : arg1.revision,
        };
        0x2::event::emit<CreditFunded>(v11);
        0x2::transfer::transfer<CreditPosition>(v10, v9);
    }

    public fun previous_treasury(arg0: &TreasuryUpdated) : address {
        arg0.previous_treasury
    }

    public fun protocol_is_paused(arg0: &ProtocolState) : bool {
        arg0.paused
    }

    public fun protocol_revision(arg0: &ProtocolState) : u64 {
        arg0.revision
    }

    public fun protocol_version(arg0: &ProtocolState) : u64 {
        arg0.version
    }

    public fun provided_usdc(arg0: &CreditRepaid) : u64 {
        arg0.provided_usdc
    }

    public fun refresh_position_status_v1(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock) : PositionStatusV1 {
        assert_position_binding(arg0, arg1, arg2);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, v0, arg3);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, v0);
        PositionStatusV1{
            obligation_id                               : v0,
            as_of_timestamp_ms                          : 0x2::clock::timestamp_ms(arg3),
            debt_usdc_base_units_wad                    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1)),
            deposited_value_usd_wad                     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
            allowed_borrow_value_usd_wad                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
            unhealthy_borrow_value_usd_wad              : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unhealthy_borrow_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
            unweighted_borrowed_value_usd_wad           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
            weighted_borrowed_value_usd_wad             : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
            weighted_borrowed_value_upper_bound_usd_wad : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_upper_bound_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
            healthy                                     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_healthy<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1),
            liquidatable                                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1),
        }
    }

    public fun remainder_usdc(arg0: &CreditRepaid) : u64 {
        arg0.remainder_usdc
    }

    public fun repaid_usdc(arg0: &CreditRepaid) : u64 {
        arg0.repaid_usdc
    }

    public fun repay(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert_position(arg0, arg1, arg2, arg5);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        assert!(v0 > 0, 16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1.debt_reserve_index, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap), arg3, &mut arg4, arg5);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        let v2 = CreditRepaid{
            config_id      : 0x2::object::id<CreditConfig>(arg1),
            position_id    : 0x2::object::id<CreditPosition>(arg0),
            obligation_id  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.obligation_cap),
            borrower       : arg0.borrower,
            card_reference : arg0.card_reference,
            provided_usdc  : v0,
            repaid_usdc    : v0 - v1,
            remainder_usdc : v1,
        };
        0x2::event::emit<CreditRepaid>(v2);
        arg4
    }

    public fun requested_ctoken_amount(arg0: &CollateralWithdrawn) : u64 {
        arg0.requested_ctoken_amount
    }

    public fun revision(arg0: &CreditConfig) : u64 {
        arg0.revision
    }

    public fun set_min_draw_usdc(arg0: &AdminCap, arg1: &ProtocolState, arg2: &mut CreditConfig, arg3: u64) {
        assert_admin_for_config(arg0, arg1, arg2);
        assert!(arg3 > 0 && arg3 != 18446744073709551615, 10);
        if (arg2.min_draw_usdc == arg3) {
            return
        };
        arg2.min_draw_usdc = arg3;
        arg2.revision = arg2.revision + 1;
        let v0 = DrawMinimumUpdated{
            config_id     : 0x2::object::id<CreditConfig>(arg2),
            min_draw_usdc : arg3,
            revision      : arg2.revision,
        };
        0x2::event::emit<DrawMinimumUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut ProtocolState, arg2: bool) {
        assert_admin(arg0, arg1);
        assert_current_version(arg1);
        if (arg1.paused == arg2) {
            return
        };
        arg1.paused = arg2;
        arg1.revision = arg1.revision + 1;
        let v0 = PauseUpdated{
            protocol_id : 0x2::object::id<ProtocolState>(arg1),
            paused      : arg2,
            version     : arg1.version,
            revision    : arg1.revision,
        };
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut ProtocolState, arg2: address) {
        assert_admin(arg0, arg1);
        assert_current_version(arg1);
        assert!(arg2 != @0x0, 1);
        if (arg1.treasury == arg2) {
            return
        };
        assert!(arg1.paused, 17);
        arg1.treasury = arg2;
        arg1.revision = arg1.revision + 1;
        let v0 = TreasuryUpdated{
            protocol_id       : 0x2::object::id<ProtocolState>(arg1),
            previous_treasury : arg1.treasury,
            new_treasury      : arg2,
            version           : arg1.version,
            revision          : arg1.revision,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun status_v1_allowed_borrow_value_usd_wad(arg0: &PositionStatusV1) : u256 {
        arg0.allowed_borrow_value_usd_wad
    }

    public fun status_v1_as_of_timestamp_ms(arg0: &PositionStatusV1) : u64 {
        arg0.as_of_timestamp_ms
    }

    public fun status_v1_debt_usdc_base_units_wad(arg0: &PositionStatusV1) : u256 {
        arg0.debt_usdc_base_units_wad
    }

    public fun status_v1_deposited_value_usd_wad(arg0: &PositionStatusV1) : u256 {
        arg0.deposited_value_usd_wad
    }

    public fun status_v1_is_healthy(arg0: &PositionStatusV1) : bool {
        arg0.healthy
    }

    public fun status_v1_is_liquidatable(arg0: &PositionStatusV1) : bool {
        arg0.liquidatable
    }

    public fun status_v1_obligation_id(arg0: &PositionStatusV1) : 0x2::object::ID {
        arg0.obligation_id
    }

    public fun status_v1_unhealthy_borrow_value_usd_wad(arg0: &PositionStatusV1) : u256 {
        arg0.unhealthy_borrow_value_usd_wad
    }

    public fun status_v1_unweighted_borrowed_value_usd_wad(arg0: &PositionStatusV1) : u256 {
        arg0.unweighted_borrowed_value_usd_wad
    }

    public fun status_v1_weighted_borrowed_value_upper_bound_usd_wad(arg0: &PositionStatusV1) : u256 {
        arg0.weighted_borrowed_value_upper_bound_usd_wad
    }

    public fun status_v1_weighted_borrowed_value_usd_wad(arg0: &PositionStatusV1) : u256 {
        arg0.weighted_borrowed_value_usd_wad
    }

    public fun treasury(arg0: &ProtocolState) : address {
        arg0.treasury
    }

    public fun underlying_amount(arg0: &CollateralWithdrawn) : u64 {
        arg0.underlying_amount
    }

    public fun withdraw_collateral<T0>(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_position(arg0, arg1, arg2, arg6);
        assert!(arg4 > 0, 21);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 23);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        assert!(v0 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2)), 5);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v0, &arg0.obligation_cap, arg3, arg4, arg6);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, v0, arg3, v1, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg5, 22);
        emit_collateral_withdrawn<T0>(arg0, arg1, arg4, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v1), v3);
        v2
    }

    public fun withdraw_sui(arg0: &CreditPosition, arg1: &CreditConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_position(arg0, arg1, arg2, arg7);
        assert!(arg5 > 0, 21);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2);
        assert!(v0 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2)), 5);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, v0, &arg0.obligation_cap, arg3, arg5, arg7);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, v0, arg3, v1, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(), arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, v0, &v2, arg4, arg7);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, v0, v2, arg7);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg6, 22);
        emit_collateral_withdrawn<0x2::sui::SUI>(arg0, arg1, arg5, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(&v1), v4);
        v3
    }

    // decompiled from Move bytecode v7
}

