module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::presale {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCap has key {
        id: 0x2::object::UID,
        user_presale_info: 0x2::table::Table<address, PresaleInfo>,
        vim_balance: 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>,
        dao: address,
        deployer: address,
        claim_countdown: u64,
        lp_usdt_amount: u64,
        lp_vim_amount: u64,
        presale_start_time: u64,
        presale_end_time: u64,
        presale_start_claim_time: u64,
        total_presale_amount: u64,
        presale_price: u64,
        presale_min_amount_per_account: u64,
        presale_max_amount_per_account: u64,
    }

    struct PresaleInfo has drop, store {
        presale_amount: u64,
        claim_amount: u64,
        is_white_list: bool,
    }

    struct PayToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
    }

    struct QueryPresaleInfo has copy, drop {
        claim_countdown: u64,
        presale_start_time: u64,
        presale_end_time: u64,
        presale_start_claim_time: u64,
        total_presale_amount: u64,
        presale_price: u64,
        presale_min_amount_per_account: u64,
        presale_max_amount_per_account: u64,
        user_presale_amount: u64,
        user_claim_amount: u64,
        user_pending_amount: u64,
        user_left_claim_timestamp: u64,
        user_is_white_list: bool,
    }

    public entry fun presale<T0>(arg0: &mut TreasuryCap, arg1: u64, arg2: &PayToken<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(arg0.presale_start_time > 0 && v1 >= arg0.presale_start_time, 5);
        assert!(arg0.presale_end_time > 0 && v1 < arg0.presale_end_time, 5);
        assert!(arg1 >= arg0.presale_min_amount_per_account && arg1 <= arg0.presale_max_amount_per_account, 6);
        let v2 = arg1 * 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::pow(10, arg2.decimals) * arg0.presale_price;
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 7);
        if (0x2::table::contains<address, PresaleInfo>(&arg0.user_presale_info, v0)) {
            let v3 = 0x2::table::borrow_mut<address, PresaleInfo>(&mut arg0.user_presale_info, v0);
            let v4 = v3.presale_amount;
            if (v3.is_white_list) {
                v4 = v3.presale_amount / 10;
            };
            assert!(arg1 + v4 / 1000000 <= arg0.presale_max_amount_per_account, 6);
            if (v3.is_white_list) {
                arg1 = arg1 * 10;
            };
            v3.presale_amount = v3.presale_amount + arg1 * 1000000;
        } else {
            let v5 = PresaleInfo{
                presale_amount : arg1 * 1000000,
                claim_amount   : 0,
                is_white_list  : false,
            };
            0x2::table::add<address, PresaleInfo>(&mut arg0.user_presale_info, v0, v5);
        };
        arg0.total_presale_amount = arg0.total_presale_amount + arg1 * 1000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2, arg5), arg0.deployer);
        reture_back_or_delete<T0>(arg3, arg5);
    }

    public entry fun claim(arg0: &mut TreasuryCap, arg1: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.presale_start_claim_time > 0 && 0x2::clock::timestamp_ms(arg3) / 1000 >= arg0.presale_start_claim_time, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, PresaleInfo>(&arg0.user_presale_info, v0), 4);
        let v1 = user_pending_amount(arg0, arg3, v0);
        assert!(v1 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg0.vim_balance, v1), arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::mint_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg1, v1), arg4), arg0.dao);
        let v2 = 0x2::table::borrow_mut<address, PresaleInfo>(&mut arg0.user_presale_info, v0);
        v2.claim_amount = v2.claim_amount + v1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = TreasuryCap{
            id                             : 0x2::object::new(arg0),
            user_presale_info              : 0x2::table::new<address, PresaleInfo>(arg0),
            vim_balance                    : 0x2::balance::zero<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(),
            dao                            : v0,
            deployer                       : v0,
            claim_countdown                : 2592000,
            lp_usdt_amount                 : 100000 * 1000000,
            lp_vim_amount                  : 6250 * 1000000,
            presale_start_time             : 0,
            presale_end_time               : 0,
            presale_start_claim_time       : 0,
            total_presale_amount           : 0,
            presale_price                  : 8,
            presale_min_amount_per_account : 10,
            presale_max_amount_per_account : 500,
        };
        0x2::transfer::share_object<TreasuryCap>(v2);
    }

    public entry fun lp_mint(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.presale_end_time > 0 && 0x2::clock::timestamp_ms(arg4) / 1000 >= arg1.presale_end_time, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg1.vim_balance, arg1.lp_vim_amount), arg5), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::mint_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg2, arg1.lp_vim_amount), arg5), arg1.dao);
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::mint_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg1, arg3), arg4), arg2);
    }

    public entry fun mint_balance<T0>(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury, arg3: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::DepoisitToken<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&arg1.vim_balance) == 0, 0);
        assert!(arg1.presale_end_time > 0 && 0x2::clock::timestamp_ms(arg6) / 1000 >= arg1.presale_end_time, 5);
        0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut arg1.vim_balance, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::deposit<T0>(arg2, arg3, arg4, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_u64((arg1.total_presale_amount + arg1.lp_vim_amount) / 1000000, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::pow(10, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::decimals<T0>(arg3))), 0, arg5, arg7));
    }

    public fun query_presale_info(arg0: &TreasuryCap, arg1: &0x2::clock::Clock, arg2: address) : QueryPresaleInfo {
        let v0 = QueryPresaleInfo{
            claim_countdown                : arg0.claim_countdown,
            presale_start_time             : arg0.presale_start_time,
            presale_end_time               : arg0.presale_end_time,
            presale_start_claim_time       : arg0.presale_start_claim_time,
            total_presale_amount           : arg0.total_presale_amount,
            presale_price                  : arg0.presale_price,
            presale_min_amount_per_account : arg0.presale_min_amount_per_account,
            presale_max_amount_per_account : arg0.presale_max_amount_per_account,
            user_presale_amount            : 0,
            user_claim_amount              : 0,
            user_pending_amount            : 0,
            user_left_claim_timestamp      : 0,
            user_is_white_list             : false,
        };
        if (0x2::table::contains<address, PresaleInfo>(&arg0.user_presale_info, arg2)) {
            let v1 = 0x2::table::borrow<address, PresaleInfo>(&arg0.user_presale_info, arg2);
            v0.user_presale_amount = v1.presale_amount;
            v0.user_claim_amount = v1.claim_amount;
            v0.user_is_white_list = v1.is_white_list;
            if (v0.user_is_white_list) {
                v0.presale_max_amount_per_account = v0.presale_max_amount_per_account * 10;
            };
            let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
            if (arg0.presale_end_time > 0 && v2 >= arg0.presale_end_time && arg0.presale_start_claim_time > 0) {
                if (v2 < arg0.presale_start_claim_time) {
                    v0.user_pending_amount = v0.user_presale_amount * 5 / 100;
                    v0.user_left_claim_timestamp = arg0.presale_start_claim_time - v2;
                } else {
                    let v3 = 5;
                    let v4 = v3;
                    let v5 = (v2 - arg0.presale_start_claim_time) / arg0.claim_countdown;
                    if (v5 >= 1 && v5 < 12) {
                        v4 = v3 + 8 * v5;
                    } else if (v5 >= 12) {
                        v4 = 100;
                    };
                    v0.user_pending_amount = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(v1.presale_amount * v4 / 100, v1.claim_amount);
                    if (v0.user_pending_amount == 0 && v5 < 12) {
                        let v6 = v5 + 1;
                        let v7 = arg0.presale_start_claim_time + arg0.claim_countdown * v6;
                        if (v7 > v2) {
                            v0.user_left_claim_timestamp = v7 - v2;
                        };
                        if (v6 < 12) {
                            v0.user_pending_amount = v1.presale_amount * 8 / 100;
                        } else {
                            v0.user_pending_amount = v1.presale_amount * 7 / 100;
                        };
                    };
                };
            };
        };
        v0
    }

    fun reture_back_or_delete<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun set_claim_countdown(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: u64) {
        arg1.claim_countdown = arg2;
    }

    public entry fun set_dao(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: address) {
        arg1.dao = arg2;
    }

    public entry fun set_deployer(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: address) {
        arg1.deployer = arg2;
    }

    public entry fun set_lp_amount(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: u64, arg3: u64) {
        arg1.lp_usdt_amount = arg2;
        arg1.lp_vim_amount = arg3;
    }

    public entry fun set_pay_token<T0>(arg0: &AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PayToken<T0>{
            id       : 0x2::object::new(arg2),
            decimals : 0x2::coin::get_decimals<T0>(arg1),
        };
        0x2::transfer::share_object<PayToken<T0>>(v0);
    }

    public entry fun set_presale_amount_per_account(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: u64, arg3: u64) {
        arg1.presale_min_amount_per_account = arg2;
        arg1.presale_max_amount_per_account = arg3;
    }

    public entry fun set_presale_price(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: u64) {
        arg1.presale_price = arg2;
    }

    public entry fun set_presale_time(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: u64, arg3: u64, arg4: u64) {
        arg1.presale_start_time = arg2;
        arg1.presale_end_time = arg3;
        arg1.presale_start_claim_time = arg4;
    }

    public entry fun set_whitelist(arg0: &AdminCap, arg1: &mut TreasuryCap, arg2: address, arg3: bool) {
        if (arg3) {
            if (0x2::table::contains<address, PresaleInfo>(&arg1.user_presale_info, arg2)) {
                0x2::table::borrow_mut<address, PresaleInfo>(&mut arg1.user_presale_info, arg2).is_white_list = true;
            } else {
                let v0 = PresaleInfo{
                    presale_amount : 0,
                    claim_amount   : 0,
                    is_white_list  : true,
                };
                0x2::table::add<address, PresaleInfo>(&mut arg1.user_presale_info, arg2, v0);
            };
        } else {
            assert!(0x2::table::contains<address, PresaleInfo>(&arg1.user_presale_info, arg2), 4);
            0x2::table::borrow_mut<address, PresaleInfo>(&mut arg1.user_presale_info, arg2).is_white_list = false;
        };
    }

    public fun user_pending_amount(arg0: &TreasuryCap, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.presale_start_claim_time == 0 || arg0.presale_start_claim_time > v0) {
            return 0
        };
        if (!0x2::table::contains<address, PresaleInfo>(&arg0.user_presale_info, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, PresaleInfo>(&arg0.user_presale_info, arg2);
        let v2 = 5;
        let v3 = v2;
        let v4 = (v0 - arg0.presale_start_claim_time) / arg0.claim_countdown;
        if (v4 >= 1 && v4 < 12) {
            v3 = v2 + 8 * v4;
        } else if (v4 >= 12) {
            v3 = 100;
        };
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(v1.presale_amount * v3 / 100, v1.claim_amount)
    }

    // decompiled from Move bytecode v6
}

