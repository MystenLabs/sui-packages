module 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x1::option::Option<0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::Operation>,
        principle: u64,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_market::LeverageMarket, arg2: &0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_market::is_leverate_on_going(arg1), 13906834513645797375);
        0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_market::mark_leverage_finished(arg1);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::deposit::deposit<T0, T1>(0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::market_obligation(arg2), arg0, arg4, arg7, arg8);
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T2>(&arg3) + 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::loan_amount<T0, T2>(&arg3);
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow::borrow<T0, T2>(0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::market_obligation(arg2), arg0, arg5, v0, arg6, arg7, arg8);
        assert!(0x2::coin::value<T2>(&v1) == v0, 13906834548005535743);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::repay_flash_loan<T0, T2>(arg0, 0x2::coin::split<T2>(&mut v1, v0, arg8), arg3, arg8);
        v1
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_market::LeverageMarket, arg2: &mut 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::Direction, arg6: &0x2::clock::Clock, arg7: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg8: &mut 0x2::tx_context::TxContext) : (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T2>, 0x2::coin::Coin<T2>) {
        assert!(!0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_market::is_leverate_on_going(arg1), 13906834359026974719);
        0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_market::mark_leverage_ongoing(arg1);
        0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::set_or_check_position<T1, T2>(arg2, 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::get_entry_price<T1, T2>(arg7, arg6, arg5), arg5, 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::swap_borrow());
        let (v0, v1) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::borrow_flash_loan<T0, T2>(arg0, arg4 - 0x2::coin::value<T2>(&arg3), arg8);
        let v2 = v0;
        let v3 = NewSwapBorrowEvent{
            leverage_owner_cap : 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::id(arg2),
            operation          : 0x1::option::some<0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::Operation>(0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::swap_borrow()),
            principle          : 0xef72bc94b4162cf7d72041a41ebeff221df7f5a1db91bd923a292f4416639c16::leverage_obligation::increase_amount(arg2, 0x2::coin::value<T2>(&arg3)),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v3);
        0x2::coin::join<T2>(&mut v2, arg3);
        assert!(0x2::coin::value<T2>(&v2) == arg4, 13906834432041418751);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

