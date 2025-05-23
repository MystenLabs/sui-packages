module 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::lottery {
    struct LotteryDrawResult has copy, drop {
        round_id: u64,
        lottery_id: 0x2::object::ID,
        draw_seed: vector<u8>,
        bls_sig: vector<u8>,
        draw_result: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult,
    }

    struct Lottery<phantom T0> has key {
        id: 0x2::object::UID,
        center_id: 0x2::object::ID,
        round_id: u64,
        pot: 0x2::balance::Balance<T0>,
        pot_final_balance: u64,
        stop_purchase_time: u64,
        draw_seed: vector<u8>,
        draw_result: 0x1::option::Option<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult>,
        unsettled_tickets: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>,
        pot_winners_distribution: 0x2::vec_map::VecMap<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>,
        reward_per_ticket_map: 0x2::vec_map::VecMap<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, u64>,
        jackpot_winners: vector<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>,
    }

    struct NewTicket has copy, drop {
        owner: 0x1::option::Option<0x1::ascii::String>,
        normal_numbers: vector<u8>,
        special_numbers: vector<u8>,
        lottery_id: 0x2::object::ID,
        round_id: u64,
        chain_id: 0x1::option::Option<0x1::ascii::String>,
        app_id: 0x1::option::Option<0x1::ascii::String>,
        ref_id: 0x1::option::Option<0x1::ascii::String>,
    }

    public fun id<T0>(arg0: &Lottery<T0>) : 0x2::object::ID {
        0x2::object::id<Lottery<T0>>(arg0)
    }

    public fun draw<T0>(arg0: &mut Lottery<T0>, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg3);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x1::vector::is_empty<u8>(&arg0.draw_seed)) {
            err_no_draw_seed_to_get_result();
        };
        if (0x1::option::is_some<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult>(&arg0.draw_result)) {
            err_already_has_draw_result();
        };
        let v0 = id<T0>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        0x1::vector::append<u8>(&mut v1, arg0.draw_seed);
        if (!0x2::bls12381::bls12381_min_pk_verify(&arg2, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::bls_pub_key<T0>(arg1), &v1)) {
            err_invalid_bls_signature();
        };
        let v2 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::get_result(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::draw_config<T0>(arg1), arg2);
        let v3 = LotteryDrawResult{
            round_id    : arg0.round_id,
            lottery_id  : id<T0>(arg0),
            draw_seed   : v1,
            bls_sig     : arg2,
            draw_result : v2,
        };
        0x2::event::emit<LotteryDrawResult>(v3);
        0x1::option::fill<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult>(&mut arg0.draw_result, v2);
    }

    public fun assert_correct_lottery_center<T0>(arg0: &Lottery<T0>, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>) {
        if (arg0.center_id != 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::id<T0>(arg1)) {
            err_wrong_lottery_center();
        };
    }

    public fun calc_payouts<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: &0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&arg0.unsettled_tickets) > 0) {
            err_still_has_unsettled_tickets();
        };
        let v0 = arg0.pot_final_balance;
        let v1 = 0;
        let v2 = *0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::payouts_config<T0>(arg1);
        let v3 = 0x2::vec_map::keys<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::Payout>(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::inner(&v2));
        while (0x1::vector::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&v3) > 0) {
            let v4 = 0x1::vector::pop_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&mut v3);
            let v5 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(0x2::vec_map::get<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&arg0.pot_winners_distribution, &v4));
            if (v5 > 0) {
                let v6 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::get_payout_amount(0x2::vec_map::get<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::Payout>(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::inner(&v2), &v4), v0);
                v1 = v1 + v6;
                0x2::vec_map::insert<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, u64>(&mut arg0.reward_per_ticket_map, v4, v6 / v5);
                continue
            };
            0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::adjust_payouts(&mut v2, &v4);
        };
        if (v1 > v0) {
            0x2::balance::join<T0>(&mut arg0.pot, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::withdraw_from_reserve<T0>(arg1, v1 - v0));
        };
    }

    public fun create<T0>(arg0: &mut 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg0);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg0, arg2);
        let v0 = 0x2::vec_map::keys<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::Payout>(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts::inner(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::payouts_config<T0>(arg0)));
        let v1 = 0x1::vector::empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&v0)) {
            0x1::vector::push_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&mut v1, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::new<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(200, arg2));
            v2 = v2 + 1;
        };
        let v3 = Lottery<T0>{
            id                       : 0x2::object::new(arg2),
            center_id                : 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::id<T0>(arg0),
            round_id                 : 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::get_current_round_id<T0>(arg0),
            pot                      : 0x2::balance::zero<T0>(),
            pot_final_balance        : 0,
            stop_purchase_time       : arg1,
            draw_seed                : b"",
            draw_result              : 0x1::option::none<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult>(),
            unsettled_tickets        : 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::new<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(200, arg2),
            pot_winners_distribution : 0x2::vec_map::from_keys_values<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(v0, v1),
            reward_per_ticket_map    : 0x2::vec_map::empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, u64>(),
            jackpot_winners          : 0x1::vector::empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(),
        };
        0x2::transfer::share_object<Lottery<T0>>(v3);
    }

    public fun destroy<T0>(arg0: Lottery<T0>, arg1: &mut 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(&arg0, arg1);
        if (total_winner_ticket_count<T0>(&arg0) > 0 || 0x1::vector::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&arg0.jackpot_winners) > 0) {
            err_winners_not_all_paid();
        };
        let Lottery {
            id                       : v0,
            center_id                : _,
            round_id                 : _,
            pot                      : v3,
            pot_final_balance        : _,
            stop_purchase_time       : _,
            draw_seed                : _,
            draw_result              : _,
            unsettled_tickets        : v8,
            pot_winners_distribution : v9,
            reward_per_ticket_map    : _,
            jackpot_winners          : v11,
        } = arg0;
        let v12 = v11;
        let v13 = v9;
        let v14 = v8;
        if (!0x1::vector::is_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&v12)) {
            err_cannot_destroy_lottery();
        };
        0x2::object::delete(v0);
        if (!0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::is_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&v14)) {
            err_cannot_destroy_lottery();
        };
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::destroy_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(v14);
        let v15 = 0;
        while (v15 < 0x2::vec_map::size<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&v13)) {
            let (_, v17) = 0x2::vec_map::pop<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&mut v13);
            let v18 = v17;
            if (!0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::is_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&v18)) {
                err_cannot_destroy_lottery();
            };
            0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::destroy_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(v18);
            v15 = v15 + 1;
        };
        0x2::vec_map::destroy_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(v13);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::deposit_to_reserve<T0>(arg1, 0x2::coin::from_balance<T0>(v3, arg2));
    }

    fun err_already_has_draw_result() {
        abort 3
    }

    fun err_already_has_draw_seed() {
        abort 3
    }

    fun err_cannot_destroy_lottery() {
        abort 5
    }

    fun err_invalid_bls_signature() {
        abort 4
    }

    fun err_invalid_picks() {
        abort 2
    }

    fun err_no_draw_result_to_settle() {
        abort 3
    }

    fun err_no_draw_seed_to_get_result() {
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

    entry fun gen_draw_seed<T0>(arg0: &mut Lottery<T0>, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg4);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x2::clock::timestamp_ms(arg3) <= arg0.stop_purchase_time) {
            err_too_early_to_draw();
        };
        if (!0x1::vector::is_empty<u8>(&arg0.draw_seed)) {
            err_already_has_draw_seed();
        };
        let v0 = 0x2::random::new_generator(arg2, arg4);
        arg0.draw_seed = 0x2::random::generate_bytes(&mut v0, 8);
    }

    public fun pay_jackpot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = 0x1::vector::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&arg0.jackpot_winners);
        if (v0 == 0) {
            return
        };
        let v1 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::withdraw_from_jackpot<T0>(arg1, arg2);
        let v2 = 0x2::coin::value<T0>(&v1) / v0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::pop_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&mut arg0.jackpot_winners);
            let v5 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::buyer(&v4);
            if (0x1::option::is_some<address>(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v2, arg2), 0x1::option::destroy_some<address>(v5));
                0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::emit_winning_event<T0>(v4, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::jackpot_combination<T0>(arg1), v2);
            } else {
                0x1::option::destroy_none<address>(v5);
            };
            v3 = v3 + 1;
        };
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::deposit_to_reserve<T0>(arg1, v1);
    }

    public fun pay_pot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg4);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (total_winner_ticket_count<T0>(arg0) == 0) {
            return
        };
        if (0x2::vec_map::is_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, u64>(&arg0.reward_per_ticket_map)) {
            err_pot_payouts_not_calculated();
        };
        if (0x2::vec_map::contains<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, u64>(&arg0.reward_per_ticket_map, &arg2)) {
            let v0 = *0x2::vec_map::get<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, u64>(&arg0.reward_per_ticket_map, &arg2);
            let v1 = 0x2::vec_map::get_mut<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&mut arg0.pot_winners_distribution, &arg2);
            let v2 = 0;
            while (v2 < 0x1::u64::min(arg3, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(v1))) {
                let v3 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::pop_front<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(v1);
                let v4 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::buyer(&v3);
                if (0x1::option::is_some<address>(&v4)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, v0), arg4), 0x1::option::destroy_some<address>(v4));
                } else {
                    0x1::option::destroy_none<address>(v4);
                };
                0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::emit_winning_event<T0>(v3, arg2, v0);
                v2 = v2 + 1;
            };
        };
    }

    public fun purchase<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: 0x1::option::Option<0x1::ascii::String>, arg8: 0x1::option::Option<0x1::ascii::String>, arg9: 0x1::option::Option<0x1::ascii::String>, arg10: 0x1::option::Option<0x1::ascii::String>, arg11: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = NewTicket{
            owner           : arg7,
            normal_numbers  : arg4,
            special_numbers : arg5,
            lottery_id      : id<T0>(arg0),
            round_id        : arg0.round_id,
            chain_id        : arg8,
            app_id          : arg9,
            ref_id          : arg10,
        };
        0x2::event::emit<NewTicket>(v0);
        if (0x2::clock::timestamp_ms(arg2) >= arg0.stop_purchase_time) {
            err_too_late_to_purchase();
        };
        let (v1, v2, v3) = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payment::check_and_split<T0>(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::payment_config<T0>(arg1), arg3, arg11);
        let v4 = v1;
        arg0.pot_final_balance = arg0.pot_final_balance + 0x2::coin::value<T0>(&v4);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(v4));
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::deposit_to_jackpot<T0>(arg1, v2);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::deposit_to_reserve<T0>(arg1, v3);
        let v5 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::picks::new(arg4, arg5);
        if (!0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::is_valid_picks(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::draw_config<T0>(arg1), &v5)) {
            err_invalid_picks();
        };
        let v6 = if (arg6) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(0x2::tx_context::sender(arg11))
        };
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::push_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&mut arg0.unsettled_tickets, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::new(v6, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::picks::new(arg4, arg5), id<T0>(arg0), arg0.round_id, arg7, arg8, arg9, arg10));
    }

    public fun settle_tickets<T0>(arg0: &mut Lottery<T0>, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::BiglottoCenter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_valid_package_version<T0>(arg1);
        0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::assert_sender_is_manager<T0>(arg1, arg3);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (0x1::option::is_none<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult>(&arg0.draw_result)) {
            err_no_draw_result_to_settle();
        };
        let v0 = *0x1::option::borrow<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::draw::DrawResult>(&arg0.draw_result);
        let v1 = 0;
        while (v1 < 0x1::u64::min(arg2, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&arg0.unsettled_tickets))) {
            let v2 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::pop_front<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&mut arg0.unsettled_tickets);
            let v3 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::get_combination(&v2, &v0);
            if (v3 == 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::center::jackpot_combination<T0>(arg1)) {
                0x1::vector::push_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(&mut arg0.jackpot_winners, v2);
            } else if (0x2::vec_map::contains<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&arg0.pot_winners_distribution, &v3)) {
                0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::push_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(0x2::vec_map::get_mut<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&mut arg0.pot_winners_distribution, &v3), v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun total_winner_ticket_count<T0>(arg0: &Lottery<T0>) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&arg0.pot_winners_distribution);
        0x1::vector::reverse<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&mut v1);
            v0 = v0 + 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>(0x2::vec_map::get<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::big_queue::BigQueue<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::ticket::Ticket>>(&arg0.pot_winners_distribution, &v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

