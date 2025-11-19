module 0xc814ab90018ced77c71381792dac7e598934b8c84dd15b2347b757e7f02a97dd::nut {
    struct NUT has drop {
        dummy_field: bool,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<NUT>,
    }

    struct FaucetConfig has store, key {
        id: 0x2::object::UID,
        is_open: bool,
        amount: u64,
        interval: u64,
    }

    struct UserClaim has store {
        last_claim_time: u64,
    }

    struct Faucet has store, key {
        id: 0x2::object::UID,
        user_claims: 0x2::table::Table<address, UserClaim>,
    }

    struct UserTipInfo has copy, store {
        total_received: u64,
        total_withdrawn: u64,
    }

    struct TipPool has store, key {
        id: 0x2::object::UID,
        total_tips: u64,
        withdraw_ratio: u64,
        user_tips: 0x2::table::Table<address, UserTipInfo>,
        tip_records: 0x2::table::Table<address, 0x2::table::Table<address, u64>>,
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<NUT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<NUT>(arg0) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<NUT>>(0x2::coin::split<NUT>(arg0, arg2, arg3), arg1);
    }

    public fun balance(arg0: &0x2::coin::Coin<NUT>) : u64 {
        0x2::coin::value<NUT>(arg0)
    }

    public entry fun burn_coin(arg0: &mut Cap, arg1: 0x2::coin::Coin<NUT>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<NUT>(&arg1) > 0, 1);
        0x2::coin::burn<NUT>(&mut arg0.cap, arg1);
    }

    public entry fun claim(arg0: &mut Faucet, arg1: &FaucetConfig, arg2: &mut Cap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.is_open, 3);
        let v2 = if (0x2::table::contains<address, UserClaim>(&arg0.user_claims, v0)) {
            0x2::table::borrow_mut<address, UserClaim>(&mut arg0.user_claims, v0)
        } else {
            let v3 = UserClaim{last_claim_time: 0};
            0x2::table::add<address, UserClaim>(&mut arg0.user_claims, v0, v3);
            0x2::table::borrow_mut<address, UserClaim>(&mut arg0.user_claims, v0)
        };
        assert!(v1 >= v2.last_claim_time + arg1.interval, 4);
        v2.last_claim_time = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<NUT>>(0x2::coin::mint<NUT>(&mut arg2.cap, arg1.amount, arg4), v0);
    }

    public fun get_last_claim_time(arg0: &Faucet, arg1: address) : (bool, u64) {
        if (0x2::table::contains<address, UserClaim>(&arg0.user_claims, arg1)) {
            (true, 0x2::table::borrow<address, UserClaim>(&arg0.user_claims, arg1).last_claim_time)
        } else {
            (false, 0)
        }
    }

    public fun get_tip_amount(arg0: &TipPool, arg1: address, arg2: address) : u64 {
        if (0x2::table::contains<address, 0x2::table::Table<address, u64>>(&arg0.tip_records, arg1)) {
            let v1 = 0x2::table::borrow<address, 0x2::table::Table<address, u64>>(&arg0.tip_records, arg1);
            if (0x2::table::contains<address, u64>(v1, arg2)) {
                *0x2::table::borrow<address, u64>(v1, arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_total_tips(arg0: &TipPool) : u64 {
        arg0.total_tips
    }

    public fun get_user_max_withdrawable(arg0: &TipPool, arg1: address) : u64 {
        if (0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, arg1)) {
            let v1 = 0x2::table::borrow<address, UserTipInfo>(&arg0.user_tips, arg1);
            let v2 = v1.total_received * arg0.withdraw_ratio / 10000;
            if (v2 > v1.total_withdrawn) {
                v2 - v1.total_withdrawn
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_user_tips(arg0: &TipPool, arg1: address) : u64 {
        if (0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, arg1)) {
            0x2::table::borrow<address, UserTipInfo>(&arg0.user_tips, arg1).total_received
        } else {
            0
        }
    }

    public fun get_user_unwithdrawn_tips(arg0: &TipPool, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, arg1)) {
            let v2 = 0x2::table::borrow<address, UserTipInfo>(&arg0.user_tips, arg1);
            (v2.total_received, v2.total_withdrawn)
        } else {
            (0, 0)
        }
    }

    public fun get_withdraw_ratio(arg0: &TipPool) : u64 {
        arg0.withdraw_ratio
    }

    public fun get_withdrawable_amount(arg0: &TipPool, arg1: address) : u64 {
        if (0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, arg1)) {
            let v1 = 0x2::table::borrow<address, UserTipInfo>(&arg0.user_tips, arg1);
            let v2 = v1.total_received * arg0.withdraw_ratio / 10000;
            if (v2 > v1.total_withdrawn) {
                v2 - v1.total_withdrawn
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_withdrawn_amount(arg0: &TipPool, arg1: address) : u64 {
        if (0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, arg1)) {
            0x2::table::borrow<address, UserTipInfo>(&arg0.user_tips, arg1).total_withdrawn
        } else {
            0
        }
    }

    fun init(arg0: NUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUT>(arg0, 6, b"NUT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NUT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<NUT>>(0x2::coin::mint<NUT>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = Cap{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::public_transfer<Cap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = FaucetConfig{
            id       : 0x2::object::new(arg1),
            is_open  : true,
            amount   : 5000000,
            interval : 86400000,
        };
        0x2::transfer::public_share_object<FaucetConfig>(v4);
        let v5 = Faucet{
            id          : 0x2::object::new(arg1),
            user_claims : 0x2::table::new<address, UserClaim>(arg1),
        };
        0x2::transfer::public_share_object<Faucet>(v5);
        let v6 = TipPool{
            id             : 0x2::object::new(arg1),
            total_tips     : 0,
            withdraw_ratio : 0,
            user_tips      : 0x2::table::new<address, UserTipInfo>(arg1),
            tip_records    : 0x2::table::new<address, 0x2::table::Table<address, u64>>(arg1),
        };
        0x2::transfer::public_share_object<TipPool>(v6);
    }

    public entry fun mint_coin(arg0: &mut Cap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NUT>>(0x2::coin::mint<NUT>(&mut arg0.cap, arg1, arg3), arg2);
    }

    public entry fun set_faucet_amount(arg0: &mut FaucetConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 5);
        assert!(arg1 > 0, 1);
        arg0.amount = arg1;
    }

    public entry fun set_faucet_interval(arg0: &mut FaucetConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 5);
        assert!(arg1 > 0, 1);
        arg0.interval = arg1;
    }

    public entry fun set_faucet_status(arg0: &mut FaucetConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 5);
        arg0.is_open = arg1;
    }

    public entry fun set_withdraw_ratio(arg0: &mut TipPool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 5);
        assert!(arg1 <= 10000, 6);
        arg0.withdraw_ratio = arg1;
    }

    public entry fun tip(arg0: &mut TipPool, arg1: &mut Cap, arg2: &mut 0x2::coin::Coin<NUT>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg4 > 0, 1);
        assert!(0x2::coin::value<NUT>(arg2) >= arg4, 2);
        0x2::coin::burn<NUT>(&mut arg1.cap, 0x2::coin::split<NUT>(arg2, arg4, arg5));
        arg0.total_tips = arg0.total_tips + arg4;
        if (0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, arg3)) {
            let v1 = 0x2::table::borrow_mut<address, UserTipInfo>(&mut arg0.user_tips, arg3);
            v1.total_received = v1.total_received + arg4;
        } else {
            let v2 = UserTipInfo{
                total_received  : arg4,
                total_withdrawn : 0,
            };
            0x2::table::add<address, UserTipInfo>(&mut arg0.user_tips, arg3, v2);
        };
        if (!0x2::table::contains<address, 0x2::table::Table<address, u64>>(&arg0.tip_records, v0)) {
            0x2::table::add<address, 0x2::table::Table<address, u64>>(&mut arg0.tip_records, v0, 0x2::table::new<address, u64>(arg5));
        };
        let v3 = 0x2::table::borrow_mut<address, 0x2::table::Table<address, u64>>(&mut arg0.tip_records, v0);
        if (0x2::table::contains<address, u64>(v3, arg3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(v3, arg3);
            *v4 = *v4 + arg4;
        } else {
            0x2::table::add<address, u64>(v3, arg3, arg4);
        };
    }

    public entry fun withdraw_tips(arg0: &mut TipPool, arg1: &mut Cap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.withdraw_ratio > 0, 8);
        assert!(0x2::table::contains<address, UserTipInfo>(&arg0.user_tips, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, UserTipInfo>(&mut arg0.user_tips, v0);
        assert!(v1.total_received > 0, 7);
        assert!(v1.total_withdrawn + arg2 <= v1.total_received * arg0.withdraw_ratio / 10000, 9);
        assert!(arg2 > 0, 1);
        v1.total_withdrawn = v1.total_withdrawn + arg2;
        arg0.total_tips = arg0.total_tips - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<NUT>>(0x2::coin::mint<NUT>(&mut arg1.cap, arg2, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

