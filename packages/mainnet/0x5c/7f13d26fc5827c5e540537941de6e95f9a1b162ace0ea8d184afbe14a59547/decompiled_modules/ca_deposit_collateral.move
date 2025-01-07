module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::ca_deposit_collateral {
    public fun deposit_collateral<T0: store>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::CreditAccount, arg1: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::OwnerKey, arg2: 0x2::coin::Coin<T0>) {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::assert_owner(arg0, arg1);
        assert!(0x1::type_name::get<T0>() == 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::denom(arg0), 0);
        if (0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::asset_exists<T0>(arg0)) {
            let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg0);
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(arg2));
            0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::add_asset<0x2::balance::Balance<T0>>(v0, arg0);
        } else {
            0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::add_asset<0x2::balance::Balance<T0>>(0x2::coin::into_balance<T0>(arg2), arg0);
        };
    }

    public fun deposit_collateral_new<T0>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::CreditAccount, arg1: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::OwnerKey, arg2: 0x2::coin::Coin<T0>) {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::assert_owner(arg0, arg1);
        assert!(0x1::type_name::get<T0>() == 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::denom(arg0), 0);
        if (0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::asset_exists<0x2::balance::Balance<T0>>(arg0)) {
            let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg0);
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(arg2));
            0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::add_asset<0x2::balance::Balance<T0>>(v0, arg0);
        } else {
            0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::add_asset<0x2::balance::Balance<T0>>(0x2::coin::into_balance<T0>(arg2), arg0);
        };
    }

    // decompiled from Move bytecode v6
}

