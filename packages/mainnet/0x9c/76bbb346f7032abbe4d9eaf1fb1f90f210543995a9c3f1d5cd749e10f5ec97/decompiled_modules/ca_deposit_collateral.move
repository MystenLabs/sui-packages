module 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::ca_deposit_collateral {
    public fun deposit_collateral<T0: store>(arg0: &mut 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::CreditAccount, arg1: &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::OwnerKey, arg2: 0x2::coin::Coin<T0>) {
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::assert_owner(arg0, arg1);
        assert!(0x1::type_name::get<T0>() == 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::denom(arg0), 0);
        if (0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::asset_exists<T0>(arg0)) {
            let v0 = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg0);
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(arg2));
            0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::add_asset<0x2::balance::Balance<T0>>(v0, arg0);
        } else {
            0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::add_asset<0x2::balance::Balance<T0>>(0x2::coin::into_balance<T0>(arg2), arg0);
        };
    }

    // decompiled from Move bytecode v6
}

