module 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset {
    struct AssetConfig has copy, drop, store {
        min_borrow_amount: u64,
        max_borrow_amount: u64,
        max_deposit_amount: u64,
        repay_fee_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        liquidation_fee_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    struct Asset<phantom T0> has store, key {
        id: 0x2::object::UID,
        flash_loan_lock: bool,
        interest_model: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::interest::InterestModel,
    }

    struct DFKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BorrowPaused has copy, drop, store {
        dummy_field: bool,
    }

    struct DepositPaused has copy, drop, store {
        dummy_field: bool,
    }

    struct WithdrawPaused has copy, drop, store {
        dummy_field: bool,
    }

    struct LiquidationPaused has copy, drop, store {
        dummy_field: bool,
    }

    struct FlashLoanPaused has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::interest::InterestModel, arg1: AssetConfig, arg2: &mut 0x2::tx_context::TxContext) : Asset<T0> {
        let v0 = Asset<T0>{
            id              : 0x2::object::new(arg2),
            flash_loan_lock : false,
            interest_model  : arg0,
        };
        let v1 = DFKey<AssetConfig>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<AssetConfig>, 0x1::option::Option<AssetConfig>>(&mut v0.id, v1, 0x1::option::some<AssetConfig>(arg1));
        let v2 = BorrowPaused{dummy_field: false};
        0x2::dynamic_field::add<BorrowPaused, bool>(&mut v0.id, v2, false);
        let v3 = DepositPaused{dummy_field: false};
        0x2::dynamic_field::add<DepositPaused, bool>(&mut v0.id, v3, false);
        let v4 = WithdrawPaused{dummy_field: false};
        0x2::dynamic_field::add<WithdrawPaused, bool>(&mut v0.id, v4, false);
        let v5 = LiquidationPaused{dummy_field: false};
        0x2::dynamic_field::add<LiquidationPaused, bool>(&mut v0.id, v5, false);
        let v6 = FlashLoanPaused{dummy_field: false};
        0x2::dynamic_field::add<FlashLoanPaused, bool>(&mut v0.id, v6, false);
        v0
    }

    fun assert_not_equal_and_set<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: bool) {
        let v0 = 0x2::dynamic_field::borrow_mut<T0, bool>(arg0, arg1);
        assert!(*v0 != arg2, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::error::updating_with_same_value());
        *v0 = arg2;
    }

    public(friend) fun asset_config<T0>(arg0: &Asset<T0>) : &AssetConfig {
        let v0 = DFKey<AssetConfig>{dummy_field: false};
        0x1::option::borrow<AssetConfig>(0x2::dynamic_field::borrow<DFKey<AssetConfig>, 0x1::option::Option<AssetConfig>>(&arg0.id, v0))
    }

    public fun borrow_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = BorrowPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<BorrowPaused, bool>(&arg0.id, v0)
    }

    public(friend) fun change_operation_status<T0>(arg0: &mut Asset<T0>, arg1: u8, arg2: bool) {
        let v0 = &arg1;
        if (*v0 == 0) {
            let v1 = &mut arg0.id;
            let v2 = BorrowPaused{dummy_field: false};
            assert_not_equal_and_set<BorrowPaused>(v1, v2, arg2);
        } else if (*v0 == 1) {
            let v3 = &mut arg0.id;
            let v4 = DepositPaused{dummy_field: false};
            assert_not_equal_and_set<DepositPaused>(v3, v4, arg2);
        } else if (*v0 == 2) {
            let v5 = &mut arg0.id;
            let v6 = WithdrawPaused{dummy_field: false};
            assert_not_equal_and_set<WithdrawPaused>(v5, v6, arg2);
        } else if (*v0 == 3) {
            let v7 = &mut arg0.id;
            let v8 = LiquidationPaused{dummy_field: false};
            assert_not_equal_and_set<LiquidationPaused>(v7, v8, arg2);
        } else {
            assert!(*v0 == 4, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::error::invalid_operation_status());
            let v9 = &mut arg0.id;
            let v10 = FlashLoanPaused{dummy_field: false};
            assert_not_equal_and_set<FlashLoanPaused>(v9, v10, arg2);
        };
    }

    public fun deposit_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = DepositPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<DepositPaused, bool>(&arg0.id, v0)
    }

    public(friend) fun flash_loan_finished<T0>(arg0: &mut Asset<T0>) {
        arg0.flash_loan_lock = false;
    }

    public fun flash_loan_ongoing<T0>(arg0: &Asset<T0>) : bool {
        arg0.flash_loan_lock
    }

    public fun flash_loan_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = FlashLoanPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<FlashLoanPaused, bool>(&arg0.id, v0)
    }

    public(friend) fun flash_loan_triggered<T0>(arg0: &mut Asset<T0>) {
        arg0.flash_loan_lock = true;
    }

    public(friend) fun interest_model<T0>(arg0: &Asset<T0>) : &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::interest::InterestModel {
        &arg0.interest_model
    }

    public fun liquidation_fee_rate(arg0: &AssetConfig) : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal {
        arg0.liquidation_fee_rate
    }

    public fun liquidation_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = LiquidationPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<LiquidationPaused, bool>(&arg0.id, v0)
    }

    public fun max_borrow_amount(arg0: &AssetConfig) : u64 {
        arg0.max_borrow_amount
    }

    public fun max_deposit_amount(arg0: &AssetConfig) : u64 {
        arg0.max_deposit_amount
    }

    public fun min_borrow_amount(arg0: &AssetConfig) : u64 {
        arg0.min_borrow_amount
    }

    public(friend) fun new_asset_config(arg0: u64, arg1: u64, arg2: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal, arg3: u64, arg4: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal) : AssetConfig {
        AssetConfig{
            min_borrow_amount    : arg0,
            max_borrow_amount    : arg1,
            max_deposit_amount   : arg3,
            repay_fee_rate       : arg2,
            liquidation_fee_rate : arg4,
        }
    }

    public fun repay_fee_rate(arg0: &AssetConfig) : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal {
        arg0.repay_fee_rate
    }

    public(friend) fun update_asset_config<T0>(arg0: &mut Asset<T0>, arg1: AssetConfig) {
        let v0 = DFKey<AssetConfig>{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<DFKey<AssetConfig>, 0x1::option::Option<AssetConfig>>(&mut arg0.id, v0) = 0x1::option::some<AssetConfig>(arg1);
    }

    public(friend) fun update_interest_model<T0>(arg0: &mut Asset<T0>, arg1: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::interest::InterestModel) {
        arg0.interest_model = arg1;
    }

    public fun withdraw_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = WithdrawPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<WithdrawPaused, bool>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

