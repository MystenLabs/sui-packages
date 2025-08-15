module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset {
    struct Collateral has copy, drop, store {
        collateral_factor: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        liquidation_incentive: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        liquidation_revenue_factor: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
    }

    struct BorrowConfig has copy, drop, store {
        min_borrow_amount: u64,
        max_borrow_amount: u64,
        max_deposit_amount: u64,
        flash_loan_fee_rate: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        repay_fee_rate: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
    }

    struct Asset<phantom T0> has store, key {
        id: 0x2::object::UID,
        flash_loan_lock: bool,
        interest_model: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel,
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

    public(friend) fun new<T0>(arg0: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel, arg1: BorrowConfig, arg2: &mut 0x2::tx_context::TxContext) : Asset<T0> {
        let v0 = Asset<T0>{
            id              : 0x2::object::new(arg2),
            flash_loan_lock : false,
            interest_model  : arg0,
        };
        let v1 = DFKey<Collateral>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<Collateral>, 0x1::option::Option<Collateral>>(&mut v0.id, v1, 0x1::option::none<Collateral>());
        let v2 = DFKey<BorrowConfig>{dummy_field: false};
        0x2::dynamic_field::add<DFKey<BorrowConfig>, 0x1::option::Option<BorrowConfig>>(&mut v0.id, v2, 0x1::option::some<BorrowConfig>(arg1));
        let v3 = BorrowPaused{dummy_field: false};
        0x2::dynamic_field::add<BorrowPaused, bool>(&mut v0.id, v3, false);
        let v4 = DepositPaused{dummy_field: false};
        0x2::dynamic_field::add<DepositPaused, bool>(&mut v0.id, v4, false);
        let v5 = WithdrawPaused{dummy_field: false};
        0x2::dynamic_field::add<WithdrawPaused, bool>(&mut v0.id, v5, false);
        v0
    }

    public fun borrow_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = BorrowPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<BorrowPaused, bool>(&arg0.id, v0)
    }

    public fun borrow_setting<T0>(arg0: &Asset<T0>) : &BorrowConfig {
        let v0 = DFKey<BorrowConfig>{dummy_field: false};
        0x1::option::borrow<BorrowConfig>(0x2::dynamic_field::borrow<DFKey<BorrowConfig>, 0x1::option::Option<BorrowConfig>>(&arg0.id, v0))
    }

    public fun can_be_collateral<T0>(arg0: &Asset<T0>) : bool {
        let v0 = DFKey<Collateral>{dummy_field: false};
        0x1::option::is_some<Collateral>(0x2::dynamic_field::borrow<DFKey<Collateral>, 0x1::option::Option<Collateral>>(&arg0.id, v0))
    }

    public(friend) fun change_operation_status<T0>(arg0: &mut Asset<T0>, arg1: u8, arg2: bool) {
        assert!(arg1 < 3, 13906834994682134527);
        if (arg1 == 0) {
            let v0 = BorrowPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<BorrowPaused, bool>(&mut arg0.id, v0) = arg2;
        } else if (arg1 == 1) {
            let v1 = DepositPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DepositPaused, bool>(&mut arg0.id, v1) = arg2;
        } else if (arg1 == 2) {
            let v2 = WithdrawPaused{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<WithdrawPaused, bool>(&mut arg0.id, v2) = arg2;
        };
    }

    public fun collateral_factor(arg0: &Collateral) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.collateral_factor
    }

    public fun collateral_setting<T0>(arg0: &Asset<T0>) : &Collateral {
        let v0 = DFKey<Collateral>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DFKey<Collateral>, 0x1::option::Option<Collateral>>(&arg0.id, v0);
        assert!(0x1::option::is_some<Collateral>(v1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::asset_not_collateral());
        0x1::option::borrow<Collateral>(v1)
    }

    public fun deposit_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = DepositPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<DepositPaused, bool>(&arg0.id, v0)
    }

    public(friend) fun disable_as_collateral<T0>(arg0: &mut Asset<T0>) {
        let v0 = DFKey<Collateral>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<Collateral>, 0x1::option::Option<Collateral>>(&mut arg0.id, v0);
        assert!(0x1::option::is_some<Collateral>(v1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::asset_not_collateral());
        *v1 = 0x1::option::none<Collateral>();
    }

    public(friend) fun enable_as_collateral<T0>(arg0: &mut Asset<T0>, arg1: Collateral) {
        let v0 = DFKey<Collateral>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<Collateral>, 0x1::option::Option<Collateral>>(&mut arg0.id, v0);
        assert!(0x1::option::is_none<Collateral>(v1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::asset_already_collateral());
        *v1 = 0x1::option::some<Collateral>(arg1);
    }

    public fun flash_loan_fee_rate(arg0: &BorrowConfig) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.flash_loan_fee_rate
    }

    public(friend) fun flash_loan_finished<T0>(arg0: &mut Asset<T0>) {
        arg0.flash_loan_lock = false;
    }

    public fun flash_loan_ongoing<T0>(arg0: &Asset<T0>) : bool {
        arg0.flash_loan_lock
    }

    public(friend) fun flash_loan_triggered<T0>(arg0: &mut Asset<T0>) {
        arg0.flash_loan_lock = true;
    }

    public fun interest_model<T0>(arg0: &Asset<T0>) : &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel {
        &arg0.interest_model
    }

    public fun liq_revenue_factor(arg0: &Collateral) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.liquidation_revenue_factor
    }

    public fun liquidation_incentive(arg0: &Collateral) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.liquidation_incentive
    }

    public fun max_borrow_amount(arg0: &BorrowConfig) : u64 {
        arg0.max_borrow_amount
    }

    public fun max_deposit_amount(arg0: &BorrowConfig) : u64 {
        arg0.max_deposit_amount
    }

    public fun min_borrow_amount(arg0: &BorrowConfig) : u64 {
        arg0.min_borrow_amount
    }

    public(friend) fun new_borrow_config(arg0: u64, arg1: u64, arg2: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg3: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg4: u64) : BorrowConfig {
        BorrowConfig{
            min_borrow_amount   : arg0,
            max_borrow_amount   : arg1,
            max_deposit_amount  : arg4,
            flash_loan_fee_rate : arg2,
            repay_fee_rate      : arg3,
        }
    }

    public(friend) fun new_collateral(arg0: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg2: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) : Collateral {
        Collateral{
            collateral_factor          : arg0,
            liquidation_incentive      : arg1,
            liquidation_revenue_factor : arg2,
        }
    }

    public fun repay_fee_rate(arg0: &BorrowConfig) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.repay_fee_rate
    }

    public(friend) fun update_borrow<T0>(arg0: &mut Asset<T0>, arg1: BorrowConfig) {
        let v0 = DFKey<BorrowConfig>{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<DFKey<BorrowConfig>, 0x1::option::Option<BorrowConfig>>(&mut arg0.id, v0) = 0x1::option::some<BorrowConfig>(arg1);
    }

    public(friend) fun update_collateral<T0>(arg0: &mut Asset<T0>, arg1: Collateral) {
        let v0 = DFKey<Collateral>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DFKey<Collateral>, 0x1::option::Option<Collateral>>(&mut arg0.id, v0);
        assert!(0x1::option::is_some<Collateral>(v1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::asset_not_collateral());
        *v1 = 0x1::option::some<Collateral>(arg1);
    }

    public(friend) fun update_interest_model<T0>(arg0: &mut Asset<T0>, arg1: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel) {
        arg0.interest_model = arg1;
    }

    public fun withdraw_paused<T0>(arg0: &Asset<T0>) : bool {
        let v0 = WithdrawPaused{dummy_field: false};
        *0x2::dynamic_field::borrow<WithdrawPaused, bool>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

