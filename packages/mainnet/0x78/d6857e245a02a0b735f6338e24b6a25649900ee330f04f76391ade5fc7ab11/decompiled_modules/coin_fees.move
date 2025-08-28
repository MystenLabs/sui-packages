module 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees {
    struct CoinFeeConfiguration has copy, drop, store {
        buy_fee_split_bps: u64,
        sell_fee_split_bps: u64,
        buy_fee_mode: u8,
        sell_fee_mode: u8,
    }

    struct CoinFeeConfig has store {
        buy_fee_split_bps: u64,
        sell_fee_split_bps: u64,
        buy_fee_mode: u8,
        sell_fee_mode: u8,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        is_br_coin: bool,
    }

    public fun add_fee_config(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: bool) {
        assert!(arg4 <= 1, 3);
        assert!(arg5 <= 1, 3);
        let v0 = CoinFeeConfig{
            buy_fee_split_bps  : arg2,
            sell_fee_split_bps : arg3,
            buy_fee_mode       : arg4,
            sell_fee_mode      : arg5,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            creator            : arg1,
            is_br_coin         : arg6,
        };
        0x2::dynamic_field::add<vector<u8>, CoinFeeConfig>(arg0, b"fee_config", v0);
    }

    public(friend) fun collect_coin_fee(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<0x2::sui::SUI>) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            return 0
        };
        0x2::balance::join<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, CoinFeeConfig>(arg0, b"fee_config").treasury, arg1);
        0x2::balance::value<0x2::sui::SUI>(&arg1)
    }

    public fun create_default_fee_config() : CoinFeeConfiguration {
        CoinFeeConfiguration{
            buy_fee_split_bps  : 5000,
            sell_fee_split_bps : 5000,
            buy_fee_mode       : 0,
            sell_fee_mode      : 1,
        }
    }

    public fun create_fee_config(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : CoinFeeConfiguration {
        assert!(arg2 <= 1, 3);
        assert!(arg3 <= 1, 3);
        CoinFeeConfiguration{
            buy_fee_split_bps  : arg0,
            sell_fee_split_bps : arg1,
            buy_fee_mode       : arg2,
            sell_fee_mode      : arg3,
        }
    }

    public fun get_buy_fee_mode(arg0: &0x2::object::UID) : u8 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            return 0
        };
        0x2::dynamic_field::borrow<vector<u8>, CoinFeeConfig>(arg0, b"fee_config").buy_fee_mode
    }

    public fun get_buy_fee_split_bps(arg0: &0x2::object::UID) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            return 0
        };
        0x2::dynamic_field::borrow<vector<u8>, CoinFeeConfig>(arg0, b"fee_config").buy_fee_split_bps
    }

    public fun get_config_buy_fee_mode(arg0: &CoinFeeConfiguration) : u8 {
        arg0.buy_fee_mode
    }

    public fun get_config_buy_fee_split_bps(arg0: &CoinFeeConfiguration) : u64 {
        arg0.buy_fee_split_bps
    }

    public fun get_config_sell_fee_mode(arg0: &CoinFeeConfiguration) : u8 {
        arg0.sell_fee_mode
    }

    public fun get_config_sell_fee_split_bps(arg0: &CoinFeeConfiguration) : u64 {
        arg0.sell_fee_split_bps
    }

    public fun get_sell_fee_mode(arg0: &0x2::object::UID) : u8 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            return 0
        };
        0x2::dynamic_field::borrow<vector<u8>, CoinFeeConfig>(arg0, b"fee_config").sell_fee_mode
    }

    public fun get_sell_fee_split_bps(arg0: &0x2::object::UID) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            return 0
        };
        0x2::dynamic_field::borrow<vector<u8>, CoinFeeConfig>(arg0, b"fee_config").sell_fee_split_bps
    }

    public fun get_treasury_balance_for_creator(arg0: &0x2::object::UID, arg1: address) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            return 0
        };
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, CoinFeeConfig>(arg0, b"fee_config");
        if (v0.creator == arg1) {
            0x2::balance::value<0x2::sui::SUI>(&v0.treasury)
        } else {
            0
        }
    }

    public(friend) fun release_treasury_to_creator(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : (address, u64) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(arg0, b"fee_config")) {
            return (@0x0, 0)
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, CoinFeeConfig>(arg0, b"fee_config");
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.treasury);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.treasury), arg1), v0.creator);
            (v0.creator, v1)
        } else {
            (v0.creator, 0)
        }
    }

    // decompiled from Move bytecode v6
}

