module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode {
    struct EModeCollateral has store {
        collateral_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_incentive: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct EModeBorrow has store {
        max_borrow_amount: u64,
        borrow_weight: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct EModeFlashLoan has store {
        flash_loan_fee_rate: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct EModeRateLimiter has store {
        deposit: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::Limiter,
        borrow: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::Limiter,
    }

    struct EMode has store, key {
        id: 0x2::object::UID,
    }

    struct EModeGroup has store {
        assets: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<EMode>,
        assets_borrows: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>,
        oracle_base_token: 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::BaseToken,
    }

    struct EModeGroupRegistry has store {
        next_group_id: u8,
        groups: 0x2::table::Table<u8, EModeGroup>,
    }

    struct NewEMode has copy, drop, store {
        collateral_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_incentive: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        max_borrow_amount: u64,
        borrow_weight: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        flash_loan_fee_rate: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        deposit_limiter: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter,
        borrow_limiter: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter,
    }

    struct EModeInfo has copy, drop {
        asset: 0x1::type_name::TypeName,
        oracle_base_token: 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::BaseToken,
        collateral_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_incentive: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        max_borrow_amount: u64,
        borrow_weight: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        flash_loan_fee_rate: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        deposit_limiter: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::RateLimitUsage,
        borrow_limiter: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::RateLimitUsage,
    }

    struct DFKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow(arg0: &EMode) : &EModeBorrow {
        let v0 = DFKey<EModeBorrow>{dummy_field: false};
        0x2::dynamic_field::borrow<DFKey<EModeBorrow>, EModeBorrow>(&arg0.id, v0)
    }

    public(friend) fun borrow_amount(arg0: &EModeGroup, arg1: 0x1::type_name::TypeName) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&arg0.assets_borrows, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_does_not_support_asset());
        *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&arg0.assets_borrows, arg1)
    }

    public(friend) fun borrow_emode(arg0: &EModeGroup, arg1: 0x1::type_name::TypeName) : &EMode {
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports_type<EMode>(&arg0.assets, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_does_not_support_asset());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<EMode>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_emode_group(arg0: &EModeGroupRegistry, arg1: u8) : &EModeGroup {
        ensure_group_exists(arg0, arg1);
        0x2::table::borrow<u8, EModeGroup>(&arg0.groups, arg1)
    }

    public(friend) fun borrow_emode_group_mut(arg0: &mut EModeGroupRegistry, arg1: u8) : &mut EModeGroup {
        ensure_group_exists(arg0, arg1);
        0x2::table::borrow_mut<u8, EModeGroup>(&mut arg0.groups, arg1)
    }

    public(friend) fun borrow_emode_mut(arg0: &mut EModeGroup, arg1: 0x1::type_name::TypeName) : &mut EMode {
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports_type<EMode>(&arg0.assets, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_does_not_support_asset());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<EMode>(&mut arg0.assets, arg1)
    }

    public(friend) fun borrow_mut_borrow_limiter(arg0: &mut EMode) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::Limiter {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v0).borrow
    }

    public(friend) fun borrow_mut_deposit_limiter(arg0: &mut EMode) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::Limiter {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v0).deposit
    }

    public(friend) fun borrow_mut_emode(arg0: &mut EModeGroupRegistry, arg1: u8, arg2: 0x1::type_name::TypeName) : &mut EMode {
        ensure_group_exists(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<u8, EModeGroup>(&mut arg0.groups, arg1);
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports_type<EMode>(&v0.assets, arg2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_does_not_support_asset());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<EMode>(&mut v0.assets, arg2)
    }

    public(friend) fun borrow_weight(arg0: &EModeBorrow) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.borrow_weight
    }

    public(friend) fun can_be_collateral(arg0: &EModeCollateral) : bool {
        let v0 = liquidation_factor(arg0);
        0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::gt_u64(&v0, 0)
    }

    public(friend) fun collateral(arg0: &EMode) : &EModeCollateral {
        let v0 = DFKey<EModeCollateral>{dummy_field: false};
        0x2::dynamic_field::borrow<DFKey<EModeCollateral>, EModeCollateral>(&arg0.id, v0)
    }

    public(friend) fun collateral_factor(arg0: &EModeCollateral) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.collateral_factor
    }

    public(friend) fun ensure_group_exists(arg0: &EModeGroupRegistry, arg1: u8) {
        assert!(0x2::table::contains<u8, EModeGroup>(&arg0.groups, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_not_exists());
    }

    public(friend) fun fee_rate(arg0: &EModeFlashLoan) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.flash_loan_fee_rate
    }

    public(friend) fun flash_loan(arg0: &EMode) : &EModeFlashLoan {
        let v0 = DFKey<EModeFlashLoan>{dummy_field: false};
        0x2::dynamic_field::borrow<DFKey<EModeFlashLoan>, EModeFlashLoan>(&arg0.id, v0)
    }

    public(friend) fun get_oracle_base_token(arg0: &EModeGroup) : 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::BaseToken {
        arg0.oracle_base_token
    }

    public(friend) fun limiter_usage(arg0: &EMode, arg1: u64) : (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::RateLimitUsage, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::RateLimitUsage) {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DFKey<EModeRateLimiter>, EModeRateLimiter>(&arg0.id, v0);
        (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::current_usage(&v1.deposit, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::current_usage(&v1.borrow, arg1))
    }

    public(friend) fun liquidation_factor(arg0: &EModeCollateral) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.liquidation_factor
    }

    public(friend) fun liquidation_incentive(arg0: &EModeCollateral) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.liquidation_incentive
    }

    public fun list_assets(arg0: &EModeGroupRegistry, arg1: u8, arg2: u64) : vector<EModeInfo> {
        ensure_group_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<u8, EModeGroup>(&arg0.groups, arg1);
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::keys<EMode>(&v0.assets);
        let v2 = 0;
        let v3 = 0x1::vector::empty<EModeInfo>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<EMode>(&v0.assets, *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2));
            let (v5, v6) = limiter_usage(v4, arg2);
            let v7 = EModeInfo{
                asset                 : *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2),
                oracle_base_token     : get_oracle_base_token(v0),
                collateral_factor     : collateral_factor(collateral(v4)),
                liquidation_factor    : liquidation_factor(collateral(v4)),
                liquidation_incentive : liquidation_incentive(collateral(v4)),
                max_borrow_amount     : max_borrow_amount(borrow(v4)),
                borrow_weight         : borrow_weight(borrow(v4)),
                flash_loan_fee_rate   : fee_rate(flash_loan(v4)),
                deposit_limiter       : v5,
                borrow_limiter        : v6,
            };
            0x1::vector::push_back<EModeInfo>(&mut v3, v7);
            v2 = v2 + 1;
        };
        v3
    }

    public(friend) fun max_borrow_amount(arg0: &EModeBorrow) : u64 {
        arg0.max_borrow_amount
    }

    public(friend) fun new_e_mode_registry(arg0: &mut 0x2::tx_context::TxContext) : EModeGroupRegistry {
        EModeGroupRegistry{
            next_group_id : 0,
            groups        : 0x2::table::new<u8, EModeGroup>(arg0),
        }
    }

    public(friend) fun new_emode_group(arg0: &mut EModeGroupRegistry, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = arg0.next_group_id;
        assert!(v0 != 255, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::max_emode_groups_reached());
        arg0.next_group_id = arg0.next_group_id + 1;
        let v1 = EModeGroup{
            assets            : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::new<EMode>(arg2),
            assets_borrows    : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::new<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(arg2),
            oracle_base_token : 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::base_token_from_u8(arg1),
        };
        0x2::table::add<u8, EModeGroup>(&mut arg0.groups, v0, v1);
        v0
    }

    public(friend) fun new_emode_params(arg0: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: u64, arg4: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg5: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg6: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter, arg7: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter) : NewEMode {
        NewEMode{
            collateral_factor     : arg0,
            liquidation_factor    : arg1,
            liquidation_incentive : arg2,
            max_borrow_amount     : arg3,
            borrow_weight         : arg4,
            flash_loan_fee_rate   : arg5,
            deposit_limiter       : arg6,
            borrow_limiter        : arg7,
        }
    }

    public(friend) fun support_asset<T0>(arg0: &mut EModeGroupRegistry, arg1: u8, arg2: NewEMode, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u8, EModeGroup>(&arg0.groups, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_not_exists());
        let v0 = 0x2::table::borrow_mut<u8, EModeGroup>(&mut arg0.groups, arg1);
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports<EMode, T0>(&v0.assets), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_already_supports_asset());
        let v1 = EMode{id: 0x2::object::new(arg3)};
        let NewEMode {
            collateral_factor     : v2,
            liquidation_factor    : v3,
            liquidation_incentive : v4,
            max_borrow_amount     : v5,
            borrow_weight         : v6,
            flash_loan_fee_rate   : v7,
            deposit_limiter       : v8,
            borrow_limiter        : v9,
        } = arg2;
        let v10 = EModeCollateral{
            collateral_factor     : v2,
            liquidation_factor    : v3,
            liquidation_incentive : v4,
        };
        let v11 = DFKey<EModeCollateral>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<EModeCollateral>, EModeCollateral>(&mut v1.id, v11, v10);
        let v12 = EModeBorrow{
            max_borrow_amount : v5,
            borrow_weight     : v6,
        };
        let v13 = DFKey<EModeBorrow>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<EModeBorrow>, EModeBorrow>(&mut v1.id, v13, v12);
        let v14 = EModeFlashLoan{flash_loan_fee_rate: v7};
        let v15 = DFKey<EModeFlashLoan>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<EModeFlashLoan>, EModeFlashLoan>(&mut v1.id, v15, v14);
        let v16 = EModeRateLimiter{
            deposit : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::new_from_struct(v8),
            borrow  : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::new_from_struct(v9),
        };
        let v17 = DFKey<EModeRateLimiter>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut v1.id, v17, v16);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::store<EMode, T0>(&mut v0.assets, v1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::store<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, T0>(&mut v0.assets_borrows, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero());
    }

    public(friend) fun update(arg0: &mut EMode, arg1: NewEMode) {
        let NewEMode {
            collateral_factor     : v0,
            liquidation_factor    : v1,
            liquidation_incentive : v2,
            max_borrow_amount     : v3,
            borrow_weight         : v4,
            flash_loan_fee_rate   : v5,
            deposit_limiter       : v6,
            borrow_limiter        : v7,
        } = arg1;
        let v8 = DFKey<EModeCollateral>{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<DFKey<EModeCollateral>, EModeCollateral>(&mut arg0.id, v8);
        v9.collateral_factor = v0;
        v9.liquidation_factor = v1;
        v9.liquidation_incentive = v2;
        let v10 = DFKey<EModeBorrow>{dummy_field: false};
        let v11 = 0x2::dynamic_field::borrow_mut<DFKey<EModeBorrow>, EModeBorrow>(&mut arg0.id, v10);
        v11.max_borrow_amount = v3;
        v11.borrow_weight = v4;
        let v12 = DFKey<EModeFlashLoan>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DFKey<EModeFlashLoan>, EModeFlashLoan>(&mut arg0.id, v12).flash_loan_fee_rate = v5;
        let v13 = DFKey<EModeRateLimiter>{dummy_field: false};
        let v14 = 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v13);
        v14.deposit = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::new_from_struct(v6);
        v14.borrow = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::new_from_struct(v7);
    }

    public(friend) fun update_asset_borrow(arg0: &mut EModeGroup, arg1: 0x1::type_name::TypeName, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&arg0.assets_borrows, arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_group_does_not_support_asset());
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&mut arg0.assets_borrows, arg1);
        let v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::saturating_sub(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(arg3, *v0), arg2);
        *v0 = v1;
        v1
    }

    public(friend) fun update_borrow(arg0: &mut EMode, arg1: u64, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        let v0 = DFKey<EModeBorrow>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<EModeBorrow>, EModeBorrow>(&mut arg0.id, v0);
        v1.max_borrow_amount = arg1;
        v1.borrow_weight = arg2;
    }

    public(friend) fun update_collateral(arg0: &mut EMode, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        let v0 = DFKey<EModeCollateral>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<EModeCollateral>, EModeCollateral>(&mut arg0.id, v0);
        v1.collateral_factor = arg1;
        v1.liquidation_factor = arg2;
        v1.liquidation_incentive = arg3;
    }

    public(friend) fun update_flash_loan(arg0: &mut EMode, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        let v0 = DFKey<EModeFlashLoan>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DFKey<EModeFlashLoan>, EModeFlashLoan>(&mut arg0.id, v0).flash_loan_fee_rate = arg1;
    }

    public(friend) fun update_limiter(arg0: &mut EMode, arg1: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter, arg2: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter) {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v0);
        v1.deposit = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::new_from_struct(arg1);
        v1.borrow = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::new_from_struct(arg2);
    }

    // decompiled from Move bytecode v6
}

