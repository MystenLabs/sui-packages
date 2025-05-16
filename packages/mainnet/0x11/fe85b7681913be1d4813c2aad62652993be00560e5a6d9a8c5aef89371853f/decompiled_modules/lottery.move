module 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::lottery {
    struct LotteryDrawResult has copy, drop {
        round_id: u64,
        lottery_id: 0x2::object::ID,
        draw_result: 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult,
    }

    struct Lottery<phantom T0> has key {
        id: 0x2::object::UID,
        center_id: 0x2::object::ID,
        round_id: u64,
        pot: 0x2::balance::Balance<T0>,
        pot_final_balance: u64,
        stop_purchase_time: u64,
        draw_result: 0x1::option::Option<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult>,
        unsettled_tickets: 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>,
        pot_winners_distribution: 0x2::vec_map::VecMap<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>,
        reward_per_ticket_map: 0x2::vec_map::VecMap<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, u64>,
        jackpot_winners: vector<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>,
    }

    public fun id<T0>(arg0: &Lottery<T0>) : 0x2::object::ID {
        0x2::object::id<Lottery<T0>>(arg0)
    }

    entry fun draw<T0>(arg0: &mut Lottery<T0>, arg1: &0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg1, arg4);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x2::clock::timestamp_ms(arg3) <= arg0.stop_purchase_time) {
            err_too_early_to_draw();
        };
        if (0x1::option::is_some<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult>(&arg0.draw_result)) {
            err_already_has_draw_result();
        };
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::get_result(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::draw_config<T0>(arg1), &mut v0);
        let v2 = LotteryDrawResult{
            round_id    : arg0.round_id,
            lottery_id  : id<T0>(arg0),
            draw_result : v1,
        };
        0x2::event::emit<LotteryDrawResult>(v2);
        0x1::option::fill<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult>(&mut arg0.draw_result, v1);
    }

    public fun assert_correct_lottery_center<T0>(arg0: &Lottery<T0>, arg1: &0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>) {
        if (arg0.center_id != 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::id<T0>(arg1)) {
            err_wrong_lottery_center();
        };
    }

    public fun calc_payouts<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: &0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&arg0.unsettled_tickets) > 0) {
            err_still_has_unsettled_tickets();
        };
        let v0 = arg0.pot_final_balance;
        let v1 = 0;
        let v2 = *0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::payouts_config<T0>(arg1);
        let v3 = 0x2::vec_map::keys<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::Payout>(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::inner(&v2));
        while (0x1::vector::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(&v3) > 0) {
            let v4 = 0x1::vector::pop_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(&mut v3);
            let v5 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(0x2::vec_map::get<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&arg0.pot_winners_distribution, &v4));
            if (v5 > 0) {
                let v6 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::get_payout_amount(0x2::vec_map::get<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::Payout>(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::inner(&v2), &v4), v0);
                v1 = v1 + v6;
                0x2::vec_map::insert<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, u64>(&mut arg0.reward_per_ticket_map, v4, v6 / v5);
                continue
            };
            0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::adjust_payouts(&mut v2, &v4);
        };
        if (v1 > v0) {
            0x2::balance::join<T0>(&mut arg0.pot, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::withdraw_from_reserve<T0>(arg1, v1 - v0));
        };
    }

    public fun create<T0>(arg0: &mut 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg0);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg0, arg2);
        let v0 = 0x2::vec_map::keys<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::Payout>(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payouts::inner(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::payouts_config<T0>(arg0)));
        let v1 = 0x1::vector::empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(&v0)) {
            0x1::vector::push_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&mut v1, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::new<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(200, arg2));
            v2 = v2 + 1;
        };
        let v3 = Lottery<T0>{
            id                       : 0x2::object::new(arg2),
            center_id                : 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::id<T0>(arg0),
            round_id                 : 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::get_current_round_id<T0>(arg0),
            pot                      : 0x2::balance::zero<T0>(),
            pot_final_balance        : 0,
            stop_purchase_time       : arg1,
            draw_result              : 0x1::option::none<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult>(),
            unsettled_tickets        : 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::new<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(200, arg2),
            pot_winners_distribution : 0x2::vec_map::from_keys_values<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(v0, v1),
            reward_per_ticket_map    : 0x2::vec_map::empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, u64>(),
            jackpot_winners          : 0x1::vector::empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(),
        };
        0x2::transfer::share_object<Lottery<T0>>(v3);
    }

    public fun destroy<T0>(arg0: Lottery<T0>, arg1: &mut 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(&arg0, arg1);
        if (total_winner_ticket_count<T0>(&arg0) > 0 || 0x1::vector::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&arg0.jackpot_winners) > 0) {
            err_winners_not_all_paid();
        };
        let Lottery {
            id                       : v0,
            center_id                : _,
            round_id                 : _,
            pot                      : v3,
            pot_final_balance        : _,
            stop_purchase_time       : _,
            draw_result              : _,
            unsettled_tickets        : v7,
            pot_winners_distribution : v8,
            reward_per_ticket_map    : _,
            jackpot_winners          : v10,
        } = arg0;
        let v11 = v10;
        let v12 = v8;
        let v13 = v7;
        if (!0x1::vector::is_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&v11)) {
            err_cannot_destroy_lottery();
        };
        0x2::object::delete(v0);
        if (!0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::is_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&v13)) {
            err_cannot_destroy_lottery();
        };
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::destroy_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(v13);
        let v14 = 0;
        while (v14 < 0x2::vec_map::size<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&v12)) {
            let (_, v16) = 0x2::vec_map::pop<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&mut v12);
            let v17 = v16;
            if (!0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::is_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&v17)) {
                err_cannot_destroy_lottery();
            };
            0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::destroy_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(v17);
            v14 = v14 + 1;
        };
        0x2::vec_map::destroy_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(v12);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::deposit_to_reserve<T0>(arg1, 0x2::coin::from_balance<T0>(v3, arg2));
    }

    fun err_already_has_draw_result() {
        abort 3
    }

    fun err_cannot_destroy_lottery() {
        abort 5
    }

    fun err_invalid_picks() {
        abort 2
    }

    fun err_no_draw_result_to_settle() {
        abort 3
    }

    fun err_pot_payouts_not_calculated() {
        abort 4
    }

    fun err_still_has_unsettled_tickets() {
        abort 4
    }

    fun err_too_early_to_draw() {
        abort 2
    }

    fun err_too_late_to_purchase() {
        abort 2
    }

    fun err_winners_not_all_paid() {
        abort 4
    }

    fun err_wrong_lottery_center() {
        abort 1
    }

    public fun pay_jackpot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = 0x1::vector::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&arg0.jackpot_winners);
        if (v0 == 0) {
            return
        };
        let v1 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::withdraw_from_jackpot<T0>(arg1, arg2);
        let v2 = 0x2::coin::value<T0>(&v1) / v0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::pop_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&mut arg0.jackpot_winners);
            let v5 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::buyer(&v4);
            if (0x1::option::is_some<address>(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v2, arg2), 0x1::option::destroy_some<address>(v5));
                0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::emit_winning_event<T0>(v4, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::jackpot_combination<T0>(arg1), v2);
            } else {
                0x1::option::destroy_none<address>(v5);
            };
            v3 = v3 + 1;
        };
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::deposit_to_reserve<T0>(arg1, v1);
    }

    public fun pay_pot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg1, arg4);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (total_winner_ticket_count<T0>(arg0) == 0) {
            return
        };
        if (0x2::vec_map::is_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, u64>(&arg0.reward_per_ticket_map)) {
            err_pot_payouts_not_calculated();
        };
        if (0x2::vec_map::contains<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, u64>(&arg0.reward_per_ticket_map, &arg2)) {
            let v0 = *0x2::vec_map::get<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, u64>(&arg0.reward_per_ticket_map, &arg2);
            let v1 = 0x2::vec_map::get_mut<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&mut arg0.pot_winners_distribution, &arg2);
            let v2 = 0;
            while (v2 < 0x1::u64::min(arg3, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(v1))) {
                let v3 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::pop_front<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(v1);
                let v4 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::buyer(&v3);
                if (0x1::option::is_some<address>(&v4)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, v0), arg4), 0x1::option::destroy_some<address>(v4));
                } else {
                    0x1::option::destroy_none<address>(v4);
                };
                0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::emit_winning_event<T0>(v3, arg2, v0);
                v2 = v2 + 1;
            };
        };
    }

    public fun purchase<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: 0x1::option::Option<0x1::ascii::String>, arg8: 0x1::option::Option<0x1::ascii::String>, arg9: 0x1::option::Option<0x1::ascii::String>, arg10: 0x1::option::Option<0x1::ascii::String>, arg11: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x2::clock::timestamp_ms(arg2) >= arg0.stop_purchase_time) {
            err_too_late_to_purchase();
        };
        let (v0, v1, v2) = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::payment::check_and_split<T0>(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::payment_config<T0>(arg1), arg3, arg11);
        let v3 = v0;
        arg0.pot_final_balance = arg0.pot_final_balance + 0x2::coin::value<T0>(&v3);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(v3));
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::deposit_to_jackpot<T0>(arg1, v1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::deposit_to_jackpot<T0>(arg1, v2);
        let v4 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::picks::new(arg4, arg5);
        if (!0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::is_valid_picks(0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::draw_config<T0>(arg1), &v4)) {
            err_invalid_picks();
        };
        let v5 = if (arg6) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(0x2::tx_context::sender(arg11))
        };
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::push_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&mut arg0.unsettled_tickets, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::new(v5, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::picks::new(arg4, arg5), id<T0>(arg0), arg0.round_id, arg7, arg8, arg9, arg10));
    }

    public fun purchase_blank<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: 0x1::option::Option<0x1::ascii::String>, arg8: 0x1::option::Option<0x1::ascii::String>, arg9: 0x1::option::Option<0x1::ascii::String>, arg10: &mut 0x2::tx_context::TxContext) {
    }

    public fun settle_tickets<T0>(arg0: &mut Lottery<T0>, arg1: &0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::BiglottoCenter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_valid_package_version<T0>(arg1);
        0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::assert_sender_is_manager<T0>(arg1, arg3);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x1::option::is_none<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult>(&arg0.draw_result)) {
            err_no_draw_result_to_settle();
        };
        let v0 = *0x1::option::borrow<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::draw::DrawResult>(&arg0.draw_result);
        let v1 = 0;
        while (v1 < 0x1::u64::min(arg2, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&arg0.unsettled_tickets))) {
            let v2 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::pop_front<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&mut arg0.unsettled_tickets);
            let v3 = 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::get_combination(&v2, &v0);
            if (v3 == 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::center::jackpot_combination<T0>(arg1)) {
                0x1::vector::push_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(&mut arg0.jackpot_winners, v2);
            } else if (0x2::vec_map::contains<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&arg0.pot_winners_distribution, &v3)) {
                0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::push_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(0x2::vec_map::get_mut<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&mut arg0.pot_winners_distribution, &v3), v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun total_winner_ticket_count<T0>(arg0: &Lottery<T0>) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&arg0.pot_winners_distribution);
        0x1::vector::reverse<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(&mut v1);
            v0 = v0 + 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::length<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>(0x2::vec_map::get<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination, 0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::big_queue::BigQueue<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::ticket::Ticket>>(&arg0.pot_winners_distribution, &v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x11fe85b7681913be1d4813c2aad62652993be00560e5a6d9a8c5aef89371853f::combination::Combination>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

