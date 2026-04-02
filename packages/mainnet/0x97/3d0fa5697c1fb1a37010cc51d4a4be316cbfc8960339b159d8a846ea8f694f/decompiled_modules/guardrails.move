module 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails {
    struct Guardrails has key {
        id: 0x2::object::UID,
        owner: address,
        jackpot_bps: u64,
        charity_bps: u64,
        operator_bps: u64,
        reserve_bps: u64,
        referral_buyer_bps: u64,
        referral_sender_bps: u64,
        max_wallet_spend: u64,
        min_entry_payment: u64,
        entry_fee_flat: u64,
        entry_fee_bps: u64,
        min_monthly_sales: u64,
        reserve_claim_threshold: u64,
        launch_phase_end: u64,
        growth_phase_end: u64,
        total_rounds_created: u64,
        active_round_id: 0x1::option::Option<address>,
        permanent_shutdown_finalized: bool,
        new_rounds_paused: bool,
        kill_switch_armed: bool,
        supported_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        charity_whitelist: vector<address>,
        participation_permit_public_key: 0x1::option::Option<vector<u8>>,
        denylisted_wallets: 0x2::vec_set::VecSet<address>,
    }

    struct MaxWalletSpendUpdated has copy, drop {
        owner: address,
        previous_limit: u64,
        new_limit: u64,
    }

    struct SupportedCoinTypeUpdated has copy, drop {
        owner: address,
        new_type: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct CharityAdded has copy, drop {
        owner: address,
        charity: address,
    }

    struct CharityRemoved has copy, drop {
        owner: address,
        charity: address,
    }

    struct KillSwitchArmed has copy, drop {
        owner: address,
    }

    struct NewRoundsPaused has copy, drop {
        owner: address,
    }

    struct NewRoundsResumed has copy, drop {
        owner: address,
    }

    struct ParticipationPermitSignerUpdated has copy, drop {
        owner: address,
        enabled: bool,
        public_key_length: u64,
    }

    struct WalletDenylisted has copy, drop {
        owner: address,
        wallet: address,
    }

    struct WalletRemovedFromDenylist has copy, drop {
        owner: address,
        wallet: address,
    }

    struct PhaseThresholdsUpdated has copy, drop {
        owner: address,
        previous_launch_end: u64,
        previous_growth_end: u64,
        new_launch_end: u64,
        new_growth_end: u64,
    }

    public fun active_round_id(arg0: &Guardrails) : 0x1::option::Option<address> {
        arg0.active_round_id
    }

    public fun add_charity(arg0: &mut Guardrails, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(!is_charity_allowed(arg0, arg1), 6);
        assert!(0x1::vector::length<address>(&arg0.charity_whitelist) < 16, 5);
        0x1::vector::push_back<address>(&mut arg0.charity_whitelist, arg1);
        let v0 = CharityAdded{
            owner   : 0x2::tx_context::sender(arg2),
            charity : arg1,
        };
        0x2::event::emit<CharityAdded>(v0);
    }

    public fun add_denylisted_wallet(arg0: &mut Guardrails, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        0x2::vec_set::insert<address>(&mut arg0.denylisted_wallets, arg1);
        let v0 = WalletDenylisted{
            owner  : 0x2::tx_context::sender(arg2),
            wallet : arg1,
        };
        0x2::event::emit<WalletDenylisted>(v0);
    }

    public fun arm_kill_switch(arg0: &mut Guardrails, arg1: &mut 0x2::tx_context::TxContext) {
        trigger_kill_switch(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun assert_can_create_round(arg0: &Guardrails) {
        assert_protocol_live(arg0);
        assert!(!arg0.permanent_shutdown_finalized, 12);
        assert!(0x1::option::is_none<address>(&arg0.active_round_id), 13);
        assert!(!arg0.new_rounds_paused, 11);
    }

    public fun assert_charity_allowed(arg0: &Guardrails, arg1: address) {
        assert!(is_charity_allowed(arg0, arg1), 4);
    }

    public fun assert_owner(arg0: &Guardrails, arg1: address) {
        assert!(arg0.owner == arg1, 0);
    }

    public fun assert_protocol_live(arg0: &Guardrails) {
        assert!(protocol_live(arg0), 2);
    }

    public fun assert_type_supported<T0>(arg0: &Guardrails) {
        assert!(is_type_supported<T0>(arg0), 1);
    }

    public fun assert_wallet_allowed(arg0: &Guardrails, arg1: address) {
        assert!(!is_wallet_denylisted(arg0, arg1), 14);
    }

    public fun assert_wallet_limit(arg0: &Guardrails, arg1: u64, arg2: u64) {
        assert!(can_spend(arg0, arg1, arg2), 3);
    }

    public fun can_spend(arg0: &Guardrails, arg1: u64, arg2: u64) : bool {
        arg1 + arg2 <= arg0.max_wallet_spend
    }

    public fun charity_bps(arg0: &Guardrails) : u64 {
        arg0.charity_bps
    }

    public fun clear_active_round(arg0: &mut Guardrails) {
        arg0.active_round_id = 0x1::option::none<address>();
    }

    public fun clear_active_round_if_matches(arg0: &mut Guardrails, arg1: address) {
        if (0x1::option::is_some<address>(&arg0.active_round_id) && *0x1::option::borrow<address>(&arg0.active_round_id) == arg1) {
            arg0.active_round_id = 0x1::option::none<address>();
        };
    }

    public fun clear_supported_coin_type(arg0: &mut Guardrails, arg1: &mut 0x2::tx_context::TxContext) {
        set_supported_coin_type(arg0, 0x1::option::none<0x1::type_name::TypeName>(), arg1);
    }

    public fun configure_participation_permit_signer(arg0: &mut Guardrails, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x1::vector::length<u8>(&arg1) == 33, 15);
        arg0.participation_permit_public_key = 0x1::option::some<vector<u8>>(arg1);
        let v0 = ParticipationPermitSignerUpdated{
            owner             : 0x2::tx_context::sender(arg2),
            enabled           : true,
            public_key_length : 0x1::vector::length<u8>(&arg1),
        };
        0x2::event::emit<ParticipationPermitSignerUpdated>(v0);
    }

    public fun create(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > arg2, 8);
        assert!(arg2 > arg3, 9);
        assert!(arg3 > 0, 9);
        assert!(0x1::vector::length<address>(&arg4) > 0, 10);
        assert!(0x1::vector::length<address>(&arg4) <= 16, 5);
        let v0 = Guardrails{
            id                              : 0x2::object::new(arg5),
            owner                           : arg0,
            jackpot_bps                     : 5500,
            charity_bps                     : 1500,
            operator_bps                    : 2500,
            reserve_bps                     : 500,
            referral_buyer_bps              : 500,
            referral_sender_bps             : 250,
            max_wallet_spend                : arg1,
            min_entry_payment               : arg2,
            entry_fee_flat                  : arg3,
            entry_fee_bps                   : 200,
            min_monthly_sales               : 1500000,
            reserve_claim_threshold         : 50000,
            launch_phase_end                : 200,
            growth_phase_end                : 250,
            total_rounds_created            : 0,
            active_round_id                 : 0x1::option::none<address>(),
            permanent_shutdown_finalized    : false,
            new_rounds_paused               : false,
            kill_switch_armed               : false,
            supported_coin_type             : 0x1::option::none<0x1::type_name::TypeName>(),
            charity_whitelist               : arg4,
            participation_permit_public_key : 0x1::option::none<vector<u8>>(),
            denylisted_wallets              : 0x2::vec_set::empty<address>(),
        };
        assert!(fee_model_is_valid(&v0), 1);
        0x2::transfer::share_object<Guardrails>(v0);
    }

    public fun create_with_charity(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg4);
        create(arg0, arg1, arg2, arg3, v0, arg5);
    }

    public fun current_phase(arg0: &Guardrails) : u8 {
        let v0 = arg0.total_rounds_created;
        if (v0 <= arg0.launch_phase_end) {
            0
        } else if (v0 <= arg0.growth_phase_end) {
            1
        } else {
            2
        }
    }

    public fun denylisted_wallet_count(arg0: &Guardrails) : u64 {
        0x2::vec_set::length<address>(&arg0.denylisted_wallets)
    }

    public fun disable_participation_permit_signer(arg0: &mut Guardrails, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.participation_permit_public_key = 0x1::option::none<vector<u8>>();
        let v0 = ParticipationPermitSignerUpdated{
            owner             : 0x2::tx_context::sender(arg1),
            enabled           : false,
            public_key_length : 0,
        };
        0x2::event::emit<ParticipationPermitSignerUpdated>(v0);
    }

    public fun entry_fee_bps(arg0: &Guardrails) : u64 {
        arg0.entry_fee_bps
    }

    public fun entry_fee_flat(arg0: &Guardrails) : u64 {
        arg0.entry_fee_flat
    }

    public fun fee_model_is_valid(arg0: &Guardrails) : bool {
        arg0.jackpot_bps + arg0.charity_bps + arg0.operator_bps + arg0.reserve_bps == 10000
    }

    public fun growth_phase_end(arg0: &Guardrails) : u64 {
        arg0.growth_phase_end
    }

    public fun increment_round_count(arg0: &mut Guardrails) : u64 {
        arg0.total_rounds_created = arg0.total_rounds_created + 1;
        arg0.total_rounds_created
    }

    public fun is_charity_allowed(arg0: &Guardrails, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.charity_whitelist)) {
            if (*0x1::vector::borrow<address>(&arg0.charity_whitelist, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_type_supported<T0>(arg0: &Guardrails) : bool {
        if (0x1::option::is_none<0x1::type_name::TypeName>(&arg0.supported_coin_type)) {
            return true
        };
        *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.supported_coin_type) == 0x1::type_name::get<T0>()
    }

    public fun is_wallet_denylisted(arg0: &Guardrails, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.denylisted_wallets, &arg1)
    }

    public fun jackpot_bps(arg0: &Guardrails) : u64 {
        arg0.jackpot_bps
    }

    public fun kill_switch_armed(arg0: &Guardrails) : bool {
        arg0.kill_switch_armed
    }

    public fun launch_phase_end(arg0: &Guardrails) : u64 {
        arg0.launch_phase_end
    }

    public fun lock_supported_coin_type<T0>(arg0: &mut Guardrails, arg1: &mut 0x2::tx_context::TxContext) {
        set_supported_coin_type(arg0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()), arg1);
    }

    public fun mark_permanent_shutdown_finalized(arg0: &mut Guardrails, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.permanent_shutdown_finalized = true;
    }

    public fun max_wallet_spend(arg0: &Guardrails) : u64 {
        arg0.max_wallet_spend
    }

    public fun min_entry_payment(arg0: &Guardrails) : u64 {
        arg0.min_entry_payment
    }

    public fun min_monthly_sales(arg0: &Guardrails) : u64 {
        arg0.min_monthly_sales
    }

    public fun new_rounds_paused(arg0: &Guardrails) : bool {
        arg0.new_rounds_paused
    }

    public fun operator_bps(arg0: &Guardrails) : u64 {
        arg0.operator_bps
    }

    public fun owner(arg0: &Guardrails) : address {
        arg0.owner
    }

    public fun participation_permit_public_key(arg0: &Guardrails) : &0x1::option::Option<vector<u8>> {
        &arg0.participation_permit_public_key
    }

    public fun pause_new_rounds(arg0: &mut Guardrails, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.new_rounds_paused = true;
        let v0 = NewRoundsPaused{owner: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<NewRoundsPaused>(v0);
    }

    public fun permanent_shutdown_finalized(arg0: &Guardrails) : bool {
        arg0.permanent_shutdown_finalized
    }

    public fun permit_required(arg0: &Guardrails) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.participation_permit_public_key)
    }

    public fun protocol_live(arg0: &Guardrails) : bool {
        !arg0.kill_switch_armed
    }

    public fun referral_buyer_bps(arg0: &Guardrails) : u64 {
        arg0.referral_buyer_bps
    }

    public fun referral_sender_bps(arg0: &Guardrails) : u64 {
        arg0.referral_sender_bps
    }

    public fun remove_charity(arg0: &mut Guardrails, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.charity_whitelist)) {
            if (*0x1::vector::borrow<address>(&arg0.charity_whitelist, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.charity_whitelist, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 7);
        assert!(0x1::vector::length<address>(&arg0.charity_whitelist) > 0, 10);
        let v2 = CharityRemoved{
            owner   : 0x2::tx_context::sender(arg2),
            charity : arg1,
        };
        0x2::event::emit<CharityRemoved>(v2);
    }

    public fun remove_denylisted_wallet(arg0: &mut Guardrails, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        0x2::vec_set::remove<address>(&mut arg0.denylisted_wallets, &arg1);
        let v0 = WalletRemovedFromDenylist{
            owner  : 0x2::tx_context::sender(arg2),
            wallet : arg1,
        };
        0x2::event::emit<WalletRemovedFromDenylist>(v0);
    }

    public fun reserve_bps(arg0: &Guardrails) : u64 {
        arg0.reserve_bps
    }

    public fun reserve_claim_threshold(arg0: &Guardrails) : u64 {
        arg0.reserve_claim_threshold
    }

    public fun resume_new_rounds(arg0: &mut Guardrails, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.new_rounds_paused = false;
        let v0 = NewRoundsResumed{owner: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<NewRoundsResumed>(v0);
    }

    public fun set_active_round(arg0: &mut Guardrails, arg1: address) {
        arg0.active_round_id = 0x1::option::some<address>(arg1);
    }

    public fun set_max_wallet_spend(arg0: &mut Guardrails, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > arg0.entry_fee_flat, 8);
        arg0.max_wallet_spend = arg1;
        let v0 = MaxWalletSpendUpdated{
            owner          : 0x2::tx_context::sender(arg2),
            previous_limit : arg0.max_wallet_spend,
            new_limit      : arg1,
        };
        0x2::event::emit<MaxWalletSpendUpdated>(v0);
    }

    public fun set_phase_thresholds(arg0: &mut Guardrails, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1 < arg2, 8);
        arg0.launch_phase_end = arg1;
        arg0.growth_phase_end = arg2;
        let v0 = PhaseThresholdsUpdated{
            owner               : 0x2::tx_context::sender(arg3),
            previous_launch_end : arg0.launch_phase_end,
            previous_growth_end : arg0.growth_phase_end,
            new_launch_end      : arg1,
            new_growth_end      : arg2,
        };
        0x2::event::emit<PhaseThresholdsUpdated>(v0);
    }

    public fun set_supported_coin_type(arg0: &mut Guardrails, arg1: 0x1::option::Option<0x1::type_name::TypeName>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.supported_coin_type = arg1;
        let v0 = SupportedCoinTypeUpdated{
            owner    : 0x2::tx_context::sender(arg2),
            new_type : arg1,
        };
        0x2::event::emit<SupportedCoinTypeUpdated>(v0);
    }

    public fun supported_coin_type(arg0: &Guardrails) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.supported_coin_type
    }

    public fun total_rounds_created(arg0: &Guardrails) : u64 {
        arg0.total_rounds_created
    }

    public fun trigger_kill_switch(arg0: &mut Guardrails, arg1: address) {
        assert_owner(arg0, arg1);
        arg0.kill_switch_armed = true;
        let v0 = KillSwitchArmed{owner: arg1};
        0x2::event::emit<KillSwitchArmed>(v0);
    }

    // decompiled from Move bytecode v6
}

