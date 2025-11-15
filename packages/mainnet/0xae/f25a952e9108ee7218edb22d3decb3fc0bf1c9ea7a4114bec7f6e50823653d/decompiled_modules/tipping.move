module 0xaef25a952e9108ee7218edb22d3decb3fc0bf1c9ea7a4114bec7f6e50823653d::tipping {
    struct FeeConfig has key {
        id: 0x2::object::UID,
        admin: address,
        threshold_sui: u64,
        threshold_usdc: u64,
        threshold_usdt: u64,
        threshold_weth: u64,
        threshold_cetus: u64,
        fixed_fee_sui: u64,
        fixed_fee_usdc: u64,
        fixed_fee_usdt: u64,
        fixed_fee_weth: u64,
        fixed_fee_cetus: u64,
    }

    struct TipEvent has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        fee_amount: u64,
        net_amount: u64,
        coin_type: 0x1::string::String,
        timestamp: u64,
        fee_type: 0x1::string::String,
    }

    struct ConfigUpdateEvent has copy, drop {
        admin: address,
        timestamp: u64,
        update_type: 0x1::string::String,
    }

    fun calculate_fee(arg0: &FeeConfig, arg1: u64, arg2: &vector<u8>) : (u64, 0x1::string::String) {
        let (v0, v1) = get_coin_config(arg0, arg2);
        if (arg1 < v0) {
            (v1, 0x1::string::utf8(b"fixed"))
        } else {
            (arg1 * 150 / 10000, 0x1::string::utf8(b"percentage"))
        }
    }

    fun contains_substring(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 > v0) {
            return false
        };
        let v2 = 0;
        while (v2 <= v0 - v1) {
            let v3 = 0;
            let v4 = true;
            while (v3 < v1) {
                if (*0x1::vector::borrow<u8>(arg0, v2 + v3) != *0x1::vector::borrow<u8>(arg1, v3)) {
                    v4 = false;
                    break
                };
                v3 = v3 + 1;
            };
            if (v4) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    fun get_coin_config(arg0: &FeeConfig, arg1: &vector<u8>) : (u64, u64) {
        let v0 = b"sui::SUI";
        if (contains_substring(arg1, &v0)) {
            (arg0.threshold_sui, arg0.fixed_fee_sui)
        } else {
            let v3 = b"usdc::USDC";
            if (contains_substring(arg1, &v3)) {
                (arg0.threshold_usdc, arg0.fixed_fee_usdc)
            } else {
                let v4 = b"coin::COIN";
                if (contains_substring(arg1, &v4)) {
                    (arg0.threshold_usdt, arg0.fixed_fee_usdt)
                } else {
                    let v5 = b"WETH";
                    if (contains_substring(arg1, &v5)) {
                        (arg0.threshold_weth, arg0.fixed_fee_weth)
                    } else {
                        let v6 = b"CETUS";
                        if (contains_substring(arg1, &v6)) {
                            (arg0.threshold_cetus, arg0.fixed_fee_cetus)
                        } else {
                            (arg0.threshold_usdc, arg0.fixed_fee_usdc)
                        }
                    }
                }
            }
        }
    }

    public fun get_config(arg0: &FeeConfig) : (address, u64, u64, u64, u64) {
        (arg0.admin, arg0.threshold_sui, arg0.threshold_usdc, arg0.fixed_fee_sui, arg0.fixed_fee_usdc)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfig{
            id              : 0x2::object::new(arg0),
            admin           : 0x2::tx_context::sender(arg0),
            threshold_sui   : 9500000000,
            threshold_usdc  : 17000000,
            threshold_usdt  : 17000000,
            threshold_weth  : 680000,
            threshold_cetus : 17000000000,
            fixed_fee_sui   : 139700000,
            fixed_fee_usdc  : 250000,
            fixed_fee_usdt  : 250000,
            fixed_fee_weth  : 10000,
            fixed_fee_cetus : 100000000,
        };
        0x2::transfer::share_object<FeeConfig>(v0);
    }

    public fun tip<T0>(arg0: &FeeConfig, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v2 = *0x1::string::as_bytes(&v1);
        let (v3, v4) = calculate_fee(arg0, v0, &v2);
        assert!(v0 > v3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v3, arg3), @0x242524d0967f2a7b6d8302e64472bb14be1f2d6d5550451ae0e52c13ee7a9c52);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        let v5 = TipEvent{
            sender     : 0x2::tx_context::sender(arg3),
            recipient  : arg2,
            amount     : v0,
            fee_amount : v3,
            net_amount : v0 - v3,
            coin_type  : v1,
            timestamp  : 0x2::tx_context::epoch(arg3),
            fee_type   : v4,
        };
        0x2::event::emit<TipEvent>(v5);
    }

    public fun transfer_admin(arg0: &mut FeeConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
        let v0 = ConfigUpdateEvent{
            admin       : 0x2::tx_context::sender(arg2),
            timestamp   : 0x2::tx_context::epoch(arg2),
            update_type : 0x1::string::utf8(b"admin_transferred"),
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public fun update_fixed_fees(arg0: &mut FeeConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1);
        arg0.fixed_fee_sui = arg1;
        arg0.fixed_fee_usdc = arg2;
        arg0.fixed_fee_usdt = arg3;
        arg0.fixed_fee_weth = arg4;
        arg0.fixed_fee_cetus = arg5;
        let v0 = ConfigUpdateEvent{
            admin       : 0x2::tx_context::sender(arg6),
            timestamp   : 0x2::tx_context::epoch(arg6),
            update_type : 0x1::string::utf8(b"fixed_fees_updated"),
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public fun update_thresholds(arg0: &mut FeeConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1);
        arg0.threshold_sui = arg1;
        arg0.threshold_usdc = arg2;
        arg0.threshold_usdt = arg3;
        arg0.threshold_weth = arg4;
        arg0.threshold_cetus = arg5;
        let v0 = ConfigUpdateEvent{
            admin       : 0x2::tx_context::sender(arg6),
            timestamp   : 0x2::tx_context::epoch(arg6),
            update_type : 0x1::string::utf8(b"thresholds_updated"),
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

