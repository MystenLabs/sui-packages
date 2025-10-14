module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::emode {
    struct EModeCollateral has store {
        collateral_factor: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        liquidation_factor: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        liquidation_incentive: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
    }

    struct EModeBorrow has store {
        max_borrow_amount: u64,
        borrow_weight: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
    }

    struct EModeFlashLoan has store {
        flash_loan_fee_rate: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
    }

    struct EModeRateLimiter has store {
        deposit: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::Limiter,
        borrow: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::Limiter,
    }

    struct EMode has store, key {
        id: 0x2::object::UID,
    }

    struct EModeGroupRegistry has store {
        next_group_id: u8,
        groups: 0x2::table::Table<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>,
    }

    struct NewEMode has copy, drop {
        collateral_factor: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        liquidation_factor: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        liquidation_incentive: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        max_borrow_amount: u64,
        borrow_weight: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        flash_loan_fee_rate: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        deposit_limiter: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::NewLimiter,
        borrow_limiter: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::NewLimiter,
    }

    struct EModeInfo has copy, drop {
        asset: 0x1::type_name::TypeName,
        collateral_factor: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        liquidation_factor: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        liquidation_incentive: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        max_borrow_amount: u64,
        borrow_weight: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        flash_loan_fee_rate: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        deposit_limiter: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::RateLimitUsage,
        borrow_limiter: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::RateLimitUsage,
    }

    struct DFKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow(arg0: &EMode) : &EModeBorrow {
        let v0 = DFKey<EModeBorrow>{dummy_field: false};
        0x2::dynamic_field::borrow<DFKey<EModeBorrow>, EModeBorrow>(&arg0.id, v0)
    }

    public fun borrow_emode(arg0: &EModeGroupRegistry, arg1: u8, arg2: 0x1::type_name::TypeName) : &EMode {
        ensure_group_exists(arg0, arg1);
        0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::load_by_type<EMode>(0x2::table::borrow<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&arg0.groups, arg1), arg2)
    }

    public(friend) fun borrow_mut_borrow_limiter(arg0: &mut EMode) : &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::Limiter {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v0).deposit
    }

    public(friend) fun borrow_mut_deposit_limiter(arg0: &mut EMode) : &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::Limiter {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v0).deposit
    }

    public(friend) fun borrow_mut_emode(arg0: &mut EModeGroupRegistry, arg1: u8, arg2: 0x1::type_name::TypeName) : &mut EMode {
        ensure_group_exists(arg0, arg1);
        0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::load_mut_by_type<EMode>(0x2::table::borrow_mut<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&mut arg0.groups, arg1), arg2)
    }

    public fun borrow_weight(arg0: &EModeBorrow) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        arg0.borrow_weight
    }

    public fun can_be_collateral(arg0: &EModeCollateral) : bool {
        let v0 = liquidation_factor(arg0);
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::gt_u64(&v0, 0)
    }

    public fun collateral(arg0: &EMode) : &EModeCollateral {
        let v0 = DFKey<EModeCollateral>{dummy_field: false};
        0x2::dynamic_field::borrow<DFKey<EModeCollateral>, EModeCollateral>(&arg0.id, v0)
    }

    public fun collateral_factor(arg0: &EModeCollateral) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        arg0.collateral_factor
    }

    public fun default_emode_group() : u8 {
        0
    }

    public fun ensure_group_exists(arg0: &EModeGroupRegistry, arg1: u8) {
        assert!(0x2::table::contains<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&arg0.groups, arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::emode_group_not_exists());
    }

    public fun fee_rate(arg0: &EModeFlashLoan) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        arg0.flash_loan_fee_rate
    }

    public fun flash_loan(arg0: &EMode) : &EModeFlashLoan {
        let v0 = DFKey<EModeFlashLoan>{dummy_field: false};
        0x2::dynamic_field::borrow<DFKey<EModeFlashLoan>, EModeFlashLoan>(&arg0.id, v0)
    }

    public fun is_support(arg0: &EModeGroupRegistry, arg1: u8, arg2: 0x1::type_name::TypeName) : bool {
        ensure_group_exists(arg0, arg1);
        0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::supports_type<EMode>(0x2::table::borrow<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&arg0.groups, arg1), arg2)
    }

    public fun limiter_usage(arg0: &EMode, arg1: u64) : (0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::RateLimitUsage, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::RateLimitUsage) {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DFKey<EModeRateLimiter>, EModeRateLimiter>(&arg0.id, v0);
        (0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::current_usage(&v1.deposit, arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::current_usage(&v1.borrow, arg1))
    }

    public fun liquidation_factor(arg0: &EModeCollateral) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        arg0.liquidation_factor
    }

    public fun liquidation_incentive(arg0: &EModeCollateral) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        arg0.liquidation_incentive
    }

    public fun list_assets(arg0: &EModeGroupRegistry, arg1: u8, arg2: u64) : vector<EModeInfo> {
        ensure_group_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&arg0.groups, arg1);
        let v1 = 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::keys<EMode>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<EModeInfo>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::load_by_type<EMode>(v0, *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2));
            let (v5, v6) = limiter_usage(v4, arg2);
            let v7 = EModeInfo{
                asset                 : *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2),
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

    public fun max_borrow_amount(arg0: &EModeBorrow) : u64 {
        arg0.max_borrow_amount
    }

    public(friend) fun new_e_mode_registry(arg0: &mut 0x2::tx_context::TxContext) : EModeGroupRegistry {
        let v0 = EModeGroupRegistry{
            next_group_id : 0,
            groups        : 0x2::table::new<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(arg0),
        };
        let v1 = &mut v0;
        new_emode_group(v1, arg0);
        v0
    }

    public(friend) fun new_emode_group(arg0: &mut EModeGroupRegistry, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = arg0.next_group_id;
        assert!(v0 != 255, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::max_emode_groups_reached());
        arg0.next_group_id = arg0.next_group_id + 1;
        0x2::table::add<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&mut arg0.groups, v0, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::new<EMode>(arg1));
        v0
    }

    public(friend) fun new_emode_params(arg0: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg2: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg3: u64, arg4: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg5: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg6: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::NewLimiter, arg7: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::NewLimiter) : NewEMode {
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
        assert!(0x2::table::contains<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&arg0.groups, arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::emode_group_not_exists());
        let v0 = 0x2::table::borrow_mut<u8, 0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::GenericCoinTypeStorage<EMode>>(&mut arg0.groups, arg1);
        assert!(!0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::supports<EMode, T0>(v0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::group_already_supports_asset());
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
            deposit : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::new_from_struct(v8),
            borrow  : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::new_from_struct(v9),
        };
        let v17 = DFKey<EModeRateLimiter>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut v1.id, v17, v16);
        0x6485c895f331de2a9e44a0ae7bde0bf15f4d14d637fdec5fcb6e58267bc9e14b::generic_store::store<EMode, T0>(v0, v1);
    }

    public(friend) fun update_borrow(arg0: &mut EMode, arg1: u64, arg2: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        let v0 = DFKey<EModeBorrow>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<EModeBorrow>, EModeBorrow>(&mut arg0.id, v0);
        v1.max_borrow_amount = arg1;
        v1.borrow_weight = arg2;
    }

    public(friend) fun update_collateral(arg0: &mut EMode, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg2: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg3: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        let v0 = DFKey<EModeCollateral>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<EModeCollateral>, EModeCollateral>(&mut arg0.id, v0);
        v1.collateral_factor = arg1;
        v1.liquidation_factor = arg2;
        v1.liquidation_incentive = arg3;
    }

    public(friend) fun update_flash_loan(arg0: &mut EMode, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        let v0 = DFKey<EModeFlashLoan>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DFKey<EModeFlashLoan>, EModeFlashLoan>(&mut arg0.id, v0).flash_loan_fee_rate = arg1;
    }

    public(friend) fun update_limiter(arg0: &mut EMode, arg1: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::NewLimiter, arg2: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::NewLimiter) {
        let v0 = DFKey<EModeRateLimiter>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<EModeRateLimiter>, EModeRateLimiter>(&mut arg0.id, v0);
        v1.deposit = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::new_from_struct(arg1);
        v1.borrow = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter::new_from_struct(arg2);
    }

    // decompiled from Move bytecode v6
}

