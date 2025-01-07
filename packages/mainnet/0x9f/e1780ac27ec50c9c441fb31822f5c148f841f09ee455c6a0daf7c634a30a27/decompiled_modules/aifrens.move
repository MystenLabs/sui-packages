module 0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::aifrens {
    struct AIFRENS has drop {
        dummy_field: bool,
    }

    struct AifrensPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        init_claim: u64,
        max_addresses: u64,
        is_fair_claim: bool,
        claimed: 0x2::table::Table<address, bool>,
        claimed_supply: u64,
        root_proof: vector<u8>,
        airdrop_balance: 0x2::balance::Balance<AIFRENS>,
    }

    struct GovPool has store, key {
        id: 0x2::object::UID,
        ref_balance: 0x2::balance::Balance<AIFRENS>,
    }

    struct BetaPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        init_claim: u64,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
        claimed_supply: u64,
        airdrop_balance: 0x2::balance::Balance<AIFRENS>,
    }

    public entry fun beta_claim(arg0: &mut BetaPool, arg1: &0x2::clock::Clock, arg2: &0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = can_claim_beta_amount(arg0, arg1, arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, 0x2::object::id<0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis>(arg2), true);
        assert!(v2 >= 1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIFRENS>>(0x2::coin::from_balance<AIFRENS>(0x2::balance::split<AIFRENS>(&mut arg0.airdrop_balance, v2), arg3), v1);
        arg0.claimed_supply = arg0.claimed_supply + v2;
        0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::event::airdrop_event(v1, v2);
        v2
    }

    fun calc_claim_after_4_days(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 + 3 * 86400000 < arg2) {
            0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(arg0, 95, 100)
        } else {
            arg0
        };
        let v1 = if (arg1 + 4 * 86400000 < arg2) {
            0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(v0, 94, 100)
        } else {
            v0
        };
        let v2 = if (arg1 + 5 * 86400000 < arg2) {
            0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(v1, 93, 100)
        } else {
            v1
        };
        if (arg1 + 6 * 86400000 < arg2) {
            0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(v2, 92, 100)
        } else {
            v2
        }
    }

    public fun can_claim_amount(arg0: &AifrensPool, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, arg2), 2);
        let v0 = 0x2::table::length<address, bool>(&arg0.claimed);
        if (v0 >= arg0.max_addresses) {
            0
        } else if (arg0.is_fair_claim) {
            arg0.init_claim
        } else {
            let v2 = arg0.init_claim;
            let v3 = 5 * 1000000000000;
            while (v3 < 0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(v0 + 1, 100 * 1000000000000, arg0.max_addresses)) {
                let v4 = v2 * 80;
                v2 = v4 / 100;
                v3 = v3 + 5 * 1000000000000;
            };
            get_actual_claim(arg0, arg1, v2)
        }
    }

    public fun can_claim_beta_amount(arg0: &BetaPool, arg1: &0x2::clock::Clock, arg2: &0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis) : u64 {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, 0x2::object::id<0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis>(arg2)), 2);
        let v0 = 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::birthdate(arg2);
        let v1 = if (v0 > 1683378000000 + 2 * 86400000) {
            arg0.init_claim
        } else if (v0 > 1683378000000 + 86400000) {
            arg0.init_claim * 4
        } else {
            arg0.init_claim * 5
        };
        calc_claim_after_4_days(v1, arg0.launched_at_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public entry fun claim(arg0: &mut AifrensPool, arg1: &0x2::clock::Clock, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        claim_internal(arg0, arg1, arg2, arg3)
    }

    fun claim_internal(arg0: &mut AifrensPool, arg1: &0x2::clock::Clock, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::merkle_tree::verify_calldata(arg2, arg0.root_proof, 0x1::bcs::to_bytes<address>(&v1)), 3);
        let v2 = can_claim_amount(arg0, arg1, v1);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1, true);
        assert!(v2 >= 1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIFRENS>>(0x2::coin::from_balance<AIFRENS>(0x2::balance::split<AIFRENS>(&mut arg0.airdrop_balance, v2), arg3), v1);
        arg0.claimed_supply = arg0.claimed_supply + v2;
        0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::event::airdrop_event(v1, v2);
        v2
    }

    fun get_actual_claim(arg0: &AifrensPool, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        calc_claim_after_4_days(arg2, arg0.launched_at_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public fun get_beta_claimed(arg0: &BetaPool) : &0x2::table::Table<0x2::object::ID, bool> {
        &arg0.claimed
    }

    public fun get_suifrens_claimed(arg0: &AifrensPool) : &0x2::table::Table<address, bool> {
        &arg0.claimed
    }

    fun init(arg0: AIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFRENS>(arg0, 0, b"xAIFRENS", b"xAIFRENS", b"xAIFRENS is a deflationary token that will be utilized by SUI ecosystem applications. The total supply of xAIFRENS tokens is 210,000,000,000,000,000. xAIFRENS is owned by everyone in the SUI community and serves as a crucial key to unlock the future utilities of the AIFRENS universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifrens.ai/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIFRENS>>(v1);
        let v3 = 0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(50, 210000000000000000, 1000);
        let v4 = 0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(100, 210000000000000000, 1000);
        let v5 = 210000000000000000 - v3 - v4;
        let v6 = 0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(400, v5, 1000);
        let v7 = AifrensPool{
            id              : 0x2::object::new(arg1),
            name            : 0x1::string::utf8(b"ALPHA"),
            has_paused      : false,
            launched_at_ms  : 1684490400000,
            expired_at_ms   : 1684490400000 + 7 * 86400000,
            init_claim      : 924402192713,
            max_addresses   : 312560,
            is_fair_claim   : false,
            claimed         : 0x2::table::new<address, bool>(arg1),
            claimed_supply  : 0,
            root_proof      : 0x1::vector::empty<u8>(),
            airdrop_balance : 0x2::coin::into_balance<AIFRENS>(0x2::coin::mint<AIFRENS>(&mut v2, v6, arg1)),
        };
        0x2::transfer::share_object<AifrensPool>(v7);
        let v8 = 0x9fe1780ac27ec50c9c441fb31822f5c148f841f09ee455c6a0daf7c634a30a27::math::mul_div(500, v5, 1000);
        let v9 = AifrensPool{
            id              : 0x2::object::new(arg1),
            name            : 0x1::string::utf8(b"ECO"),
            has_paused      : false,
            launched_at_ms  : 1684490400000,
            expired_at_ms   : 1684490400000 + 7 * 86400000,
            init_claim      : 2309005769280,
            max_addresses   : 38653,
            is_fair_claim   : true,
            claimed         : 0x2::table::new<address, bool>(arg1),
            claimed_supply  : 0,
            root_proof      : 0x1::vector::empty<u8>(),
            airdrop_balance : 0x2::coin::into_balance<AIFRENS>(0x2::coin::mint<AIFRENS>(&mut v2, v8, arg1)),
        };
        0x2::transfer::share_object<AifrensPool>(v9);
        let v10 = BetaPool{
            id              : 0x2::object::new(arg1),
            name            : 0x1::string::utf8(b"BETA"),
            has_paused      : false,
            launched_at_ms  : 1684490400000,
            expired_at_ms   : 1684490400000 + 7 * 86400000,
            init_claim      : 124031546398,
            claimed         : 0x2::table::new<0x2::object::ID, bool>(arg1),
            claimed_supply  : 0,
            airdrop_balance : 0x2::coin::into_balance<AIFRENS>(0x2::coin::mint<AIFRENS>(&mut v2, v5 - v8 - v6, arg1)),
        };
        0x2::transfer::share_object<BetaPool>(v10);
        let v11 = GovPool{
            id          : 0x2::object::new(arg1),
            ref_balance : 0x2::coin::into_balance<AIFRENS>(0x2::coin::mint<AIFRENS>(&mut v2, v3, arg1)),
        };
        0x2::transfer::share_object<GovPool>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIFRENS>>(0x2::coin::from_balance<AIFRENS>(0x2::coin::into_balance<AIFRENS>(0x2::coin::mint<AIFRENS>(&mut v2, v4, arg1)), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFRENS>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun is_emergency(arg0: &AifrensPool) : bool {
        arg0.has_paused
    }

    public fun pause(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut AifrensPool) {
        arg1.has_paused = true;
    }

    public fun pause_beta(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut BetaPool) {
        arg1.has_paused = true;
    }

    public fun resume(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut AifrensPool) {
        arg1.has_paused = false;
    }

    public fun resume_beta(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut BetaPool) {
        arg1.has_paused = false;
    }

    public entry fun set_proof_root(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut AifrensPool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.root_proof = arg2;
    }

    public entry fun update_beta_time(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut BetaPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.launched_at_ms = arg2;
        arg1.expired_at_ms = arg3;
    }

    public entry fun update_time(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut AifrensPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.launched_at_ms = arg2;
        arg1.expired_at_ms = arg3;
    }

    public fun withdraw_beta_pool(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut BetaPool, arg2: u64) : 0x2::balance::Balance<AIFRENS> {
        0x2::balance::split<AIFRENS>(&mut arg1.airdrop_balance, arg2)
    }

    public fun withdraw_ref_pool(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut GovPool, arg2: u64) : 0x2::balance::Balance<AIFRENS> {
        0x2::balance::split<AIFRENS>(&mut arg1.ref_balance, arg2)
    }

    public fun withdraw_suifrens_pool(arg0: &0x2::coin::TreasuryCap<AIFRENS>, arg1: &mut AifrensPool, arg2: u64) : 0x2::balance::Balance<AIFRENS> {
        0x2::balance::split<AIFRENS>(&mut arg1.airdrop_balance, arg2)
    }

    // decompiled from Move bytecode v6
}

