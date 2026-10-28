module 0x8531dda24e3a97a234b8bb18a770cd0cfba76fbd79a4c1eaba54ef0f2e18ab0::practice {
    struct Position has copy, drop, store {
        symbol: vector<u8>,
        units: u64,
        cost: u64,
    }

    struct Account has key {
        id: 0x2::object::UID,
        guardian: address,
        learner: address,
        attestor: vector<u8>,
        cash: u64,
        positions: vector<Position>,
        per_trade: u64,
        daily: u64,
        paused: bool,
        allowed: vector<vector<u8>>,
        revision: u64,
        sequence: u64,
        day_spent: u64,
        spend_day: u64,
        approval: vector<u8>,
    }

    struct Quote has copy, drop, store {
        domain: vector<u8>,
        package_id: address,
        account: address,
        symbol: vector<u8>,
        buy: bool,
        requested: u64,
        amount: u64,
        units: u64,
        price: u64,
        expires_at: u64,
        revision: u64,
        sequence: u64,
        market_day: u64,
        snapshot: vector<u8>,
        commitment: vector<u8>,
        nonce: vector<u8>,
    }

    struct Created has copy, drop {
        account: address,
        guardian: address,
        learner: address,
    }

    struct EnrollmentTerms has copy, drop {
        domain: vector<u8>,
        package_id: address,
        account: address,
        guardian: address,
        learner: address,
        expires_at: u64,
        nonce: vector<u8>,
    }

    struct LearnerEnrolled has copy, drop {
        account: address,
        learner: address,
        sequence: u64,
    }

    struct PolicyChanged has copy, drop {
        account: address,
        revision: u64,
        per_trade: u64,
        daily: u64,
        paused: bool,
    }

    struct FundingKey has copy, drop, store {
        id: vector<u8>,
    }

    struct Funded has copy, drop {
        account: address,
        id: vector<u8>,
        amount: u64,
        cash: u64,
        sequence: u64,
    }

    struct ApprovalGranted has copy, drop {
        account: address,
        quote_hash: vector<u8>,
    }

    struct Executed has copy, drop {
        account: address,
        nonce: vector<u8>,
        symbol: vector<u8>,
        buy: bool,
        amount: u64,
        units: u64,
        price: u64,
        sequence: u64,
        revision: u64,
        cash: u64,
        day_spent: u64,
        spend_day: u64,
        commitment: vector<u8>,
        snapshot: vector<u8>,
    }

    struct CorporateKey has copy, drop, store {
        event_id: vector<u8>,
    }

    struct CorporateTerms has copy, drop, store {
        domain: vector<u8>,
        package_id: address,
        account: address,
        event_id: vector<u8>,
        symbol: vector<u8>,
        kind: u8,
        effective_day: u64,
        numerator: u64,
        denominator: u64,
        dividend: u64,
        price: u64,
        units_before: u64,
        sequence: u64,
        revision: u64,
        from_snapshot: vector<u8>,
        to_snapshot: vector<u8>,
        expires_at: u64,
    }

    struct CorporateApplied has copy, drop {
        account: address,
        event_id: vector<u8>,
        symbol: vector<u8>,
        kind: u8,
        effective_day: u64,
        units_before: u64,
        units_after: u64,
        cash_delta: u64,
        cost_released: u64,
        sequence: u64,
        from_snapshot: vector<u8>,
        to_snapshot: vector<u8>,
    }

    public fun adjust(arg0: &mut Account, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: u64, arg15: vector<u8>, arg16: &0x2::clock::Clock) {
        let v0 = CorporateKey{event_id: arg1};
        assert!(!0x2::dynamic_field::exists<CorporateKey>(&arg0.id, v0), 7);
        let v1 = 0x2::clock::timestamp_ms(arg16);
        let v2 = if (0x1::vector::length<u8>(&arg1) == 32) {
            if (0x1::vector::length<u8>(&arg12) == 32) {
                if (0x1::vector::length<u8>(&arg13) == 32) {
                    arg12 != arg13
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        let v3 = if (arg3 <= 1) {
            if (arg4 <= v1 / 86400000) {
                if (arg14 > v1) {
                    arg14 <= v1 + 120000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 3);
        let v4 = if (arg10 == arg0.sequence) {
            if (arg11 == arg0.revision) {
                if (arg5 > 0) {
                    if (arg6 > 0) {
                        if (arg5 <= 1000000000) {
                            if (arg6 <= 1000000000) {
                                arg8 > 0
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
            }
        } else {
            false
        };
        assert!(v4, 3);
        let v5 = CorporateTerms{
            domain        : b"trove:corporate:v1",
            package_id    : 0x1::type_name::original_id<Account>(),
            account       : 0x2::object::id_address<Account>(arg0),
            event_id      : arg1,
            symbol        : arg2,
            kind          : arg3,
            effective_day : arg4,
            numerator     : arg5,
            denominator   : arg6,
            dividend      : arg7,
            price         : arg8,
            units_before  : arg9,
            sequence      : arg10,
            revision      : arg11,
            from_snapshot : arg12,
            to_snapshot   : arg13,
            expires_at    : arg14,
        };
        let v6 = 0x1::bcs::to_bytes<CorporateTerms>(&v5);
        assert!(0x2::ed25519::ed25519_verify(&arg15, &arg0.attestor, &v6), 6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<Position>(&arg0.positions) && 0x1::vector::borrow<Position>(&arg0.positions, v7).symbol != arg2) {
            v7 = v7 + 1;
        };
        let v8 = if (v7 < 0x1::vector::length<Position>(&arg0.positions)) {
            if (arg9 > 0) {
                0x1::vector::borrow<Position>(&arg0.positions, v7).units == arg9
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 4);
        let v9 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v7);
        let (v10, v11) = if (arg3 == 0) {
            assert!(arg7 == 0, 3);
            let v12 = (arg9 as u128) * (arg5 as u128);
            let v13 = v12 % (arg6 as u128);
            v9.units = ((v12 / (arg6 as u128)) as u64);
            let v14 = (((v9.cost as u128) * v13 / v12) as u64);
            v9.cost = v9.cost - v14;
            (((v13 * (arg8 as u128) / (arg6 as u128) * 100000000) as u64), v14)
        } else {
            let v15 = if (arg5 == 1) {
                if (arg6 == 1) {
                    arg7 > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v15, 3);
            ((((arg9 as u128) * (arg7 as u128) / 100000000) as u64), 0)
        };
        arg0.cash = arg0.cash + v10;
        arg0.sequence = arg0.sequence + 1;
        arg0.approval = b"";
        0x2::dynamic_field::add<CorporateKey, bool>(&mut arg0.id, v0, true);
        let v16 = CorporateApplied{
            account       : 0x2::object::id_address<Account>(arg0),
            event_id      : arg1,
            symbol        : arg2,
            kind          : arg3,
            effective_day : arg4,
            units_before  : arg9,
            units_after   : v9.units,
            cash_delta    : v10,
            cost_released : v11,
            sequence      : arg0.sequence,
            from_snapshot : arg12,
            to_snapshot   : arg13,
        };
        0x2::event::emit<CorporateApplied>(v16);
    }

    public fun approve(arg0: &mut Account, arg1: vector<u8>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::clock::Clock, arg16: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg16) == arg0.guardian, 1);
        let v0 = quote(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        validate(arg0, &v0, &arg14, arg15);
        let v1 = 0x1::bcs::to_bytes<Quote>(&v0);
        arg0.approval = 0x2::hash::blake2b256(&v1);
        let v2 = ApprovalGranted{
            account    : 0x2::object::id_address<Account>(arg0),
            quote_hash : arg0.approval,
        };
        0x2::event::emit<ApprovalGranted>(v2);
    }

    public fun create(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        create_with_funds(arg0, arg1, arg2, arg3, arg4, 1000000000, false, arg5);
    }

    fun create_account(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        let v0 = if (arg2 > 0) {
            if (arg3 >= arg2) {
                if (0x1::vector::length<vector<u8>>(&arg4) > 0) {
                    0x1::vector::length<vector<u8>>(&arg4) <= 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg5 >= 10000 && arg5 <= 1000000000000000, 4);
        let v1 = Account{
            id        : 0x2::object::new(arg7),
            guardian  : 0x2::tx_context::sender(arg7),
            learner   : arg0,
            attestor  : arg1,
            cash      : arg5,
            positions : 0x1::vector::empty<Position>(),
            per_trade : arg2,
            daily     : arg3,
            paused    : arg6,
            allowed   : arg4,
            revision  : 0,
            sequence  : 0,
            day_spent : 0,
            spend_day : 0,
            approval  : b"",
        };
        let v2 = Created{
            account  : 0x2::object::id_address<Account>(&v1),
            guardian : v1.guardian,
            learner  : arg0,
        };
        0x2::event::emit<Created>(v2);
        0x2::transfer::share_object<Account>(v1);
    }

    public fun create_family(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        create_account(@0x0, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_with_funds(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0x2::tx_context::sender(arg7) && arg0 != @0x0, 1);
        create_account(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun enroll(arg0: &mut Account, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (arg0.learner == @0x0) {
            if (v0 != @0x0) {
                v0 != arg0.guardian
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = if (arg1 > v2) {
            if (arg1 <= v2 + 120000) {
                0x1::vector::length<u8>(&arg2) == 16
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 3);
        let v4 = EnrollmentTerms{
            domain     : b"trove:enrollment:v1",
            package_id : 0x1::type_name::original_id<Account>(),
            account    : 0x2::object::id_address<Account>(arg0),
            guardian   : arg0.guardian,
            learner    : v0,
            expires_at : arg1,
            nonce      : arg2,
        };
        let v5 = 0x1::bcs::to_bytes<EnrollmentTerms>(&v4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.attestor, &v5), 6);
        arg0.learner = v0;
        arg0.sequence = arg0.sequence + 1;
        arg0.approval = b"";
        let v6 = LearnerEnrolled{
            account  : 0x2::object::id_address<Account>(arg0),
            learner  : v0,
            sequence : arg0.sequence,
        };
        0x2::event::emit<LearnerEnrolled>(v6);
    }

    public fun execute(arg0: &mut Account, arg1: vector<u8>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::clock::Clock, arg16: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg16) == arg0.learner, 1);
        let v0 = quote(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        validate(arg0, &v0, &arg14, arg15);
        let v1 = 0x2::clock::timestamp_ms(arg15) / 86400000;
        if (arg0.spend_day != v1) {
            arg0.day_spent = 0;
            arg0.spend_day = v1;
        };
        if (arg2 && (arg3 > arg0.per_trade || arg0.day_spent + arg4 > arg0.daily)) {
            let v2 = 0x1::bcs::to_bytes<Quote>(&v0);
            assert!(arg0.approval == 0x2::hash::blake2b256(&v2), 5);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<Position>(&arg0.positions) && 0x1::vector::borrow<Position>(&arg0.positions, v3).symbol != v0.symbol) {
            v3 = v3 + 1;
        };
        if (arg2) {
            assert!(arg0.cash >= arg4, 4);
            arg0.cash = arg0.cash - arg4;
            arg0.day_spent = arg0.day_spent + arg4;
            if (v3 == 0x1::vector::length<Position>(&arg0.positions)) {
                let v4 = Position{
                    symbol : v0.symbol,
                    units  : 0,
                    cost   : 0,
                };
                0x1::vector::push_back<Position>(&mut arg0.positions, v4);
            };
            let v5 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v3);
            v5.units = v5.units + arg5;
            v5.cost = v5.cost + arg4;
        } else {
            assert!(v3 < 0x1::vector::length<Position>(&arg0.positions), 4);
            let v6 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v3);
            assert!(v6.units >= arg5, 4);
            v6.units = v6.units - arg5;
            v6.cost = v6.cost - (((v6.cost as u128) * (arg5 as u128) / (v6.units as u128)) as u64);
            arg0.cash = arg0.cash + arg4;
        };
        arg0.approval = b"";
        arg0.sequence = arg0.sequence + 1;
        let v7 = Executed{
            account    : 0x2::object::id_address<Account>(arg0),
            nonce      : v0.nonce,
            symbol     : v0.symbol,
            buy        : arg2,
            amount     : arg4,
            units      : arg5,
            price      : arg6,
            sequence   : arg0.sequence,
            revision   : arg0.revision,
            cash       : arg0.cash,
            day_spent  : arg0.day_spent,
            spend_day  : arg0.spend_day,
            commitment : v0.commitment,
            snapshot   : v0.snapshot,
        };
        0x2::event::emit<Executed>(v7);
    }

    public fun fund(arg0: &mut Account, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.guardian, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 16 && arg3 == arg0.sequence, 3);
        let v0 = FundingKey{id: arg1};
        assert!(!0x2::dynamic_field::exists<FundingKey>(&arg0.id, v0), 7);
        let v1 = if (arg2 >= 10000) {
            if (arg2 <= 1000000000000) {
                (arg0.cash as u128) + (arg2 as u128) <= 1000000000000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
        arg0.cash = arg0.cash + arg2;
        arg0.sequence = arg0.sequence + 1;
        arg0.approval = b"";
        0x2::dynamic_field::add<FundingKey, bool>(&mut arg0.id, v0, true);
        let v2 = Funded{
            account  : 0x2::object::id_address<Account>(arg0),
            id       : arg1,
            amount   : arg2,
            cash     : arg0.cash,
            sequence : arg0.sequence,
        };
        0x2::event::emit<Funded>(v2);
    }

    public fun policy(arg0: &mut Account, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.guardian, 1);
        assert!(arg1 > 0 && arg2 >= arg1, 2);
        arg0.per_trade = arg1;
        arg0.daily = arg2;
        arg0.paused = arg3;
        arg0.revision = arg0.revision + 1;
        arg0.approval = b"";
        let v0 = PolicyChanged{
            account   : 0x2::object::id_address<Account>(arg0),
            revision  : arg0.revision,
            per_trade : arg1,
            daily     : arg2,
            paused    : arg3,
        };
        0x2::event::emit<PolicyChanged>(v0);
    }

    fun quote(arg0: &Account, arg1: vector<u8>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>) : Quote {
        Quote{
            domain     : b"trove:practice:v1",
            package_id : 0x1::type_name::original_id<Account>(),
            account    : 0x2::object::id_address<Account>(arg0),
            symbol     : arg1,
            buy        : arg2,
            requested  : arg3,
            amount     : arg4,
            units      : arg5,
            price      : arg6,
            expires_at : arg7,
            revision   : arg8,
            sequence   : arg9,
            market_day : arg10,
            snapshot   : arg11,
            commitment : arg12,
            nonce      : arg13,
        }
    }

    fun validate(arg0: &Account, arg1: &Quote, arg2: &vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(!arg0.paused && 0x1::vector::contains<vector<u8>>(&arg0.allowed, &arg1.symbol), 2);
        let v1 = if (arg1.expires_at > v0) {
            if (arg1.expires_at <= v0 + 120000) {
                if (arg1.revision == arg0.revision) {
                    arg1.sequence == arg0.sequence
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        assert!(arg1.market_day <= v0 / 86400000 && v0 / 86400000 - arg1.market_day <= 5, 3);
        let v2 = if (arg1.units > 0) {
            if (arg1.price > 0) {
                if (arg1.requested > 0) {
                    if (0x1::vector::length<u8>(&arg1.snapshot) == 32) {
                        if (0x1::vector::length<u8>(&arg1.commitment) == 32) {
                            0x1::vector::length<u8>(&arg1.nonce) == 16
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
        assert!(v2, 3);
        let v3 = if (arg1.buy) {
            ((arg1.units as u128) * (arg1.price as u128) + 100000000 - 1) / 100000000
        } else {
            (arg1.units as u128) * (arg1.price as u128) / 100000000
        };
        assert!(v3 == (arg1.amount as u128) && arg1.amount <= arg1.requested, 3);
        assert!((arg1.units as u128) == (arg1.requested as u128) * 100000000 / (arg1.price as u128), 3);
        let v4 = 0x1::bcs::to_bytes<Quote>(arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.attestor, &v4), 6);
    }

    // decompiled from Move bytecode v7
}

