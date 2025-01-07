module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::ca_repay {
    public fun repay<T0: store>(arg0: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::Market, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::CreditAccount, arg2: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::OwnerKey, arg3: &0x2::clock::Clock, arg4: u64) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::assert_owner(arg1, arg2);
        assert!(0x1::type_name::get<T0>() == 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::denom(arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::accrue_interest<T0>(arg0, v0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::accrue_interest(arg1, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::get_coin_interest_config<T0>(arg0));
        let v1 = 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg1);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::add_asset<0x2::balance::Balance<T0>>(v1, arg1);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::handle_repay<T0>(arg0, 0x2::balance::split<T0>(&mut v1, arg4), v0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::decrease_debt(arg1, arg4);
    }

    // decompiled from Move bytecode v6
}

