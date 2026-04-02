module 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::lottery {
    struct ProtocolState<phantom T0> has key {
        id: 0x2::object::UID,
        rollover_balance: 0x2::balance::Balance<T0>,
        cumulative_charity: u64,
        cumulative_operator: u64,
    }

    struct Round<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        closes_at: u64,
        min_gross_payment: u64,
        open: bool,
        settled: bool,
        killed: bool,
        next_contribution_id: u64,
        total_weight: u64,
        total_gross_sales: u64,
        prize_pool: 0x2::balance::Balance<T0>,
        pending_prize_pool: u64,
        pending_charity: u64,
        pending_operator: u64,
        pending_reserve: u64,
        jackpot_winner: u64,
        jackpot_draw: u64,
        runner_up_winner: u64,
        runner_up_draw: u64,
        supporter_winner: u64,
        supporter_draw: u64,
        bonus_one_winner: u64,
        bonus_one_draw: u64,
        bonus_two_winner: u64,
        bonus_two_draw: u64,
        jackpot_prize: u64,
        runner_up_prize: u64,
        supporter_prize: u64,
        bonus_one_prize: u64,
        bonus_two_prize: u64,
        wallet_spend: vector<WalletSpend>,
        contributions: vector<Contribution>,
    }

    struct WalletSpend has store {
        player: address,
        gross_spend: u64,
        weighted_entries: u64,
    }

    struct Contribution has store {
        id: u64,
        player: address,
        gross_payment: u64,
        weighted_amount: u64,
        refundable_amount: u64,
        cumulative_start: u64,
        cumulative_end: u64,
        refunded: bool,
        jackpot_claimed: bool,
        runner_up_claimed: bool,
        supporter_claimed: bool,
        bonus_one_claimed: bool,
        bonus_two_claimed: bool,
    }

    struct EntriesPurchased has copy, drop {
        player: address,
        contribution_id: u64,
        gross_payment: u64,
        weighted_amount: u64,
        prize_allocation: u64,
        charity_allocation: u64,
        operator_allocation: u64,
        total_weight_after: u64,
    }

    struct ParticipationPermitMessage has copy, drop, store {
        purchaser: address,
        player: address,
        round_id: address,
        guardrails_id: address,
        expires_at_ms: u64,
    }

    struct RoundSettled has copy, drop {
        total_weight: u64,
        contribution_count: u64,
        jackpot_draw: u64,
        jackpot_winner: u64,
        runner_up_draw: u64,
        runner_up_winner: u64,
        supporter_draw: u64,
        supporter_winner: u64,
        bonus_one_draw: u64,
        bonus_one_winner: u64,
        bonus_two_draw: u64,
        bonus_two_winner: u64,
        jackpot_prize: u64,
        runner_up_prize: u64,
        supporter_prize: u64,
        bonus_one_prize: u64,
        bonus_two_prize: u64,
    }

    struct RoundCreated has copy, drop {
        round_number: u64,
        owner: address,
        closes_at: u64,
    }

    struct PrizeClaimed has copy, drop {
        player: address,
        contribution_id: u64,
        tier: u8,
        amount: u64,
    }

    struct RefundClaimed has copy, drop {
        player: address,
        contribution_id: u64,
        amount: u64,
    }

    struct RoundEmergencyShutdown has copy, drop {
        owner: address,
    }

    public fun current_phase(arg0: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails) : u8 {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::current_phase(arg0)
    }

    fun assert_active_round_matches<T0>(arg0: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg1: &Round<T0>) {
        let v0 = 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::active_round_id(arg0);
        assert!(0x1::option::is_some<address>(&v0), 12);
        assert!(*0x1::option::borrow<address>(&v0) == 0x2::object::id_address<Round<T0>>(arg1), 12);
    }

    fun assert_valid_participation_permit<T0>(arg0: &Round<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: address, arg3: address, arg4: u64, arg5: &vector<u8>, arg6: &0x2::clock::Clock) {
        if (!0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::permit_required(arg1)) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 17);
        let v0 = 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::participation_permit_public_key(arg1);
        assert!(0x1::option::is_some<vector<u8>>(v0), 18);
        let v1 = 0x1::option::borrow<vector<u8>>(v0);
        let v2 = participation_permit_message_bytes<T0>(arg0, arg1, arg2, arg3, arg4);
        assert!(0x2::ecdsa_k1::secp256k1_verify(arg5, v1, &v2, 1), 18);
    }

    fun assert_wallets_allowed(arg0: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg1: address, arg2: address) {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_wallet_allowed(arg0, arg1);
        if (arg2 != arg1) {
            0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_wallet_allowed(arg0, arg2);
        };
    }

    fun auto_pay_tier<T0>(arg0: &mut Round<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0 || arg2 == 0) {
            return
        };
        let v0 = mark_tier_claimed<T0>(arg0, arg1, arg3);
        let v1 = PrizeClaimed{
            player          : v0,
            contribution_id : arg1,
            tier            : arg3,
            amount          : arg2,
        };
        0x2::event::emit<PrizeClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.prize_pool, arg2, arg4), v0);
    }

    public fun bonus_one_draw<T0>(arg0: &Round<T0>) : u64 {
        arg0.bonus_one_draw
    }

    public fun bonus_one_prize<T0>(arg0: &Round<T0>) : u64 {
        arg0.bonus_one_prize
    }

    public fun bonus_one_winner<T0>(arg0: &Round<T0>) : u64 {
        arg0.bonus_one_winner
    }

    public fun bonus_two_draw<T0>(arg0: &Round<T0>) : u64 {
        arg0.bonus_two_draw
    }

    public fun bonus_two_prize<T0>(arg0: &Round<T0>) : u64 {
        arg0.bonus_two_prize
    }

    public fun bonus_two_winner<T0>(arg0: &Round<T0>) : u64 {
        arg0.bonus_two_winner
    }

    public fun buy_entries<T0>(arg0: &mut Round<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = resolve_player(&arg5, v0);
        assert_wallets_allowed(arg1, v0, v1);
        assert!(!0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::permit_required(arg1), 16);
        buy_entries_internal<T0>(arg0, arg1, arg2, arg3, arg4, v1, arg6, arg7)
    }

    fun buy_entries_internal<T0>(arg0: &mut Round<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_protocol_live(arg1);
        assert!(arg0.open && !arg0.killed, 0);
        assert!(!arg0.settled, 1);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.closes_at, 0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 >= arg0.min_gross_payment, 4);
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_wallet_limit(arg1, wallet_spend_of<T0>(arg0, arg5), v0);
        let v1 = 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::entry_fee_flat(arg1) + v0 * 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::entry_fee_bps(arg1) / 10000;
        assert!(v0 > v1, 4);
        let v2 = v0 - v1;
        let v3 = v2 * 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::charity_bps(arg1) / 10000;
        let v4 = v2 * 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::operator_bps(arg1) / 10000;
        let v5 = v2 * 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::reserve_bps(arg1) / 10000;
        let v6 = v2 - v3 - v4 - v5;
        arg0.pending_prize_pool = arg0.pending_prize_pool + v6;
        arg0.pending_charity = arg0.pending_charity + v3;
        arg0.pending_operator = arg0.pending_operator + v1 + v4;
        arg0.pending_reserve = arg0.pending_reserve + v5;
        0x2::coin::put<T0>(&mut arg0.prize_pool, arg3);
        let v7 = arg0.next_contribution_id;
        arg0.next_contribution_id = v7 + 1;
        let v8 = v2;
        if (0x1::option::is_some<address>(&arg4)) {
            let v9 = *0x1::option::borrow<address>(&arg4);
            if (v9 != arg5) {
                let v10 = v2 * 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::referral_sender_bps(arg1) / 10000;
                v8 = v2 + v2 * 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::referral_buyer_bps(arg1) / 10000;
                let v11 = arg0.next_contribution_id;
                arg0.next_contribution_id = v11 + 1;
                let v12 = arg0.total_weight + v10;
                arg0.total_weight = v12;
                let v13 = Contribution{
                    id                : v11,
                    player            : v9,
                    gross_payment     : 0,
                    weighted_amount   : v10,
                    refundable_amount : 0,
                    cumulative_start  : arg0.total_weight + 1,
                    cumulative_end    : v12,
                    refunded          : false,
                    jackpot_claimed   : false,
                    runner_up_claimed : false,
                    supporter_claimed : false,
                    bonus_one_claimed : false,
                    bonus_two_claimed : false,
                };
                0x1::vector::push_back<Contribution>(&mut arg0.contributions, v13);
                upsert_wallet_spend<T0>(arg0, v9, 0, v10);
            };
        };
        let v14 = arg0.total_weight + v8;
        arg0.total_weight = v14;
        arg0.total_gross_sales = arg0.total_gross_sales + v0;
        let v15 = Contribution{
            id                : v7,
            player            : arg5,
            gross_payment     : v0,
            weighted_amount   : v8,
            refundable_amount : v0,
            cumulative_start  : arg0.total_weight + 1,
            cumulative_end    : v14,
            refunded          : false,
            jackpot_claimed   : false,
            runner_up_claimed : false,
            supporter_claimed : false,
            bonus_one_claimed : false,
            bonus_two_claimed : false,
        };
        0x1::vector::push_back<Contribution>(&mut arg0.contributions, v15);
        upsert_wallet_spend<T0>(arg0, arg5, v0, v8);
        let v16 = EntriesPurchased{
            player              : arg5,
            contribution_id     : v7,
            gross_payment       : v0,
            weighted_amount     : v8,
            prize_allocation    : v6,
            charity_allocation  : v3,
            operator_allocation : v4 + v5,
            total_weight_after  : arg0.total_weight,
        };
        0x2::event::emit<EntriesPurchased>(v16);
        v7
    }

    public fun buy_entries_with_permit<T0>(arg0: &mut Round<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<address>, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = resolve_player(&arg5, v0);
        assert_wallets_allowed(arg1, v0, v1);
        assert_valid_participation_permit<T0>(arg0, arg1, v0, v1, arg6, &arg7, arg8);
        buy_entries_internal<T0>(arg0, arg1, arg2, arg3, arg4, v1, arg8, arg9)
    }

    public fun claim_refund<T0>(arg0: &mut Round<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.killed, 7);
        assert!(!arg0.settled, 1);
        let v0 = 0x1::vector::borrow_mut<Contribution>(&mut arg0.contributions, contribution_index_for_id<T0>(arg0, arg1));
        assert!(v0.player == 0x2::tx_context::sender(arg2), 5);
        assert!(!v0.refunded, 8);
        v0.refunded = true;
        let v1 = RefundClaimed{
            player          : 0x2::tx_context::sender(arg2),
            contribution_id : arg1,
            amount          : v0.refundable_amount,
        };
        0x2::event::emit<RefundClaimed>(v1);
        0x2::coin::take<T0>(&mut arg0.prize_pool, v0.refundable_amount, arg2)
    }

    public fun closes_at<T0>(arg0: &Round<T0>) : u64 {
        arg0.closes_at
    }

    public fun contribution_count<T0>(arg0: &Round<T0>) : u64 {
        0x1::vector::length<Contribution>(&arg0.contributions)
    }

    public fun contribution_cumulative_end<T0>(arg0: &Round<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Contribution>(&arg0.contributions, contribution_index_for_id<T0>(arg0, arg1)).cumulative_end
    }

    public fun contribution_cumulative_start<T0>(arg0: &Round<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Contribution>(&arg0.contributions, contribution_index_for_id<T0>(arg0, arg1)).cumulative_start
    }

    fun contribution_index_for_id<T0>(arg0: &Round<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Contribution>(&arg0.contributions)) {
            if (0x1::vector::borrow<Contribution>(&arg0.contributions, v0).id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 9
    }

    public fun contribution_player<T0>(arg0: &Round<T0>, arg1: u64) : address {
        0x1::vector::borrow<Contribution>(&arg0.contributions, contribution_index_for_id<T0>(arg0, arg1)).player
    }

    public fun contribution_refundable_amount<T0>(arg0: &Round<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Contribution>(&arg0.contributions, contribution_index_for_id<T0>(arg0, arg1)).refundable_amount
    }

    public fun contribution_weight<T0>(arg0: &Round<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Contribution>(&arg0.contributions, contribution_index_for_id<T0>(arg0, arg1)).weighted_amount
    }

    public fun create<T0>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg4: &mut ProtocolState<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_can_create_round(arg3);
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_type_supported<T0>(arg3);
        assert!(arg2 > 0, 4);
        let v0 = RoundCreated{
            round_number : 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::increment_round_count(arg3),
            owner        : arg0,
            closes_at    : arg1,
        };
        0x2::event::emit<RoundCreated>(v0);
        let v1 = Round<T0>{
            id                   : 0x2::object::new(arg5),
            owner                : arg0,
            closes_at            : arg1,
            min_gross_payment    : arg2,
            open                 : true,
            settled              : false,
            killed               : false,
            next_contribution_id : 1,
            total_weight         : 0,
            total_gross_sales    : 0,
            prize_pool           : 0x2::balance::withdraw_all<T0>(&mut arg4.rollover_balance),
            pending_prize_pool   : 0x2::balance::value<T0>(&arg4.rollover_balance),
            pending_charity      : 0,
            pending_operator     : 0,
            pending_reserve      : 0,
            jackpot_winner       : 0,
            jackpot_draw         : 0,
            runner_up_winner     : 0,
            runner_up_draw       : 0,
            supporter_winner     : 0,
            supporter_draw       : 0,
            bonus_one_winner     : 0,
            bonus_one_draw       : 0,
            bonus_two_winner     : 0,
            bonus_two_draw       : 0,
            jackpot_prize        : 0,
            runner_up_prize      : 0,
            supporter_prize      : 0,
            bonus_one_prize      : 0,
            bonus_two_prize      : 0,
            wallet_spend         : 0x1::vector::empty<WalletSpend>(),
            contributions        : 0x1::vector::empty<Contribution>(),
        };
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::set_active_round(arg3, 0x2::object::id_address<Round<T0>>(&v1));
        0x2::transfer::share_object<Round<T0>>(v1);
    }

    public fun current_prize_quote<T0>(arg0: &Round<T0>) : (u64, u64, u64, u64, u64) {
        quote_prizes(prize_pool_value<T0>(arg0), 0x1::vector::length<Contribution>(&arg0.contributions))
    }

    public fun eligible_total_weight<T0>(arg0: &Round<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Contribution>(&arg0.contributions)) {
            let v2 = 0x1::vector::borrow<Contribution>(&arg0.contributions, v0);
            let v3 = if (v2.id != arg1) {
                if (v2.id != arg2) {
                    if (v2.id != arg3) {
                        v2.id != arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v1 = v1 + v2.weighted_amount;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun emergency_shutdown<T0>(arg0: &mut Round<T0>, arg1: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 10);
        let v0 = if (arg0.open) {
            if (!arg0.killed) {
                !arg0.settled
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg0.open = false;
        arg0.killed = true;
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::clear_active_round_if_matches(arg1, 0x2::object::id_address<Round<T0>>(arg0));
        let v1 = RoundEmergencyShutdown{owner: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<RoundEmergencyShutdown>(v1);
    }

    public fun finalize_permanent_shutdown<T0>(arg0: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg1: &mut ProtocolState<T0>, arg2: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::Treasury<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::kill_switch_armed(arg0), 11);
        assert!(!0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::permanent_shutdown_finalized(arg0), 15);
        let v0 = 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::active_round_id(arg0);
        assert!(0x1::option::is_none<address>(&v0), 14);
        if (0x2::balance::value<T0>(&arg1.rollover_balance) > 0) {
            0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::credit_charity<T0>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.rollover_balance), arg3));
        };
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::disburse_all_on_shutdown<T0>(arg2, arg3);
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::mark_permanent_shutdown_finalized(arg0, arg3);
    }

    public fun initialize_protocol<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolState<T0>{
            id                  : 0x2::object::new(arg0),
            rollover_balance    : 0x2::balance::zero<T0>(),
            cumulative_charity  : 0,
            cumulative_operator : 0,
        };
        0x2::transfer::share_object<ProtocolState<T0>>(v0);
    }

    public fun is_killed<T0>(arg0: &Round<T0>) : bool {
        arg0.killed
    }

    public fun is_open<T0>(arg0: &Round<T0>) : bool {
        arg0.open
    }

    public fun is_settled<T0>(arg0: &Round<T0>) : bool {
        arg0.settled
    }

    public fun jackpot_draw<T0>(arg0: &Round<T0>) : u64 {
        arg0.jackpot_draw
    }

    public fun jackpot_odds_bps_for_contribution<T0>(arg0: &Round<T0>, arg1: u64) : u64 {
        if (arg0.total_weight == 0) {
            return 0
        };
        0x1::vector::borrow<Contribution>(&arg0.contributions, contribution_index_for_id<T0>(arg0, arg1)).weighted_amount * 10000 / arg0.total_weight
    }

    public fun jackpot_odds_bps_for_player<T0>(arg0: &Round<T0>, arg1: address) : u64 {
        if (arg0.total_weight == 0) {
            return 0
        };
        player_weight_of<T0>(arg0, arg1) * 10000 / arg0.total_weight
    }

    public fun jackpot_prize<T0>(arg0: &Round<T0>) : u64 {
        arg0.jackpot_prize
    }

    public fun jackpot_winner<T0>(arg0: &Round<T0>) : u64 {
        arg0.jackpot_winner
    }

    fun mark_tier_claimed<T0>(arg0: &mut Round<T0>, arg1: u64, arg2: u8) : address {
        let v0 = 0x1::vector::borrow_mut<Contribution>(&mut arg0.contributions, contribution_index_for_id<T0>(arg0, arg1));
        if (arg2 == 0) {
            assert!(!v0.jackpot_claimed, 6);
            v0.jackpot_claimed = true;
        } else if (arg2 == 1) {
            assert!(!v0.runner_up_claimed, 6);
            v0.runner_up_claimed = true;
        } else if (arg2 == 2) {
            assert!(!v0.supporter_claimed, 6);
            v0.supporter_claimed = true;
        } else if (arg2 == 3) {
            assert!(!v0.bonus_one_claimed, 6);
            v0.bonus_one_claimed = true;
        } else {
            assert!(!v0.bonus_two_claimed, 6);
            v0.bonus_two_claimed = true;
        };
        v0.player
    }

    public fun min_gross_payment<T0>(arg0: &Round<T0>) : u64 {
        arg0.min_gross_payment
    }

    public fun owner<T0>(arg0: &Round<T0>) : address {
        arg0.owner
    }

    fun participation_permit_message_bytes<T0>(arg0: &Round<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: address, arg3: address, arg4: u64) : vector<u8> {
        let v0 = ParticipationPermitMessage{
            purchaser     : arg2,
            player        : arg3,
            round_id      : 0x2::object::id_address<Round<T0>>(arg0),
            guardrails_id : 0x2::object::id_address<0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails>(arg1),
            expires_at_ms : arg4,
        };
        0x1::bcs::to_bytes<ParticipationPermitMessage>(&v0)
    }

    fun pick_contribution_id<T0>(arg0: &Round<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Contribution>(&arg0.contributions)) {
            let v2 = 0x1::vector::borrow<Contribution>(&arg0.contributions, v0);
            let v3 = if (v2.id != arg2) {
                if (v2.id != arg3) {
                    if (v2.id != arg4) {
                        v2.id != arg5
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                let v4 = v1 + v2.weighted_amount;
                v1 = v4;
                if (arg1 <= v4) {
                    return v2.id
                };
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun player_weight_of<T0>(arg0: &Round<T0>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<WalletSpend>(&arg0.wallet_spend)) {
            let v1 = 0x1::vector::borrow<WalletSpend>(&arg0.wallet_spend, v0);
            if (v1.player == arg1) {
                return v1.weighted_entries
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun prize_pool_value<T0>(arg0: &Round<T0>) : u64 {
        if (arg0.settled || arg0.killed) {
            0x2::balance::value<T0>(&arg0.prize_pool)
        } else {
            arg0.pending_prize_pool
        }
    }

    public fun process_shutdown_refunds_batch<T0>(arg0: &mut Round<T0>, arg1: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::Treasury<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : bool {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_owner(arg1, 0x2::tx_context::sender(arg5));
        assert!(0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::kill_switch_armed(arg1), 11);
        assert!(arg4 > 0, 13);
        assert!(!0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::permanent_shutdown_finalized(arg1), 15);
        let v0 = if (arg0.open) {
            if (!arg0.killed) {
                !arg0.settled
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.open = false;
            arg0.killed = true;
            let v1 = RoundEmergencyShutdown{owner: 0x2::tx_context::sender(arg5)};
            0x2::event::emit<RoundEmergencyShutdown>(v1);
        };
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::clear_active_round_if_matches(arg1, 0x2::object::id_address<Round<T0>>(arg0));
        let v2 = 0x1::vector::length<Contribution>(&arg0.contributions);
        if (arg3 > v2) {
            return true
        };
        let v3 = arg3;
        let v4 = 0;
        while (v3 < v2 && v4 < arg4) {
            let v5 = 0x1::vector::borrow_mut<Contribution>(&mut arg0.contributions, v3);
            if (v5.gross_payment > 0 && !v5.refunded) {
                v5.refunded = true;
                let v6 = RefundClaimed{
                    player          : v5.player,
                    contribution_id : v5.id,
                    amount          : v5.refundable_amount,
                };
                0x2::event::emit<RefundClaimed>(v6);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.prize_pool, v5.refundable_amount, arg5), v5.player);
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        if (v3 == v2) {
            let v7 = 0x2::balance::value<T0>(&arg0.prize_pool);
            if (v7 > 0) {
                0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::credit_charity<T0>(arg2, 0x2::coin::take<T0>(&mut arg0.prize_pool, v7, arg5));
            };
        };
        v3 == v2
    }

    public fun quote_prizes(arg0: u64, arg1: u64) : (u64, u64, u64, u64, u64) {
        if (arg1 == 0) {
            (0, 0, 0, 0, 0)
        } else {
            let (v5, v6, v7, v8, v9) = if (arg1 == 1) {
                (0, arg0, 0, 0, 0)
            } else {
                let (v10, v11, v12, v13, v14) = if (arg1 == 2) {
                    let v15 = arg0 * 8500 / 10000;
                    (v15, arg0 - v15, 0, 0, 0)
                } else {
                    let v16 = arg0 * 6000 / 10000;
                    let v17 = arg0 * 1500 / 10000;
                    let v18 = arg0 * 1000 / 10000;
                    let v19 = arg0 * 1000 / 10000;
                    (v16, v17, v18, v19, arg0 - v16 - v17 - v18 - v19)
                };
                (v14, v10, v11, v12, v13)
            };
            (v6, v7, v8, v9, v5)
        }
    }

    fun resolve_player(arg0: &0x1::option::Option<address>, arg1: address) : address {
        if (0x1::option::is_some<address>(arg0)) {
            *0x1::option::borrow<address>(arg0)
        } else {
            arg1
        }
    }

    public fun runner_up_draw<T0>(arg0: &Round<T0>) : u64 {
        arg0.runner_up_draw
    }

    public fun runner_up_prize<T0>(arg0: &Round<T0>) : u64 {
        arg0.runner_up_prize
    }

    public fun runner_up_winner<T0>(arg0: &Round<T0>) : u64 {
        arg0.runner_up_winner
    }

    public fun seed_prize_pool<T0>(arg0: &mut Round<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = if (arg0.open) {
            if (!arg0.killed) {
                !arg0.settled
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg0.pending_prize_pool = arg0.pending_prize_pool + 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.prize_pool, arg1);
    }

    entry fun settle<T0>(arg0: &mut Round<T0>, arg1: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut ProtocolState<T0>, arg3: &mut 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::Treasury<T0>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_protocol_live(arg1);
        assert_active_round_matches<T0>(arg1, arg0);
        assert!(arg0.open && !arg0.killed, 0);
        assert!(!arg0.settled, 1);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg0.closes_at, 2);
        assert!(arg0.total_weight > 0, 3);
        arg0.open = false;
        arg0.settled = true;
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::clear_active_round_if_matches(arg1, 0x2::object::id_address<Round<T0>>(arg0));
        if (arg0.pending_charity > 0) {
            0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::credit_charity<T0>(arg3, 0x2::coin::take<T0>(&mut arg0.prize_pool, arg0.pending_charity, arg6));
            arg0.pending_charity = 0;
        };
        if (arg0.pending_operator > 0) {
            0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::credit_operator<T0>(arg3, 0x2::coin::take<T0>(&mut arg0.prize_pool, arg0.pending_operator, arg6));
            arg0.pending_operator = 0;
        };
        if (arg0.pending_reserve > 0) {
            0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury::credit_reserve<T0>(arg3, 0x2::coin::take<T0>(&mut arg0.prize_pool, arg0.pending_reserve, arg6));
            arg0.pending_reserve = 0;
        };
        arg0.pending_prize_pool = 0x2::balance::value<T0>(&arg0.prize_pool);
        let v0 = 0x1::vector::length<Contribution>(&arg0.contributions);
        let (v1, v2, v3, v4, v5) = quote_prizes(0x2::balance::value<T0>(&arg0.prize_pool), v0);
        let v6 = v1;
        let v7 = 0x2::random::new_generator(arg4, arg6);
        let v8 = if (0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::current_phase(arg1) == 0) {
            100
        } else {
            10
        };
        if (0x2::random::generate_u8_in_range(&mut v7, 1, 100) > v8) {
            let v9 = v1 * 90 / 100;
            0x2::balance::join<T0>(&mut arg2.rollover_balance, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.prize_pool, v9, arg6)));
            v6 = v1 - v9;
        };
        arg0.jackpot_prize = v6;
        arg0.runner_up_prize = v2;
        arg0.supporter_prize = v3;
        arg0.bonus_one_prize = v4;
        arg0.bonus_two_prize = v5;
        let v10 = 0x2::random::new_generator(arg4, arg6);
        arg0.jackpot_draw = 0x2::random::generate_u64_in_range(&mut v10, 1, arg0.total_weight);
        arg0.jackpot_winner = pick_contribution_id<T0>(arg0, arg0.jackpot_draw, 0, 0, 0, 0);
        if (v2 > 0) {
            arg0.runner_up_draw = 0x2::random::generate_u64_in_range(&mut v10, 1, eligible_total_weight<T0>(arg0, arg0.jackpot_winner, 0, 0, 0));
            arg0.runner_up_winner = pick_contribution_id<T0>(arg0, arg0.runner_up_draw, arg0.jackpot_winner, 0, 0, 0);
        } else {
            arg0.runner_up_draw = 0;
        };
        if (v3 > 0) {
            arg0.supporter_draw = 0x2::random::generate_u64_in_range(&mut v10, 1, eligible_total_weight<T0>(arg0, arg0.jackpot_winner, arg0.runner_up_winner, 0, 0));
            arg0.supporter_winner = pick_contribution_id<T0>(arg0, arg0.supporter_draw, arg0.jackpot_winner, arg0.runner_up_winner, 0, 0);
        } else {
            arg0.supporter_draw = 0;
        };
        if (v4 > 0) {
            arg0.bonus_one_draw = 0x2::random::generate_u64_in_range(&mut v10, 1, eligible_total_weight<T0>(arg0, arg0.jackpot_winner, arg0.runner_up_winner, arg0.supporter_winner, 0));
            arg0.bonus_one_winner = pick_contribution_id<T0>(arg0, arg0.bonus_one_draw, arg0.jackpot_winner, arg0.runner_up_winner, arg0.supporter_winner, 0);
        } else {
            arg0.bonus_one_draw = 0;
        };
        if (v5 > 0) {
            arg0.bonus_two_draw = 0x2::random::generate_u64_in_range(&mut v10, 1, eligible_total_weight<T0>(arg0, arg0.jackpot_winner, arg0.runner_up_winner, arg0.supporter_winner, arg0.bonus_one_winner));
            arg0.bonus_two_winner = pick_contribution_id<T0>(arg0, arg0.bonus_two_draw, arg0.jackpot_winner, arg0.runner_up_winner, arg0.supporter_winner, arg0.bonus_one_winner);
        } else {
            arg0.bonus_two_draw = 0;
        };
        let v11 = arg0.jackpot_winner;
        let v12 = arg0.runner_up_winner;
        let v13 = arg0.supporter_winner;
        let v14 = arg0.bonus_one_winner;
        let v15 = arg0.bonus_two_winner;
        let v16 = RoundSettled{
            total_weight       : arg0.total_weight,
            contribution_count : v0,
            jackpot_draw       : arg0.jackpot_draw,
            jackpot_winner     : arg0.jackpot_winner,
            runner_up_draw     : arg0.runner_up_draw,
            runner_up_winner   : arg0.runner_up_winner,
            supporter_draw     : arg0.supporter_draw,
            supporter_winner   : arg0.supporter_winner,
            bonus_one_draw     : arg0.bonus_one_draw,
            bonus_one_winner   : arg0.bonus_one_winner,
            bonus_two_draw     : arg0.bonus_two_draw,
            bonus_two_winner   : arg0.bonus_two_winner,
            jackpot_prize      : v6,
            runner_up_prize    : v2,
            supporter_prize    : v3,
            bonus_one_prize    : v4,
            bonus_two_prize    : v5,
        };
        0x2::event::emit<RoundSettled>(v16);
        auto_pay_tier<T0>(arg0, v11, v6, 0, arg6);
        auto_pay_tier<T0>(arg0, v12, v2, 1, arg6);
        auto_pay_tier<T0>(arg0, v13, v3, 2, arg6);
        auto_pay_tier<T0>(arg0, v14, v4, 3, arg6);
        auto_pay_tier<T0>(arg0, v15, v5, 4, arg6);
    }

    public fun supporter_draw<T0>(arg0: &Round<T0>) : u64 {
        arg0.supporter_draw
    }

    public fun supporter_prize<T0>(arg0: &Round<T0>) : u64 {
        arg0.supporter_prize
    }

    public fun supporter_winner<T0>(arg0: &Round<T0>) : u64 {
        arg0.supporter_winner
    }

    public fun total_gross_sales<T0>(arg0: &Round<T0>) : u64 {
        arg0.total_gross_sales
    }

    public fun total_weight<T0>(arg0: &Round<T0>) : u64 {
        arg0.total_weight
    }

    fun upsert_wallet_spend<T0>(arg0: &mut Round<T0>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<WalletSpend>(&arg0.wallet_spend)) {
            let v1 = 0x1::vector::borrow_mut<WalletSpend>(&mut arg0.wallet_spend, v0);
            if (v1.player == arg1) {
                v1.gross_spend = v1.gross_spend + arg2;
                v1.weighted_entries = v1.weighted_entries + arg3;
                return
            };
            v0 = v0 + 1;
        };
        let v2 = WalletSpend{
            player           : arg1,
            gross_spend      : arg2,
            weighted_entries : arg3,
        };
        0x1::vector::push_back<WalletSpend>(&mut arg0.wallet_spend, v2);
    }

    public fun wallet_spend_of<T0>(arg0: &Round<T0>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<WalletSpend>(&arg0.wallet_spend)) {
            let v1 = 0x1::vector::borrow<WalletSpend>(&arg0.wallet_spend, v0);
            if (v1.player == arg1) {
                return v1.gross_spend
            };
            v0 = v0 + 1;
        };
        0
    }

    // decompiled from Move bytecode v6
}

