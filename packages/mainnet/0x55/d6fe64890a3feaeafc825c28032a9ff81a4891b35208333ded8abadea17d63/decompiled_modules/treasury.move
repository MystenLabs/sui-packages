module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury {
    struct TreasuryPolicy has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        policy_hash: vector<u8>,
        auto_yield_enabled: bool,
        yield_claim_enabled: bool,
        swap_enabled: bool,
        max_slippage_bps: u64,
        min_runtime_reserve_micros: u64,
        min_stake_amount_micros: u64,
        min_claim_amount_micros: u64,
        harvest_interval_ms: u64,
        last_yield_claim_ms: u64,
        main_treasury_wallet_ref: 0x1::string::String,
        allowed_yield_venue_hashes: vector<vector<u8>>,
        protocol_yield_skim_bps: u64,
        keep_alive_buffer_bps: u64,
        storage_markup_bps: u64,
        text_compute_markup_bps: u64,
        media_compute_markup_bps: u64,
        creator_margin_share_bps: u64,
        endowment_margin_share_bps: u64,
        protocol_margin_share_bps: u64,
        gas_front_markup_bps: u64,
        max_gas_front_micros: u64,
        allowed_gas_treasury_wallet_refs: vector<0x1::string::String>,
        nonce: u64,
        locked: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct Endowment<phantom T0> has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        principal: 0x2::balance::Balance<T0>,
        keep_alive_allocation: 0x2::balance::Balance<T0>,
        storage_allocation: 0x2::balance::Balance<T0>,
        interaction_allocation: 0x2::balance::Balance<T0>,
        fee_sink: 0x2::balance::Balance<T0>,
        unspent_credit_liability: 0x2::balance::Balance<T0>,
        keep_alive_target_mist: u64,
        storage_target_mist: u64,
        interaction_target_mist: u64,
        keep_alive_reserve_mist: u64,
        heartbeat_interval_ms: u64,
        last_epoch_ms: u64,
        heartbeat_bounty_mist: u64,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct TreasuryPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        auto_yield_enabled: bool,
        yield_claim_enabled: bool,
        swap_enabled: bool,
        timestamp_ms: u64,
    }

    struct TreasuryPolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct TreasuryLocked has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        locked: bool,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct EndowmentCreated has copy, drop {
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        principal_mist: u64,
        keep_alive_reserve_mist: u64,
        heartbeat_interval_ms: u64,
        heartbeat_bounty_mist: u64,
        timestamp_ms: u64,
    }

    struct EndowmentConfigured has copy, drop {
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        keep_alive_target_mist: u64,
        storage_target_mist: u64,
        interaction_target_mist: u64,
        keep_alive_reserve_mist: u64,
        heartbeat_interval_ms: u64,
        heartbeat_bounty_mist: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct EndowmentTopUpRecorded has copy, drop {
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        funder: address,
        allocation_kind: u8,
        amount_mist: u64,
        principal_mist: u64,
        keep_alive_mist: u64,
        storage_mist: u64,
        interaction_mist: u64,
        timestamp_ms: u64,
    }

    struct EndowmentWithdrawalRecorded has copy, drop {
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        amount_mist: u64,
        remaining_principal_mist: u64,
        keep_alive_reserve_mist: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct EndowmentHeartbeatRecorded has copy, drop {
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        keeper: address,
        net_yield_mist: u64,
        keep_alive_allocated_mist: u64,
        storage_allocated_mist: u64,
        interaction_allocated_mist: u64,
        residual_compound_mist: u64,
        bounty_mist: u64,
        principal_mist: u64,
        keep_alive_mist: u64,
        storage_mist: u64,
        interaction_mist: u64,
        epoch_ms: u64,
    }

    struct ContributionRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        contributor: address,
        contribution_ref: 0x1::string::String,
        receipt_hash: vector<u8>,
        purpose: 0x1::string::String,
        amount_micros: u64,
        timestamp_ms: u64,
    }

    struct TreasuryIntentRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        intent_type: 0x1::string::String,
        venue_ref: 0x1::string::String,
        amount_micros: u64,
        max_slippage_bps: u64,
        intent_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct TreasurySweepIntentRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        source_wallet_ref: 0x1::string::String,
        destination_wallet_ref: 0x1::string::String,
        amount_micros: u64,
        sweep_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct TreasuryYieldHarvestPolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        main_treasury_wallet_ref: 0x1::string::String,
        harvest_interval_ms: u64,
        min_claim_amount_micros: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct TreasuryYieldVenueAllowed has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        venue_ref: 0x1::string::String,
        venue_hash: vector<u8>,
        allowed: bool,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct TreasuryMonthlyYieldHarvestIntentRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        venue_ref: 0x1::string::String,
        venue_hash: vector<u8>,
        source_wallet_ref: 0x1::string::String,
        destination_wallet_ref: 0x1::string::String,
        estimated_yield_micros: u64,
        principal_micros: u64,
        harvest_interval_ms: u64,
        intent_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct TreasuryWaterfallRatesUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        protocol_yield_skim_bps: u64,
        keep_alive_buffer_bps: u64,
        storage_markup_bps: u64,
        text_compute_markup_bps: u64,
        media_compute_markup_bps: u64,
        creator_margin_share_bps: u64,
        endowment_margin_share_bps: u64,
        protocol_margin_share_bps: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct TreasuryWaterfallRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        keep_alive_paid_micros: u64,
        storage_paid_micros: u64,
        interaction_budget_micros: u64,
        residual_compound_micros: u64,
        dormant: bool,
        waterfall_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct GasTreasuryPolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        gas_front_markup_bps: u64,
        max_gas_front_micros: u64,
        allowed_wallet_count: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct GasFrontRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        chain_namespace: 0x1::string::String,
        gas_treasury_wallet_ref: 0x1::string::String,
        funded_wallet_ref: 0x1::string::String,
        fronted_micros: u64,
        markup_bps: u64,
        repayment_due_micros: u64,
        gas_front_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct GasRepaymentRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        chain_namespace: 0x1::string::String,
        gas_treasury_wallet_ref: 0x1::string::String,
        repayment_micros: u64,
        repayment_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct CreatorInteractionPaymentRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        payer: address,
        payment_ref: 0x1::string::String,
        gross_payment_micros: u64,
        compute_floor_micros: u64,
        creator_share_micros: u64,
        endowment_share_micros: u64,
        protocol_share_micros: u64,
        receipt_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct EndowmentInteractionPaymentSettled has copy, drop {
        policy_id: 0x2::object::ID,
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        payer: address,
        serving_provider: address,
        protocol_recipient: address,
        payment_ref: 0x1::string::String,
        gross_payment_mist: u64,
        compute_paid_mist: u64,
        endowment_credited_mist: u64,
        protocol_paid_mist: u64,
        receipt_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct StorageRenewalPaidFromEndowment has copy, drop {
        endowment_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        payer: address,
        renewal_provider: address,
        amount_micros: u64,
        target_expiry_ms: u64,
        renewal_epochs: u64,
        receipt_hash: vector<u8>,
        walrus_tx_digest: vector<u8>,
        storage_allocation_micros: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct TreasuryPolicySet has copy, drop {
        anft_id: 0x2::object::ID,
    }

    struct DepositRecognized has copy, drop {
        anft_id: 0x2::object::ID,
        chain: vector<u8>,
        amount: u64,
        is_credit_purchase: bool,
        at_ms: u64,
    }

    struct ToppedUp has copy, drop {
        anft_id: 0x2::object::ID,
        target: u8,
        amount: u64,
    }

    struct Donated has copy, drop {
        anft_id: 0x2::object::ID,
        net_amount: u64,
    }

    struct AllocationFlow has copy, drop {
        anft_id: 0x2::object::ID,
        from_bucket: u8,
        to_bucket: u8,
        amount: u64,
        reason: u8,
        at_ms: u64,
    }

    fun assert_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, arg1);
    }

    public fun allocation_interaction() : u8 {
        3
    }

    public fun allocation_keep_alive() : u8 {
        1
    }

    public fun allocation_principal() : u8 {
        0
    }

    public fun allocation_storage() : u8 {
        2
    }

    public(friend) fun apply_inflow_fee<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: bool) : 0x2::balance::Balance<T0> {
        let v0 = if (arg4) {
            min_u64(mul_bps(arg3, arg2), 0x2::balance::value<T0>(&arg1))
        } else {
            mul_bps(0x2::balance::value<T0>(&arg1), arg2)
        };
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg0.fee_sink, 0x2::balance::split<T0>(&mut arg1, v0));
        };
        arg1
    }

    fun apply_top_up<T0>(arg0: &mut Endowment<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>) {
        if (arg1 == 0) {
            0x2::coin::put<T0>(&mut arg0.principal, arg2);
        } else if (arg1 == 1) {
            0x2::coin::put<T0>(&mut arg0.keep_alive_allocation, arg2);
        } else if (arg1 == 2) {
            0x2::coin::put<T0>(&mut arg0.storage_allocation, arg2);
        } else {
            assert!(arg1 == 3, 217);
            0x2::coin::put<T0>(&mut arg0.interaction_allocation, arg2);
        };
    }

    fun assert_allocation_kind(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 217);
    }

    fun assert_bps(arg0: u64) {
        assert!(arg0 <= 10000, 215);
    }

    fun assert_endowment_args(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 >= 1, 218);
        assert!(arg0 >= arg1, 219);
        assert!(arg2 >= 86400000, 212);
        assert!(arg3 > 0, 207);
    }

    fun assert_endowment_matches<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &Endowment<T0>) {
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 201);
    }

    fun assert_endowment_owner<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &Endowment<T0>, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 200);
        assert_endowment_matches<T0>(arg0, arg1);
    }

    fun assert_gas_treasury_allowed(arg0: &TreasuryPolicy, arg1: &vector<u8>) {
        let v0 = 0x1::string::utf8(*arg1);
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.allowed_gas_treasury_wallet_refs, &v0), 221);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 202);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 204);
    }

    fun assert_margin_split(arg0: u64, arg1: u64, arg2: u64) {
        assert_bps(arg0);
        assert_bps(arg1);
        assert_bps(arg2);
        assert!(arg0 + arg1 + arg2 == 10000, 216);
    }

    fun assert_policy_args(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) {
        assert_ref(arg0);
        assert_hash(arg1);
        assert!(arg2 <= 10000, 205);
    }

    fun assert_policy_matches(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy) {
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 201);
    }

    fun assert_policy_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 200);
        assert_policy_matches(arg0, arg1);
    }

    fun assert_policy_unlocked(arg0: &TreasuryPolicy) {
        assert!(!arg0.locked, 206);
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 202);
        assert!(0x1::vector::length<u8>(arg0) <= 512, 203);
    }

    fun assert_venue_allowed(arg0: &TreasuryPolicy, arg1: &vector<u8>) {
        assert_hash(arg1);
        assert!(0x1::vector::contains<vector<u8>>(&arg0.allowed_yield_venue_hashes, arg1), 211);
    }

    fun assert_withdrawable_principal<T0>(arg0: &Endowment<T0>, arg1: u64) : u64 {
        assert!(arg1 > 0, 207);
        assert!(0x2::balance::value<T0>(&arg0.principal) >= arg1, 219);
        let v0 = 0x2::balance::value<T0>(&arg0.principal) - arg1;
        assert!(v0 >= arg0.keep_alive_reserve_mist, 219);
        v0
    }

    public fun auto_yield_enabled(arg0: &TreasuryPolicy) : bool {
        arg0.auto_yield_enabled
    }

    public(friend) fun buy_credits<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: vector<u8>, arg4: u64) : u64 {
        let v0 = apply_inflow_fee<T0>(arg0, arg1, arg2, 0, false);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg0.unspent_credit_liability, v0);
        arg0.nonce = arg0.nonce + 1;
        let v2 = DepositRecognized{
            anft_id            : arg0.character_id,
            chain              : arg3,
            amount             : v1,
            is_credit_purchase : true,
            at_ms              : arg4,
        };
        0x2::event::emit<DepositRecognized>(v2);
        v1
    }

    entry fun configure_endowment<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Endowment<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_endowment_owner<T0>(arg0, arg1, 0x2::tx_context::sender(arg9));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_endowment_args(0x2::balance::value<T0>(&arg1.principal), arg5, arg6, arg7);
        arg1.keep_alive_target_mist = arg2;
        arg1.storage_target_mist = arg3;
        arg1.interaction_target_mist = arg4;
        arg1.keep_alive_reserve_mist = arg5;
        arg1.heartbeat_interval_ms = arg6;
        arg1.heartbeat_bounty_mist = arg7;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg8);
        let v0 = EndowmentConfigured{
            endowment_id            : 0x2::object::uid_to_inner(&arg1.id),
            character_id            : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                   : 0x2::tx_context::sender(arg9),
            keep_alive_target_mist  : arg2,
            storage_target_mist     : arg3,
            interaction_target_mist : arg4,
            keep_alive_reserve_mist : arg5,
            heartbeat_interval_ms   : arg6,
            heartbeat_bounty_mist   : arg7,
            nonce                   : arg1.nonce,
            timestamp_ms            : arg1.updated_at_ms,
        };
        0x2::event::emit<EndowmentConfigured>(v0);
    }

    entry fun configure_gas_treasury_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert_policy_unlocked(arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_bps(arg2);
        assert!(arg3 > 0, 207);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        let v2 = 0x1::vector::length<vector<u8>>(&arg4);
        while (v1 < v2) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg4, v1);
            assert_ref(v3);
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(*v3));
            v1 = v1 + 1;
        };
        assert!(v2 > 0, 221);
        arg1.gas_front_markup_bps = arg2;
        arg1.max_gas_front_micros = arg3;
        arg1.allowed_gas_treasury_wallet_refs = v0;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v4 = GasTreasuryPolicyUpdated{
            policy_id            : 0x2::object::uid_to_inner(&arg1.id),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                : 0x2::tx_context::sender(arg6),
            gas_front_markup_bps : arg2,
            max_gas_front_micros : arg3,
            allowed_wallet_count : v2,
            nonce                : arg1.nonce,
            timestamp_ms         : arg1.updated_at_ms,
        };
        0x2::event::emit<GasTreasuryPolicyUpdated>(v4);
    }

    entry fun configure_waterfall_rates(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg11));
        assert_policy_unlocked(arg1);
        assert_bps(arg2);
        assert_bps(arg3);
        assert_bps(arg4);
        assert_bps(arg5);
        assert_bps(arg6);
        assert_margin_split(arg7, arg8, arg9);
        arg1.protocol_yield_skim_bps = arg2;
        arg1.keep_alive_buffer_bps = arg3;
        arg1.storage_markup_bps = arg4;
        arg1.text_compute_markup_bps = arg5;
        arg1.media_compute_markup_bps = arg6;
        arg1.creator_margin_share_bps = arg7;
        arg1.endowment_margin_share_bps = arg8;
        arg1.protocol_margin_share_bps = arg9;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg10);
        let v0 = TreasuryWaterfallRatesUpdated{
            policy_id                  : 0x2::object::uid_to_inner(&arg1.id),
            character_id               : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                      : 0x2::tx_context::sender(arg11),
            protocol_yield_skim_bps    : arg2,
            keep_alive_buffer_bps      : arg3,
            storage_markup_bps         : arg4,
            text_compute_markup_bps    : arg5,
            media_compute_markup_bps   : arg6,
            creator_margin_share_bps   : arg7,
            endowment_margin_share_bps : arg8,
            protocol_margin_share_bps  : arg9,
            nonce                      : arg1.nonce,
            timestamp_ms               : arg1.updated_at_ms,
        };
        0x2::event::emit<TreasuryWaterfallRatesUpdated>(v0);
    }

    entry fun configure_yield_harvest(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert_policy_unlocked(arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert!(arg3 >= 86400000, 212);
        assert!(arg4 > 0, 207);
        arg1.main_treasury_wallet_ref = 0x1::string::utf8(arg2);
        arg1.harvest_interval_ms = arg3;
        arg1.min_claim_amount_micros = arg4;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = TreasuryYieldHarvestPolicyUpdated{
            policy_id                : 0x2::object::uid_to_inner(&arg1.id),
            character_id             : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                    : 0x2::tx_context::sender(arg6),
            main_treasury_wallet_ref : arg1.main_treasury_wallet_ref,
            harvest_interval_ms      : arg3,
            min_claim_amount_micros  : arg4,
            nonce                    : arg1.nonce,
            timestamp_ms             : arg1.updated_at_ms,
        };
        0x2::event::emit<TreasuryYieldHarvestPolicyUpdated>(v0);
    }

    entry fun create_endowment<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg9));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_endowment_args(v0, arg5, arg6, arg7);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = Endowment<T0>{
            id                       : 0x2::object::new(arg9),
            character_id             : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                    : 0x2::tx_context::sender(arg9),
            principal                : 0x2::coin::into_balance<T0>(arg1),
            keep_alive_allocation    : 0x2::balance::zero<T0>(),
            storage_allocation       : 0x2::balance::zero<T0>(),
            interaction_allocation   : 0x2::balance::zero<T0>(),
            fee_sink                 : 0x2::balance::zero<T0>(),
            unspent_credit_liability : 0x2::balance::zero<T0>(),
            keep_alive_target_mist   : arg2,
            storage_target_mist      : arg3,
            interaction_target_mist  : arg4,
            keep_alive_reserve_mist  : arg5,
            heartbeat_interval_ms    : arg6,
            last_epoch_ms            : 0,
            heartbeat_bounty_mist    : arg7,
            nonce                    : 0,
            created_at_ms            : v1,
            updated_at_ms            : v1,
        };
        let v3 = EndowmentCreated{
            endowment_id            : 0x2::object::uid_to_inner(&v2.id),
            character_id            : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                   : 0x2::tx_context::sender(arg9),
            principal_mist          : v0,
            keep_alive_reserve_mist : arg5,
            heartbeat_interval_ms   : arg6,
            heartbeat_bounty_mist   : arg7,
            timestamp_ms            : v1,
        };
        0x2::event::emit<EndowmentCreated>(v3);
        0x2::transfer::share_object<Endowment<T0>>(v2);
    }

    entry fun create_treasury_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg11));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_policy_args(&arg1, &arg2, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = TreasuryPolicy{
            id                               : 0x2::object::new(arg11),
            character_id                     : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                            : 0x2::tx_context::sender(arg11),
            policy_uri                       : 0x1::string::utf8(arg1),
            policy_hash                      : arg2,
            auto_yield_enabled               : arg3,
            yield_claim_enabled              : arg4,
            swap_enabled                     : arg5,
            max_slippage_bps                 : arg6,
            min_runtime_reserve_micros       : arg7,
            min_stake_amount_micros          : arg8,
            min_claim_amount_micros          : arg9,
            harvest_interval_ms              : 2592000000,
            last_yield_claim_ms              : 0,
            main_treasury_wallet_ref         : 0x1::string::utf8(b"unset"),
            allowed_yield_venue_hashes       : vector[],
            protocol_yield_skim_bps          : 1000,
            keep_alive_buffer_bps            : 500,
            storage_markup_bps               : 4000,
            text_compute_markup_bps          : 20000,
            media_compute_markup_bps         : 10000,
            creator_margin_share_bps         : 7500,
            endowment_margin_share_bps       : 1500,
            protocol_margin_share_bps        : 1000,
            gas_front_markup_bps             : 5000,
            max_gas_front_micros             : 0,
            allowed_gas_treasury_wallet_refs : 0x1::vector::empty<0x1::string::String>(),
            nonce                            : 0,
            locked                           : false,
            created_at_ms                    : v0,
            updated_at_ms                    : v0,
        };
        let v2 = TreasuryPolicyCreated{
            policy_id           : 0x2::object::uid_to_inner(&v1.id),
            character_id        : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner               : 0x2::tx_context::sender(arg11),
            policy_uri          : v1.policy_uri,
            auto_yield_enabled  : arg3,
            yield_claim_enabled : arg4,
            swap_enabled        : arg5,
            timestamp_ms        : v0,
        };
        0x2::event::emit<TreasuryPolicyCreated>(v2);
        0x2::transfer::public_transfer<TreasuryPolicy>(v1, 0x2::tx_context::sender(arg11));
    }

    public(friend) fun deposit_donation<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: vector<u8>, arg4: u64) : u64 {
        let v0 = apply_inflow_fee<T0>(arg0, arg1, arg2, 0, false);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (_, _) = split_deposit_buffer_first<T0>(arg0, v0, arg4);
        arg0.nonce = arg0.nonce + 1;
        let v4 = Donated{
            anft_id    : arg0.character_id,
            net_amount : v1,
        };
        0x2::event::emit<Donated>(v4);
        let v5 = DepositRecognized{
            anft_id            : arg0.character_id,
            chain              : arg3,
            amount             : v1,
            is_credit_purchase : false,
            at_ms              : arg4,
        };
        0x2::event::emit<DepositRecognized>(v5);
        v1
    }

    public(friend) fun deposit_swept_principal<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x2::balance::join<T0>(&mut arg0.principal, arg1);
        arg0.nonce = arg0.nonce + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::value<T0>(&arg0.principal)
    }

    public fun endowment_character_id<T0>(arg0: &Endowment<T0>) : 0x2::object::ID {
        arg0.character_id
    }

    public fun endowment_nonce<T0>(arg0: &Endowment<T0>) : u64 {
        arg0.nonce
    }

    public fun endowment_object_id<T0>(arg0: &Endowment<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun endowment_owner<T0>(arg0: &Endowment<T0>) : address {
        arg0.owner
    }

    fun fund_until_target<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg1);
        if (v0 >= arg2) {
            return 0
        };
        let v1 = 0x2::balance::value<T0>(arg0);
        if (v1 == 0) {
            return 0
        };
        let v2 = min_u64(v1, arg2 - v0);
        if (v2 == 0) {
            return 0
        };
        0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(arg0, v2));
        v2
    }

    public fun harvest_interval_ms(arg0: &TreasuryPolicy) : u64 {
        arg0.harvest_interval_ms
    }

    entry fun heartbeat<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Endowment<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_endowment_matches<T0>(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        let (v0, v1, v2, v3, v4, v5, v6) = run_heartbeat<T0>(arg1, arg2, arg3, arg4);
        if (v1) {
            let v7 = EndowmentHeartbeatRecorded{
                endowment_id               : 0x2::object::uid_to_inner(&arg1.id),
                character_id               : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
                keeper                     : 0x2::tx_context::sender(arg4),
                net_yield_mist             : 0x2::coin::value<T0>(&arg2),
                keep_alive_allocated_mist  : v2,
                storage_allocated_mist     : v3,
                interaction_allocated_mist : v4,
                residual_compound_mist     : v5,
                bounty_mist                : v6,
                principal_mist             : 0x2::balance::value<T0>(&arg1.principal),
                keep_alive_mist            : 0x2::balance::value<T0>(&arg1.keep_alive_allocation),
                storage_mist               : 0x2::balance::value<T0>(&arg1.storage_allocation),
                interaction_mist           : 0x2::balance::value<T0>(&arg1.interaction_allocation),
                epoch_ms                   : arg1.last_epoch_ms,
            };
            0x2::event::emit<EndowmentHeartbeatRecorded>(v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun heartbeat_bounty_mist<T0>(arg0: &Endowment<T0>) : u64 {
        arg0.heartbeat_bounty_mist
    }

    public fun interaction_allocation_mist<T0>(arg0: &Endowment<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.interaction_allocation)
    }

    public fun is_locked(arg0: &TreasuryPolicy) : bool {
        arg0.locked
    }

    public fun keep_alive_allocation_mist<T0>(arg0: &Endowment<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.keep_alive_allocation)
    }

    public fun keep_alive_reserve_mist<T0>(arg0: &Endowment<T0>) : u64 {
        arg0.keep_alive_reserve_mist
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    entry fun pay_storage_renewal<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::authority::AgentCap, arg2: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::authority::RevocationRegistry, arg3: &mut Endowment<T0>, arg4: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::storage_policy::StoragePolicy, arg5: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::storage_policy::StorageBlobRecord, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::authority::assert_cap_scope(arg0, arg1, arg2, arg9, 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::authority::scope_authorize_payment(), arg12, arg13);
        assert_endowment_matches<T0>(arg0, arg3);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert!(arg8 > 0, 207);
        assert_hash(&arg10);
        assert_hash(&arg11);
        assert!(0x2::balance::value<T0>(&arg3.storage_allocation) >= arg8, 224);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::storage_policy::record_paid_renewal_from_endowment(arg0, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12);
        arg3.nonce = arg3.nonce + 1;
        arg3.updated_at_ms = 0x2::clock::timestamp_ms(arg12);
        if (arg8 > 0) {
            let v0 = AllocationFlow{
                anft_id     : arg3.character_id,
                from_bucket : 3,
                to_bucket   : 6,
                amount      : arg8,
                reason      : 3,
                at_ms       : arg3.updated_at_ms,
            };
            0x2::event::emit<AllocationFlow>(v0);
        };
        let v1 = StorageRenewalPaidFromEndowment{
            endowment_id              : 0x2::object::uid_to_inner(&arg3.id),
            character_id              : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            policy_id                 : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::storage_policy::storage_policy_id(arg4),
            record_id                 : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::storage_policy::storage_blob_record_id(arg5),
            payer                     : 0x2::tx_context::sender(arg13),
            renewal_provider          : arg9,
            amount_micros             : arg8,
            target_expiry_ms          : arg6,
            renewal_epochs            : arg7,
            receipt_hash              : arg10,
            walrus_tx_digest          : arg11,
            storage_allocation_micros : 0x2::balance::value<T0>(&arg3.storage_allocation),
            nonce                     : arg3.nonce,
            timestamp_ms              : arg3.updated_at_ms,
        };
        0x2::event::emit<StorageRenewalPaidFromEndowment>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3.storage_allocation, arg8, arg13), arg9);
    }

    public fun policy_character_id(arg0: &TreasuryPolicy) : 0x2::object::ID {
        arg0.character_id
    }

    public fun policy_nonce(arg0: &TreasuryPolicy) : u64 {
        arg0.nonce
    }

    public fun policy_owner(arg0: &TreasuryPolicy) : address {
        arg0.owner
    }

    public fun principal_mist<T0>(arg0: &Endowment<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.principal)
    }

    public fun protocol_yield_skim_bps(arg0: &TreasuryPolicy) : u64 {
        arg0.protocol_yield_skim_bps
    }

    entry fun record_claim_yield_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert_policy_unlocked(arg1);
        assert!(arg1.yield_claim_enabled, 209);
        record_intent(arg0, arg1, b"claim_yield", arg2, arg3, 0, arg4, arg5, arg6);
    }

    entry fun record_contribution(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_hash(&arg3);
        assert_ref(&arg4);
        assert!(arg5 > 0, 207);
        let v0 = ContributionRecorded{
            policy_id        : 0x2::object::uid_to_inner(&arg1.id),
            character_id     : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            contributor      : 0x2::tx_context::sender(arg7),
            contribution_ref : 0x1::string::utf8(arg2),
            receipt_hash     : arg3,
            purpose          : 0x1::string::utf8(arg4),
            amount_micros    : arg5,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ContributionRecorded>(v0);
    }

    entry fun record_creator_interaction_payment(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        assert_policy_unlocked(arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_hash(&arg5);
        assert!(arg3 >= arg4, 213);
        let v0 = arg3 - arg4;
        let v1 = mul_bps(v0, arg1.creator_margin_share_bps);
        let v2 = mul_bps(v0, arg1.endowment_margin_share_bps);
        let v3 = CreatorInteractionPaymentRecorded{
            policy_id              : 0x2::object::uid_to_inner(&arg1.id),
            character_id           : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            payer                  : 0x2::tx_context::sender(arg7),
            payment_ref            : 0x1::string::utf8(arg2),
            gross_payment_micros   : arg3,
            compute_floor_micros   : arg4,
            creator_share_micros   : v1,
            endowment_share_micros : v2,
            protocol_share_micros  : v0 - v1 - v2,
            receipt_hash           : arg5,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CreatorInteractionPaymentRecorded>(v3);
    }

    entry fun record_epoch_waterfall(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg8));
        assert_policy_unlocked(arg1);
        assert_hash(&arg6);
        assert!(arg2 > 0, 207);
        let v0 = mul_bps(arg2, arg1.protocol_yield_skim_bps);
        let v1 = arg2 - v0;
        let v2 = arg3 + mul_bps(arg3, arg1.keep_alive_buffer_bps);
        let v3 = min_u64(v1, v2);
        let v4 = v1 - v3;
        let v5 = min_u64(v4, arg4 + mul_bps(arg4, arg1.storage_markup_bps));
        let v6 = v4 - v5;
        let v7 = min_u64(v6, arg5);
        let v8 = TreasuryWaterfallRecorded{
            policy_id                 : 0x2::object::uid_to_inner(&arg1.id),
            character_id              : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                     : 0x2::tx_context::sender(arg8),
            gross_yield_micros        : arg2,
            protocol_skim_micros      : v0,
            net_yield_micros          : v1,
            keep_alive_paid_micros    : v3,
            storage_paid_micros       : v5,
            interaction_budget_micros : v7,
            residual_compound_micros  : v6 - v7,
            dormant                   : v3 < v2,
            waterfall_hash            : arg6,
            timestamp_ms              : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TreasuryWaterfallRecorded>(v8);
    }

    entry fun record_gas_front(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg8));
        assert_policy_unlocked(arg1);
        assert_policy_matches(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_ref(&arg3);
        assert_ref(&arg4);
        assert_hash(&arg6);
        assert!(arg5 > 0, 207);
        assert!(arg5 <= arg1.max_gas_front_micros, 222);
        assert_gas_treasury_allowed(arg1, &arg3);
        let v0 = GasFrontRecorded{
            policy_id               : 0x2::object::uid_to_inner(&arg1.id),
            character_id            : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                   : 0x2::tx_context::sender(arg8),
            chain_namespace         : 0x1::string::utf8(arg2),
            gas_treasury_wallet_ref : 0x1::string::utf8(arg3),
            funded_wallet_ref       : 0x1::string::utf8(arg4),
            fronted_micros          : arg5,
            markup_bps              : arg1.gas_front_markup_bps,
            repayment_due_micros    : repayment_due(arg5, arg1.gas_front_markup_bps),
            gas_front_hash          : arg6,
            timestamp_ms            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<GasFrontRecorded>(v0);
    }

    entry fun record_gas_repayment(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg7));
        assert_policy_unlocked(arg1);
        assert_policy_matches(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_ref(&arg3);
        assert_hash(&arg5);
        assert!(arg4 > 0, 223);
        assert_gas_treasury_allowed(arg1, &arg3);
        let v0 = GasRepaymentRecorded{
            policy_id               : 0x2::object::uid_to_inner(&arg1.id),
            character_id            : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                   : 0x2::tx_context::sender(arg7),
            chain_namespace         : 0x1::string::utf8(arg2),
            gas_treasury_wallet_ref : 0x1::string::utf8(arg3),
            repayment_micros        : arg4,
            repayment_hash          : arg5,
            timestamp_ms            : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<GasRepaymentRecorded>(v0);
    }

    fun record_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg6);
        assert!(arg4 > 0, 207);
        assert!(arg5 <= 10000, 205);
        let v0 = TreasuryIntentRecorded{
            policy_id        : 0x2::object::uid_to_inner(&arg1.id),
            character_id     : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner            : 0x2::tx_context::sender(arg8),
            intent_type      : 0x1::string::utf8(arg2),
            venue_ref        : 0x1::string::utf8(arg3),
            amount_micros    : arg4,
            max_slippage_bps : arg5,
            intent_hash      : arg6,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TreasuryIntentRecorded>(v0);
    }

    entry fun record_monthly_yield_harvest_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg10));
        assert_policy_unlocked(arg1);
        assert!(arg1.yield_claim_enabled, 209);
        assert_venue_allowed(arg1, &arg3);
        assert_ref(&arg2);
        assert_ref(&arg4);
        assert_ref(&arg5);
        assert_hash(&arg8);
        assert!(arg6 >= arg1.min_claim_amount_micros, 213);
        assert!(arg7 > 0, 207);
        assert!(0x1::string::utf8(arg5) == arg1.main_treasury_wallet_ref, 214);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        if (arg1.last_yield_claim_ms > 0) {
            assert!(v0 >= arg1.last_yield_claim_ms + arg1.harvest_interval_ms, 212);
        };
        arg1.last_yield_claim_ms = v0;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = v0;
        let v1 = TreasuryMonthlyYieldHarvestIntentRecorded{
            policy_id              : 0x2::object::uid_to_inner(&arg1.id),
            character_id           : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                  : 0x2::tx_context::sender(arg10),
            venue_ref              : 0x1::string::utf8(arg2),
            venue_hash             : arg3,
            source_wallet_ref      : 0x1::string::utf8(arg4),
            destination_wallet_ref : arg1.main_treasury_wallet_ref,
            estimated_yield_micros : arg6,
            principal_micros       : arg7,
            harvest_interval_ms    : arg1.harvest_interval_ms,
            intent_hash            : arg8,
            timestamp_ms           : v0,
        };
        0x2::event::emit<TreasuryMonthlyYieldHarvestIntentRecorded>(v1);
    }

    entry fun record_stake_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert_policy_unlocked(arg1);
        assert!(arg1.auto_yield_enabled, 208);
        record_intent(arg0, arg1, b"stake", arg2, arg3, 0, arg4, arg5, arg6);
    }

    entry fun record_swap_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg7));
        assert_policy_unlocked(arg1);
        assert!(arg1.swap_enabled, 210);
        assert!(arg4 <= arg1.max_slippage_bps, 205);
        record_intent(arg0, arg1, b"swap", arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun record_sweep_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg7));
        assert_policy_unlocked(arg1);
        assert_policy_matches(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_ref(&arg3);
        assert_hash(&arg5);
        assert!(arg4 > 0, 207);
        let v0 = TreasurySweepIntentRecorded{
            policy_id              : 0x2::object::uid_to_inner(&arg1.id),
            character_id           : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                  : 0x2::tx_context::sender(arg7),
            source_wallet_ref      : 0x1::string::utf8(arg2),
            destination_wallet_ref : 0x1::string::utf8(arg3),
            amount_micros          : arg4,
            sweep_hash             : arg5,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TreasurySweepIntentRecorded>(v0);
    }

    fun repayment_due(arg0: u64, arg1: u64) : u64 {
        arg0 + mul_bps(arg0, arg1)
    }

    fun run_heartbeat<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, bool, u64, u64, u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        if (v1 == 0) {
            return (arg1, false, 0, 0, 0, 0, 0)
        };
        if (arg0.last_epoch_ms > 0 && v0 < arg0.last_epoch_ms + arg0.heartbeat_interval_ms) {
            return (arg1, false, 0, 0, 0, 0, 0)
        };
        assert!(v1 >= arg0.heartbeat_bounty_mist, 225);
        let v2 = arg0.character_id;
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        let v4 = &mut v3;
        let v5 = &mut arg0.keep_alive_allocation;
        let v6 = fund_until_target<T0>(v4, v5, arg0.keep_alive_target_mist);
        if (v6 > 0) {
            let v7 = AllocationFlow{
                anft_id     : v2,
                from_bucket : 6,
                to_bucket   : 1,
                amount      : v6,
                reason      : 0,
                at_ms       : v0,
            };
            0x2::event::emit<AllocationFlow>(v7);
        };
        let v8 = &mut v3;
        let v9 = &mut arg0.storage_allocation;
        let v10 = fund_until_target<T0>(v8, v9, arg0.storage_target_mist);
        if (v10 > 0) {
            let v11 = AllocationFlow{
                anft_id     : v2,
                from_bucket : 6,
                to_bucket   : 3,
                amount      : v10,
                reason      : 1,
                at_ms       : v0,
            };
            0x2::event::emit<AllocationFlow>(v11);
        };
        let v12 = &mut v3;
        let v13 = &mut arg0.interaction_allocation;
        let v14 = fund_until_target<T0>(v12, v13, arg0.interaction_target_mist);
        if (v14 > 0) {
            let v15 = AllocationFlow{
                anft_id     : v2,
                from_bucket : 6,
                to_bucket   : 4,
                amount      : v14,
                reason      : 1,
                at_ms       : v0,
            };
            0x2::event::emit<AllocationFlow>(v15);
        };
        let v16 = 0x2::balance::value<T0>(&v3);
        0x2::balance::join<T0>(&mut arg0.principal, v3);
        if (v16 > 0) {
            let v17 = AllocationFlow{
                anft_id     : v2,
                from_bucket : 6,
                to_bucket   : 0,
                amount      : v16,
                reason      : 2,
                at_ms       : v0,
            };
            0x2::event::emit<AllocationFlow>(v17);
        };
        assert!(0x2::balance::value<T0>(&arg0.keep_alive_allocation) >= arg0.heartbeat_bounty_mist, 220);
        let v18 = arg0.heartbeat_bounty_mist;
        if (v18 > 0) {
            let v19 = AllocationFlow{
                anft_id     : v2,
                from_bucket : 1,
                to_bucket   : 6,
                amount      : v18,
                reason      : 9,
                at_ms       : v0,
            };
            0x2::event::emit<AllocationFlow>(v19);
        };
        arg0.last_epoch_ms = v0;
        arg0.nonce = arg0.nonce + 1;
        arg0.updated_at_ms = v0;
        (0x2::coin::take<T0>(&mut arg0.keep_alive_allocation, v18, arg3), true, v6, v10, v14, v16, v18)
    }

    entry fun set_treasury_lock(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: bool, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg5));
        assert!(0x1::vector::length<u8>(&arg3) <= 128, 204);
        arg1.locked = arg2;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = TreasuryLocked{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg5),
            locked       : arg2,
            reason_hash  : arg3,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<TreasuryLocked>(v0);
    }

    entry fun set_yield_venue_allowed(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert_policy_unlocked(arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_hash(&arg3);
        let v0 = 0x1::vector::contains<vector<u8>>(&arg1.allowed_yield_venue_hashes, &arg3);
        if (arg4 && !v0) {
            0x1::vector::push_back<vector<u8>>(&mut arg1.allowed_yield_venue_hashes, arg3);
        };
        if (!arg4 && v0) {
            let (v1, v2) = 0x1::vector::index_of<vector<u8>>(&arg1.allowed_yield_venue_hashes, &arg3);
            assert!(v1, 211);
            0x1::vector::remove<vector<u8>>(&mut arg1.allowed_yield_venue_hashes, v2);
        };
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v3 = TreasuryYieldVenueAllowed{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg6),
            venue_ref    : 0x1::string::utf8(arg2),
            venue_hash   : arg3,
            allowed      : arg4,
            nonce        : arg1.nonce,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<TreasuryYieldVenueAllowed>(v3);
    }

    entry fun settle_endowment_interaction_payment<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &TreasuryPolicy, arg2: &mut Endowment<T0>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: address, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        assert_endowment_matches<T0>(arg0, arg2);
        assert_policy_unlocked(arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg8);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 207);
        assert!(v0 >= arg5, 213);
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1, arg5, arg10), arg6);
        };
        let v2 = mul_bps(0x2::balance::value<T0>(&v1), arg1.protocol_margin_share_bps);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1, v2, arg10), arg7);
        };
        0x2::balance::join<T0>(&mut arg2.interaction_allocation, v1);
        arg2.nonce = arg2.nonce + 1;
        arg2.updated_at_ms = 0x2::clock::timestamp_ms(arg9);
        let v3 = EndowmentInteractionPaymentSettled{
            policy_id               : 0x2::object::uid_to_inner(&arg1.id),
            endowment_id            : 0x2::object::uid_to_inner(&arg2.id),
            character_id            : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            payer                   : 0x2::tx_context::sender(arg10),
            serving_provider        : arg6,
            protocol_recipient      : arg7,
            payment_ref             : 0x1::string::utf8(arg3),
            gross_payment_mist      : v0,
            compute_paid_mist       : arg5,
            endowment_credited_mist : 0x2::balance::value<T0>(&v1),
            protocol_paid_mist      : v2,
            receipt_hash            : arg8,
            timestamp_ms            : arg2.updated_at_ms,
        };
        0x2::event::emit<EndowmentInteractionPaymentSettled>(v3);
    }

    fun split_deposit_buffer_first<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : (u64, u64) {
        let v0 = arg0.character_id;
        let v1 = &mut arg1;
        let v2 = &mut arg0.keep_alive_allocation;
        let v3 = fund_until_target<T0>(v1, v2, arg0.keep_alive_target_mist);
        if (v3 > 0) {
            let v4 = AllocationFlow{
                anft_id     : v0,
                from_bucket : 6,
                to_bucket   : 1,
                amount      : v3,
                reason      : 6,
                at_ms       : arg2,
            };
            0x2::event::emit<AllocationFlow>(v4);
        };
        let v5 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.principal, arg1);
        if (v5 > 0) {
            let v6 = AllocationFlow{
                anft_id     : v0,
                from_bucket : 6,
                to_bucket   : 0,
                amount      : v5,
                reason      : 7,
                at_ms       : arg2,
            };
            0x2::event::emit<AllocationFlow>(v6);
        };
        (v3, v5)
    }

    public fun storage_allocation_mist<T0>(arg0: &Endowment<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.storage_allocation)
    }

    public fun swap_enabled(arg0: &TreasuryPolicy) : bool {
        arg0.swap_enabled
    }

    entry fun top_up_endowment<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Endowment<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_endowment_matches<T0>(arg0, arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_allocation_kind(arg2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 207);
        apply_top_up<T0>(arg1, arg2, arg3);
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v1 = EndowmentTopUpRecorded{
            endowment_id     : 0x2::object::uid_to_inner(&arg1.id),
            character_id     : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            funder           : 0x2::tx_context::sender(arg5),
            allocation_kind  : arg2,
            amount_mist      : v0,
            principal_mist   : 0x2::balance::value<T0>(&arg1.principal),
            keep_alive_mist  : 0x2::balance::value<T0>(&arg1.keep_alive_allocation),
            storage_mist     : 0x2::balance::value<T0>(&arg1.storage_allocation),
            interaction_mist : 0x2::balance::value<T0>(&arg1.interaction_allocation),
            timestamp_ms     : arg1.updated_at_ms,
        };
        0x2::event::emit<EndowmentTopUpRecorded>(v1);
    }

    public(friend) fun top_up_principal_balance<T0>(arg0: &mut Endowment<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: bool, arg4: vector<u8>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (arg3) {
            buy_credits<T0>(arg0, arg1, arg2, arg4, v0)
        } else {
            deposit_donation<T0>(arg0, arg1, arg2, arg4, v0)
        };
        arg0.updated_at_ms = v0;
        v1
    }

    entry fun update_treasury_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut TreasuryPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg12));
        assert_policy_unlocked(arg1);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_policy_args(&arg2, &arg3, arg7);
        arg1.policy_uri = 0x1::string::utf8(arg2);
        arg1.policy_hash = arg3;
        arg1.auto_yield_enabled = arg4;
        arg1.yield_claim_enabled = arg5;
        arg1.swap_enabled = arg6;
        arg1.max_slippage_bps = arg7;
        arg1.min_runtime_reserve_micros = arg8;
        arg1.min_stake_amount_micros = arg9;
        arg1.min_claim_amount_micros = arg10;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg11);
        let v0 = TreasuryPolicyUpdated{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg12),
            policy_uri   : arg1.policy_uri,
            nonce        : arg1.nonce,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<TreasuryPolicyUpdated>(v0);
        let v1 = TreasuryPolicySet{anft_id: 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0)};
        0x2::event::emit<TreasuryPolicySet>(v1);
    }

    entry fun withdraw_endowment_principal<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Endowment<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_endowment_owner<T0>(arg0, arg1, 0x2::tx_context::sender(arg5));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = EndowmentWithdrawalRecorded{
            endowment_id             : 0x2::object::uid_to_inner(&arg1.id),
            character_id             : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                    : 0x2::tx_context::sender(arg5),
            recipient                : arg3,
            amount_mist              : arg2,
            remaining_principal_mist : assert_withdrawable_principal<T0>(arg1, arg2),
            keep_alive_reserve_mist  : arg1.keep_alive_reserve_mist,
            nonce                    : arg1.nonce,
            timestamp_ms             : arg1.updated_at_ms,
        };
        0x2::event::emit<EndowmentWithdrawalRecorded>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.principal, arg2, arg5), arg3);
    }

    public fun yield_claim_enabled(arg0: &TreasuryPolicy) : bool {
        arg0.yield_claim_enabled
    }

    // decompiled from Move bytecode v7
}

