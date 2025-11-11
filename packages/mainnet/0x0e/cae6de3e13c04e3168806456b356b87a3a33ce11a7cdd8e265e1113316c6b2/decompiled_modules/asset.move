module 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::asset {
    struct AssetConfig has copy, drop, store {
        min_borrow_amount: u64,
        max_deposit_amount: u64,
        repay_fee_rate: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        liquidation_fee_rate: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
    }

    struct Asset<phantom T0> has store, key {
        id: 0x2::object::UID,
        flash_loan_lock: bool,
        interest_model: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::interest::InterestModel,
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

    public(friend) fun new<T0>(arg0: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::interest::InterestModel, arg1: AssetConfig, arg2: &mut 0x2::tx_context::TxContext) : Asset<T0> {
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

    public(friend) fun asset_config<T0>(arg0: &Asset<T0>) : &AssetConfig {
        let v0 = DFKey<AssetConfig>{dummy_field: false};
        0x1::option::borrow<AssetConfig>(0x2::dynamic_field::borrow<DFKey<AssetConfig>, 0x1::option::Option<AssetConfig>>(&arg0.id, v0))
    }

    public fun borrow_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = BorrowPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<BorrowPaused, bool>(&arg0.id, v0)
    }

    public(friend) fun change_operation_status<T0>(arg0: &mut Asset<T0>, arg1: u8, arg2: bool) {
        assert!(arg1 < 5, 13906834651084750847);
        if (arg1 == 0) {
            let v0 = BorrowPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<BorrowPaused, bool>(&mut arg0.id, v0) = arg2;
        } else if (arg1 == 1) {
            let v1 = DepositPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DepositPaused, bool>(&mut arg0.id, v1) = arg2;
        } else if (arg1 == 2) {
            let v2 = WithdrawPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<WithdrawPaused, bool>(&mut arg0.id, v2) = arg2;
        } else if (arg1 == 3) {
            let v3 = LiquidationPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<LiquidationPaused, bool>(&mut arg0.id, v3) = arg2;
        } else if (arg1 == 4) {
            let v4 = FlashLoanPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FlashLoanPaused, bool>(&mut arg0.id, v4) = arg2;
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

    public(friend) fun interest_model<T0>(arg0: &Asset<T0>) : &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::interest::InterestModel {
        &arg0.interest_model
    }

    public fun liquidation_fee_rate(arg0: &AssetConfig) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        arg0.liquidation_fee_rate
    }

    public fun liquidation_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = LiquidationPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<LiquidationPaused, bool>(&arg0.id, v0)
    }

    public fun max_deposit_amount(arg0: &AssetConfig) : u64 {
        arg0.max_deposit_amount
    }

    public fun min_borrow_amount(arg0: &AssetConfig) : u64 {
        arg0.min_borrow_amount
    }

    public(friend) fun new_asset_config(arg0: u64, arg1: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg2: u64, arg3: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal) : AssetConfig {
        AssetConfig{
            min_borrow_amount    : arg0,
            max_deposit_amount   : arg2,
            repay_fee_rate       : arg1,
            liquidation_fee_rate : arg3,
        }
    }

    public fun repay_fee_rate(arg0: &AssetConfig) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        arg0.repay_fee_rate
    }

    public(friend) fun update_asset_config<T0>(arg0: &mut Asset<T0>, arg1: AssetConfig) {
        let v0 = DFKey<AssetConfig>{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<DFKey<AssetConfig>, 0x1::option::Option<AssetConfig>>(&mut arg0.id, v0) = 0x1::option::some<AssetConfig>(arg1);
    }

    public(friend) fun update_interest_model<T0>(arg0: &mut Asset<T0>, arg1: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::interest::InterestModel) {
        arg0.interest_model = arg1;
    }

    public fun withdraw_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = WithdrawPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<WithdrawPaused, bool>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

