module 0x62b62fe7b3b935588cd9468062e3e358e265e07c9e2ccfd43ab329b27738ad35::test {
    struct NaviTestInfo has copy, drop {
        usdc_collateral_value: u256,
        usdc_collateral_balance: u256,
        usdt_borrow_value: u256,
        usdt_borrow_balance: u256,
        health_borrow_value: u256,
        borrow_value_limit: u256,
        borrow_balance_limit: u256,
        avg_ltv: u256,
        avg_threshold: u256,
    }

    public entry fun get_account_info(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg1, arg2, 1, arg3);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg0, arg1, arg2, 2, arg3);
        let v2 = v0 * (700000 as u256) / (1000000 as u256);
        let v3 = if (v2 <= v1) {
            0
        } else {
            v2 - v1
        };
        let v4 = NaviTestInfo{
            usdc_collateral_value   : v0,
            usdc_collateral_balance : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, 1, arg3),
            usdt_borrow_value       : v1,
            usdt_borrow_balance     : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, 1, arg3),
            health_borrow_value     : v2,
            borrow_value_limit      : v3,
            borrow_balance_limit    : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v3, 1),
            avg_ltv                 : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::calculate_avg_ltv(arg0, arg1, arg2, arg3),
            avg_threshold           : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::calculate_avg_threshold(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<NaviTestInfo>(v4);
    }

    // decompiled from Move bytecode v6
}

