module 0x282df60372adda5334cf55fd102c749005b95b0bcec1a2ffd9b60f2ac49fdb7a::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VoterMintPass has key {
        id: 0x2::object::UID,
        owner: address,
        cap_mist: u64,
        used_mist: u64,
    }

    struct ReserveState has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MSUI>,
        mint_enabled: bool,
        mint_rate_msui_per_sui: u64,
        mint_phase: u8,
        active_window_rate_msui_per_sui: u64,
        active_window_cap_mist: u64,
        active_window_minted_mist: u64,
        sft_reward_enabled: bool,
        sft_reward_sui_equivalent_mist: u64,
        sft_reward_rate_msui_per_sui: u64,
        sft_reward_sponsored_mist: u64,
        sft_reward_claimed_count: u64,
        sft_reward_max_claim_count: u64,
        sft_reward_minted_base_units: u64,
        min_mint_mist: u64,
        max_supply_base_units: u64,
        total_minted_base_units: u64,
        total_burned_for_signal_base_units: u64,
        redeem_status: u8,
        risk_sleeve_status: u8,
        governance_mode: u8,
    }

    struct TreasuryVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_sui_received_mist: u64,
        total_sui_withdrawn_mist: u64,
        reserved_sui_mist: u64,
        deployed_sui_mist: u64,
    }

    struct MintEvent has copy, drop {
        minter: address,
        sui_received_mist: u64,
        msui_minted_base_units: u64,
    }

    struct VoterMintEvent has copy, drop {
        voter: address,
        sui_received_mist: u64,
        msui_minted_base_units: u64,
        rate_msui_per_sui: u64,
        pass_used_mist: u64,
        pass_cap_mist: u64,
    }

    struct FounderSeedMintEvent has copy, drop {
        admin: address,
        recipient: address,
        sui_received_mist: u64,
        msui_minted_base_units: u64,
        rate_msui_per_sui: u64,
    }

    struct SftRewardClaimEvent has copy, drop {
        claimant: address,
        burned_sft_id: 0x2::object::ID,
        reward_base_units: u64,
        claimed_count: u64,
        max_claim_count: u64,
    }

    public fun mint(arg0: &mut ReserveState, arg1: &mut TreasuryVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 0);
        assert!(arg0.mint_phase == 2, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg0.min_mint_mist, 1);
        assert!(arg0.active_window_rate_msui_per_sui > 0, 1);
        let v1 = (arg0.active_window_minted_mist as u128) + (v0 as u128);
        assert!(v1 <= (arg0.active_window_cap_mist as u128), 5);
        let v2 = arg0.active_window_rate_msui_per_sui;
        let (v3, v4) = deposit_and_mint(arg0, arg1, arg2, v2, arg3);
        arg0.active_window_minted_mist = (v1 as u64);
        let v5 = MintEvent{
            minter                 : 0x2::tx_context::sender(arg3),
            sui_received_mist      : v0,
            msui_minted_base_units : v4,
        };
        0x2::event::emit<MintEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MSUI>>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun active_window_cap_mist(arg0: &ReserveState) : u64 {
        arg0.active_window_cap_mist
    }

    public fun active_window_minted_mist(arg0: &ReserveState) : u64 {
        arg0.active_window_minted_mist
    }

    public fun active_window_rate_msui_per_sui(arg0: &ReserveState) : u64 {
        arg0.active_window_rate_msui_per_sui
    }

    public fun admin_seed_mint(arg0: &AdminCap, arg1: &mut ReserveState, arg2: &mut TreasuryVault, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = deposit_and_mint(arg1, arg2, arg3, arg4, arg6);
        let v2 = FounderSeedMintEvent{
            admin                  : 0x2::tx_context::sender(arg6),
            recipient              : arg5,
            sui_received_mist      : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            msui_minted_base_units : v1,
            rate_msui_per_sui      : arg4,
        };
        0x2::event::emit<FounderSeedMintEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MSUI>>(v0, arg5);
    }

    public fun burn_sft_for_msui(arg0: &mut ReserveState, arg1: 0x4d44f25e1f09ce78b7aeb7d8cc0803592a9d8cbea79890eb1b7fe2dab7d99058::outage_chronicles::OutageSft, arg2: 0x4d44f25e1f09ce78b7aeb7d8cc0803592a9d8cbea79890eb1b7fe2dab7d99058::outage_chronicles::BurnPermit, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sft_reward_enabled, 6);
        assert!(arg0.sft_reward_claimed_count < arg0.sft_reward_max_claim_count, 7);
        let v0 = calculate_sft_reward_base_units(arg0);
        assert!(v0 > 0, 1);
        let v1 = (arg0.total_minted_base_units as u128) + (v0 as u128);
        assert!(v1 <= (arg0.max_supply_base_units as u128), 2);
        let v2 = (arg0.sft_reward_minted_base_units as u128) + (v0 as u128);
        assert!(v2 <= 18446744073709551615, 8);
        let v3 = arg0.sft_reward_claimed_count + 1;
        0x4d44f25e1f09ce78b7aeb7d8cc0803592a9d8cbea79890eb1b7fe2dab7d99058::outage_chronicles::burn_with_permit(arg1, arg2, arg3);
        arg0.sft_reward_claimed_count = v3;
        arg0.sft_reward_minted_base_units = (v2 as u64);
        arg0.total_minted_base_units = (v1 as u64);
        let v4 = SftRewardClaimEvent{
            claimant          : 0x2::tx_context::sender(arg3),
            burned_sft_id     : 0x2::object::id<0x4d44f25e1f09ce78b7aeb7d8cc0803592a9d8cbea79890eb1b7fe2dab7d99058::outage_chronicles::OutageSft>(&arg1),
            reward_base_units : v0,
            claimed_count     : v3,
            max_claim_count   : arg0.sft_reward_max_claim_count,
        };
        0x2::event::emit<SftRewardClaimEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<MSUI>>(0x2::coin::mint<MSUI>(&mut arg0.treasury_cap, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    fun calculate_mint_base_units(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        assert!(v0 <= 340282366920938463463374607431768211455 / v1, 3);
        let v2 = v0 * v1;
        assert!(v2 <= 340282366920938463463374607431768211455 / 1000000000, 3);
        let v3 = v2 * 1000000000 / 1000000000;
        assert!(v3 <= 18446744073709551615, 3);
        (v3 as u64)
    }

    fun calculate_sft_reward_base_units(arg0: &ReserveState) : u64 {
        let v0 = (arg0.sft_reward_sui_equivalent_mist as u128);
        let v1 = (arg0.sft_reward_rate_msui_per_sui as u128);
        assert!(v0 <= 340282366920938463463374607431768211455 / v1, 8);
        let v2 = v0 * v1;
        assert!(v2 <= 340282366920938463463374607431768211455 / 1000000000, 8);
        let v3 = v2 * 1000000000 / 1000000000;
        assert!(v3 <= 18446744073709551615, 8);
        (v3 as u64)
    }

    fun create_initial_state(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 9, b"MSUI", b"Micro SUItegy", b"Deposit-only Micro SUItegy reserve token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://soc.mindfrog.xyz/msui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSUI>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = ReserveState{
            id                                 : 0x2::object::new(arg1),
            treasury_cap                       : v0,
            mint_enabled                       : false,
            mint_rate_msui_per_sui             : 1000,
            mint_phase                         : 0,
            active_window_rate_msui_per_sui    : 1000,
            active_window_cap_mist             : 0,
            active_window_minted_mist          : 0,
            sft_reward_enabled                 : false,
            sft_reward_sui_equivalent_mist     : 100000000,
            sft_reward_rate_msui_per_sui       : 1000,
            sft_reward_sponsored_mist          : 0,
            sft_reward_claimed_count           : 0,
            sft_reward_max_claim_count         : 0,
            sft_reward_minted_base_units       : 0,
            min_mint_mist                      : 100000000,
            max_supply_base_units              : 1000000000000000000,
            total_minted_base_units            : 0,
            total_burned_for_signal_base_units : 0,
            redeem_status                      : 0,
            risk_sleeve_status                 : 0,
            governance_mode                    : 0,
        };
        0x2::transfer::share_object<ReserveState>(v3);
        let v4 = TreasuryVault{
            id                       : 0x2::object::new(arg1),
            balance                  : 0x2::balance::zero<0x2::sui::SUI>(),
            total_sui_received_mist  : 0,
            total_sui_withdrawn_mist : 0,
            reserved_sui_mist        : 0,
            deployed_sui_mist        : 0,
        };
        0x2::transfer::share_object<TreasuryVault>(v4);
    }

    public fun create_voter_mint_pass(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VoterMintPass{
            id        : 0x2::object::new(arg3),
            owner     : arg1,
            cap_mist  : arg2,
            used_mist : 0,
        };
        0x2::transfer::transfer<VoterMintPass>(v0, arg1);
    }

    public fun default_voter_pass_cap_mist() : u64 {
        100000000000
    }

    fun deposit_and_mint(arg0: &mut ReserveState, arg1: &mut TreasuryVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<MSUI>, u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg0.min_mint_mist, 1);
        assert!(arg3 > 0, 1);
        let v1 = calculate_mint_base_units(v0, arg3);
        assert!(v1 > 0, 1);
        let v2 = (arg0.total_minted_base_units as u128) + (v1 as u128);
        assert!(v2 <= (arg0.max_supply_base_units as u128), 2);
        let v3 = (arg1.total_sui_received_mist as u128) + (v0 as u128);
        assert!(v3 <= 18446744073709551615, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.total_sui_received_mist = (v3 as u64);
        arg0.total_minted_base_units = (v2 as u64);
        (0x2::coin::mint<MSUI>(&mut arg0.treasury_cap, v1, arg4), v1)
    }

    public fun error_max_supply_exceeded() : u64 {
        2
    }

    public fun error_mint_overflow() : u64 {
        3
    }

    public fun error_mint_paused() : u64 {
        0
    }

    public fun error_mint_too_small() : u64 {
        1
    }

    public fun error_sft_reward_disabled() : u64 {
        6
    }

    public fun error_sft_reward_invalid_funding_amount() : u64 {
        11
    }

    public fun error_sft_reward_overflow() : u64 {
        8
    }

    public fun error_sft_reward_pool_exhausted() : u64 {
        7
    }

    public fun error_voter_pass_cap_exceeded() : u64 {
        10
    }

    public fun error_voter_pass_wrong_owner() : u64 {
        9
    }

    public fun error_window_cap_exceeded() : u64 {
        5
    }

    public fun error_wrong_mint_phase() : u64 {
        4
    }

    public fun fund_sft_reward_pool(arg0: &AdminCap, arg1: &mut ReserveState, arg2: &mut TreasuryVault, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(arg1.sft_reward_sui_equivalent_mist > 0, 8);
        assert!(v0 % arg1.sft_reward_sui_equivalent_mist == 0, 11);
        let v1 = (arg1.sft_reward_sponsored_mist as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 8);
        let v2 = (arg1.sft_reward_max_claim_count as u128) + ((v0 / arg1.sft_reward_sui_equivalent_mist) as u128);
        assert!(v2 <= 18446744073709551615, 8);
        let v3 = (arg2.total_sui_received_mist as u128) + (v0 as u128);
        assert!(v3 <= 18446744073709551615, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg2.total_sui_received_mist = (v3 as u64);
        arg1.sft_reward_sponsored_mist = (v1 as u64);
        arg1.sft_reward_max_claim_count = (v2 as u64);
    }

    public fun governance_mode(arg0: &ReserveState) : u8 {
        arg0.governance_mode
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        create_initial_state(arg0, arg1);
    }

    public fun max_supply_base_units(arg0: &ReserveState) : u64 {
        arg0.max_supply_base_units
    }

    public fun min_mint_mist(arg0: &ReserveState) : u64 {
        arg0.min_mint_mist
    }

    public fun mint_enabled(arg0: &ReserveState) : bool {
        arg0.mint_enabled
    }

    public fun mint_phase(arg0: &ReserveState) : u8 {
        arg0.mint_phase
    }

    public fun mint_rate_msui_per_sui(arg0: &ReserveState) : u64 {
        arg0.mint_rate_msui_per_sui
    }

    public fun mint_with_voter_pass(arg0: &mut ReserveState, arg1: &mut TreasuryVault, arg2: &mut VoterMintPass, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.owner, 9);
        assert!(arg0.mint_enabled, 0);
        assert!(arg0.mint_phase == 1, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = (arg2.used_mist as u128) + (v0 as u128);
        assert!(v1 <= (arg2.cap_mist as u128), 10);
        let v2 = (arg0.active_window_minted_mist as u128) + (v0 as u128);
        assert!(v2 <= (arg0.active_window_cap_mist as u128), 5);
        let v3 = arg0.active_window_rate_msui_per_sui;
        let (v4, v5) = deposit_and_mint(arg0, arg1, arg3, v3, arg4);
        arg2.used_mist = (v1 as u64);
        arg0.active_window_minted_mist = (v2 as u64);
        let v6 = VoterMintEvent{
            voter                  : 0x2::tx_context::sender(arg4),
            sui_received_mist      : v0,
            msui_minted_base_units : v5,
            rate_msui_per_sui      : v3,
            pass_used_mist         : arg2.used_mist,
            pass_cap_mist          : arg2.cap_mist,
        };
        0x2::event::emit<VoterMintEvent>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<MSUI>>(v4, 0x2::tx_context::sender(arg4));
    }

    public fun mist_per_sui() : u128 {
        1000000000
    }

    public fun msui_base_units_per_msui() : u128 {
        1000000000
    }

    public fun phase_closed() : u8 {
        0
    }

    public fun phase_public() : u8 {
        2
    }

    public fun phase_voter_priority() : u8 {
        1
    }

    public fun redeem_status(arg0: &ReserveState) : u8 {
        arg0.redeem_status
    }

    public fun risk_sleeve_status(arg0: &ReserveState) : u8 {
        arg0.risk_sleeve_status
    }

    public fun set_mint_enabled(arg0: &AdminCap, arg1: &mut ReserveState, arg2: bool) {
        arg1.mint_enabled = arg2;
    }

    public fun set_mint_rate(arg0: &AdminCap, arg1: &mut ReserveState, arg2: u64) {
        arg1.mint_rate_msui_per_sui = arg2;
    }

    public fun set_mint_window(arg0: &AdminCap, arg1: &mut ReserveState, arg2: u8, arg3: u64, arg4: u64) {
        assert!(arg2 <= 2, 4);
        assert!(arg3 > 0, 1);
        arg1.mint_phase = arg2;
        arg1.active_window_rate_msui_per_sui = arg3;
        arg1.active_window_cap_mist = arg4;
        arg1.active_window_minted_mist = 0;
    }

    public fun set_sft_reward_enabled(arg0: &AdminCap, arg1: &mut ReserveState, arg2: bool) {
        arg1.sft_reward_enabled = arg2;
    }

    public fun sft_reward_base_units(arg0: &ReserveState) : u64 {
        calculate_sft_reward_base_units(arg0)
    }

    public fun sft_reward_claimed_count(arg0: &ReserveState) : u64 {
        arg0.sft_reward_claimed_count
    }

    public fun sft_reward_enabled(arg0: &ReserveState) : bool {
        arg0.sft_reward_enabled
    }

    public fun sft_reward_max_claim_count(arg0: &ReserveState) : u64 {
        arg0.sft_reward_max_claim_count
    }

    public fun sft_reward_minted_base_units(arg0: &ReserveState) : u64 {
        arg0.sft_reward_minted_base_units
    }

    public fun sft_reward_rate_msui_per_sui(arg0: &ReserveState) : u64 {
        arg0.sft_reward_rate_msui_per_sui
    }

    public fun sft_reward_remaining_claim_count(arg0: &ReserveState) : u64 {
        if (arg0.sft_reward_claimed_count >= arg0.sft_reward_max_claim_count) {
            0
        } else {
            arg0.sft_reward_max_claim_count - arg0.sft_reward_claimed_count
        }
    }

    public fun sft_reward_sponsored_mist(arg0: &ReserveState) : u64 {
        arg0.sft_reward_sponsored_mist
    }

    public fun sft_reward_sui_equivalent_mist(arg0: &ReserveState) : u64 {
        arg0.sft_reward_sui_equivalent_mist
    }

    public fun total_burned_for_signal_base_units(arg0: &ReserveState) : u64 {
        arg0.total_burned_for_signal_base_units
    }

    public fun total_minted_base_units(arg0: &ReserveState) : u64 {
        arg0.total_minted_base_units
    }

    public fun treasury_balance_mist(arg0: &TreasuryVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun treasury_deployed_sui_mist(arg0: &TreasuryVault) : u64 {
        arg0.deployed_sui_mist
    }

    public fun treasury_reserved_sui_mist(arg0: &TreasuryVault) : u64 {
        arg0.reserved_sui_mist
    }

    public fun treasury_total_sui_received_mist(arg0: &TreasuryVault) : u64 {
        arg0.total_sui_received_mist
    }

    public fun treasury_total_sui_withdrawn_mist(arg0: &TreasuryVault) : u64 {
        arg0.total_sui_withdrawn_mist
    }

    public fun voter_mint_pass_cap_mist(arg0: &VoterMintPass) : u64 {
        arg0.cap_mist
    }

    public fun voter_mint_pass_owner(arg0: &VoterMintPass) : address {
        arg0.owner
    }

    public fun voter_mint_pass_used_mist(arg0: &VoterMintPass) : u64 {
        arg0.used_mist
    }

    // decompiled from Move bytecode v6
}

