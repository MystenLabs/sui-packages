module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin {
    struct TokenRegistry has key {
        id: 0x2::object::UID,
    }

    struct TokenKey has copy, drop, store {
        t: 0x1::ascii::String,
    }

    struct TokenCfg has copy, drop, store {
        tips: bool,
        tip_fee_bps: u64,
        tip_fee_cap: u64,
        tip_free_below: u64,
        claim_fee_bps: u64,
        claim_fee_floor: u64,
    }

    struct CoinGift<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        total: u64,
        per_claim: u64,
        max_claims: u64,
        claims: u64,
        expires_ms: u64,
        flags: u8,
        message: 0x1::string::String,
        claimed: 0x2::table::Table<address, bool>,
        active: bool,
    }

    struct CardKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinGiftCreated has copy, drop {
        gift_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        total: u64,
        per_claim: u64,
        max_claims: u64,
        flags: u8,
    }

    struct CoinGiftClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        claimer: address,
        amount: u64,
        fee: u64,
        claims: u64,
        remaining: u64,
    }

    struct CoinGiftReclaimed has copy, drop {
        gift_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        amount: u64,
    }

    struct TipCoinEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        tipper: address,
        creator: address,
        referrer: address,
        amount: u64,
        creator_amount: u64,
        referrer_amount: u64,
        fee_amount: u64,
        note: 0x1::string::String,
        anonymous: bool,
    }

    struct AnyFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun any_tip_fee_bps(arg0: &TokenRegistry) : u64 {
        let v0 = AnyFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AnyFeeKey>(&arg0.id, v0)) {
            let v2 = AnyFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<AnyFeeKey, u64>(&arg0.id, v2)
        } else {
            100
        }
    }

    public fun card<T0>(arg0: &CoinGift<T0>) : 0x1::string::String {
        let v0 = CardKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CardKey>(&arg0.id, v0)) {
            let v2 = CardKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CardKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            0x1::string::utf8(b"")
        }
    }

    entry fun claim<T0>(arg0: &mut CoinGift<T0>, arg1: &TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags == 0, 7);
        do_claim<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun claim_with_ticket<T0>(arg0: &mut CoinGift<T0>, arg1: &TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::verify_ticket(arg3, 0x2::object::id<CoinGift<T0>>(arg0), 0x2::tx_context::sender(arg7), arg4, arg5, 0x2::clock::timestamp_ms(arg6)), 8);
        do_claim<T0>(arg0, arg1, arg2, arg6, arg7);
    }

    public fun claims<T0>(arg0: &CoinGift<T0>) : u64 {
        arg0.claims
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0 && arg1 > 0, 1);
        assert!(arg3 <= 1 | 2, 10);
        let v1 = ((((v0 as u128) + (arg1 as u128) - 1) / (arg1 as u128)) as u64);
        let v2 = CoinGift<T0>{
            id         : 0x2::object::new(arg6),
            creator    : 0x2::tx_context::sender(arg6),
            balance    : 0x2::coin::into_balance<T0>(arg0),
            total      : v0,
            per_claim  : arg1,
            max_claims : v1,
            claims     : 0,
            expires_ms : arg2,
            flags      : arg3,
            message    : arg4,
            claimed    : 0x2::table::new<address, bool>(arg6),
            active     : true,
        };
        if (0x1::string::length(&arg5) > 0) {
            assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_blob_id(&arg5), 14);
            let v3 = CardKey{dummy_field: false};
            0x2::dynamic_field::add<CardKey, 0x1::string::String>(&mut v2.id, v3, arg5);
        };
        let v4 = 0x2::object::id<CoinGift<T0>>(&v2);
        let v5 = CoinGiftCreated{
            gift_id    : v4,
            coin_type  : tname<T0>(),
            creator    : v2.creator,
            total      : v0,
            per_claim  : arg1,
            max_claims : v1,
            flags      : arg3,
        };
        0x2::event::emit<CoinGiftCreated>(v5);
        0x2::transfer::share_object<CoinGift<T0>>(v2);
        v4
    }

    public fun create_registry(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    fun do_claim<T0>(arg0: &mut CoinGift<T0>, arg1: &TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg0.expires_ms == 0 || 0x2::clock::timestamp_ms(arg3) < arg0.expires_ms, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 4);
        assert!(0x2::balance::value<T0>(&arg0.balance) > 0, 5);
        let v1 = 0x2::tx_context::sponsor(arg4);
        let (v2, v3) = quote_claim<T0>(arg0, arg1, 0x1::option::is_some<address>(&v1));
        let v4 = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v0) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg0.creator)) {
            0
        } else {
            v3
        };
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.claims = arg0.claims + 1;
        let v5 = 0x2::balance::split<T0>(&mut arg0.balance, v2);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v4), arg4), 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg2));
        };
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T0>(&arg0.balance) == 0) {
            arg0.active = false;
        };
        let v6 = CoinGiftClaimed{
            gift_id   : 0x2::object::id<CoinGift<T0>>(arg0),
            coin_type : tname<T0>(),
            claimer   : v0,
            amount    : v2,
            fee       : v4,
            claims    : arg0.claims,
            remaining : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<CoinGiftClaimed>(v6);
    }

    public fun has_token<T0>(arg0: &TokenRegistry) : bool {
        let v0 = TokenKey{t: tname<T0>()};
        0x2::dynamic_field::exists<TokenKey>(&arg0.id, v0)
    }

    public fun is_active<T0>(arg0: &CoinGift<T0>) : bool {
        arg0.active
    }

    public fun quote_any<T0>(arg0: &TokenRegistry, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64) {
        assert!(tname<T0>() != tname<0x2::sui::SUI>(), 25);
        if (has_token<T0>(arg0)) {
            return quote_tip<T0>(arg0, arg1, arg2, arg3)
        };
        assert!(arg1 > 0, 1);
        assert!(arg3 <= 1000, 22);
        let v0 = (((arg1 as u128) * (any_tip_fee_bps(arg0) as u128) / 10000) as u64);
        let v1 = if (arg2) {
            (((arg1 as u128) * (arg3 as u128) / 10000) as u64)
        } else {
            0
        };
        (arg1 - v0 - v1, v1, v0)
    }

    public fun quote_claim<T0>(arg0: &CoinGift<T0>, arg1: &TokenRegistry, arg2: bool) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = if (v0 < arg0.per_claim || ((v0 - arg0.per_claim) as u128) * 100 < (arg0.per_claim as u128)) {
            v0
        } else {
            arg0.per_claim
        };
        if (!arg2) {
            return (v1, 0)
        };
        assert!(has_token<T0>(arg1), 21);
        let v2 = token_cfg<T0>(arg1);
        let v3 = (((v1 as u128) * (v2.claim_fee_bps as u128) / 10000) as u64);
        let v4 = if (v3 > v2.claim_fee_floor) {
            v3
        } else {
            v2.claim_fee_floor
        };
        let v5 = (((v1 as u128) * (1000 as u128) / 10000) as u64);
        let v6 = if (v4 > v5) {
            v5
        } else {
            v4
        };
        (v1, v6)
    }

    public fun quote_tip<T0>(arg0: &TokenRegistry, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64) {
        assert!(arg1 > 0, 1);
        assert!(arg3 <= 1000, 22);
        assert!(tips_allowed<T0>(arg0), 20);
        let v0 = token_cfg<T0>(arg0);
        let v1 = if (arg1 < v0.tip_free_below) {
            0
        } else {
            (((arg1 as u128) * (v0.tip_fee_bps as u128) / 10000) as u64)
        };
        let v2 = v1;
        if (v1 > v0.tip_fee_cap) {
            v2 = v0.tip_fee_cap;
        };
        let v3 = if (arg2) {
            (((arg1 as u128) * (arg3 as u128) / 10000) as u64)
        } else {
            0
        };
        (arg1 - v2 - v3, v3, v2)
    }

    entry fun reclaim<T0>(arg0: &mut CoinGift<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        arg0.active = false;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1), arg0.creator);
        };
        let v1 = CoinGiftReclaimed{
            gift_id   : 0x2::object::id<CoinGift<T0>>(arg0),
            coin_type : tname<T0>(),
            creator   : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<CoinGiftReclaimed>(v1);
    }

    public fun remaining<T0>(arg0: &CoinGift<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun remove_token<T0>(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::AdminCap, arg1: &mut TokenRegistry) {
        let v0 = TokenKey{t: tname<T0>()};
        if (0x2::dynamic_field::exists<TokenKey>(&arg1.id, v0)) {
            0x2::dynamic_field::remove<TokenKey, TokenCfg>(&mut arg1.id, v0);
        };
    }

    public fun set_any_tip_fee(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::AdminCap, arg1: &mut TokenRegistry, arg2: u64) {
        assert!(arg2 <= 500, 12);
        let v0 = AnyFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AnyFeeKey>(&arg1.id, v0)) {
            let v1 = AnyFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<AnyFeeKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = AnyFeeKey{dummy_field: false};
            0x2::dynamic_field::add<AnyFeeKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_token<T0>(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::AdminCap, arg1: &mut TokenRegistry, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg3 <= 500 && arg6 <= 500, 12);
        let v0 = TokenKey{t: tname<T0>()};
        let v1 = TokenCfg{
            tips            : arg2,
            tip_fee_bps     : arg3,
            tip_fee_cap     : arg4,
            tip_free_below  : arg5,
            claim_fee_bps   : arg6,
            claim_fee_floor : arg7,
        };
        if (0x2::dynamic_field::exists<TokenKey>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<TokenKey, TokenCfg>(&mut arg1.id, v0) = v1;
        } else {
            0x2::dynamic_field::add<TokenKey, TokenCfg>(&mut arg1.id, v0, v1);
        };
    }

    public fun tip_any<T0>(arg0: &TokenRegistry, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: address, arg5: u64, arg6: 0x1::string::String, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg6)) <= 560 && 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::is_clean_note(&arg6), 24);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::eff_ref_bps(arg1, arg3, arg5);
        let v2 = arg4 != @0x0 && v1 > 0;
        assert!(!v2 || arg4 != v0 && arg4 != arg3, 23);
        let v3 = 0x2::coin::value<T0>(&arg2);
        let (v4, v5, v6) = quote_any<T0>(arg0, v3, v2, v1);
        let (v7, v8) = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v0) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg3)) {
            (v4 + v6, 0)
        } else {
            (v4, v6)
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v8, arg8), 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg1));
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v5, arg8), arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg3);
        let v9 = if (v2) {
            arg4
        } else {
            @0x0
        };
        let v10 = TipCoinEvent{
            coin_type       : tname<T0>(),
            tipper          : v0,
            creator         : arg3,
            referrer        : v9,
            amount          : v3,
            creator_amount  : v7,
            referrer_amount : v5,
            fee_amount      : v8,
            note            : arg6,
            anonymous       : arg7,
        };
        0x2::event::emit<TipCoinEvent>(v10);
    }

    public fun tip_coin<T0>(arg0: &TokenRegistry, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: address, arg5: u64, arg6: 0x1::string::String, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg6)) <= 560 && 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::is_clean_note(&arg6), 24);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::eff_ref_bps(arg1, arg3, arg5);
        let v2 = arg4 != @0x0 && v1 > 0;
        assert!(!v2 || arg4 != v0 && arg4 != arg3, 23);
        let v3 = 0x2::coin::value<T0>(&arg2);
        let (v4, v5, v6) = quote_tip<T0>(arg0, v3, v2, v1);
        let (v7, v8) = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v0) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg3)) {
            (v4 + v6, 0)
        } else {
            (v4, v6)
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v8, arg8), 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg1));
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v5, arg8), arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg3);
        let v9 = if (v2) {
            arg4
        } else {
            @0x0
        };
        let v10 = TipCoinEvent{
            coin_type       : tname<T0>(),
            tipper          : v0,
            creator         : arg3,
            referrer        : v9,
            amount          : v3,
            creator_amount  : v7,
            referrer_amount : v5,
            fee_amount      : v8,
            note            : arg6,
            anonymous       : arg7,
        };
        0x2::event::emit<TipCoinEvent>(v10);
    }

    public fun tips_allowed<T0>(arg0: &TokenRegistry) : bool {
        if (has_token<T0>(arg0)) {
            let v1 = token_cfg<T0>(arg0);
            v1.tips
        } else {
            false
        }
    }

    fun tname<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    public fun token_cfg<T0>(arg0: &TokenRegistry) : TokenCfg {
        let v0 = TokenKey{t: tname<T0>()};
        *0x2::dynamic_field::borrow<TokenKey, TokenCfg>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v7
}

