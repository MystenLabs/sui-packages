module 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve {
    struct BONDING_CURVE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceRelayerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceConfig has key {
        id: 0x2::object::UID,
        sui_price_scaled: u64,
        updated_at_ms: u64,
        version: u64,
    }

    struct SuiPriceUpdated has copy, drop {
        price_scaled: u64,
        updated_at_ms: u64,
    }

    struct PriceRelayerCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
    }

    struct LaunchIssuerCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchIssuerRegistry has key {
        id: 0x2::object::UID,
        active_cap_id: 0x2::object::ID,
        price_config_id: 0x2::object::ID,
        graduation_registry_id: 0x2::object::ID,
        active_price_relayer_cap_id: 0x2::object::ID,
    }

    struct LaunchTicket<phantom T0> has key {
        id: 0x2::object::UID,
        issuer_cap_id: 0x2::object::ID,
        recipient: address,
        expires_at_ms: u64,
    }

    struct LaunchTicketIssued has copy, drop {
        ticket_id: 0x2::object::ID,
        recipient: address,
        expires_at_ms: u64,
    }

    struct LaunchIssuerCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct LaunchIssuerCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct PriceRelayerCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct CurveMigrated has copy, drop {
        curve_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct ProposalMigrated has copy, drop {
        proposal_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct LockMigrated has copy, drop {
        lock_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct PriceConfigMigrated has copy, drop {
        config_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct Payout has copy, drop, store {
        recipient: address,
        bps: u64,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        treasury: 0x2::coin::TreasuryCap<T0>,
        creator: address,
        payouts: vector<Payout>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        airdrop_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        graduated: bool,
        paused: bool,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        graduation_target: u8,
        anti_bot_delay: u8,
        created_at_ms: u64,
        metadata_updated: bool,
        lp_fees_accumulated: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        creator_lp_nft_id: 0x1::option::Option<0x2::object::ID>,
        current_grad_threshold: u64,
        active_creator_cap_id: 0x2::object::ID,
        last_creator_activity_ms: u64,
        cto_cooldown_until_ms: u64,
        buyback: BuybackConfig,
        buyback_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        last_buyback_ms: u64,
        version: u64,
        price_config_id: 0x2::object::ID,
        graduation_registry_id: 0x2::object::ID,
    }

    struct BuybackConfig has drop, store {
        bps: u64,
        burn: bool,
        min_out_bps: u64,
        deadline_ms: u64,
        threshold_mist: u64,
    }

    struct VestingLock<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        beneficiary: address,
        locked: 0x2::balance::Balance<T0>,
        total_amount: u64,
        claimed: u64,
        start_ms: u64,
        duration_ms: u64,
        mode: u8,
        version: u64,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        graduation_target: u8,
        anti_bot_delay: u8,
    }

    struct TokensPurchased has copy, drop {
        curve_id: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
        creator_fee: u64,
        protocol_fee: u64,
        airdrop_fee: u64,
        lp_fee: u64,
        referral_fee: u64,
        referral: 0x1::option::Option<address>,
        new_sui_reserve: u64,
        new_token_reserve: u64,
        grad_threshold_used: u64,
        tail_refund: u64,
    }

    struct TokensSold has copy, drop {
        curve_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        creator_fee: u64,
        protocol_fee: u64,
        airdrop_fee: u64,
        lp_fee: u64,
        referral_fee: u64,
        referral: 0x1::option::Option<address>,
        new_sui_reserve: u64,
        new_token_reserve: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        final_sui_reserve: u64,
        creator_bonus: u64,
        protocol_bonus: u64,
        graduation_target: u8,
    }

    struct PoolRecorded has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        creator_lp_nft_id: 0x2::object::ID,
    }

    struct GraduationFundsClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        sui_amount: u64,
        lp_amount: u64,
    }

    struct TokensLocked has copy, drop {
        lock_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        beneficiary: address,
        total_amount: u64,
        start_ms: u64,
        duration_ms: u64,
        mode: u8,
    }

    struct VestedClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        remaining: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct ProtocolFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct AirdropFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct PayoutsUpdated has copy, drop {
        curve_id: 0x2::object::ID,
        updated_by: address,
    }

    struct LaunchFeeCollected has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct Comment has copy, drop {
        curve_id: 0x2::object::ID,
        author: address,
        text: 0x1::string::String,
        parent_id: address,
    }

    struct CommentGateSet has copy, drop {
        curve_id: 0x2::object::ID,
        holder_gated: bool,
    }

    struct PauseToggled has copy, drop {
        curve_id: 0x2::object::ID,
        paused: bool,
    }

    struct MetadataUpdated has copy, drop {
        curve_id: 0x2::object::ID,
    }

    struct GraduationCap has store, key {
        id: 0x2::object::UID,
    }

    struct GraduationRegistry has key {
        id: 0x2::object::UID,
        active_cap_id: 0x2::object::ID,
    }

    struct GraduationCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct GraduationCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct BuybackConfigured has copy, drop {
        curve_id: 0x2::object::ID,
        buyback_bps: u64,
        burn: bool,
        min_out_bps: u64,
        deadline_ms: u64,
        threshold_mist: u64,
    }

    struct BuybackExecuted has copy, drop {
        curve_id: 0x2::object::ID,
        sui_spent: u64,
        tokens_bought: u64,
        burned: bool,
        tip: u64,
    }

    struct BuybackSweptExpired has copy, drop {
        curve_id: 0x2::object::ID,
        sui_swept: u64,
    }

    struct BuybackReady has copy, drop {
        curve_id: 0x2::object::ID,
        buyback_fees: u64,
        threshold: u64,
    }

    struct TokensBurned has copy, drop {
        curve_id: 0x2::object::ID,
        burner: address,
        amount: u64,
        total_supply_after: u64,
    }

    struct CreatorHeartbeat has copy, drop {
        curve_id: 0x2::object::ID,
        at_ms: u64,
    }

    struct ProtocolSurchargeCollected has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct TakeoverProposed has copy, drop {
        curve_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        proposer: address,
        deadline_ms: u64,
    }

    struct TakeoverVoted has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        amount: u64,
        total_weight: u64,
    }

    struct TakeoverUnvoted has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        amount: u64,
    }

    struct TakeoverResolved has copy, drop {
        proposal_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        succeeded: bool,
        total_weight: u64,
    }

    struct VoteReclaimed has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        amount: u64,
    }

    struct TakeoverProposal<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        proposer: address,
        proposer_bond: u64,
        opened_at_ms: u64,
        deadline_ms: u64,
        escrow: 0x2::balance::Balance<T0>,
        votes: 0x2::table::Table<address, u64>,
        total_weight: u64,
        quorum_target: u64,
        resolved: bool,
        succeeded: bool,
        version: u64,
    }

    public fun active_creator_cap_id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.active_creator_cap_id
    }

    public fun active_graduation_cap_id(arg0: &GraduationRegistry) : 0x2::object::ID {
        arg0.active_cap_id
    }

    public fun active_launch_issuer_cap_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.active_cap_id
    }

    public fun active_price_relayer_cap_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.active_price_relayer_cap_id
    }

    public fun airdrop_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.airdrop_fees)
    }

    public fun anti_bot_delay<T0>(arg0: &Curve<T0>) : u8 {
        arg0.anti_bot_delay
    }

    fun assert_active_creator<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.curve_id == 0x2::object::id<Curve<T0>>(arg1), 6);
        assert!(0x2::object::id<CreatorCap>(arg0) == arg1.active_creator_cap_id, 36);
        arg1.last_creator_activity_ms = 0x2::clock::timestamp_ms(arg2);
    }

    fun assert_curve_version<T0>(arg0: &Curve<T0>) {
        assert!(arg0.version == 1, 66);
    }

    fun assert_lock_version<T0>(arg0: &VestingLock<T0>) {
        assert!(arg0.version == 1, 66);
    }

    fun assert_no_self_referral(arg0: &0x1::option::Option<address>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(arg0)) {
            let v0 = *0x1::option::borrow<address>(arg0);
            assert!(v0 != 0x2::tx_context::sender(arg2), 27);
            assert!(v0 != arg1, 27);
        };
    }

    fun assert_proposal_version<T0>(arg0: &TakeoverProposal<T0>) {
        assert!(arg0.version == 1, 66);
    }

    fun build_payouts(arg0: vector<address>, arg1: vector<u64>) : vector<Payout> {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0 && v0 <= 10, 19);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 19);
        let v1 = 0;
        let v2 = 0x1::vector::empty<Payout>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg0, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg1, v3);
            let v6 = 0;
            while (v6 < v3) {
                assert!(0x1::vector::borrow<Payout>(&v2, v6).recipient != v4, 19);
                v6 = v6 + 1;
            };
            v1 = v1 + v5;
            let v7 = Payout{
                recipient : v4,
                bps       : v5,
            };
            0x1::vector::push_back<Payout>(&mut v2, v7);
            v3 = v3 + 1;
        };
        assert!(v1 == 10000, 19);
        v2
    }

    public fun burn_tokens<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 81);
        let v0 = TokensBurned{
            curve_id           : 0x2::object::id<Curve<T0>>(arg0),
            burner             : 0x2::tx_context::sender(arg2),
            amount             : 0x2::coin::burn<T0>(&mut arg0.treasury, arg1),
            total_supply_after : 0x2::coin::total_supply<T0>(&arg0.treasury),
        };
        0x2::event::emit<TokensBurned>(v0);
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &PriceConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 4);
        assert!(!arg0.paused, 28);
        assert!(0x2::object::id<PriceConfig>(arg4) == arg0.price_config_id, 67);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 7);
        assert_no_self_referral(&arg3, arg0.creator, arg6);
        if (arg0.anti_bot_delay > 0) {
            if (0x2::clock::timestamp_ms(arg5) < arg0.created_at_ms + (arg0.anti_bot_delay as u64) * 1000) {
                assert!(0x2::tx_context::sender(arg6) == arg0.creator, 18);
            };
        };
        let v1 = resolve_grad_threshold(arg4, arg5);
        arg0.current_grad_threshold = v1;
        let v2 = 0x1::option::is_some<address>(&arg3);
        let v3 = v0 - v0 * 100 / 10000;
        let v4 = effective_sui_reserve<T0>(arg0);
        let v5 = effective_token_reserve<T0>(arg0);
        let v6 = quote_out(v3, v4, v5);
        let v7 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        if (v6 < v7 && v8 >= v1) {
            do_graduate_inline<T0>(arg0, arg6);
            let v9 = TokensPurchased{
                curve_id            : 0x2::object::id<Curve<T0>>(arg0),
                buyer               : 0x2::tx_context::sender(arg6),
                sui_in              : v0,
                tokens_out          : 0,
                creator_fee         : 0,
                protocol_fee        : 0,
                airdrop_fee         : 0,
                lp_fee              : 0,
                referral_fee        : 0,
                referral            : arg3,
                new_sui_reserve     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
                new_token_reserve   : 0x2::balance::value<T0>(&arg0.token_reserve),
                grad_threshold_used : v1,
                tail_refund         : v0,
            };
            0x2::event::emit<TokensPurchased>(v9);
            return (0x2::coin::zero<T0>(arg6), arg1)
        };
        let (v10, v11) = if (v6 >= v7) {
            let v12 = (((v4 as u128) * (v7 as u128) / ((v5 as u128) - (v7 as u128))) as u64);
            let v13 = if (v12 > v3) {
                v3
            } else {
                v12
            };
            (v7, v13)
        } else if (v8 + v3 >= v1) {
            let v14 = v1 - v8;
            let v15 = if (v14 > v3) {
                v3
            } else {
                v14
            };
            let v16 = quote_out(v15, v4, v5);
            let v17 = if (v16 > v7) {
                v7
            } else {
                v16
            };
            (v17, v15)
        } else {
            (v6, v3)
        };
        assert!(v10 > 0, 2);
        assert!(v10 >= arg2, 3);
        let v18 = gross_up_for_fee(v11, v0);
        let v19 = v18 * 100 / 10000;
        let (v20, v21, v22, v23, v24) = split_fee_v7(v19, v2);
        let v25 = v20 * arg0.buyback.bps / 10000;
        let v26 = v20 - v25;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v26, arg6)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v21, arg6)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.airdrop_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v22, arg6)));
        if (v25 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v25, arg6)));
        };
        emit_buyback_ready_if_crossed<T0>(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees));
        if (v24 > 0 && v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v24, arg6), *0x1::option::borrow<address>(&arg3));
        };
        arg0.lp_fees_accumulated = arg0.lp_fees_accumulated + v23;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v18 - v19 + v23, arg6)));
        let v27 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v10);
        if (!arg0.graduated && (0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v1)) {
            do_graduate_inline<T0>(arg0, arg6);
        };
        let v28 = TokensPurchased{
            curve_id            : 0x2::object::id<Curve<T0>>(arg0),
            buyer               : 0x2::tx_context::sender(arg6),
            sui_in              : v0,
            tokens_out          : v10,
            creator_fee         : v26,
            protocol_fee        : v21,
            airdrop_fee         : v22,
            lp_fee              : v23,
            referral_fee        : v24,
            referral            : arg3,
            new_sui_reserve     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            new_token_reserve   : 0x2::balance::value<T0>(&arg0.token_reserve),
            grad_threshold_used : v1,
            tail_refund         : v0 - v18,
        };
        0x2::event::emit<TokensPurchased>(v28);
        (0x2::coin::from_balance<T0>(v27, arg6), arg1)
    }

    public fun buyback_bps<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.bps
    }

    public fun buyback_burn<T0>(arg0: &Curve<T0>) : bool {
        arg0.buyback.burn
    }

    public fun buyback_deadline_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.deadline_ms
    }

    public fun buyback_fees_pending<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees)
    }

    public fun buyback_min_out_bps<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.min_out_bps
    }

    public fun buyback_threshold_mist<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buyback.threshold_mist
    }

    public fun canonical_graduation_registry_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.graduation_registry_id
    }

    public fun canonical_price_config_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.price_config_id
    }

    fun circulating_supply<T0>(arg0: &Curve<T0>) : u64 {
        800000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun claim_airdrop_fees<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.airdrop_fees);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.airdrop_fees, v0), arg2), 0x2::tx_context::sender(arg2));
        let v1 = AirdropFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            amount   : v0,
        };
        0x2::event::emit<AirdropFeesClaimed>(v1);
    }

    public fun claim_creator_fees<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1, arg2);
        assert!(!arg1.paused, 28);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fees);
        assert!(v0 > 0, 8);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.creator_fees, v0), arg3);
        let v2 = 0x1::vector::length<Payout>(&arg1.payouts);
        let v3 = 0;
        while (v3 < v2 - 1) {
            let v4 = 0x1::vector::borrow<Payout>(&arg1.payouts, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v0 * v4.bps / 10000, arg3), v4.recipient);
            v3 = v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x1::vector::borrow<Payout>(&arg1.payouts, v2 - 1).recipient);
        let v5 = CreatorFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            creator  : 0x2::tx_context::sender(arg3),
            amount   : v0,
        };
        0x2::event::emit<CreatorFeesClaimed>(v5);
    }

    public fun claim_graduation_funds<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        claim_graduation_funds_impl<T0>(arg1, arg2)
    }

    fun claim_graduation_funds_impl<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_curve_version<T0>(arg0);
        assert!(arg0.graduated, 5);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed"), 51);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        assert!(v0 >= 500000000000, 52);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"grad_funds_claimed", true);
        let v1 = 1000000000000000 - 800000000000000;
        let v2 = GraduationFundsClaimed{
            curve_id   : 0x2::object::id<Curve<T0>>(arg0),
            sui_amount : v0,
            lp_amount  : v1,
        };
        0x2::event::emit<GraduationFundsClaimed>(v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_reserve), arg1), 0x2::coin::from_balance<T0>(0x2::coin::mint_balance<T0>(&mut arg0.treasury, v1), arg1))
    }

    public fun claim_graduation_funds_with_cap<T0>(arg0: &GraduationCap, arg1: &GraduationRegistry, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<GraduationRegistry>(arg1) == arg2.graduation_registry_id, 68);
        assert!(arg1.active_cap_id == 0x2::object::id<GraduationCap>(arg0), 61);
        claim_graduation_funds_impl<T0>(arg2, arg3)
    }

    public fun claim_protocol_fees<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_fees);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.protocol_fees, v0), arg2), 0x2::tx_context::sender(arg2));
        let v1 = ProtocolFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            amount   : v0,
        };
        0x2::event::emit<ProtocolFeesClaimed>(v1);
    }

    public fun claim_vested<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_lock_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.beneficiary, 33);
        let v1 = vested_amount(arg0.total_amount, arg0.start_ms, arg0.duration_ms, arg0.mode, 0x2::clock::timestamp_ms(arg1));
        let v2 = if (v1 > arg0.claimed) {
            v1 - arg0.claimed
        } else {
            0
        };
        assert!(v2 > 0, 34);
        arg0.claimed = arg0.claimed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked, v2), arg2), v0);
        let v3 = VestedClaimed{
            lock_id     : 0x2::object::id<VestingLock<T0>>(arg0),
            beneficiary : v0,
            amount      : v2,
            remaining   : 0x2::balance::value<T0>(&arg0.locked),
        };
        0x2::event::emit<VestedClaimed>(v3);
    }

    public fun collect_protocol_surcharge<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_curve_version<T0>(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 76);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = ProtocolSurchargeCollected{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<ProtocolSurchargeCollected>(v1);
    }

    public fun comments_holder_gated<T0>(arg0: &Curve<T0>) : bool {
        !0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"comments_ungated")
    }

    fun consume_launch_ticket<T0>(arg0: LaunchTicket<T0>, arg1: &LaunchIssuerRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let LaunchTicket {
            id            : v0,
            issuer_cap_id : v1,
            recipient     : v2,
            expires_at_ms : v3,
        } = arg0;
        0x2::object::delete(v0);
        assert!(arg1.active_cap_id == v1, 63);
        assert!(0x2::tx_context::sender(arg3) == v2, 65);
        assert!(0x2::clock::timestamp_ms(arg2) <= v3, 64);
    }

    public fun create_and_return<T0>(arg0: LaunchTicket<T0>, arg1: &LaunchIssuerRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: 0x1::string::String, arg7: vector<address>, arg8: vector<u64>, arg9: u8, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (Curve<T0>, CreatorCap) {
        consume_launch_ticket<T0>(arg0, arg1, arg11, arg12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 2000000000, 9);
        let v0 = if (arg9 == 0) {
            true
        } else if (arg9 == 1) {
            true
        } else {
            arg9 == 2
        };
        assert!(v0, 10);
        let v1 = if (arg10 == 0) {
            true
        } else if (arg10 == 15) {
            true
        } else {
            arg10 == 30
        };
        assert!(v1, 11);
        let v2 = 0x2::tx_context::sender(arg12);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 53);
        let v3 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v4 = 0x2::object::new(arg12);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = 0x2::object::new(arg12);
        let v7 = BuybackConfig{
            bps            : 0,
            burn           : false,
            min_out_bps    : 9900,
            deadline_ms    : 0,
            threshold_mist : 0,
        };
        let v8 = Curve<T0>{
            id                       : v4,
            sui_reserve              : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve            : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg2, 800000000000000, arg12)),
            treasury                 : arg2,
            creator                  : v2,
            payouts                  : build_payouts(arg7, arg8),
            creator_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            protocol_fees            : v3,
            airdrop_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            graduated                : false,
            paused                   : false,
            name                     : arg4,
            symbol                   : arg5,
            graduation_target        : arg9,
            anti_bot_delay           : arg10,
            created_at_ms            : 0x2::clock::timestamp_ms(arg11),
            metadata_updated         : false,
            lp_fees_accumulated      : 0,
            pool_id                  : 0x1::option::none<0x2::object::ID>(),
            creator_lp_nft_id        : 0x1::option::none<0x2::object::ID>(),
            current_grad_threshold   : 0,
            active_creator_cap_id    : 0x2::object::uid_to_inner(&v6),
            last_creator_activity_ms : 0x2::clock::timestamp_ms(arg11),
            cto_cooldown_until_ms    : 0,
            buyback                  : v7,
            buyback_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            last_buyback_ms          : 0x2::clock::timestamp_ms(arg11),
            version                  : 1,
            price_config_id          : arg1.price_config_id,
            graduation_registry_id   : arg1.graduation_registry_id,
        };
        let v9 = LaunchFeeCollected{
            curve_id : v5,
            amount   : 2000000000,
        };
        0x2::event::emit<LaunchFeeCollected>(v9);
        let v10 = CurveCreated{
            curve_id          : v5,
            creator           : v2,
            name              : v8.name,
            symbol            : v8.symbol,
            graduation_target : v8.graduation_target,
            anti_bot_delay    : v8.anti_bot_delay,
        };
        0x2::event::emit<CurveCreated>(v10);
        let v11 = CreatorCap{
            id       : v6,
            curve_id : v5,
        };
        (v8, v11)
    }

    public fun create_with_launch_fee<T0>(arg0: LaunchTicket<T0>, arg1: &LaunchIssuerRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: 0x1::string::String, arg7: vector<address>, arg8: vector<u64>, arg9: u8, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_and_return<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::share_object<Curve<T0>>(v0);
        0x2::transfer::public_transfer<CreatorCap>(v1, 0x2::tx_context::sender(arg12));
    }

    public fun created_at_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    public fun creator_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun creator_heartbeat<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1, arg2);
        let v0 = CreatorHeartbeat{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            at_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CreatorHeartbeat>(v0);
    }

    public fun creator_lp_nft_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.creator_lp_nft_id
    }

    public fun cto_circulating_supply<T0>(arg0: &Curve<T0>) : u64 {
        circulating_supply<T0>(arg0)
    }

    public fun cto_cooldown_until_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.cto_cooldown_until_ms
    }

    public fun current_grad_threshold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.current_grad_threshold
    }

    public fun current_version() : u64 {
        1
    }

    fun dampened_grad_threshold(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 9000000000000
        };
        let v0 = 1000000;
        let v1 = isqrt(arg0 * v0);
        if (v1 == 0) {
            return 9000000000000
        };
        9000000000000 * isqrt(1000 * v0) / v1
    }

    fun do_graduate_inline<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = grad_bonuses(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v0), arg1), arg0.creator);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyback_fees));
        let v2 = 0x2::balance::withdraw_all<T0>(&mut arg0.token_reserve);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::coin::burn<T0>(&mut arg0.treasury, 0x2::coin::from_balance<T0>(v2, arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        arg0.graduated = true;
        let v3 = Graduated{
            curve_id          : 0x2::object::id<Curve<T0>>(arg0),
            final_sui_reserve : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            creator_bonus     : v0,
            protocol_bonus    : v1,
            graduation_target : arg0.graduation_target,
        };
        0x2::event::emit<Graduated>(v3);
    }

    fun effective_sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) + 4369000000000
    }

    fun effective_token_reserve<T0>(arg0: &Curve<T0>) : u64 {
        1073000000000000 - 800000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve)
    }

    fun emit_buyback_ready_if_crossed<T0>(arg0: &Curve<T0>, arg1: u64) {
        let v0 = arg0.buyback.threshold_mist;
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees);
        if (arg1 < v0 && v1 >= v0) {
            let v2 = BuybackReady{
                curve_id     : 0x2::object::id<Curve<T0>>(arg0),
                buyback_fees : v1,
                threshold    : v0,
            };
            0x2::event::emit<BuybackReady>(v2);
        };
    }

    public fun execute_buyback<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 4);
        assert!(!arg0.paused, 28);
        assert!(arg0.buyback.deadline_ms == 0 || 0x2::clock::timestamp_ms(arg1) <= arg0.buyback.deadline_ms, 70);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees);
        assert!(v0 > 0, 39);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.last_buyback_ms + 600000, 74);
        arg0.last_buyback_ms = v1;
        let v2 = v0 * 25 / 10000;
        let v3 = v0 - v2;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.buyback_fees, v2), arg2), 0x2::tx_context::sender(arg2));
        };
        let v4 = effective_sui_reserve<T0>(arg0);
        let v5 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v6 = arg0.buyback.min_out_bps;
        assert!(v6 >= 9000 && v6 < 10000, 78);
        let v7 = (v6 as u128);
        let v8 = (v4 as u128) * ((10000 as u128) - v7) / v7;
        let v9 = if ((v3 as u128) > v8) {
            (v8 as u64)
        } else {
            v3
        };
        let v10 = quote_out(v9, v4, effective_token_reserve<T0>(arg0));
        let v11 = if (v10 > v5) {
            v5
        } else {
            v10
        };
        assert!(v11 > 0, 39);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.buyback_fees, v9));
        if (arg0.buyback.burn) {
            0x2::coin::burn<T0>(&mut arg0.treasury, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v11), arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v11), arg2), arg0.creator);
        };
        let v12 = BuybackExecuted{
            curve_id      : 0x2::object::id<Curve<T0>>(arg0),
            sui_spent     : v9,
            tokens_bought : v11,
            burned        : arg0.buyback.burn,
            tip           : v2,
        };
        0x2::event::emit<BuybackExecuted>(v12);
    }

    fun grad_bonuses(arg0: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (10000 as u128);
        (((v0 * (50 as u128) / v1) as u64), ((v0 * (50 as u128) / v1) as u64))
    }

    public fun grad_funds_claimed<T0>(arg0: &Curve<T0>) : bool {
        0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"grad_funds_claimed")
    }

    public fun graduate<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &PriceConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        graduate_impl<T0>(arg0, arg2, arg3, arg4);
    }

    fun graduate_impl<T0>(arg0: &mut Curve<T0>, arg1: &PriceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 4);
        assert!(!arg0.paused, 28);
        assert!(0x2::object::id<PriceConfig>(arg1) == arg0.price_config_id, 67);
        assert!(0x2::balance::value<T0>(&arg0.token_reserve) == 0 || 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= resolve_grad_threshold(arg1, arg2), 5);
        do_graduate_inline<T0>(arg0, arg3);
    }

    public fun graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated
    }

    public fun graduation_registry_id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.graduation_registry_id
    }

    public fun graduation_target<T0>(arg0: &Curve<T0>) : u8 {
        arg0.graduation_target
    }

    fun gross_up_for_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = ((10000 - 100) as u128);
        let v1 = ((arg0 as u128) * (10000 as u128) + v0 - 1) / v0;
        if (v1 >= (arg1 as u128)) {
            arg1
        } else {
            (v1 as u64)
        }
    }

    fun init(arg0: BONDING_CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(4000 + 5000 + 1000 == 10000, 21);
        assert!(reserve_after_grad_bonuses(dampened_grad_threshold(35000)) >= 500000000000, 71);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = PriceRelayerCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::object::id<PriceRelayerCap>(&v2);
        let v4 = PriceRelayerCapIssued{cap_id: v3};
        0x2::event::emit<PriceRelayerCapIssued>(v4);
        0x2::transfer::public_transfer<PriceRelayerCap>(v2, v0);
        let v5 = PriceConfig{
            id               : 0x2::object::new(arg1),
            sui_price_scaled : 0,
            updated_at_ms    : 0,
            version          : 1,
        };
        0x2::transfer::share_object<PriceConfig>(v5);
        let v6 = GraduationCap{id: 0x2::object::new(arg1)};
        let v7 = 0x2::object::id<GraduationCap>(&v6);
        let v8 = GraduationRegistry{
            id            : 0x2::object::new(arg1),
            active_cap_id : v7,
        };
        let v9 = 0x2::object::id<GraduationRegistry>(&v8);
        let v10 = GraduationCapIssued{
            cap_id      : v7,
            registry_id : v9,
        };
        0x2::event::emit<GraduationCapIssued>(v10);
        0x2::transfer::public_transfer<GraduationCap>(v6, v0);
        0x2::transfer::share_object<GraduationRegistry>(v8);
        let v11 = LaunchIssuerCap{id: 0x2::object::new(arg1)};
        let v12 = 0x2::object::id<LaunchIssuerCap>(&v11);
        let v13 = LaunchIssuerRegistry{
            id                          : 0x2::object::new(arg1),
            active_cap_id               : v12,
            price_config_id             : 0x2::object::id<PriceConfig>(&v5),
            graduation_registry_id      : v9,
            active_price_relayer_cap_id : v3,
        };
        let v14 = LaunchIssuerCapIssued{
            cap_id      : v12,
            registry_id : 0x2::object::id<LaunchIssuerRegistry>(&v13),
        };
        0x2::event::emit<LaunchIssuerCapIssued>(v14);
        0x2::transfer::public_transfer<LaunchIssuerCap>(v11, v0);
        0x2::transfer::share_object<LaunchIssuerRegistry>(v13);
    }

    fun isqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun issue_launch_ticket<T0>(arg0: &LaunchIssuerCap, arg1: &LaunchIssuerRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active_cap_id == 0x2::object::id<LaunchIssuerCap>(arg0), 63);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 3600000;
        let v1 = LaunchTicket<T0>{
            id            : 0x2::object::new(arg4),
            issuer_cap_id : 0x2::object::id<LaunchIssuerCap>(arg0),
            recipient     : arg2,
            expires_at_ms : v0,
        };
        let v2 = LaunchTicketIssued{
            ticket_id     : 0x2::object::id<LaunchTicket<T0>>(&v1),
            recipient     : arg2,
            expires_at_ms : v0,
        };
        0x2::event::emit<LaunchTicketIssued>(v2);
        0x2::transfer::transfer<LaunchTicket<T0>>(v1, arg2);
    }

    public fun last_buyback_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.last_buyback_ms
    }

    public fun last_creator_activity_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.last_creator_activity_ms
    }

    public fun lock_beneficiary<T0>(arg0: &VestingLock<T0>) : address {
        arg0.beneficiary
    }

    public fun lock_claimed<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.claimed
    }

    public fun lock_remaining<T0>(arg0: &VestingLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun lock_tokens<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.paused, 28);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 35);
        let v1 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v1, 30);
        let v2 = if (arg3 == 604800000) {
            true
        } else if (arg3 == 2592000000) {
            true
        } else if (arg3 == 15552000000) {
            true
        } else {
            arg3 == 31536000000
        };
        assert!(v2, 31);
        if (arg2 == 2) {
            assert!(arg3 >= 2592000000, 32);
        };
        let v3 = VestingLock<T0>{
            id           : 0x2::object::new(arg5),
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            beneficiary  : 0x2::tx_context::sender(arg5),
            locked       : 0x2::coin::into_balance<T0>(arg1),
            total_amount : v0,
            claimed      : 0,
            start_ms     : 0x2::clock::timestamp_ms(arg4),
            duration_ms  : arg3,
            mode         : arg2,
            version      : 1,
        };
        let v4 = TokensLocked{
            lock_id      : 0x2::object::id<VestingLock<T0>>(&v3),
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            beneficiary  : v3.beneficiary,
            total_amount : v0,
            start_ms     : v3.start_ms,
            duration_ms  : arg3,
            mode         : arg2,
        };
        0x2::event::emit<TokensLocked>(v4);
        0x2::transfer::share_object<VestingLock<T0>>(v3);
    }

    public fun lock_total<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.total_amount
    }

    public fun lock_version<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.version
    }

    public fun lp_fees_accumulated<T0>(arg0: &Curve<T0>) : u64 {
        arg0.lp_fees_accumulated
    }

    public fun metadata_updated<T0>(arg0: &Curve<T0>) : bool {
        arg0.metadata_updated
    }

    public fun migrate_curve<T0>(arg0: &mut Curve<T0>) {
        assert!(arg0.version < 1, 66);
        arg0.version = 1;
        let v0 = CurveMigrated{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<CurveMigrated>(v0);
    }

    public fun migrate_lock<T0>(arg0: &mut VestingLock<T0>) {
        assert!(arg0.version < 1, 66);
        arg0.version = 1;
        let v0 = LockMigrated{
            lock_id      : 0x2::object::id<VestingLock<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<LockMigrated>(v0);
    }

    public fun migrate_price_config(arg0: &mut PriceConfig) {
        assert!(arg0.version < 1, 66);
        arg0.version = 1;
        let v0 = PriceConfigMigrated{
            config_id    : 0x2::object::id<PriceConfig>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<PriceConfigMigrated>(v0);
    }

    public fun migrate_proposal<T0>(arg0: &mut TakeoverProposal<T0>) {
        assert!(arg0.version < 1, 66);
        arg0.version = 1;
        let v0 = ProposalMigrated{
            proposal_id  : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<ProposalMigrated>(v0);
    }

    public fun paused<T0>(arg0: &Curve<T0>) : bool {
        arg0.paused
    }

    public fun pool_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun post_comment<T0>(arg0: &mut Curve<T0>, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.paused, 28);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000, 26);
        if (comments_holder_gated<T0>(arg0)) {
            assert!(0x2::coin::value<T0>(arg3) > 0, 37);
        };
        let v0 = 0x1::string::length(&arg1);
        assert!(v0 > 0, 17);
        assert!(v0 <= 280, 16);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = Comment{
            curve_id  : 0x2::object::id<Curve<T0>>(arg0),
            author    : 0x2::tx_context::sender(arg5),
            text      : arg1,
            parent_id : arg4,
        };
        0x2::event::emit<Comment>(v1);
    }

    public fun price_config_id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.price_config_id
    }

    public fun price_config_version(arg0: &PriceConfig) : u64 {
        arg0.version
    }

    public fun price_scaled(arg0: &PriceConfig) : u64 {
        arg0.sui_price_scaled
    }

    public fun price_updated_at_ms(arg0: &PriceConfig) : u64 {
        arg0.updated_at_ms
    }

    public fun proposal_curve_id<T0>(arg0: &TakeoverProposal<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun proposal_deadline_ms<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun proposal_escrow_value<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun proposal_has_voter<T0>(arg0: &TakeoverProposal<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.votes, arg1)
    }

    public fun proposal_proposer<T0>(arg0: &TakeoverProposal<T0>) : address {
        arg0.proposer
    }

    public fun proposal_quorum_target<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.quorum_target
    }

    public fun proposal_resolved<T0>(arg0: &TakeoverProposal<T0>) : bool {
        arg0.resolved
    }

    public fun proposal_succeeded<T0>(arg0: &TakeoverProposal<T0>) : bool {
        arg0.succeeded
    }

    public fun proposal_total_weight<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.total_weight
    }

    public fun proposal_version<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.version
    }

    public fun proposal_voter_weight<T0>(arg0: &TakeoverProposal<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.votes, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.votes, arg1)
        } else {
            0
        }
    }

    public fun propose_takeover<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 4);
        assert!(!arg0.paused, 28);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.last_creator_activity_ms >= 432000000, 40);
        assert!(v0 >= arg0.cto_cooldown_until_ms, 41);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"cto_live_proposal"), 55);
        let v1 = circulating_supply<T0>(arg0);
        assert!(v1 > 0, 59);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 59);
        assert!(v2 >= v1 * 100 / 10000, 42);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v4, v3, v2);
        let v5 = TakeoverProposal<T0>{
            id            : 0x2::object::new(arg3),
            curve_id      : 0x2::object::id<Curve<T0>>(arg0),
            proposer      : v3,
            proposer_bond : v2,
            opened_at_ms  : v0,
            deadline_ms   : v0 + 259200000,
            escrow        : 0x2::coin::into_balance<T0>(arg1),
            votes         : v4,
            total_weight  : v2,
            quorum_target : v1 * 2500 / 10000,
            resolved      : false,
            succeeded     : false,
            version       : 1,
        };
        let v6 = 0x2::object::id<TakeoverProposal<T0>>(&v5);
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"cto_live_proposal", v6);
        let v7 = TakeoverProposed{
            curve_id    : 0x2::object::id<Curve<T0>>(arg0),
            proposal_id : v6,
            proposer    : v3,
            deadline_ms : v5.deadline_ms,
        };
        0x2::event::emit<TakeoverProposed>(v7);
        0x2::transfer::share_object<TakeoverProposal<T0>>(v5);
    }

    public fun protocol_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_fees)
    }

    fun quote_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        (((arg2 as u128) * v0 / ((arg1 as u128) + v0)) as u64)
    }

    public fun reclaim_vote<T0>(arg0: &mut TakeoverProposal<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 58);
        assert!(0x2::table::contains<address, u64>(&arg0.votes, arg1), 57);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.votes, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v0), arg2), arg1);
        let v1 = VoteReclaimed{
            proposal_id : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            voter       : arg1,
            amount      : v0,
        };
        0x2::event::emit<VoteReclaimed>(v1);
    }

    public fun record_graduation_pool<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        record_graduation_pool_impl<T0>(arg1, arg2, arg3);
    }

    fun record_graduation_pool_impl<T0>(arg0: &mut Curve<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert_curve_version<T0>(arg0);
        assert!(arg0.graduated, 5);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 29);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.creator_lp_nft_id = 0x1::option::some<0x2::object::ID>(arg2);
        let v0 = PoolRecorded{
            curve_id          : 0x2::object::id<Curve<T0>>(arg0),
            pool_id           : arg1,
            creator_lp_nft_id : arg2,
        };
        0x2::event::emit<PoolRecorded>(v0);
    }

    public fun record_graduation_pool_with_cap<T0>(arg0: &GraduationCap, arg1: &GraduationRegistry, arg2: &mut Curve<T0>, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        assert!(0x2::object::id<GraduationRegistry>(arg1) == arg2.graduation_registry_id, 68);
        assert!(arg1.active_cap_id == 0x2::object::id<GraduationCap>(arg0), 61);
        record_graduation_pool_impl<T0>(arg2, arg3, arg4);
    }

    fun reserve_after_grad_bonuses(arg0: u64) : u64 {
        let (v0, v1) = grad_bonuses(arg0);
        arg0 - v0 - v1
    }

    fun resolve_grad_threshold(arg0: &PriceConfig, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.sui_price_scaled == 0) {
            return 9000000000000
        };
        if (0x2::clock::timestamp_ms(arg1) > arg0.updated_at_ms + 1800000) {
            return 9000000000000
        };
        dampened_grad_threshold(arg0.sui_price_scaled)
    }

    public fun resolve_takeover<T0>(arg0: &mut TakeoverProposal<T0>, arg1: &mut Curve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert!(arg0.curve_id == 0x2::object::id<Curve<T0>>(arg1), 44);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.deadline_ms, 46);
        assert!(!arg0.resolved, 48);
        let v1 = arg0.quorum_target;
        let v2 = if (v0 - arg1.last_creator_activity_ms >= 432000000) {
            if (v1 > 0) {
                if (arg0.total_weight > 0) {
                    arg0.total_weight >= v1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        arg0.resolved = true;
        arg0.succeeded = v2;
        0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(&mut arg1.id, b"cto_live_proposal");
        if (v2) {
            let v3 = CreatorCap{
                id       : 0x2::object::new(arg3),
                curve_id : 0x2::object::id<Curve<T0>>(arg1),
            };
            arg1.active_creator_cap_id = 0x2::object::id<CreatorCap>(&v3);
            arg1.creator = arg0.proposer;
            arg1.last_creator_activity_ms = v0;
            0x2::transfer::public_transfer<CreatorCap>(v3, arg0.proposer);
        } else {
            let v4 = if (arg0.total_weight >= v1) {
                0
            } else {
                v1 - arg0.total_weight
            };
            let v5 = if (v1 == 0) {
                259200000
            } else {
                (((259200000 as u128) * (v4 as u128) / (v1 as u128)) as u64)
            };
            arg1.cto_cooldown_until_ms = v0 + v5;
        };
        let v6 = TakeoverResolved{
            proposal_id  : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            curve_id     : 0x2::object::id<Curve<T0>>(arg1),
            succeeded    : v2,
            total_weight : arg0.total_weight,
        };
        0x2::event::emit<TakeoverResolved>(v6);
    }

    public fun rotate_graduation_cap(arg0: &AdminCap, arg1: &mut GraduationRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GraduationCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<GraduationCap>(&v0);
        arg1.active_cap_id = v1;
        let v2 = GraduationCapRotated{
            old_cap_id : arg1.active_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<GraduationCapRotated>(v2);
        0x2::transfer::public_transfer<GraduationCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun rotate_launch_issuer_cap(arg0: &AdminCap, arg1: &mut LaunchIssuerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchIssuerCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<LaunchIssuerCap>(&v0);
        arg1.active_cap_id = v1;
        let v2 = LaunchIssuerCapRotated{
            old_cap_id : arg1.active_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<LaunchIssuerCapRotated>(v2);
        0x2::transfer::public_transfer<LaunchIssuerCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun rotate_price_relayer_cap(arg0: &AdminCap, arg1: &mut LaunchIssuerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceRelayerCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<PriceRelayerCap>(&v0);
        arg1.active_price_relayer_cap_id = v1;
        let v2 = PriceRelayerCapRotated{
            old_cap_id : arg1.active_price_relayer_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<PriceRelayerCapRotated>(v2);
        0x2::transfer::public_transfer<PriceRelayerCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 4);
        assert!(!arg0.paused, 28);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        assert_no_self_referral(&arg3, arg0.creator, arg4);
        let v1 = quote_out(v0, effective_token_reserve<T0>(arg0), effective_sui_reserve<T0>(arg0));
        let v2 = v1 * 100 / 10000;
        let v3 = 0x1::option::is_some<address>(&arg3);
        let (v4, v5, v6, v7, v8) = split_fee_v7(v2, v3);
        let v9 = v4 * arg0.buyback.bps / 10000;
        let v10 = v4 - v9;
        let v11 = v1 - v2;
        assert!(v11 >= arg2, 3);
        let v12 = v1 - v7;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v12, 2);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v13 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v12), arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v10, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v5, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.airdrop_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v6, arg4)));
        if (v9 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v9, arg4)));
        };
        emit_buyback_ready_if_crossed<T0>(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees));
        if (v8 > 0 && v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v8, arg4), *0x1::option::borrow<address>(&arg3));
        };
        arg0.lp_fees_accumulated = arg0.lp_fees_accumulated + v7;
        let v14 = TokensSold{
            curve_id          : 0x2::object::id<Curve<T0>>(arg0),
            seller            : 0x2::tx_context::sender(arg4),
            tokens_in         : v0,
            sui_out           : v11,
            creator_fee       : v10,
            protocol_fee      : v5,
            airdrop_fee       : v6,
            lp_fee            : v7,
            referral_fee      : v8,
            referral          : arg3,
            new_sui_reserve   : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            new_token_reserve : 0x2::balance::value<T0>(&arg0.token_reserve),
        };
        0x2::event::emit<TokensSold>(v14);
        v13
    }

    public fun set_buyback_config<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1, arg7);
        assert!(arg2 <= 10000, 38);
        assert!(arg4 < 10000, 69);
        assert!(arg6 == 0 || arg6 >= 1000000, 75);
        let v0 = if (arg4 == 0) {
            9900
        } else {
            arg4
        };
        assert!(v0 >= 9000, 78);
        assert!(arg5 == 0 || arg5 > 0x2::clock::timestamp_ms(arg7) + 600000, 79);
        let v1 = BuybackConfig{
            bps            : arg2,
            burn           : arg3,
            min_out_bps    : v0,
            deadline_ms    : arg5,
            threshold_mist : arg6,
        };
        arg1.buyback = v1;
        let v2 = BuybackConfigured{
            curve_id       : 0x2::object::id<Curve<T0>>(arg1),
            buyback_bps    : arg2,
            burn           : arg3,
            min_out_bps    : v0,
            deadline_ms    : arg5,
            threshold_mist : arg6,
        };
        0x2::event::emit<BuybackConfigured>(v2);
    }

    public fun set_comment_gate<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1, arg3);
        if (arg2) {
            assert!(0x2::dynamic_field::exists<vector<u8>>(&arg1.id, b"comments_ungated"), 50);
            0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg1.id, b"comments_ungated");
        } else {
            assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg1.id, b"comments_ungated"), 50);
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, b"comments_ungated", true);
        };
        let v0 = CommentGateSet{
            curve_id     : 0x2::object::id<Curve<T0>>(arg1),
            holder_gated : arg2,
        };
        0x2::event::emit<CommentGateSet>(v0);
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: bool) {
        assert_curve_version<T0>(arg1);
        arg1.paused = arg2;
        let v0 = PauseToggled{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            paused   : arg2,
        };
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun set_sui_price(arg0: &PriceRelayerCap, arg1: &LaunchIssuerRegistry, arg2: &mut PriceConfig, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2.version == 1, 66);
        assert!(0x2::object::id<PriceRelayerCap>(arg0) == arg1.active_price_relayer_cap_id, 77);
        assert!(0x2::object::id<PriceConfig>(arg2) == arg1.price_config_id, 67);
        assert!(arg3 >= 100 && arg3 <= 35000, 43);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2.sui_price_scaled != 0) {
            assert!(v0 >= arg2.updated_at_ms + 240000, 72);
            if (v0 <= arg2.updated_at_ms + 3600000) {
                let v1 = arg2.sui_price_scaled;
                let v2 = v1 * 2000 / 10000;
                assert!(arg3 <= v1 + v2 && arg3 + v2 >= v1, 73);
            };
        };
        arg2.sui_price_scaled = arg3;
        arg2.updated_at_ms = v0;
        let v3 = SuiPriceUpdated{
            price_scaled  : arg3,
            updated_at_ms : arg2.updated_at_ms,
        };
        0x2::event::emit<SuiPriceUpdated>(v3);
    }

    public fun share_curve<T0>(arg0: Curve<T0>) {
        0x2::transfer::share_object<Curve<T0>>(arg0);
    }

    fun split_fee_v7(arg0: u64, arg1: bool) : (u64, u64, u64, u64, u64) {
        let v0 = arg0 * 4000 / 10000;
        let v1 = arg0 * 1000 / 10000;
        let v2 = if (arg1) {
            arg0 * 1000 / 10000
        } else {
            0
        };
        let v3 = arg0 - v0 - v1 - v2;
        let v4 = v3 / 2;
        (v0, v3 - v4, v4, v1, v2)
    }

    public fun sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun sweep_expired_buyback<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg0);
        assert!(!arg0.graduated, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.buyback.deadline_ms != 0 && v0 > arg0.buyback.deadline_ms, 80);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_fees);
        assert!(v1 > 0, 39);
        assert!(v0 >= arg0.last_buyback_ms + 600000, 74);
        arg0.last_buyback_ms = v0;
        let v2 = (((effective_sui_reserve<T0>(arg0) as u128) * (100 as u128) / (10000 as u128)) as u64);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.buyback_fees, v3));
        let v4 = BuybackSweptExpired{
            curve_id  : 0x2::object::id<Curve<T0>>(arg0),
            sui_swept : v3,
        };
        0x2::event::emit<BuybackSweptExpired>(v4);
    }

    public fun token_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun unvote_takeover<T0>(arg0: &mut TakeoverProposal<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_proposal_version<T0>(arg0);
        assert!(!arg0.resolved, 48);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.deadline_ms, 45);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.votes, v0), 57);
        let v1 = if (v0 == arg0.proposer) {
            let v2 = *0x2::table::borrow<address, u64>(&arg0.votes, v0) - arg0.proposer_bond;
            assert!(v2 > 0, 60);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.votes, v0) = arg0.proposer_bond;
            v2
        } else {
            0x2::table::remove<address, u64>(&mut arg0.votes, v0)
        };
        arg0.total_weight = arg0.total_weight - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v1), arg2), v0);
        let v3 = TakeoverUnvoted{
            proposal_id : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            voter       : v0,
            amount      : v1,
        };
        0x2::event::emit<TakeoverUnvoted>(v3);
    }

    public fun update_metadata<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1, arg7);
        assert!(!arg1.metadata_updated, 22);
        assert!(0x2::clock::timestamp_ms(arg7) < arg1.created_at_ms + 86400000, 23);
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            true
        } else if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            true
        } else {
            0x1::option::is_some<0x1::string::String>(&arg6)
        };
        assert!(v0, 23);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v1 = 0x1::option::borrow<0x1::string::String>(&arg3);
            assert!(0x1::string::length(v1) <= 64, 24);
            0x2::coin::update_name<T0>(&arg1.treasury, arg2, *v1);
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            let v2 = 0x1::option::borrow<0x1::ascii::String>(&arg4);
            assert!(0x1::ascii::length(v2) <= 16, 25);
            0x2::coin::update_symbol<T0>(&arg1.treasury, arg2, *v2);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            0x2::coin::update_description<T0>(&arg1.treasury, arg2, *0x1::option::borrow<0x1::string::String>(&arg5));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            0x2::coin::update_icon_url<T0>(&arg1.treasury, arg2, 0x1::ascii::string(*0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&arg6))));
        };
        arg1.metadata_updated = true;
        let v3 = MetadataUpdated{curve_id: 0x2::object::id<Curve<T0>>(arg1)};
        0x2::event::emit<MetadataUpdated>(v3);
    }

    public fun update_payouts<T0>(arg0: &CreatorCap, arg1: &mut Curve<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_curve_version<T0>(arg1);
        assert_active_creator<T0>(arg0, arg1, arg4);
        assert!(!arg1.paused, 28);
        arg1.payouts = build_payouts(arg2, arg3);
        let v0 = PayoutsUpdated{
            curve_id   : 0x2::object::id<Curve<T0>>(arg1),
            updated_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PayoutsUpdated>(v0);
    }

    public fun version<T0>(arg0: &Curve<T0>) : u64 {
        arg0.version
    }

    fun vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64) : u64 {
        if (arg4 < arg1) {
            return 0
        };
        let v0 = arg4 - arg1;
        if (arg3 == 0) {
            if (v0 >= arg2) {
                arg0
            } else {
                0
            }
        } else if (arg3 == 1) {
            if (v0 >= arg2) {
                arg0
            } else {
                (((arg0 as u128) * (v0 as u128) / (arg2 as u128)) as u64)
            }
        } else {
            let v2 = v0 / 2592000000;
            let v3 = arg2 / 2592000000;
            if (v2 >= v3) {
                arg0
            } else {
                (((arg0 as u128) * (v2 as u128) / (v3 as u128)) as u64)
            }
        }
    }

    public fun vote_takeover<T0>(arg0: &mut TakeoverProposal<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_proposal_version<T0>(arg0);
        assert!(!arg0.resolved, 48);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline_ms, 45);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 800000000000000 * 1 / 10000, 56);
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.votes, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.votes, v1) = *0x2::table::borrow<address, u64>(&arg0.votes, v1) + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.votes, v1, v0);
        };
        arg0.total_weight = arg0.total_weight + v0;
        let v2 = TakeoverVoted{
            proposal_id  : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            voter        : v1,
            amount       : v0,
            total_weight : arg0.total_weight,
        };
        0x2::event::emit<TakeoverVoted>(v2);
    }

    // decompiled from Move bytecode v7
}

