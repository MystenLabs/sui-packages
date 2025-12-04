module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault {
    struct FeeVault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        balance_a_gauge: 0x2::balance::Balance<T0>,
        balance_b_gauge: 0x2::balance::Balance<T1>,
        balance_a_recipients: 0x2::balance::Balance<T0>,
        balance_b_recipients: 0x2::balance::Balance<T1>,
        stable: bool,
        gauge_active: bool,
    }

    public fun id<T0, T1, T2>(arg0: &FeeVault<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<FeeVault<T0, T1, T2>>(arg0)
    }

    public(friend) fun claim_fees<T0, T1, T2>(arg0: &mut FeeVault<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_a_gauge), arg1), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_b_gauge), arg1))
    }

    public fun deposit<T0, T1, T2>(arg0: &mut FeeVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::DistributionConfig, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0.gauge_active) {
            0x2::balance::join<T0>(&mut arg0.balance_a_gauge, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::to_gauge_rate(arg3) / 10000, arg4)));
            0x2::balance::join<T1>(&mut arg0.balance_b_gauge, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, 0x2::coin::value<T1>(&arg2) * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::to_gauge_rate(arg3) / 10000, arg4)));
        };
        0x2::balance::join<T0>(&mut arg0.balance_a_recipients, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b_recipients, 0x2::coin::into_balance<T1>(arg2));
    }

    public(friend) fun distribute_fees<T0, T1, T2>(arg0: &mut FeeVault<T0, T1, T2>, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::recipients(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::distribution_config(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::Recipient>(v0)) {
            let v2 = 0x1::vector::borrow<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::Recipient>(v0, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a_recipients, 0x2::balance::value<T0>(&arg0.balance_a_recipients) * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::rate(v2) / 10000), arg2), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::addr(v2));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b_recipients, 0x2::balance::value<T1>(&arg0.balance_b_recipients) * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::rate(v2) / 10000), arg2), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::addr(v2));
            v1 = v1 + 1;
        };
    }

    public(friend) fun init_vault<T0, T1, T2>(arg0: &mut 0x2::tx_context::TxContext) : FeeVault<T0, T1, T2> {
        FeeVault<T0, T1, T2>{
            id                   : 0x2::object::new(arg0),
            balance_a_gauge      : 0x2::balance::zero<T0>(),
            balance_b_gauge      : 0x2::balance::zero<T1>(),
            balance_a_recipients : 0x2::balance::zero<T0>(),
            balance_b_recipients : 0x2::balance::zero<T1>(),
            stable               : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>(),
            gauge_active         : false,
        }
    }

    public(friend) fun set_gauge_active<T0, T1, T2>(arg0: &mut FeeVault<T0, T1, T2>, arg1: bool) {
        arg0.gauge_active = arg1;
    }

    // decompiled from Move bytecode v6
}

