module 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::incentive_v3 {
    struct Incentive has key {
        id: 0x2::object::UID,
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::storage::Storage, arg2: &mut 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::incentive_v2::IncentiveV2, arg6: &mut Incentive, arg7: &0x2::object::ID) {
        abort 0
    }

    public fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::oracle::PriceOracle, arg2: &mut 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::storage::Storage, arg3: &mut 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::incentive_v2::IncentiveV2, arg7: &mut Incentive, arg8: &0x2::object::ID, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

