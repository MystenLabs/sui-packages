module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::lucky {
    struct LuckyGift<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        total: u64,
        max_claims: u64,
        claims: u64,
        min_claim: u64,
        expires_ms: u64,
        flags: u8,
        message: 0x1::string::String,
        claimed: 0x2::table::Table<address, bool>,
        active: bool,
    }

    struct CardKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LuckyGiftCreated has copy, drop {
        gift_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        total: u64,
        max_claims: u64,
        min_claim: u64,
        flags: u8,
    }

    struct LuckyGiftClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        claimer: address,
        amount: u64,
        fee: u64,
        claims: u64,
        remaining: u64,
    }

    struct LuckyGiftReclaimed has copy, drop {
        gift_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        amount: u64,
    }

    struct HolderLuckyGift<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        total: u64,
        max_claims: u64,
        claims: u64,
        min_claim: u64,
        expires_ms: u64,
        flags: u8,
        message: 0x1::string::String,
        claimed: 0x2::table::Table<address, bool>,
        active: bool,
        holder_type: 0x1::ascii::String,
        used_nfts: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public fun card<T0>(arg0: &LuckyGift<T0>) : 0x1::string::String {
        let v0 = CardKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CardKey>(&arg0.id, v0)) {
            let v2 = CardKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CardKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            0x1::string::utf8(b"")
        }
    }

    entry fun claim<T0>(arg0: &mut LuckyGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags == 0, 7);
        do_claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun claim_holder<T0, T1: store + key>(arg0: &mut HolderLuckyGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: T1, arg5: vector<u8>, arg6: u64, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        holder_checks<T0, T1>(arg0, 0x2::object::id<T1>(&arg4), arg3, arg5, arg6, arg8, arg9);
        do_claim_holder<T0>(arg0, arg1, arg2, arg3, arg7, arg8, arg9);
        0x2::transfer::public_transfer<T1>(arg4, 0x2::tx_context::sender(arg9));
    }

    entry fun claim_holder_kiosk<T0, T1: store + key>(arg0: &mut HolderLuckyGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: u64, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg4, arg5) && 0x2::kiosk::has_item_with_type<T1>(arg4, arg6), 33);
        holder_checks<T0, T1>(arg0, arg6, arg3, arg7, arg8, arg10, arg11);
        do_claim_holder<T0>(arg0, arg1, arg2, arg3, arg9, arg10, arg11);
    }

    entry fun claim_with_ticket<T0>(arg0: &mut LuckyGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: vector<u8>, arg5: u64, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::verify_ticket(arg3, 0x2::object::id<LuckyGift<T0>>(arg0), 0x2::tx_context::sender(arg8), arg4, arg5, 0x2::clock::timestamp_ms(arg7)), 8);
        do_claim<T0>(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    public fun claims<T0>(arg0: &LuckyGift<T0>) : u64 {
        arg0.claims
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        assert!(arg1 >= 2 && arg1 <= 20, 30);
        assert!(arg3 <= 1 | 2, 10);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg4)) <= 560, 32);
        let v1 = v0 / arg1;
        assert!(v1 >= 10, 31);
        if (is_sui<T0>()) {
            assert!(v1 >= 100000000, 31);
        };
        let v2 = (((v1 as u128) * (1000 as u128) / 10000) as u64);
        let v3 = LuckyGift<T0>{
            id         : 0x2::object::new(arg6),
            creator    : 0x2::tx_context::sender(arg6),
            balance    : 0x2::coin::into_balance<T0>(arg0),
            total      : v0,
            max_claims : arg1,
            claims     : 0,
            min_claim  : v2,
            expires_ms : arg2,
            flags      : arg3,
            message    : arg4,
            claimed    : 0x2::table::new<address, bool>(arg6),
            active     : true,
        };
        if (0x1::string::length(&arg5) > 0) {
            assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_blob_id(&arg5), 14);
            let v4 = CardKey{dummy_field: false};
            0x2::dynamic_field::add<CardKey, 0x1::string::String>(&mut v3.id, v4, arg5);
        };
        let v5 = 0x2::object::id<LuckyGift<T0>>(&v3);
        let v6 = LuckyGiftCreated{
            gift_id    : v5,
            coin_type  : tname<T0>(),
            creator    : v3.creator,
            total      : v0,
            max_claims : arg1,
            min_claim  : v2,
            flags      : arg3,
        };
        0x2::event::emit<LuckyGiftCreated>(v6);
        0x2::transfer::share_object<LuckyGift<T0>>(v3);
        v5
    }

    public fun create_holder<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::ascii::length(&arg6) > 0 && 0x1::ascii::length(&arg6) <= 512, 34);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        assert!(arg1 >= 2 && arg1 <= 20, 30);
        assert!(arg3 <= 1 | 2, 10);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg4)) <= 560, 32);
        let v1 = v0 / arg1;
        assert!(v1 >= 10, 31);
        if (is_sui<T0>()) {
            assert!(v1 >= 100000000, 31);
        };
        let v2 = (((v1 as u128) * (1000 as u128) / 10000) as u64);
        let v3 = HolderLuckyGift<T0>{
            id          : 0x2::object::new(arg7),
            creator     : 0x2::tx_context::sender(arg7),
            balance     : 0x2::coin::into_balance<T0>(arg0),
            total       : v0,
            max_claims  : arg1,
            claims      : 0,
            min_claim   : v2,
            expires_ms  : arg2,
            flags       : arg3,
            message     : arg4,
            claimed     : 0x2::table::new<address, bool>(arg7),
            active      : true,
            holder_type : arg6,
            used_nfts   : 0x2::table::new<0x2::object::ID, bool>(arg7),
        };
        if (0x1::string::length(&arg5) > 0) {
            assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_blob_id(&arg5), 14);
            let v4 = CardKey{dummy_field: false};
            0x2::dynamic_field::add<CardKey, 0x1::string::String>(&mut v3.id, v4, arg5);
        };
        let v5 = 0x2::object::id<HolderLuckyGift<T0>>(&v3);
        let v6 = LuckyGiftCreated{
            gift_id    : v5,
            coin_type  : tname<T0>(),
            creator    : v3.creator,
            total      : v0,
            max_claims : arg1,
            min_claim  : v2,
            flags      : arg3,
        };
        0x2::event::emit<LuckyGiftCreated>(v6);
        0x2::transfer::share_object<HolderLuckyGift<T0>>(v3);
        v5
    }

    fun do_claim<T0>(arg0: &mut LuckyGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.active;
        let v1 = &mut arg0.claimed;
        let v2 = &mut arg0.balance;
        let v3 = &mut arg0.claims;
        draw<T0>(0x2::object::id<LuckyGift<T0>>(arg0), arg0.creator, v0, arg0.expires_ms, v1, v2, v3, arg0.max_claims, arg0.min_claim, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun do_claim_holder<T0>(arg0: &mut HolderLuckyGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.active;
        let v1 = &mut arg0.claimed;
        let v2 = &mut arg0.balance;
        let v3 = &mut arg0.claims;
        draw<T0>(0x2::object::id<HolderLuckyGift<T0>>(arg0), arg0.creator, v0, arg0.expires_ms, v1, v2, v3, arg0.max_claims, arg0.min_claim, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun draw<T0>(arg0: 0x2::object::ID, arg1: address, arg2: &mut bool, arg3: u64, arg4: &mut 0x2::table::Table<address, bool>, arg5: &mut 0x2::balance::Balance<T0>, arg6: &mut u64, arg7: u64, arg8: u64, arg9: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg10: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg11: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg12: &0x2::random::Random, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(*arg2, 2);
        assert!(arg3 == 0 || 0x2::clock::timestamp_ms(arg13) < arg3, 3);
        let v0 = 0x2::tx_context::sender(arg14);
        assert!(!0x2::table::contains<address, bool>(arg4, v0), 4);
        let v1 = 0x2::balance::value<T0>(arg5);
        assert!(v1 > 0 && *arg6 < arg7, 5);
        let (v2, v3) = share_range(v1, arg7 - *arg6, arg8);
        let v4 = 0x2::random::new_generator(arg12, arg14);
        let v5 = 0x2::random::generate_u64_in_range(&mut v4, v2, v3);
        let v6 = 0x2::tx_context::sponsor(arg14);
        let v7 = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v0) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg1)) {
            0
        } else {
            fee_for<T0>(v5, arg9, arg11, 0x1::option::is_some<address>(&v6))
        };
        0x2::table::add<address, bool>(arg4, v0, true);
        *arg6 = *arg6 + 1;
        let v8 = 0x2::balance::split<T0>(arg5, v5);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v7), arg14), 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg10));
        };
        if (0x2::balance::value<T0>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg14), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v8);
        };
        if (0x2::balance::value<T0>(arg5) == 0 || *arg6 >= arg7) {
            *arg2 = false;
        };
        let v9 = LuckyGiftClaimed{
            gift_id   : arg0,
            coin_type : tname<T0>(),
            claimer   : v0,
            amount    : v5,
            fee       : v7,
            claims    : *arg6,
            remaining : 0x2::balance::value<T0>(arg5),
        };
        0x2::event::emit<LuckyGiftClaimed>(v9);
    }

    public fun fee_for<T0>(arg0: u64, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::TokenRegistry, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg3: bool) : u64 {
        if (!arg3 || arg0 == 0) {
            return 0
        };
        if (is_sui<T0>()) {
            let v0 = (((arg0 as u128) * (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::claim_fee_bps(arg2) as u128) / 10000) as u64);
            let v1 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::claim_fee(arg2);
            let v2 = if (v0 > v1) {
                v0
            } else {
                v1
            };
            return if (v2 > arg0) {
                arg0
            } else {
                v2
            }
        };
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::has_token<T0>(arg1), 21);
        let v4 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::token_cfg<T0>(arg1);
        let (v5, v6) = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift_coin::claim_fee_settings(&v4);
        let v7 = (((arg0 as u128) * (v5 as u128) / 10000) as u64);
        let v8 = if (v7 > v6) {
            v7
        } else {
            v6
        };
        let v9 = (((arg0 as u128) * (1000 as u128) / 10000) as u64);
        if (v8 > v9) {
            v9
        } else {
            v8
        }
    }

    fun holder_checks<T0, T1>(arg0: &mut HolderLuckyGift<T0>, arg1: 0x2::object::ID, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(tname<T1>() == arg0.holder_type, 33);
        if (arg0.flags != 0) {
            assert!(0x2::clock::timestamp_ms(arg5) < arg4, 36);
            assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::verify_ticket(arg2, 0x2::object::id<HolderLuckyGift<T0>>(arg0), 0x2::tx_context::sender(arg6), arg3, arg4, 0x2::clock::timestamp_ms(arg5)), 8);
        };
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.used_nfts, arg1), 35);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.used_nfts, arg1, true);
    }

    public fun holder_claims<T0>(arg0: &HolderLuckyGift<T0>) : u64 {
        arg0.claims
    }

    public fun holder_is_active<T0>(arg0: &HolderLuckyGift<T0>) : bool {
        arg0.active
    }

    public fun holder_nft_used<T0>(arg0: &HolderLuckyGift<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.used_nfts, arg1)
    }

    public fun holder_remaining<T0>(arg0: &HolderLuckyGift<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun holder_type<T0>(arg0: &HolderLuckyGift<T0>) : 0x1::ascii::String {
        arg0.holder_type
    }

    public fun is_active<T0>(arg0: &LuckyGift<T0>) : bool {
        arg0.active
    }

    fun is_sui<T0>() : bool {
        tname<T0>() == tname<0x2::sui::SUI>()
    }

    public fun max_claims<T0>(arg0: &LuckyGift<T0>) : u64 {
        arg0.max_claims
    }

    public fun min_claim<T0>(arg0: &LuckyGift<T0>) : u64 {
        arg0.min_claim
    }

    entry fun reclaim<T0>(arg0: &mut LuckyGift<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        arg0.active = false;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1), arg0.creator);
        };
        let v1 = LuckyGiftReclaimed{
            gift_id   : 0x2::object::id<LuckyGift<T0>>(arg0),
            coin_type : tname<T0>(),
            creator   : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<LuckyGiftReclaimed>(v1);
    }

    entry fun reclaim_holder<T0>(arg0: &mut HolderLuckyGift<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        arg0.active = false;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1), arg0.creator);
        };
        let v1 = LuckyGiftReclaimed{
            gift_id   : 0x2::object::id<HolderLuckyGift<T0>>(arg0),
            coin_type : tname<T0>(),
            creator   : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<LuckyGiftReclaimed>(v1);
    }

    public fun remaining<T0>(arg0: &LuckyGift<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun share_range(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg1 <= 1) {
            return (arg0, arg0)
        };
        let v0 = ((arg1 - 1) as u128) * (arg2 as u128);
        let v1 = (arg0 as u128);
        let v2 = if (v1 > v0) {
            ((v1 - v0) as u64)
        } else {
            0
        };
        let v3 = if (arg2 < v2) {
            arg2
        } else {
            v2
        };
        let v4 = ((v1 * 2 / (arg1 as u128)) as u64);
        let v5 = if (v4 > v3) {
            v4 - v3
        } else {
            v3
        };
        let v6 = v5;
        if (v5 > v2) {
            v6 = v2;
        };
        if (v6 < v3) {
            v6 = v3;
        };
        (v3, v6)
    }

    fun tname<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    // decompiled from Move bytecode v7
}

