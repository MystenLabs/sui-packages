module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::spot {
    struct PairSpec has copy, drop, store {
        kind: u8,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        underlying: u32,
        venue: u32,
    }

    struct PairKey has copy, drop, store {
        id: u256,
    }

    struct DelistedPairKey has copy, drop, store {
        id: u256,
    }

    struct SpotReceipt<phantom T0, phantom T1> {
        exchange: 0x2::object::ID,
        user: address,
        pair: u256,
        is_buy: bool,
        nonce: u64,
        digest: vector<u8>,
        key_epoch: u64,
        expiry_ms: u64,
        amount: u64,
        total_price: u64,
        min_fill: u64,
        taken: u64,
        fee: u64,
        fee_bps: u64,
        triggered: bool,
        fire: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire>,
        taken_at_ms: u64,
        parent_nonce: u64,
        max_coins: u64,
        min_out: u64,
        index_price: u64,
        decimals: u8,
    }

    struct PairListed has copy, drop {
        pair: u256,
        spec: PairSpec,
    }

    struct PairDelisted has copy, drop {
        pair: u256,
    }

    struct SpotFilled has copy, drop {
        pair: u256,
        user: address,
        is_buy: bool,
        nonce: u64,
        coins: u64,
        cash: u64,
        fee: u64,
    }

    public fun base(arg0: &PairSpec) : 0x1::type_name::TypeName {
        arg0.base
    }

    fun check_debtor<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: address, arg2: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg3: &0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg4: u64) : u64 {
        if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1)) == 0) {
            return 0
        };
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_is_buy(arg2);
        let v1 = if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::is_risk_revoked<T0>(arg0)) {
            if (!v0) {
                if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_reduce_only(arg2)) {
                    0x1::option::is_none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return 0
        };
        assert!(0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg3), 614);
        let v2 = 0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg3);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::check_risk_target<T0>(arg0, v2, arg1, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::seq(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1)), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_instrument(arg2), v0, false, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_nonce(arg2), arg4);
        if (v0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_amount(v2)
        } else {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_total_price(v2)
        }
    }

    fun check_index<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg2: &PairSpec, arg3: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof, arg4: u64, arg5: u64, arg6: u64) : 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire> {
        let (_, v1) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::coin_info<T0>(arg0, arg2.base);
        assert!(arg2.underlying == v1, 622);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_domain_of(arg3), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_exchange(arg3), 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0));
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_underlying(arg3) == arg2.underlying, 617);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_market_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_at_ms(arg3), arg4);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_index_price(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_price(arg3));
        let v2 = 0x1::option::some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(*arg3);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::trigger_now<T0>(arg0, arg1, arg2.underlying, &v2, arg4, arg5, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::cover_now<T0>(arg0, arg1, arg6))
    }

    public fun delist_pair<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: u256) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        let v0 = PairKey{id: arg2};
        assert!(0x2::dynamic_field::exists<PairKey>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid<T0>(arg1), v0), 602);
        let v1 = PairKey{id: arg2};
        0x2::dynamic_field::remove<PairKey, PairSpec>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid_mut<T0>(arg1), v1);
        let v2 = DelistedPairKey{id: arg2};
        0x2::dynamic_field::add<DelistedPairKey, bool>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid_mut<T0>(arg1), v2, true);
        let v3 = PairDelisted{pair: arg2};
        0x2::event::emit<PairDelisted>(v3);
    }

    public fun finish<T0, T1, T2>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: SpotReceipt<T1, T2>, arg2: 0x2::coin::Coin<T2>, arg3: 0x2::coin::Coin<T1>) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_version<T0>(arg0);
        let SpotReceipt {
            exchange     : v0,
            user         : v1,
            pair         : v2,
            is_buy       : v3,
            nonce        : v4,
            digest       : v5,
            key_epoch    : v6,
            expiry_ms    : v7,
            amount       : v8,
            total_price  : v9,
            min_fill     : v10,
            taken        : v11,
            fee          : v12,
            fee_bps      : v13,
            triggered    : v14,
            fire         : v15,
            taken_at_ms  : v16,
            parent_nonce : v17,
            max_coins    : v18,
            min_out      : v19,
            index_price  : v20,
            decimals     : v21,
        } = arg1;
        assert!(v0 == 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0), 610);
        let v22 = pair<T0>(arg0, v2);
        let (v23, v24) = if (v3) {
            (v22.quote, v22.base)
        } else {
            (v22.base, v22.quote)
        };
        assert!(0x1::type_name::with_original_ids<T1>() == v23 && 0x1::type_name::with_original_ids<T2>() == v24, 616);
        let v25 = 0x2::coin::value<T2>(&arg2);
        let v26 = 0x2::coin::value<T1>(&arg3);
        assert!(v26 <= v11, 611);
        let v27 = v11 - v26;
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::vault_join<T0, T2>(arg0, arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::vault_join<T0, T1>(arg0, arg3);
        let (v28, v29, v30) = if (v3) {
            if (v25 == 0) {
                assert!(v27 == 0, 612);
            };
            assert!(v25 <= v18, 619);
            assert!(v25 >= v19, 620);
            assert!((v27 as u128) * pow10(v21) * (10000 as u128) <= (v20 as u128) * ((10000 as u128) + 300) * (v25 as u128), 618);
            let v31 = 0x1::u64::min(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::mul_div(v27, v13, 10000, false), v12);
            assert!(((v27 + v31) as u128) * (v8 as u128) <= (v9 as u128) * (v25 as u128), 608);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_coin<T0>(arg0, v1, 0x1::type_name::with_original_ids<T2>(), v25);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, v1, v26 + v12 - v31);
            (v25, v27 + v31, v31)
        } else {
            if (v27 == 0) {
                assert!(v25 == 0, 612);
            };
            assert!((v25 as u128) * pow10(v21) * (10000 as u128) >= (v20 as u128) * ((10000 as u128) - 300) * (v27 as u128), 618);
            let v32 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::mul_div(v25, v13, 10000, false);
            let v33 = v25 - v32;
            assert!((v33 as u128) * (v8 as u128) >= (v9 as u128) * (v27 as u128), 613);
            assert!(v33 >= v19, 620);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_coin<T0>(arg0, v1, 0x1::type_name::with_original_ids<T1>(), v26);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, v1, v33);
            (v27, v33, v32)
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::add_fee<T0>(arg0, v30);
        if (v28 > 0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::check_parent_nonce<T0>(arg0, v1, v6, v4, v2, v17, v28);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fill_nonce(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, v1), v4, v5, v2, v6, v7, v8, v10, v28, v16, v14, v15);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::record_child<T0>(arg0, v1, v17, v28);
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::clear_busy(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, v1));
        let v34 = SpotFilled{
            pair   : v2,
            user   : v1,
            is_buy : v3,
            nonce  : v4,
            coins  : v28,
            cash   : v29,
            fee    : v30,
        };
        0x2::event::emit<SpotFilled>(v34);
    }

    public fun is_delisted_pair<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: u256) : bool {
        let v0 = DelistedPairKey{id: arg1};
        0x2::dynamic_field::exists<DelistedPairKey>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid<T0>(arg0), v0)
    }

    public fun is_pair<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: u256) : bool {
        let v0 = PairKey{id: arg1};
        0x2::dynamic_field::exists<PairKey>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid<T0>(arg0), v0)
    }

    public fun kind(arg0: &PairSpec) : u8 {
        arg0.kind
    }

    fun left<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent) : u64 {
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_user(arg1));
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_nonce(arg1);
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::filled(v0, v1);
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::is_cancelled(v0, v1) && v2 < 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_amount(arg1), 606);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_amount(arg1) - v2
    }

    public fun list_pair<T0, T1>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: u32) : u256 {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_not_paused<T0>(arg1);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(v0 != 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>() && 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::is_allowed_coin<T0>(arg1, v0), 605);
        let (_, v2) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::coin_info<T0>(arg1, v0);
        assert!(v2 != 0, 621);
        let v3 = pair_spec(0, v0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>(), v2, arg2);
        let v4 = pair_id(&v3);
        let v5 = PairKey{id: v4};
        assert!(!0x2::dynamic_field::exists<PairKey>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid<T0>(arg1), v5), 601);
        let v6 = DelistedPairKey{id: v4};
        assert!(!0x2::dynamic_field::exists<DelistedPairKey>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid<T0>(arg1), v6), 623);
        let v7 = PairKey{id: v4};
        0x2::dynamic_field::add<PairKey, PairSpec>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid_mut<T0>(arg1), v7, v3);
        let v8 = PairListed{
            pair : v4,
            spec : v3,
        };
        0x2::event::emit<PairListed>(v8);
        v4
    }

    public fun pair<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: u256) : PairSpec {
        assert!(is_pair<T0>(arg0, arg1), 602);
        let v0 = PairKey{id: arg1};
        *0x2::dynamic_field::borrow<PairKey, PairSpec>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::uid<T0>(arg0), v0)
    }

    fun pair_for<T0, T1>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg2: u8) : PairSpec {
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_instrument(arg1);
        assert!(is_pair<T0>(arg0, v0), 602);
        let v1 = pair<T0>(arg0, v0);
        assert!(v1.kind == arg2, 603);
        assert!(v1.base == 0x1::type_name::with_original_ids<T1>() && v1.quote == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>(), 605);
        v1
    }

    public fun pair_id(arg0: &PairSpec) : u256 {
        let v0 = 0x2::bcs::to_bytes<PairSpec>(arg0);
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 32) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v1, v3) as u256);
            v3 = v3 + 1;
        };
        v2 & 452312848583266388373324160190187140051835877600158453279131187530910662655 | 114887463540149662646824336688307533573166312910440247132899321632851308314624
    }

    public fun pair_spec(arg0: u8, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u32, arg4: u32) : PairSpec {
        assert!(arg0 == 0, 600);
        PairSpec{
            kind       : arg0,
            base       : arg1,
            quote      : arg2,
            underlying : arg3,
            venue      : arg4,
        }
    }

    fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quote(arg0: &PairSpec) : 0x1::type_name::TypeName {
        arg0.quote
    }

    fun receipt<T0, T1, T2>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg2: u64, arg3: u64, arg4: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire>, arg5: u64, arg6: &PairSpec, arg7: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof, arg8: u64, arg9: u64) : SpotReceipt<T1, T2> {
        let (v0, _) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::coin_info<T0>(arg0, arg6.base);
        SpotReceipt<T1, T2>{
            exchange     : 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0),
            user         : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_user(arg1),
            pair         : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_instrument(arg1),
            is_buy       : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_is_buy(arg1),
            nonce        : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_nonce(arg1),
            digest       : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::digest(arg1),
            key_epoch    : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_key_epoch(arg1),
            expiry_ms    : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_expiry_ms(arg1),
            amount       : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_amount(arg1),
            total_price  : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_total_price(arg1),
            min_fill     : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_min_fill(arg1),
            taken        : arg2,
            fee          : arg3,
            fee_bps      : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::taker_fee_bps<T0>(arg0),
            triggered    : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_trigger_price(arg1) != 0,
            fire         : arg4,
            taken_at_ms  : arg5,
            parent_nonce : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_parent_nonce(arg1),
            max_coins    : arg8,
            min_out      : arg9,
            index_price  : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_price(arg7),
            decimals     : v0,
        }
    }

    public fun receipt_taken<T0, T1>(arg0: &SpotReceipt<T0, T1>) : u64 {
        arg0.taken
    }

    public fun receipt_user<T0, T1>(arg0: &SpotReceipt<T0, T1>) : address {
        arg0.user
    }

    public fun spot_kind() : u8 {
        0
    }

    public fun take_buy<T0, T1>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg3: vector<u8>, arg4: u64, arg5: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof, arg6: vector<u8>, arg7: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SpotReceipt<T0, T1>) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::check_signed<T0>(arg1, &arg2, &arg3, 0x2::clock::timestamp_ms(arg9));
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_price<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(arg1, &arg5, &arg6);
        if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg7)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_risk<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg1, 0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg7), &arg8);
        };
        take_buy_checked<T0, T1>(arg1, arg2, arg4, arg5, arg7, arg9, arg10)
    }

    fun take_buy_checked<T0, T1>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg2: u64, arg3: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof, arg4: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SpotReceipt<T0, T1>) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_not_paused<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_is_buy(&arg1), 604);
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_reduce_only(&arg1), 609);
        let v1 = pair_for<T0, T1>(arg0, &arg1, 0);
        assert!(arg2 > 0, 607);
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_user(&arg1);
        let v3 = left<T0>(arg0, &arg1);
        let v4 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::taker_fee<T0>(arg0, &arg1, arg2);
        assert!(arg2 + v4 <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::mul_div(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_total_price(&arg1), v3, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_amount(&arg1), false), 608);
        if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg4)) {
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_total_price(0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg4)) == arg2, 615);
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, v2, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>(), arg2 + v4);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_busy(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, v2));
        (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::vault_split<T0, T0>(arg0, arg2, arg6), receipt<T0, T0, T1>(arg0, &arg1, arg2, v4, check_index<T0>(arg0, &arg1, &v1, &arg3, v0, v3, 18446744073709551615), v0, &v1, &arg3, v3, check_debtor<T0>(arg0, v2, &arg1, &arg4, v0)))
    }

    public fun take_sell<T0, T1>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg3: vector<u8>, arg4: u64, arg5: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof, arg6: vector<u8>, arg7: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SpotReceipt<T1, T0>) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::check_signed<T0>(arg1, &arg2, &arg3, 0x2::clock::timestamp_ms(arg9));
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_price<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(arg1, &arg5, &arg6);
        if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg7)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_risk<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg1, 0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg7), &arg8);
        };
        take_sell_checked<T0, T1>(arg1, arg2, arg4, arg5, arg7, arg9, arg10)
    }

    fun take_sell_checked<T0, T1>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::OrderIntent, arg2: u64, arg3: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof, arg4: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SpotReceipt<T1, T0>) {
        if (!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_reduce_only(&arg1)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_not_paused<T0>(arg0);
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_is_buy(&arg1), 604);
        let v1 = pair_for<T0, T1>(arg0, &arg1, 0);
        assert!(arg2 > 0, 607);
        assert!(arg2 <= left<T0>(arg0, &arg1), 608);
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_user(&arg1);
        let v3 = if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::intent_reduce_only(&arg1)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v2), &v1.base)
        } else {
            18446744073709551615
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::check_parent<T0>(arg0, &arg1, arg2);
        if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg4)) {
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_amount(0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg4)) == arg2, 615);
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::check_fee_cap<T0>(arg0, &arg1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, v2, 0x1::type_name::with_original_ids<T1>(), arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_busy(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, v2));
        (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::vault_split<T0, T1>(arg0, arg2, arg6), receipt<T0, T1, T0>(arg0, &arg1, arg2, 0, check_index<T0>(arg0, &arg1, &v1, &arg3, v0, arg2, v3), v0, &v1, &arg3, 0, check_debtor<T0>(arg0, v2, &arg1, &arg4, v0)))
    }

    public fun underlying(arg0: &PairSpec) : u32 {
        arg0.underlying
    }

    public fun venue(arg0: &PairSpec) : u32 {
        arg0.venue
    }

    // decompiled from Move bytecode v7
}

