module 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::factory {
    struct OwnerSponsorAccounting has copy, drop, store {
        slot: u64,
        settled_net: u64,
        fee_earned: u64,
        sponsored_outbound: u64,
        sponsored_gas_budget: u64,
    }

    struct Factory<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        wallet_a: address,
        wallet_b: address,
        wallet_a_fallback: address,
        wallet_b_fallback: address,
        fee_bps: u64,
        fast_cctp_fee_bps: u64,
        estimated_gas_usdc: u64,
        sentinel_multiplier: u64,
        referrer_share_bps: u64,
        treasury_a_share_bps: u64,
        treasury_b_share_bps: u64,
        flush_threshold: u64,
        open_relaying_enabled: bool,
        min_sponsored_inbound_volume: u64,
        approved_referrers: vector<address>,
        hook_domains: vector<u32>,
        fee_vault: 0x2::balance::Balance<T0>,
        sponsor_slot: u64,
        min_sponsored_outbound_volume: u64,
        sponsored_outbound_gas_bps: u64,
        pending_wallet_a: u64,
        pending_wallet_b: u64,
        pending_referrers: vector<PendingReferrer>,
        total_escrowed: u64,
        total_deployed: u64,
        total_disbursed: u64,
        sponsor_accounting: 0x2::table::Table<address, OwnerSponsorAccounting>,
        is_sponsored_owner: 0x2::table::Table<address, bool>,
        is_receiver: 0x2::table::Table<address, bool>,
    }

    struct PendingReferrer has copy, drop, store {
        referrer: address,
        amount: u64,
    }

    struct Disbursed has copy, drop {
        pool: u64,
        to_a: u64,
        to_b: u64,
        to_ref: u64,
    }

    struct ReceiverFeeEscrowed has copy, drop {
        pool: u64,
        to_a: u64,
        to_b: u64,
        to_ref: u64,
        referrer: address,
    }

    struct TreasurySettled has copy, drop {
        to: address,
        amount: u64,
        leg: u8,
    }

    struct Recovered has copy, drop {
        to: address,
        amount: u64,
    }

    struct SponsoredTransferRelayed has copy, drop {
        from: address,
        to: address,
        value: u64,
        sentinel: address,
        nonce: address,
        reward: u64,
    }

    struct SponsoredOutboundPolicyUpdated has copy, drop {
        old_slot: u64,
        new_slot: u64,
        old_min_volume: u64,
        new_min_volume: u64,
    }

    struct SponsoredOutboundGasBpsUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct OwnerSponsorSettlementRecorded has copy, drop {
        owner: address,
        net_amount: u64,
        fee_earned: u64,
        slot: u64,
        settled_net: u64,
    }

    struct OwnerSponsoredOutboundConsumed has copy, drop {
        owner: address,
        amount: u64,
        budget: u64,
        slot: u64,
        sponsored_outbound: u64,
        sponsored_gas_budget: u64,
    }

    struct FeeBpsUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct EstimatedGasUpdated has copy, drop {
        old_estimate: u64,
        new_estimate: u64,
    }

    struct SentinelMultiplierUpdated has copy, drop {
        old_mult: u64,
        new_mult: u64,
    }

    struct FlushThresholdUpdated has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
    }

    struct HookDomainUpdated has copy, drop {
        domain: u32,
        allowed: bool,
    }

    struct SponsorPolicyUpdated has copy, drop {
        active: bool,
    }

    struct SponsoredInboundPolicyUpdated has copy, drop {
        old_min_volume: u64,
        new_min_volume: u64,
    }

    struct ReferrerApprovalUpdated has copy, drop {
        referrer: address,
        approved: bool,
    }

    struct ProtocolFeeSplitUpdated has copy, drop {
        referrer_share_bps: u64,
        treasury_a_share_bps: u64,
        treasury_b_share_bps: u64,
    }

    struct AdminTransferStarted has copy, drop {
        old_admin: address,
        pending_admin: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun accept_admin<T0>(arg0: &mut Factory<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 2);
        assert!(v0 == *0x1::option::borrow<address>(&arg0.pending_admin), 2);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        let v1 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : v0,
        };
        0x2::event::emit<AdminTransferred>(v1);
    }

    fun add_pending_referrer<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: u64) {
        let (v0, v1) = find_pending_referrer(&arg0.pending_referrers, arg1);
        if (v0) {
            let v2 = 0x1::vector::borrow_mut<PendingReferrer>(&mut arg0.pending_referrers, v1);
            v2.amount = v2.amount + arg2;
        } else {
            let v3 = PendingReferrer{
                referrer : arg1,
                amount   : arg2,
            };
            0x1::vector::push_back<PendingReferrer>(&mut arg0.pending_referrers, v3);
        };
    }

    fun advance_sponsor_slot<T0>(arg0: &mut Factory<T0>) {
        arg0.sponsor_slot = arg0.sponsor_slot + 1;
    }

    public fun assert_admin<T0>(arg0: &Factory<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public fun assert_referrer_approved<T0>(arg0: &Factory<T0>, arg1: address) {
        if (arg1 == @0x0) {
            return
        };
        assert!(is_approved_referrer<T0>(arg0, arg1), 10);
    }

    public fun assert_sponsored_inbound<T0>(arg0: &Factory<T0>, arg1: u64) {
        assert!(arg0.open_relaying_enabled, 8);
        assert!(arg1 >= arg0.min_sponsored_inbound_volume, 9);
    }

    public fun consume_sponsored_outbound<T0>(arg0: &Factory<T0>, arg1: &mut OwnerSponsorAccounting, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg1.slot == arg0.sponsor_slot, 13);
        assert!(arg1.settled_net >= arg0.min_sponsored_outbound_volume, 13);
        assert!(arg1.sponsored_gas_budget >= arg4, 15);
        arg1.sponsored_outbound = arg1.sponsored_outbound + arg3;
        arg1.sponsored_gas_budget = arg1.sponsored_gas_budget - arg4;
        let v0 = OwnerSponsoredOutboundConsumed{
            owner                : arg2,
            amount               : arg3,
            budget               : arg4,
            slot                 : arg1.slot,
            sponsored_outbound   : arg1.sponsored_outbound,
            sponsored_gas_budget : arg1.sponsored_gas_budget,
        };
        0x2::event::emit<OwnerSponsoredOutboundConsumed>(v0);
    }

    public fun create<T0>(arg0: &0x2::package::UpgradeCap, arg1: address, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::package::upgrade_package(arg0);
        let v0 = if (arg1 != @0x0) {
            if (arg2 != @0x0) {
                if (arg3 != @0x0) {
                    arg4 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        assert!(arg1 != arg2, 4);
        assert!(arg5 <= 300 && arg6 <= 300, 5);
        assert!(arg8 >= 2 && arg8 <= 10, 6);
        assert!(arg9 <= 1000000000, 7);
        let v1 = Factory<T0>{
            id                            : 0x2::object::new(arg10),
            admin                         : 0x2::tx_context::sender(arg10),
            pending_admin                 : 0x1::option::none<address>(),
            wallet_a                      : arg1,
            wallet_b                      : arg2,
            wallet_a_fallback             : arg3,
            wallet_b_fallback             : arg4,
            fee_bps                       : arg5,
            fast_cctp_fee_bps             : arg6,
            estimated_gas_usdc            : arg7,
            sentinel_multiplier           : arg8,
            referrer_share_bps            : 1000,
            treasury_a_share_bps          : 5000,
            treasury_b_share_bps          : 4000,
            flush_threshold               : arg9,
            open_relaying_enabled         : true,
            min_sponsored_inbound_volume  : 10000000,
            approved_referrers            : vector[],
            hook_domains                  : vector[],
            fee_vault                     : 0x2::balance::zero<T0>(),
            sponsor_slot                  : 0,
            min_sponsored_outbound_volume : 100000000,
            sponsored_outbound_gas_bps    : 1000,
            pending_wallet_a              : 0,
            pending_wallet_b              : 0,
            pending_referrers             : 0x1::vector::empty<PendingReferrer>(),
            total_escrowed                : 0,
            total_deployed                : 0,
            total_disbursed               : 0,
            sponsor_accounting            : 0x2::table::new<address, OwnerSponsorAccounting>(arg10),
            is_sponsored_owner            : 0x2::table::new<address, bool>(arg10),
            is_receiver                   : 0x2::table::new<address, bool>(arg10),
        };
        0x2::transfer::share_object<Factory<T0>>(v1);
    }

    public fun current_sponsor_slot<T0>(arg0: &Factory<T0>) : u64 {
        arg0.sponsor_slot
    }

    public fun deposit_protocol_fee<T0>(arg0: &mut Factory<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.fee_vault, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun escrow_receiver_fee<T0>(arg0: &mut Factory<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let (v1, v2, v3) = split_protocol_fees<T0>(arg0, v0, arg2);
        0x2::balance::join<T0>(&mut arg0.fee_vault, arg1);
        arg0.pending_wallet_a = arg0.pending_wallet_a + v1;
        arg0.pending_wallet_b = arg0.pending_wallet_b + v2;
        if (v3 > 0) {
            add_pending_referrer<T0>(arg0, arg2, v3);
        };
        arg0.total_escrowed = arg0.total_escrowed + v0;
        let v4 = ReceiverFeeEscrowed{
            pool     : v0,
            to_a     : v1,
            to_b     : v2,
            to_ref   : v3,
            referrer : arg2,
        };
        0x2::event::emit<ReceiverFeeEscrowed>(v4);
    }

    public fun estimated_gas_usdc<T0>(arg0: &Factory<T0>) : u64 {
        arg0.estimated_gas_usdc
    }

    public fun fast_cctp_fee_bps<T0>(arg0: &Factory<T0>) : u64 {
        arg0.fast_cctp_fee_bps
    }

    public fun fee_bps<T0>(arg0: &Factory<T0>) : u64 {
        arg0.fee_bps
    }

    public fun fee_vault_balance<T0>(arg0: &Factory<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_vault)
    }

    public fun fees_for<T0>(arg0: &Factory<T0>, arg1: u64, arg2: u32, arg3: bool) : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::FeeBreakdown {
        let v0 = arg2 == 0 || is_hook_domain<T0>(arg0, arg2);
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::compute(arg1, arg0.fee_bps, arg0.fast_cctp_fee_bps, arg0.estimated_gas_usdc, arg0.sentinel_multiplier, arg0.flush_threshold, arg3, v0)
    }

    fun find_address(arg0: &vector<address>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_domain(arg0: &vector<u32>, arg1: u32) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(arg0)) {
            if (*0x1::vector::borrow<u32>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_pending_referrer(arg0: &vector<PendingReferrer>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PendingReferrer>(arg0)) {
            if (0x1::vector::borrow<PendingReferrer>(arg0, v0).referrer == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun flush_threshold<T0>(arg0: &Factory<T0>) : u64 {
        arg0.flush_threshold
    }

    public fun is_approved_referrer<T0>(arg0: &Factory<T0>, arg1: address) : bool {
        let (v0, _) = find_address(&arg0.approved_referrers, arg1);
        v0
    }

    public fun is_fast_threshold(arg0: u64) : bool {
        arg0 == 1000
    }

    public fun is_hook_domain<T0>(arg0: &Factory<T0>, arg1: u32) : bool {
        let (v0, _) = find_domain(&arg0.hook_domains, arg1);
        v0
    }

    public fun mark_receiver<T0>(arg0: &mut Factory<T0>, arg1: address) {
        if (!0x2::table::contains<address, bool>(&arg0.is_receiver, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.is_receiver, arg1, true);
        };
    }

    public fun mark_sponsored_owner<T0>(arg0: &mut Factory<T0>, arg1: address) {
        if (!0x2::table::contains<address, bool>(&arg0.is_sponsored_owner, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.is_sponsored_owner, arg1, true);
        };
    }

    public fun min_sponsored_inbound_volume<T0>(arg0: &Factory<T0>) : u64 {
        arg0.min_sponsored_inbound_volume
    }

    public fun open_relaying_enabled<T0>(arg0: &Factory<T0>) : bool {
        arg0.open_relaying_enabled
    }

    public fun pending_referrer<T0>(arg0: &Factory<T0>, arg1: address) : u64 {
        let (v0, v1) = find_pending_referrer(&arg0.pending_referrers, arg1);
        if (v0) {
            0x1::vector::borrow<PendingReferrer>(&arg0.pending_referrers, v1).amount
        } else {
            0
        }
    }

    public fun pending_wallet_a<T0>(arg0: &Factory<T0>) : u64 {
        arg0.pending_wallet_a
    }

    public fun pending_wallet_b<T0>(arg0: &Factory<T0>) : u64 {
        arg0.pending_wallet_b
    }

    public fun record_owner_sponsor_settlement<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<address, OwnerSponsorAccounting>(&arg0.sponsor_accounting, arg1)) {
            let v0 = OwnerSponsorAccounting{
                slot                 : arg0.sponsor_slot,
                settled_net          : 0,
                fee_earned           : 0,
                sponsored_outbound   : 0,
                sponsored_gas_budget : 0,
            };
            0x2::table::add<address, OwnerSponsorAccounting>(&mut arg0.sponsor_accounting, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, OwnerSponsorAccounting>(&mut arg0.sponsor_accounting, arg1);
        if (v1.slot != arg0.sponsor_slot) {
            v1.slot = arg0.sponsor_slot;
            v1.settled_net = 0;
            v1.fee_earned = 0;
            v1.sponsored_outbound = 0;
            v1.sponsored_gas_budget = 0;
        };
        v1.settled_net = v1.settled_net + arg2;
        v1.fee_earned = v1.fee_earned + arg3;
        let v2 = OwnerSponsorSettlementRecorded{
            owner       : arg1,
            net_amount  : arg2,
            fee_earned  : arg3,
            slot        : v1.slot,
            settled_net : v1.settled_net,
        };
        0x2::event::emit<OwnerSponsorSettlementRecorded>(v2);
    }

    public fun record_receiver_deployed<T0>(arg0: &mut Factory<T0>) {
        arg0.total_deployed = arg0.total_deployed + 1;
    }

    public fun record_receiver_disbursement<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (arg1 == 0) {
            return
        };
        arg0.total_disbursed = arg0.total_disbursed + arg1;
        advance_sponsor_slot<T0>(arg0);
        let v0 = Disbursed{
            pool   : arg1,
            to_a   : arg2,
            to_b   : arg3,
            to_ref : arg4,
        };
        0x2::event::emit<Disbursed>(v0);
    }

    public fun recover<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg3);
        assert!(arg1 != @0x0, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.fee_vault);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        if (v1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_vault, v1), arg3), arg1);
        let v2 = Recovered{
            to     : arg1,
            amount : v1,
        };
        0x2::event::emit<Recovered>(v2);
    }

    public fun sentinel_multiplier<T0>(arg0: &Factory<T0>) : u64 {
        arg0.sentinel_multiplier
    }

    public fun set_approved_referrer<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg3);
        assert!(arg1 != @0x0, 3);
        let (v0, v1) = find_address(&arg0.approved_referrers, arg1);
        if (arg2 && !v0) {
            0x1::vector::push_back<address>(&mut arg0.approved_referrers, arg1);
        };
        if (!arg2 && v0) {
            0x1::vector::swap_remove<address>(&mut arg0.approved_referrers, v1);
        };
        let v2 = ReferrerApprovalUpdated{
            referrer : arg1,
            approved : arg2,
        };
        0x2::event::emit<ReferrerApprovalUpdated>(v2);
    }

    public fun set_cctp_fast_fee_bps<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 <= 300, 5);
        arg0.fast_cctp_fee_bps = arg1;
        let v0 = FeeBpsUpdated{
            old_bps : arg0.fast_cctp_fee_bps,
            new_bps : arg1,
        };
        0x2::event::emit<FeeBpsUpdated>(v0);
    }

    public fun set_estimated_gas_usdc<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        arg0.estimated_gas_usdc = arg1;
        let v0 = EstimatedGasUpdated{
            old_estimate : arg0.estimated_gas_usdc,
            new_estimate : arg1,
        };
        0x2::event::emit<EstimatedGasUpdated>(v0);
    }

    public fun set_fee_bps<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 <= 300, 5);
        arg0.fee_bps = arg1;
        let v0 = FeeBpsUpdated{
            old_bps : arg0.fee_bps,
            new_bps : arg1,
        };
        0x2::event::emit<FeeBpsUpdated>(v0);
    }

    public fun set_flush_threshold<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 <= 1000000000, 7);
        arg0.flush_threshold = arg1;
        let v0 = FlushThresholdUpdated{
            old_threshold : arg0.flush_threshold,
            new_threshold : arg1,
        };
        0x2::event::emit<FlushThresholdUpdated>(v0);
    }

    public fun set_hook_domain<T0>(arg0: &mut Factory<T0>, arg1: u32, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg3);
        let (v0, v1) = find_domain(&arg0.hook_domains, arg1);
        if (arg2 && !v0) {
            0x1::vector::push_back<u32>(&mut arg0.hook_domains, arg1);
        };
        if (!arg2 && v0) {
            0x1::vector::swap_remove<u32>(&mut arg0.hook_domains, v1);
        };
        let v2 = HookDomainUpdated{
            domain  : arg1,
            allowed : arg2,
        };
        0x2::event::emit<HookDomainUpdated>(v2);
    }

    public fun set_min_sponsored_inbound_volume<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        arg0.min_sponsored_inbound_volume = arg1;
        let v0 = SponsoredInboundPolicyUpdated{
            old_min_volume : arg0.min_sponsored_inbound_volume,
            new_min_volume : arg1,
        };
        0x2::event::emit<SponsoredInboundPolicyUpdated>(v0);
    }

    public fun set_protocol_fee_split<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg4);
        let v0 = if (arg1 <= 10000) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        arg0.referrer_share_bps = arg1;
        arg0.treasury_a_share_bps = arg2;
        arg0.treasury_b_share_bps = arg3;
        let v1 = ProtocolFeeSplitUpdated{
            referrer_share_bps   : arg1,
            treasury_a_share_bps : arg2,
            treasury_b_share_bps : arg3,
        };
        0x2::event::emit<ProtocolFeeSplitUpdated>(v1);
    }

    public fun set_sentinel_multiplier<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 >= 2 && arg1 <= 10, 6);
        arg0.sentinel_multiplier = arg1;
        let v0 = SentinelMultiplierUpdated{
            old_mult : arg0.sentinel_multiplier,
            new_mult : arg1,
        };
        0x2::event::emit<SentinelMultiplierUpdated>(v0);
    }

    public fun set_sponsor_policy<T0>(arg0: &mut Factory<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        arg0.open_relaying_enabled = arg1;
        let v0 = SponsorPolicyUpdated{active: arg1};
        0x2::event::emit<SponsorPolicyUpdated>(v0);
    }

    public fun set_sponsored_inbound_policy<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        set_min_sponsored_inbound_volume<T0>(arg0, arg1, arg2);
    }

    public fun set_sponsored_outbound_gas_bps<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 <= 3000, 16);
        arg0.sponsored_outbound_gas_bps = arg1;
        let v0 = SponsoredOutboundGasBpsUpdated{
            old_bps : arg0.sponsored_outbound_gas_bps,
            new_bps : arg1,
        };
        0x2::event::emit<SponsoredOutboundGasBpsUpdated>(v0);
    }

    public fun set_sponsored_outbound_policy<T0>(arg0: &mut Factory<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 >= 100000000, 12);
        arg0.min_sponsored_outbound_volume = arg1;
        let v0 = SponsoredOutboundPolicyUpdated{
            old_slot       : arg0.sponsor_slot,
            new_slot       : arg0.sponsor_slot,
            old_min_volume : arg0.min_sponsored_outbound_volume,
            new_min_volume : arg1,
        };
        0x2::event::emit<SponsoredOutboundPolicyUpdated>(v0);
    }

    public fun settle_referrer<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = find_pending_referrer(&arg0.pending_referrers, arg1);
        if (!v0) {
            return
        };
        let v2 = 0x1::vector::swap_remove<PendingReferrer>(&mut arg0.pending_referrers, v1);
        settle_to<T0>(arg0, v2.referrer, v2.amount, 2, arg2);
    }

    fun settle_to<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_vault, arg2), arg4), arg1);
        arg0.total_disbursed = arg0.total_disbursed + arg2;
        let v0 = TreasurySettled{
            to     : arg1,
            amount : arg2,
            leg    : arg3,
        };
        0x2::event::emit<TreasurySettled>(v0);
    }

    public fun settle_wallet_a<T0>(arg0: &mut Factory<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.pending_wallet_a;
        if (v0 == 0) {
            return
        };
        let v1 = arg0.wallet_a_fallback;
        arg0.pending_wallet_a = 0;
        settle_to<T0>(arg0, v1, v0, 0, arg1);
    }

    public fun settle_wallet_b<T0>(arg0: &mut Factory<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.pending_wallet_b;
        if (v0 == 0) {
            return
        };
        let v1 = arg0.wallet_b_fallback;
        arg0.pending_wallet_b = 0;
        settle_to<T0>(arg0, v1, v0, 1, arg1);
    }

    public fun split_protocol_fees<T0>(arg0: &Factory<T0>, arg1: u64, arg2: address) : (u64, u64, u64) {
        let v0 = if (arg2 != @0x0 && is_approved_referrer<T0>(arg0, arg2)) {
            arg1 * arg0.referrer_share_bps / 10000
        } else {
            0
        };
        let v1 = arg1 - v0;
        let v2 = v1 * arg0.treasury_a_share_bps / (arg0.treasury_a_share_bps + arg0.treasury_b_share_bps);
        (v2, v1 - v2, v0)
    }

    public fun sponsored_transfer<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open_relaying_enabled, 8);
        assert!(arg2 != @0x0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        assert!(v0 >= arg5 && v0 <= arg6, 7);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 9);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = arg2 == arg1 && 0x2::table::contains<address, bool>(&arg0.is_receiver, arg1);
        let v4 = !v3 && 0x2::table::contains<address, bool>(&arg0.is_sponsored_owner, v2);
        assert!(v3 || v4, 8);
        if (v3) {
            assert!(v1 >= arg0.min_sponsored_inbound_volume, 9);
        };
        if (v4) {
            assert!(v1 >= arg0.min_sponsored_outbound_volume, 13);
        };
        let v5 = arg0.estimated_gas_usdc * arg0.sentinel_multiplier;
        let v6 = v1 * 3000 / 10000;
        let v7 = 0x2::balance::value<T0>(&arg0.fee_vault);
        let v8 = if (v5 < v6) {
            v5
        } else {
            v6
        };
        let v9 = v8;
        if (v8 > v7) {
            v9 = v7;
        };
        if (arg4 < v9) {
            v9 = arg4;
        };
        if (v4) {
            if (!0x2::table::contains<address, OwnerSponsorAccounting>(&arg0.sponsor_accounting, v2)) {
                let v10 = OwnerSponsorAccounting{
                    slot                 : arg0.sponsor_slot,
                    settled_net          : 0,
                    fee_earned           : 0,
                    sponsored_outbound   : 0,
                    sponsored_gas_budget : 0,
                };
                0x2::table::add<address, OwnerSponsorAccounting>(&mut arg0.sponsor_accounting, v2, v10);
            };
            let v11 = 0x2::table::borrow_mut<address, OwnerSponsorAccounting>(&mut arg0.sponsor_accounting, v2);
            if (v11.slot != arg0.sponsor_slot) {
                v11.slot = arg0.sponsor_slot;
                v11.settled_net = 0;
                v11.fee_earned = 0;
                v11.sponsored_outbound = 0;
                v11.sponsored_gas_budget = 0;
            };
            assert!(v11.settled_net >= arg0.min_sponsored_outbound_volume, 13);
            assert!(v1 <= v11.settled_net - v11.sponsored_outbound, 14);
            assert!(v9 <= v11.fee_earned * arg0.sponsored_outbound_gas_bps / 10000 - v11.sponsored_gas_budget, 15);
            v11.sponsored_outbound = v11.sponsored_outbound + v1;
            v11.sponsored_gas_budget = v11.sponsored_gas_budget + v9;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg2);
        let v12 = SponsoredTransferRelayed{
            from     : arg1,
            to       : arg2,
            value    : v1,
            sentinel : v2,
            nonce    : arg2,
            reward   : v9,
        };
        0x2::event::emit<SponsoredTransferRelayed>(v12);
    }

    public fun total_deployed<T0>(arg0: &Factory<T0>) : u64 {
        arg0.total_deployed
    }

    public fun total_disbursed<T0>(arg0: &Factory<T0>) : u64 {
        arg0.total_disbursed
    }

    public fun total_escrowed<T0>(arg0: &Factory<T0>) : u64 {
        arg0.total_escrowed
    }

    public fun transfer_admin<T0>(arg0: &mut Factory<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg2);
        assert!(arg1 != @0x0, 3);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = AdminTransferStarted{
            old_admin     : arg0.admin,
            pending_admin : arg1,
        };
        0x2::event::emit<AdminTransferStarted>(v0);
    }

    public fun valid_threshold(arg0: u64) : bool {
        arg0 == 1000 || arg0 == 2000
    }

    public fun wallet_a<T0>(arg0: &Factory<T0>) : address {
        arg0.wallet_a
    }

    public fun wallet_a_fallback<T0>(arg0: &Factory<T0>) : address {
        arg0.wallet_a_fallback
    }

    public fun wallet_b<T0>(arg0: &Factory<T0>) : address {
        arg0.wallet_b
    }

    public fun wallet_b_fallback<T0>(arg0: &Factory<T0>) : address {
        arg0.wallet_b_fallback
    }

    public fun zero_fees<T0>(arg0: &Factory<T0>, arg1: bool) : 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::FeeBreakdown {
        0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::fees::zero(arg0.flush_threshold, arg1)
    }

    // decompiled from Move bytecode v7
}

