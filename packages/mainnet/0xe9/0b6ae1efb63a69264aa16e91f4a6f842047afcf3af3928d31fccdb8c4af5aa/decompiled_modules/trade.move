module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade {
    struct OrderIntent has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        user: address,
        key_epoch: u64,
        instrument: u256,
        is_buy: bool,
        amount: u64,
        total_price: u64,
        min_fill: u64,
        reduce_only: bool,
        trigger_price: u64,
        trigger_above: bool,
        max_fee_bps: u64,
        parent_nonce: u64,
        created_at_ms: u64,
        expiry_ms: u64,
        nonce: u64,
    }

    struct CancelIntent has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        user: address,
        key_epoch: u64,
        nonce: u64,
        at_ms: u64,
    }

    struct Traded has copy, drop {
        instrument: u256,
        buyer: address,
        seller: address,
        amount: u64,
        total_price: u64,
        buyer_is_maker: bool,
        fee: u64,
        buy_nonce: u64,
        sell_nonce: u64,
        lent: u64,
    }

    public(friend) fun fill<T0>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: u256, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg9: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>) : u64 {
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, arg1)));
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>();
        let (v2, v3) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::apply_fill(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument_mut<T0>(arg0, arg1), arg2, arg3, arg4, arg5, v0 == v1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::track_position<T0>(arg0, arg2, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::has_position(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, arg1), arg2), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::has_position(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, arg1), arg2));
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::track_position<T0>(arg0, arg3, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::has_position(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, arg1), arg3), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::has_position(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, arg1), arg3));
        let v4 = 0;
        let v5 = if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg9)) {
            if (v0 == v1) {
                v3 > arg5
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::margin_enabled(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg3)), 416);
            v4 = v3 - arg5;
        };
        let (v6, v7) = if (v0 == v1) {
            (v2, 0)
        } else {
            (0, v2)
        };
        let (v8, v9) = if (v0 == v1) {
            (v3 - v4, 0)
        } else {
            (0, v3 - v4)
        };
        let v10 = arg5 + arg6;
        let v11 = v8 + arg7;
        if (v6 >= v10) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, arg2, v6 - v10);
        };
        if (arg5 >= v11) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, arg3, arg5 - v11);
        };
        if (v4 > 0) {
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::lend<T0>(arg0, arg3, v4) <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_debt_after(0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg9)), 418);
        };
        if (v6 < v10) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, arg2, v1, v10 - v6);
        };
        if (arg5 < v11) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, arg3, v1, v11 - arg5);
        };
        if (v7 > 0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_coin<T0>(arg0, arg2, v0, v7);
        };
        if (v9 > 0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, arg3, v0, v9);
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::add_fee<T0>(arg0, arg6 + arg7);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::bump<T0>(arg0, arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::bump<T0>(arg0, arg3);
        if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg8)) {
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg2)) <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_debt_after(0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg8)), 418);
        };
        if (v4 > 0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_house_limit<T0>(arg0);
        };
        v4
    }

    public fun cancel_intent(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) : CancelIntent {
        CancelIntent{
            domain    : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::cancel_domain(),
            exchange  : arg0,
            user      : arg1,
            key_epoch : arg2,
            nonce     : arg3,
            at_ms     : arg4,
        }
    }

    public fun cancel_signed<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: CancelIntent, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator_cap<T0>(arg1, arg0);
        assert!(arg2.domain == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::cancel_domain(), 420);
        assert!(arg2.exchange == 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg1), 401);
        assert!(arg2.nonce != 0, 432);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg2.at_ms <= v0 + 5000 && v0 <= arg2.at_ms + 604800000, 429);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::signer_key<T0>(arg1, arg2.user);
        let v2 = 0x2::bcs::to_bytes<CancelIntent>(&arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v1, &v2), 400);
        assert!(arg2.key_epoch == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::key_epoch(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg1, arg2.user)), 423);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cancel_for<T0>(arg1, arg2.user, arg2.nonce);
    }

    public(friend) fun check_fee_cap<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent) {
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::taker_fee_bps<T0>(arg0) <= arg1.max_fee_bps, 424);
    }

    fun check_life(arg0: &OrderIntent, arg1: u64) {
        assert!(arg1 < arg0.expiry_ms, 407);
        assert!(arg0.expiry_ms <= arg1 + 31622400000, 408);
        assert!(arg0.created_at_ms <= arg1 + 5000, 430);
        assert!((arg0.expiry_ms as u128) <= (arg0.created_at_ms as u128) + (31622400000 as u128), 408);
    }

    public(friend) fun check_parent<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: u64) {
        check_parent_nonce<T0>(arg0, arg1.user, arg1.key_epoch, arg1.nonce, arg1.instrument, arg1.parent_nonce, arg2);
    }

    public(friend) fun check_parent_nonce<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u256, arg5: u64, arg6: u64) {
        if (arg5 == 0) {
            return
        };
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1);
        assert!(arg5 != arg3, 426);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::nonce_key_epoch(v0, arg5);
        assert!(0x1::option::is_none<u64>(&v1) || *0x1::option::borrow<u64>(&v1) == arg2, 431);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::filled(v0, arg5) == 0 || 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::nonce_instrument(v0, arg5) == arg4, 435);
        assert!((0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::children_filled(v0, arg5) as u128) + (arg6 as u128) <= (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::filled(v0, arg5) as u128), 426);
    }

    public(friend) fun check_risk<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval, arg2: address, arg3: u64, arg4: u256, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        check_risk_target<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_amount(arg1) == arg8 && 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_total_price(arg1) == arg9, 415);
    }

    public(friend) fun check_risk_target<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval, arg2: address, arg3: u64, arg4: u256, arg5: bool, arg6: bool, arg7: u64, arg8: u64) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_domain_of(arg1), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_exchange(arg1), 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0));
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_at_ms(arg1), arg8);
        let v0 = if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_user(arg1) == arg2) {
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_seq(arg1) == arg3) {
                if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_instrument(arg1) == arg4) {
                    if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_is_buy(arg1) == arg5) {
                        if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_is_maker(arg1) == arg6) {
                            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_nonce(arg1) == arg7
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 415);
    }

    public(friend) fun check_signed<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: &vector<u8>, arg3: u64) {
        verify_user<T0>(arg0, arg1, arg2);
        check_terms<T0>(arg0, arg1, arg3);
    }

    public(friend) fun check_terms<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: u64) {
        assert!(arg1.domain == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::order_domain(), 420);
        assert!(arg1.exchange == 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0), 401);
        assert!(arg1.key_epoch == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::key_epoch(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1.user)), 423);
        assert!(arg1.amount > 0, 409);
        assert!(arg1.nonce != 0, 432);
        check_life(arg1, arg2);
    }

    public(friend) fun cover_now<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: u64) : u64 {
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1.user);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::filled(v0, arg1.nonce);
        let v2 = if (v1 < arg1.amount) {
            arg1.amount - v1
        } else {
            0
        };
        let v3 = 0x1::u64::min(v2, arg2);
        let v4 = v3;
        if (arg1.parent_nonce != 0) {
            let v5 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::filled(v0, arg1.parent_nonce);
            let v6 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::children_filled(v0, arg1.parent_nonce);
            let v7 = if (v5 > v6) {
                v5 - v6
            } else {
                0
            };
            v4 = 0x1::u64::min(v3, v7);
        };
        v4
    }

    public(friend) fun digest(arg0: &OrderIntent) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<OrderIntent>(arg0);
        0x2::hash::blake2b256(&v0)
    }

    fun execute<T0>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: OrderIntent, arg2: OrderIntent, arg3: u64, arg4: bool, arg5: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>, arg6: vector<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg7: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0);
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::house<T0>(arg0);
        assert!(arg1.domain == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::order_domain() && arg2.domain == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::order_domain(), 420);
        assert!(arg1.exchange == v1 && arg2.exchange == v1, 401);
        assert!(arg1.is_buy && !arg2.is_buy, 402);
        assert!(arg1.instrument == arg2.instrument, 403);
        assert!(arg1.user != arg2.user, 406);
        let v3 = if (arg3 > 0) {
            if (arg1.amount > 0) {
                arg2.amount > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 409);
        assert!(arg1.nonce != 0 && arg2.nonce != 0, 432);
        check_life(&arg1, v0);
        check_life(&arg2, v0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_idle<T0>(arg0, arg1.user);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_idle<T0>(arg0, arg2.user);
        assert!(arg1.key_epoch == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::key_epoch(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1.user)) && arg2.key_epoch == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::key_epoch(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg2.user)), 423);
        if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::is_paused<T0>(arg0)) {
            assert!((arg1.reduce_only || arg1.user == v2) && (arg2.reduce_only || arg2.user == v2), 428);
        };
        let v4 = arg1.instrument;
        let v5 = *0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, v4));
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_closed(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, v4)), 404);
        assert!(v0 < 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::expiry_ms(&v5), 405);
        let v6 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::short_of(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, v4), arg1.user);
        let v7 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::long_of(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, v4), arg2.user);
        if (arg1.reduce_only) {
            assert!(arg3 <= v6, 414);
        };
        if (arg2.reduce_only) {
            assert!(arg3 <= v7, 414);
        };
        let v8 = 18446744073709551615;
        let v9 = if (arg1.reduce_only) {
            v6
        } else {
            v8
        };
        let v10 = if (arg2.reduce_only) {
            v7
        } else {
            v8
        };
        let v11 = if (arg4) {
            mul_div(arg1.total_price, arg3, arg1.amount, false)
        } else {
            mul_div(arg2.total_price, arg3, arg2.amount, true)
        };
        assert!((v11 as u128) * (arg1.amount as u128) <= (arg1.total_price as u128) * (arg3 as u128), 413);
        assert!((v11 as u128) * (arg2.amount as u128) >= (arg2.total_price as u128) * (arg3 as u128), 413);
        if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(&v5) == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>()) {
            assert!(v11 <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::lots_value(&v5, arg3), 422);
        };
        check_parent<T0>(arg0, &arg1, arg3);
        check_parent<T0>(arg0, &arg2, arg3);
        let v12 = 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>();
        let v13 = 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>();
        0x1::vector::reverse<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&mut arg6);
        let v14 = 0;
        while (v14 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg6)) {
            let v15 = 0x1::vector::pop_back<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&mut arg6);
            let v16 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::risk_user(&v15);
            assert!(v16 != v2, 419);
            if (v16 == arg1.user && 0x1::option::is_none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&v12)) {
                check_risk<T0>(arg0, &v15, arg1.user, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::seq(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1.user)), v4, true, arg4, arg1.nonce, arg3, v11, v0);
                0x1::option::fill<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&mut v12, v15);
            } else {
                assert!(v16 == arg2.user && 0x1::option::is_none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&v13), 415);
                check_risk<T0>(arg0, &v15, arg2.user, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::seq(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg2.user)), v4, false, !arg4, arg2.nonce, arg3, v11, v0);
                0x1::option::fill<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&mut v13, v15);
            };
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg6);
        let v17 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::is_risk_revoked<T0>(arg0);
        let v18 = if (arg1.user != v2) {
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1.user)) > 0) {
                let v19 = if (v17) {
                    if (arg1.reduce_only) {
                        arg2.user == v2
                    } else {
                        false
                    }
                } else {
                    false
                };
                !v19
            } else {
                false
            }
        } else {
            false
        };
        if (v18) {
            assert!(0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&v12), 427);
        };
        let v20 = if (arg2.user != v2) {
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg2.user)) > 0) {
                let v21 = if (v17) {
                    if (arg2.reduce_only) {
                        arg1.user == v2
                    } else {
                        false
                    }
                } else {
                    false
                };
                !v21
            } else {
                false
            }
        } else {
            false
        };
        if (v20) {
            assert!(0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&v13), 427);
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fill_nonce(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, arg1.user), arg1.nonce, digest(&arg1), v4, arg1.key_epoch, arg1.expiry_ms, arg1.amount, arg1.min_fill, arg3, v0, arg1.trigger_price != 0, trigger_now<T0>(arg0, &arg1, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::underlying(&v5), &arg5, v0, arg3, cover_now<T0>(arg0, &arg1, v9)));
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fill_nonce(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, arg2.user), arg2.nonce, digest(&arg2), v4, arg2.key_epoch, arg2.expiry_ms, arg2.amount, arg2.min_fill, arg3, v0, arg2.trigger_price != 0, trigger_now<T0>(arg0, &arg2, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::underlying(&v5), &arg5, v0, arg3, cover_now<T0>(arg0, &arg2, v10)));
        record_child<T0>(arg0, arg1.user, arg1.parent_nonce, arg3);
        record_child<T0>(arg0, arg2.user, arg2.parent_nonce, arg3);
        let v22 = if (arg4) {
            taker_fee<T0>(arg0, &arg2, v11)
        } else {
            taker_fee<T0>(arg0, &arg1, v11)
        };
        let (v23, v24) = if (arg4) {
            (0, v22)
        } else {
            (v22, 0)
        };
        let v25 = Traded{
            instrument     : v4,
            buyer          : arg1.user,
            seller         : arg2.user,
            amount         : arg3,
            total_price    : v11,
            buyer_is_maker : arg4,
            fee            : v22,
            buy_nonce      : arg1.nonce,
            sell_nonce     : arg2.nonce,
            lent           : fill<T0>(arg0, v4, arg1.user, arg2.user, arg3, v11, v23, v24, v12, v13),
        };
        0x2::event::emit<Traded>(v25);
    }

    public fun execute_trade<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: OrderIntent, arg3: vector<u8>, arg4: OrderIntent, arg5: vector<u8>, arg6: u64, arg7: bool, arg8: 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>, arg9: vector<u8>, arg10: vector<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        verify_user<T0>(arg1, &arg2, &arg3);
        verify_user<T0>(arg1, &arg4, &arg5);
        if (0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg8)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_price<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(arg1, 0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg8), &arg9);
        };
        assert!(0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg10) == 0x1::vector::length<vector<u8>>(&arg11), 415);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg10)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_risk<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(arg1, 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(&arg10, v0), 0x1::vector::borrow<vector<u8>>(&arg11, v0));
            v0 = v0 + 1;
        };
        execute<T0>(arg1, arg2, arg4, arg6, arg7, arg8, arg10, arg12);
    }

    public fun intent(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u256, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64) : OrderIntent {
        OrderIntent{
            domain        : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::order_domain(),
            exchange      : arg0,
            user          : arg1,
            key_epoch     : arg2,
            instrument    : arg3,
            is_buy        : arg4,
            amount        : arg5,
            total_price   : arg6,
            min_fill      : arg7,
            reduce_only   : arg8,
            trigger_price : arg9,
            trigger_above : arg10,
            max_fee_bps   : arg11,
            parent_nonce  : arg12,
            created_at_ms : arg13,
            expiry_ms     : arg14,
            nonce         : arg15,
        }
    }

    public fun intent_amount(arg0: &OrderIntent) : u64 {
        arg0.amount
    }

    public fun intent_created_at_ms(arg0: &OrderIntent) : u64 {
        arg0.created_at_ms
    }

    public fun intent_expiry_ms(arg0: &OrderIntent) : u64 {
        arg0.expiry_ms
    }

    public fun intent_instrument(arg0: &OrderIntent) : u256 {
        arg0.instrument
    }

    public fun intent_is_buy(arg0: &OrderIntent) : bool {
        arg0.is_buy
    }

    public fun intent_key_epoch(arg0: &OrderIntent) : u64 {
        arg0.key_epoch
    }

    public fun intent_max_fee_bps(arg0: &OrderIntent) : u64 {
        arg0.max_fee_bps
    }

    public fun intent_min_fill(arg0: &OrderIntent) : u64 {
        arg0.min_fill
    }

    public fun intent_nonce(arg0: &OrderIntent) : u64 {
        arg0.nonce
    }

    public fun intent_parent_nonce(arg0: &OrderIntent) : u64 {
        arg0.parent_nonce
    }

    public fun intent_reduce_only(arg0: &OrderIntent) : bool {
        arg0.reduce_only
    }

    public fun intent_total_price(arg0: &OrderIntent) : u64 {
        arg0.total_price
    }

    public fun intent_trigger_price(arg0: &OrderIntent) : u64 {
        arg0.trigger_price
    }

    public fun intent_user(arg0: &OrderIntent) : address {
        arg0.user
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = v0 / (arg2 as u128);
        let v2 = if (arg3 && v1 * (arg2 as u128) < v0) {
            v1 + 1
        } else {
            v1
        };
        assert!(v2 <= 18446744073709551615, 421);
        (v2 as u64)
    }

    public(friend) fun record_child<T0>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: address, arg2: u64, arg3: u64) {
        if (arg2 == 0 || arg3 == 0) {
            return
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::add_child_fill(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, arg1), arg2, arg3);
    }

    public(friend) fun taker_fee<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: u64) : u64 {
        check_fee_cap<T0>(arg0, arg1);
        mul_div(arg2, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::taker_fee_bps<T0>(arg0), 10000, false)
    }

    public(friend) fun trigger_now<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: u32, arg3: &0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>, arg4: u64, arg5: u64, arg6: u64) : 0x1::option::Option<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire> {
        if (arg1.trigger_price == 0) {
            return 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire>()
        };
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1.user);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fired_at_ms(v0, arg1.nonce);
        let (v2, v3) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fired_cover(v0, arg1.nonce);
        let v4 = if (v1 > 0) {
            if (arg4 <= v1 + 60000) {
                (v3 as u128) + (arg5 as u128) <= (v2 as u128)
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            return 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire>()
        };
        assert!(0x1::option::is_some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(arg3), 410);
        let v5 = 0x1::option::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(arg3);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_domain_of(v5), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_exchange(v5), 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0));
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_underlying(v5) == arg2, 411);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_at_ms(v5), arg4);
        let v6 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_at_ms(v5);
        assert!(v6 >= arg1.created_at_ms, 425);
        assert!(v6 > 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fired_proof_ms(v0, arg1.nonce), 433);
        if (arg1.parent_nonce != 0) {
            assert!(v6 >= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::last_fill_ms(v0, arg1.parent_nonce), 434);
        };
        let v7 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_price(v5);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_index_price(v7);
        assert!(arg1.trigger_above && v7 >= arg1.trigger_price || v7 <= arg1.trigger_price, 412);
        0x1::option::some<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Fire>(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::fire(0x1::u64::min(v6, arg4), v6, arg6))
    }

    fun verify_user<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: &OrderIntent, arg2: &vector<u8>) {
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::signer_key<T0>(arg0, arg1.user);
        let v1 = 0x2::bcs::to_bytes<OrderIntent>(arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, &v0, &v1), 400);
    }

    // decompiled from Move bytecode v7
}

