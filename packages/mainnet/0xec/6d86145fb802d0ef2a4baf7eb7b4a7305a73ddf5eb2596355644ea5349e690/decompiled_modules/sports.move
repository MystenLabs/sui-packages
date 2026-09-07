module 0xec6d86145fb802d0ef2a4baf7eb7b4a7305a73ddf5eb2596355644ea5349e690::sports {
    struct SettlementCap has key {
        id: 0x2::object::UID,
    }

    struct OracleConfig has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    struct RevenueConfig has key {
        id: 0x2::object::UID,
        recipient: address,
        fee_bps: u64,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        event_id: vector<u8>,
        event_name: vector<u8>,
        home_team: vector<u8>,
        away_team: vector<u8>,
        league_name: vector<u8>,
        sport_name: vector<u8>,
        market_type: vector<u8>,
        prediction: u8,
        odds_bps: u64,
        taker_stake_required: u64,
        match_start_ms: u64,
        expires_at_ms: u64,
        maker_stake: 0x2::balance::Balance<T0>,
        taker_stake: 0x2::balance::Balance<T0>,
        taker: address,
        status: u8,
    }

    struct OfferCreatedEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
        match_start_ms: u64,
        expires_at_ms: u64,
        maker_stake: u64,
        taker_stake: u64,
        odds_bps: u64,
    }

    struct OfferAcceptedEvent has copy, drop {
        offer_id: 0x2::object::ID,
        taker: address,
        taker_stake: u64,
    }

    struct OfferSettledEvent has copy, drop {
        offer_id: 0x2::object::ID,
        winner: address,
        outcome: u8,
        payout: u64,
        fee: u64,
    }

    struct OracleKeyChangeEvent has copy, drop {
        old_key: vector<u8>,
        new_key: vector<u8>,
    }

    struct RevenueEvent has copy, drop {
        offer_id: 0x2::object::ID,
        recipient: address,
        fee_bps: u64,
        fee: u64,
    }

    struct OfferCancelledEvent has copy, drop {
        offer_id: 0x2::object::ID,
        creator: address,
    }

    struct OfferExpiredEvent has copy, drop {
        offer_id: 0x2::object::ID,
        caller: address,
    }

    public entry fun accept_offer<T0>(arg0: &mut Offer<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 0, 4);
        assert!(v0 < arg0.expires_at_ms, 5);
        assert!(v0 < arg0.match_start_ms, 6);
        assert!(v1 != arg0.creator, 7);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.taker_stake_required, 8);
        0x2::balance::join<T0>(&mut arg0.taker_stake, 0x2::coin::into_balance<T0>(arg1));
        arg0.taker = v1;
        arg0.status = 1;
        let v2 = OfferAcceptedEvent{
            offer_id    : 0x2::object::uid_to_inner(&arg0.id),
            taker       : v1,
            taker_stake : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<OfferAcceptedEvent>(v2);
    }

    public entry fun cancel_offer<T0>(arg0: Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 9);
        let Offer {
            id                   : v0,
            creator              : v1,
            event_id             : _,
            event_name           : _,
            home_team            : _,
            away_team            : _,
            league_name          : _,
            sport_name           : _,
            market_type          : _,
            prediction           : _,
            odds_bps             : _,
            taker_stake_required : _,
            match_start_ms       : _,
            expires_at_ms        : _,
            maker_stake          : v14,
            taker_stake          : v15,
            taker                : _,
            status               : _,
        } = arg0;
        let v18 = v0;
        0x2::balance::destroy_zero<T0>(v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg1), v1);
        0x2::object::delete(v18);
        let v19 = OfferCancelledEvent{
            offer_id : 0x2::object::uid_to_inner(&v18),
            creator  : v1,
        };
        0x2::event::emit<OfferCancelledEvent>(v19);
    }

    public entry fun create_offer<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::coin::Coin<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::coin::value<T0>(&arg12);
        assert!(v1 > 0 && arg11 > 0, 0);
        let v2 = if (arg9 > v0) {
            if (arg10 > v0) {
                arg10 <= arg9
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        assert!(arg7 <= 2, 3);
        assert!(arg8 >= 10000 && arg8 <= 100000, 2);
        let v3 = 0x2::tx_context::sender(arg14);
        let v4 = Offer<T0>{
            id                   : 0x2::object::new(arg14),
            creator              : v3,
            event_id             : arg0,
            event_name           : arg1,
            home_team            : arg2,
            away_team            : arg3,
            league_name          : arg4,
            sport_name           : arg5,
            market_type          : arg6,
            prediction           : arg7,
            odds_bps             : arg8,
            taker_stake_required : arg11,
            match_start_ms       : arg9,
            expires_at_ms        : arg10,
            maker_stake          : 0x2::coin::into_balance<T0>(arg12),
            taker_stake          : 0x2::balance::zero<T0>(),
            taker                : @0x0,
            status               : 0,
        };
        let v5 = OfferCreatedEvent{
            offer_id       : 0x2::object::uid_to_inner(&v4.id),
            creator        : v3,
            match_start_ms : arg9,
            expires_at_ms  : arg10,
            maker_stake    : v1,
            taker_stake    : arg11,
            odds_bps       : arg8,
        };
        0x2::event::emit<OfferCreatedEvent>(v5);
        0x2::transfer::share_object<Offer<T0>>(v4);
    }

    public entry fun expire_offer<T0>(arg0: Offer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 5);
        let Offer {
            id                   : v0,
            creator              : v1,
            event_id             : _,
            event_name           : _,
            home_team            : _,
            away_team            : _,
            league_name          : _,
            sport_name           : _,
            market_type          : _,
            prediction           : _,
            odds_bps             : _,
            taker_stake_required : _,
            match_start_ms       : _,
            expires_at_ms        : _,
            maker_stake          : v14,
            taker_stake          : v15,
            taker                : _,
            status               : _,
        } = arg0;
        let v18 = v0;
        0x2::balance::destroy_zero<T0>(v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg2), v1);
        0x2::object::delete(v18);
        let v19 = OfferExpiredEvent{
            offer_id : 0x2::object::uid_to_inner(&v18),
            caller   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OfferExpiredEvent>(v19);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SettlementCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SettlementCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OracleConfig{
            id         : 0x2::object::new(arg0),
            public_key : b"",
        };
        0x2::transfer::share_object<OracleConfig>(v1);
        let v2 = RevenueConfig{
            id        : 0x2::object::new(arg0),
            recipient : @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4,
            fee_bps   : 250,
        };
        0x2::transfer::share_object<RevenueConfig>(v2);
    }

    public entry fun set_oracle_public_key(arg0: &mut OracleConfig, arg1: vector<u8>, arg2: &SettlementCap) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13);
        arg0.public_key = arg1;
        let v0 = OracleKeyChangeEvent{
            old_key : arg0.public_key,
            new_key : arg0.public_key,
        };
        0x2::event::emit<OracleKeyChangeEvent>(v0);
    }

    public entry fun settle_offer<T0>(arg0: Offer<T0>, arg1: u8, arg2: vector<u8>, arg3: &OracleConfig, arg4: &RevenueConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 10);
        assert!(arg1 <= 2, 11);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg0.match_start_ms, 6);
        assert!(arg4.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg4.fee_bps == 250, 14);
        assert!(0x1::vector::length<u8>(&arg3.public_key) == 32 && 0x1::vector::length<u8>(&arg2) == 64, 12);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = b"JASON_SPORTS_SETTLEMENT_V1";
        0x1::vector::append<u8>(&mut v1, 0x2::object::id_to_bytes(&v0));
        0x1::vector::push_back<u8>(&mut v1, arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.match_start_ms));
        let v2 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg3.public_key, &v2), 12);
        let Offer {
            id                   : v3,
            creator              : v4,
            event_id             : _,
            event_name           : _,
            home_team            : _,
            away_team            : _,
            league_name          : _,
            sport_name           : _,
            market_type          : _,
            prediction           : v12,
            odds_bps             : _,
            taker_stake_required : _,
            match_start_ms       : _,
            expires_at_ms        : _,
            maker_stake          : v17,
            taker_stake          : v18,
            taker                : v19,
            status               : _,
        } = arg0;
        let v21 = v17;
        let v22 = v3;
        let v23 = 0x2::object::uid_to_inner(&v22);
        0x2::balance::join<T0>(&mut v21, v18);
        let v24 = 0x2::balance::value<T0>(&v21);
        let v25 = v24 * arg4.fee_bps / 10000;
        assert!(v25 > 0 && v25 < v24, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v21, v25), arg6), arg4.recipient);
        let v26 = if (v12 == arg1) {
            v4
        } else {
            v19
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg6), v26);
        0x2::object::delete(v22);
        let v27 = OfferSettledEvent{
            offer_id : v23,
            winner   : v26,
            outcome  : arg1,
            payout   : v24 - v25,
            fee      : v25,
        };
        0x2::event::emit<OfferSettledEvent>(v27);
        let v28 = RevenueEvent{
            offer_id  : v23,
            recipient : arg4.recipient,
            fee_bps   : arg4.fee_bps,
            fee       : v25,
        };
        0x2::event::emit<RevenueEvent>(v28);
    }

    // decompiled from Move bytecode v7
}

