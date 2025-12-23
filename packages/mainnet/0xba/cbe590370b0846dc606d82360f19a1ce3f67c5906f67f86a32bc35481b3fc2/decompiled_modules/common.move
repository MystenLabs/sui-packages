module 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common {
    public(friend) fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    public(friend) fun convert_to_base_at_price(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::single_base(arg0) as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun convert_to_quote_at_price(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) / (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::single_base(arg0) as u128)) as u64)
    }

    public(friend) fun decode_order_id(arg0: u128) : (bool, u64, u64) {
        (arg0 >> 127 == 0, ((arg0 >> 64) as u64) & 9223372036854775807, ((arg0 & 18446744073709551615) as u64))
    }

    public(friend) fun ensure_multiple_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1 * arg1
    }

    public(friend) fun ensure_multiple_round_up(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 - 1) / arg1 * arg1
    }

    public(friend) fun get_available_base_balance(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
        if (v0 < 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::minimum_base_in_balance_manager(arg0)) {
            0
        } else {
            v0 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::minimum_base_in_balance_manager(arg0)
        }
    }

    public(friend) fun get_available_quote_balance(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        if (v0 < 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::minimum_quote_in_balance_manager(arg0)) {
            0
        } else {
            v0 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::minimum_quote_in_balance_manager(arg0)
        }
    }

    public fun get_best_ask(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : u64 {
        let (_, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v2;
        *0x1::vector::borrow<u64>(&v4, 0)
    }

    public fun get_best_bid(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v0;
        *0x1::vector::borrow<u64>(&v4, 0)
    }

    public fun get_best_prices(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v2;
        let v5 = v0;
        (*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v4, 0), 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun get_effective_quote(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg2 + convert_to_quote_at_price(arg0, arg1, arg3)
    }

    public fun get_full_order_book(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 18446744073709551615, arg1)
    }

    public fun get_pool_fees(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        (v0, v1)
    }

    public(friend) fun order_is_bid(arg0: u128) : bool {
        let (v0, _, _) = decode_order_id(arg0);
        v0
    }

    public(friend) fun order_price(arg0: u128) : u64 {
        let (_, v1, _) = decode_order_id(arg0);
        v1
    }

    // decompiled from Move bytecode v6
}

