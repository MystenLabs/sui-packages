module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::flash_loan {
    struct BorrowFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BorrowFlashLoanV2Event has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
        fee_discount_numerator: u64,
        fee_discount_denominator: u64,
    }

    struct RepayFlashLoanV2Event has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun borrow_flash_loan<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::FlashLoan<T0>) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        borrow_flash_loan_internal<T0>(arg1, arg2, arg3)
    }

    fun borrow_flash_loan_internal<T0>(arg0: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::FlashLoan<T0>) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::assert_whitelist_access(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::is_base_asset_active(arg0, v0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::base_asset_not_active_error());
        let (v1, v2) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::borrow_flash_loan<T0>(arg0, arg1, arg2);
        let v3 = v2;
        let v4 = BorrowFlashLoanV2Event{
            borrower                 : 0x2::tx_context::sender(arg2),
            asset                    : v0,
            amount                   : arg1,
            fee                      : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::flash_loan_fee<T0>(&v3),
            fee_discount_numerator   : 0,
            fee_discount_denominator : 0,
        };
        0x2::event::emit<BorrowFlashLoanV2Event>(v4);
        (v1, v3)
    }

    public fun repay_flash_loan<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanV2Event{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
            fee      : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::flash_loan_fee<T0>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanV2Event>(v0);
        let v1 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::flash_loan_loan_amount<T0>(&arg3) + 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::flash_loan_fee<T0>(&arg3);
        if (0x2::coin::value<T0>(&arg2) > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) - v1, arg4), 0x2::tx_context::sender(arg4));
        };
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

