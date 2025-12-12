module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::set_unlock<T0>(arg0, arg5);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::gt(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

