module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::ca_deposit_collateral {
    public fun deposit_collateral<T0: store>(arg0: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::CreditAccount, arg1: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::OwnerKey, arg2: 0x2::coin::Coin<T0>) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::assert_owner(arg0, arg1);
        assert!(0x1::type_name::get<T0>() == 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::denom(arg0), 0);
        if (0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::asset_exists<T0>(arg0)) {
            let v0 = 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg0);
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(arg2));
            0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::add_asset<0x2::balance::Balance<T0>>(v0, arg0);
        } else {
            0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::add_asset<0x2::balance::Balance<T0>>(0x2::coin::into_balance<T0>(arg2), arg0);
        };
    }

    // decompiled from Move bytecode v6
}

