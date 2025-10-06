module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::tidal {
    struct Holders has store, key {
        id: 0x2::object::UID,
        accounts: vector<address>,
        shares: vector<u256>,
        expires: vector<u256>,
    }

    struct Rates has store, key {
        id: 0x2::object::UID,
        values: vector<u256>,
    }

    entry fun buy(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg4), 13906834805703573503);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg2);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg1)));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::add_coins_to_balance(arg2, arg1);
        assert!(v0 >= 1000000000, 13906834840063311871);
        assert!(v0 <= 1000000000000, 13906834844358279167);
        let v1 = calculate_buy_rate(arg2);
        let v2 = v0 / v1;
        let v3 = calculate_account_expiry(v0, arg0, arg2, arg3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg2, arg0, local_expire_timestamp(), v3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_local_value(arg2, arg0, local_exchange_shares(), v2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg2, global_exchange_shares(), v2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::mint_tokens(arg0, v0, arg2, arg4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_admin(arg2, v0 * 20 / 1000, arg4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle::add_coins_to_next(v0 * 30 / 1000, arg2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle::add_tokens_to_next(v0, arg2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg2, global_exchange_coins(), v0 * 950 / 1000);
        update_holders(arg0, true, arg2);
        update_rates(arg2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::tidal_bought(arg0, v0, v1, v2, v0);
    }

    fun calculate_account_expiry(arg0: u256, arg1: address, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg2, arg1, local_expire_timestamp());
        let v1 = v0 + arg0 / 1000000;
        let v2 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg3) + 28800000;
        let v3 = if (v0 == 0) {
            true
        } else if (0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg2, arg1, local_exchange_shares()) == 0) {
            true
        } else {
            v1 >= v2
        };
        if (v3) {
            v2
        } else if (v0 <= 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg3)) {
            v0
        } else {
            v1
        }
    }

    fun calculate_buy_rate(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) : u256 {
        let v0 = calculate_exchange_rate(arg0);
        let v1 = if (v0 >= 10000) {
            v0 + 500
        } else {
            v0 + 500 + (10000 - v0) * 100 / 1000
        };
        v1 * 1000 / 950
    }

    fun calculate_exchange_rate(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) : u256 {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg0, global_exchange_shares());
        let v1 = if (v0 > 0) {
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg0, global_exchange_coins()) / v0
        } else {
            10000
        };
        if (v1 > 20000) {
            20000
        } else {
            v1
        }
    }

    fun calculate_expiry_rate(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) : u256 {
        calculate_exchange_rate(arg0) * 950 / 1000
    }

    fun calculate_sell_rate(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) : u256 {
        calculate_exchange_rate(arg0) * 990 / 1000
    }

    entry fun expire(arg0: address, arg1: address, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg4), 13906835179365728255);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg2);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg2, arg1, local_exchange_shares());
        assert!(v0 > 0, 13906835200840564735);
        assert!(0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg2, arg1, local_expire_timestamp()) < 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg3), 13906835218020433919);
        let v1 = calculate_expiry_rate(arg2);
        let v2 = v0 * v1;
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg2, arg1, local_exchange_shares(), 0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg2, global_exchange_shares(), v0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg2, global_exchange_coins(), v2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_account(arg2, arg1, v2, arg4);
        update_holders(arg1, false, arg2);
        update_rates(arg2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::tidal_sold(arg1, v0, v1, v2);
    }

    fun global_buy_rate() : 0x1::string::String {
        0x1::string::utf8(b"tidal_buy_rate")
    }

    fun global_exchange_coins() : 0x1::string::String {
        0x1::string::utf8(b"tidal_exchange_coins")
    }

    fun global_exchange_rate() : 0x1::string::String {
        0x1::string::utf8(b"tidal_exchange_rate")
    }

    fun global_exchange_shares() : 0x1::string::String {
        0x1::string::utf8(b"tidal_exchange_shares")
    }

    fun global_expiry_rate() : 0x1::string::String {
        0x1::string::utf8(b"tidal_expiry_rate")
    }

    fun global_sell_rate() : 0x1::string::String {
        0x1::string::utf8(b"tidal_sell_rate")
    }

    fun holders_bag_index() : 0x1::string::String {
        0x1::string::utf8(b"tidal_holders")
    }

    fun local_exchange_shares() : 0x1::string::String {
        0x1::string::utf8(b"tidal_exchange_shares")
    }

    fun local_expire_timestamp() : 0x1::string::String {
        0x1::string::utf8(b"tidal_expire_timestamp")
    }

    fun rates_bag_index() : 0x1::string::String {
        0x1::string::utf8(b"tidal_rates")
    }

    entry fun sell(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906835037631807487);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg1, arg0, local_exchange_shares());
        assert!(v0 > 0, 13906835059106643967);
        let v1 = calculate_sell_rate(arg1);
        let v2 = v0 * v1;
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg1, arg0, local_exchange_shares(), 0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg1, global_exchange_shares(), v0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg1, global_exchange_coins(), v2);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_account(arg1, arg0, v2, arg2);
        update_holders(arg0, false, arg1);
        update_rates(arg1);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::tidal_sold(arg0, v0, v1, v2);
    }

    entry fun setup(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906834410566582271);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg1, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        if (!0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::has_value(arg1, holders_bag_index())) {
            let v0 = Holders{
                id       : 0x2::object::new(arg2),
                accounts : vector[],
                shares   : vector[],
                expires  : vector[],
            };
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::add_value<Holders>(arg1, holders_bag_index(), v0);
        };
        if (!0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::has_value(arg1, rates_bag_index())) {
            let v1 = Rates{
                id     : 0x2::object::new(arg2),
                values : vector[],
            };
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::add_value<Rates>(arg1, rates_bag_index(), v1);
        };
    }

    fun update_holders(arg0: address, arg1: bool, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Holders>(arg2, holders_bag_index());
        let (v1, v2) = 0x1::vector::index_of<address>(&v0.accounts, &arg0);
        if (v1) {
            0x1::vector::swap_remove<address>(&mut v0.accounts, v2);
            0x1::vector::swap_remove<u256>(&mut v0.shares, v2);
            0x1::vector::swap_remove<u256>(&mut v0.expires, v2);
        };
        if (arg1) {
            assert!(0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x1::vector::length<address>(&v0.accounts)) < 1000, 13906835415588929535);
            0x1::vector::push_back<address>(&mut v0.accounts, arg0);
            0x1::vector::push_back<u256>(&mut v0.shares, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg2, arg0, local_exchange_shares()));
            0x1::vector::push_back<u256>(&mut v0.expires, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg2, arg0, local_expire_timestamp()));
        };
    }

    fun update_rates(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) {
        let v0 = calculate_exchange_rate(arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg0, global_exchange_rate(), v0);
        let v1 = calculate_buy_rate(arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg0, global_buy_rate(), v1);
        let v2 = calculate_sell_rate(arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg0, global_sell_rate(), v2);
        let v3 = calculate_expiry_rate(arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg0, global_expiry_rate(), v3);
        let v4 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Rates>(arg0, rates_bag_index());
        if (0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x1::vector::length<u256>(&v4.values)) >= 20) {
            0x1::vector::remove<u256>(&mut v4.values, 0);
        };
        0x1::vector::push_back<u256>(&mut v4.values, v0);
    }

    entry fun win(arg0: address, arg1: u256, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg6), 13906834526530699263);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg3);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg2)));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::add_coins_to_balance(arg3, arg2);
        assert!(v0 >= 1000000000, 13906834560890437631);
        assert!(v0 <= 1000000000000, 13906834565185404927);
        assert!(arg1 <= 1, 13906834578070306815);
        let v1 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::get_random(arg3, arg5, arg6);
        let v2 = v1;
        if (arg1 == 0) {
            v2 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_max() - v1;
        };
        let v3 = v0 * v2 * 190 / 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_max() * 1000000;
        let v4 = calculate_account_expiry(v0, arg0, arg3, arg4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg3, arg0, local_expire_timestamp(), v4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_local_value(arg3, arg0, local_exchange_shares(), v3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg3, global_exchange_shares(), v3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::mint_tokens(arg0, v0, arg3, arg6);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_admin(arg3, v0 * 20 / 1000, arg6);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle::add_coins_to_next(v0 * 30 / 1000, arg3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle::add_tokens_to_next(v0, arg3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg3, global_exchange_coins(), v0 * 950 / 1000);
        update_holders(arg0, true, arg3);
        update_rates(arg3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::tidal_won(arg0, v0, arg1, v1, v3, v0);
    }

    // decompiled from Move bytecode v6
}

