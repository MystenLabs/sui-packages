module 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::flash_loan {
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

    public fun borrow_flash_loan<T0>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::Version, arg1: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::FlashLoan<T0>) {
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::assert_current_version(arg0);
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::uid(arg1), 0x2::tx_context::sender(arg3)), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::is_base_asset_active(arg1, v0), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::base_asset_not_active_error());
        let v1 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg2,
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v1);
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::borrow_flash_loan<T0>(arg1, arg2, arg3)
    }

    public fun repay_flash_loan<T0>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::Version, arg1: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

