module 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::lottery {
    struct LotteryDrawResult has copy, drop {
        lottery_id: 0x2::object::ID,
        round_id: u64,
        draw_seed: vector<u8>,
        bls_sig: vector<u8>,
        draw_result: 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult,
    }

    struct RoundData<phantom T0> has store {
        round_id: u64,
        pot: 0x2::balance::Balance<T0>,
        pot_final_balance: u64,
        stop_purchase_time: u64,
        draw_seed: vector<u8>,
        draw_result: 0x1::option::Option<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult>,
        unsettled_tickets: 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>,
        pot_winners_distribution: 0x2::vec_map::VecMap<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>,
        reward_per_ticket_map: 0x2::vec_map::VecMap<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, u64>,
        jackpot_winners: vector<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>,
    }

    struct Lottery<phantom T0> has key {
        id: 0x2::object::UID,
        center_id: 0x2::object::ID,
        current_round_id: u64,
        round_data: 0x1::option::Option<RoundData<T0>>,
    }

    public fun id<T0>(arg0: &Lottery<T0>) : 0x2::object::ID {
        0x2::object::id<Lottery<T0>>(arg0)
    }

    public fun draw<T0>(arg0: &mut Lottery<T0>, arg1: &0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg3);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x1::vector::is_empty<u8>(&v0.draw_seed)) {
            err_no_draw_seed_to_get_result();
        };
        if (0x1::option::is_some<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult>(&v0.draw_result)) {
            err_already_has_draw_result();
        };
        let v1 = v0.draw_seed;
        if (!0x2::bls12381::bls12381_min_pk_verify(&arg2, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::bls_pub_key<T0>(arg1), &v1)) {
            err_invalid_bls_signature();
        };
        let v2 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::get_result(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::draw_config<T0>(arg1), arg2);
        0x1::option::fill<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult>(&mut v0.draw_result, v2);
        let v3 = LotteryDrawResult{
            lottery_id  : id<T0>(arg0),
            round_id    : arg0.current_round_id,
            draw_seed   : v1,
            bls_sig     : arg2,
            draw_result : v2,
        };
        0x2::event::emit<LotteryDrawResult>(v3);
    }

    fun assert_correct_lottery_center<T0>(arg0: &Lottery<T0>, arg1: &0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>) {
        if (arg0.center_id != 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::id<T0>(arg1)) {
            err_wrong_lottery_center();
        };
    }

    fun borrow_round_data<T0>(arg0: &Lottery<T0>) : &RoundData<T0> {
        if (0x1::option::is_none<RoundData<T0>>(&arg0.round_data)) {
            err_round_data_not_found();
        };
        0x1::option::borrow<RoundData<T0>>(&arg0.round_data)
    }

    fun borrow_round_data_mut<T0>(arg0: &mut Lottery<T0>) : &mut RoundData<T0> {
        if (0x1::option::is_none<RoundData<T0>>(&arg0.round_data)) {
            err_round_data_not_found();
        };
        0x1::option::borrow_mut<RoundData<T0>>(&mut arg0.round_data)
    }

    public fun calc_payouts<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: &0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&v0.unsettled_tickets) > 0) {
            err_still_has_unsettled_tickets();
        };
        let v1 = v0.pot_final_balance;
        let v2 = 0;
        let v3 = *0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::payouts_config<T0>(arg1);
        let v4 = 0x2::vec_map::keys<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::Payout>(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::inner(&v3));
        while (0x1::vector::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(&v4) > 0) {
            let v5 = 0x1::vector::pop_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(&mut v4);
            let v6 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(0x2::vec_map::get<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&v0.pot_winners_distribution, &v5));
            if (v6 > 0) {
                let v7 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::get_payout_amount(0x2::vec_map::get<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::Payout>(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::inner(&v3), &v5), v1);
                v2 = v2 + v7;
                0x2::vec_map::insert<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, u64>(&mut v0.reward_per_ticket_map, v5, v7 / v6);
                continue
            };
            0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::adjust_payouts(&mut v3, &v5);
        };
        if (v2 > v1) {
            0x2::balance::join<T0>(&mut v0.pot, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::withdraw_from_reserve<T0>(arg1, v2 - v1));
        };
    }

    public fun create<T0>(arg0: &mut 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg0);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg0, arg1);
        let v0 = Lottery<T0>{
            id               : 0x2::object::new(arg1),
            center_id        : 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::id<T0>(arg0),
            current_round_id : 0,
            round_data       : 0x1::option::none<RoundData<T0>>(),
        };
        0x2::transfer::share_object<Lottery<T0>>(v0);
    }

    public fun destroy_current_round<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (total_winner_ticket_count<T0>(arg0) > 0) {
            err_winners_not_all_paid();
        };
        let RoundData {
            round_id                 : _,
            pot                      : v1,
            pot_final_balance        : _,
            stop_purchase_time       : _,
            draw_seed                : _,
            draw_result              : _,
            unsettled_tickets        : v6,
            pot_winners_distribution : v7,
            reward_per_ticket_map    : _,
            jackpot_winners          : v9,
        } = 0x1::option::extract<RoundData<T0>>(&mut arg0.round_data);
        let v10 = v9;
        let v11 = v7;
        let v12 = v6;
        if (!0x1::vector::is_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&v10)) {
            err_cannot_destroy_lottery();
        };
        if (!0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::is_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&v12)) {
            err_cannot_destroy_lottery();
        };
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::destroy_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(v12);
        let v13 = 0;
        while (v13 < 0x2::vec_map::size<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&v11)) {
            let (_, v15) = 0x2::vec_map::pop<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&mut v11);
            let v16 = v15;
            if (!0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::is_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&v16)) {
                err_cannot_destroy_lottery();
            };
            0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::destroy_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(v16);
            v13 = v13 + 1;
        };
        0x2::vec_map::destroy_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(v11);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::deposit_to_reserve<T0>(arg1, 0x2::coin::from_balance<T0>(v1, arg2));
    }

    fun err_already_has_draw_result() {
        abort 9
    }

    fun err_already_has_draw_seed() {
        abort 6
    }

    fun err_cannot_destroy_lottery() {
        abort 14
    }

    fun err_invalid_bls_signature() {
        abort 8
    }

    fun err_invalid_picks() {
        abort 4
    }

    fun err_no_draw_result_to_settle() {
        abort 10
    }

    fun err_no_draw_seed_to_get_result() {
        abort 7
    }

    fun err_pot_payouts_not_calculated() {
        abort 12
    }

    fun err_round_data_already_exists() {
        abort 1
    }

    fun err_round_data_not_found() {
        abort 0
    }

    fun err_still_has_unsettled_tickets() {
        abort 11
    }

    fun err_too_early_to_draw() {
        abort 5
    }

    fun err_too_late_to_purchase() {
        abort 3
    }

    fun err_winners_not_all_paid() {
        abort 13
    }

    fun err_wrong_lottery_center() {
        abort 2
    }

    entry fun gen_draw_seed<T0>(arg0: &mut Lottery<T0>, arg1: &0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg4);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x2::clock::timestamp_ms(arg3) <= v0.stop_purchase_time) {
            err_too_early_to_draw();
        };
        if (!0x1::vector::is_empty<u8>(&v0.draw_seed)) {
            err_already_has_draw_seed();
        };
        let v1 = 0x2::random::new_generator(arg2, arg4);
        v0.draw_seed = 0x2::random::generate_bytes(&mut v1, 256);
    }

    fun increase_round_id<T0>(arg0: &mut Lottery<T0>) : u64 {
        arg0.current_round_id = arg0.current_round_id + 1;
        arg0.current_round_id
    }

    public fun new_round<T0>(arg0: &mut Lottery<T0>, arg1: &0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg3);
        if (0x1::option::is_some<RoundData<T0>>(&arg0.round_data)) {
            err_round_data_already_exists();
        };
        let v0 = 0x2::vec_map::keys<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::Payout>(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payouts::inner(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::payouts_config<T0>(arg1)));
        let v1 = increase_round_id<T0>(arg0);
        let v2 = 0x1::vector::empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(&v0)) {
            0x1::vector::push_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&mut v2, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::new<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(200, arg3));
            v3 = v3 + 1;
        };
        let v4 = RoundData<T0>{
            round_id                 : v1,
            pot                      : 0x2::balance::zero<T0>(),
            pot_final_balance        : 0,
            stop_purchase_time       : arg2,
            draw_seed                : b"",
            draw_result              : 0x1::option::none<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult>(),
            unsettled_tickets        : 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::new<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(200, arg3),
            pot_winners_distribution : 0x2::vec_map::from_keys_values<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(v0, v2),
            reward_per_ticket_map    : 0x2::vec_map::empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, u64>(),
            jackpot_winners          : 0x1::vector::empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(),
        };
        0x1::option::fill<RoundData<T0>>(&mut arg0.round_data, v4);
    }

    public fun pay_jackpot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg2);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = borrow_round_data_mut<T0>(arg0);
        let v1 = 0x1::vector::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&v0.jackpot_winners);
        if (v1 == 0) {
            return
        };
        let v2 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::withdraw_from_jackpot<T0>(arg1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2) / v1;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::pop_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&mut v0.jackpot_winners);
            let v6 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::buyer(&v5);
            if (0x1::option::is_some<address>(&v6)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2, v3, arg2), 0x1::option::destroy_some<address>(v6));
                0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::emit_winning_event<T0>(v5, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::jackpot_combination<T0>(arg1), v3);
            } else {
                0x1::option::destroy_none<address>(v6);
            };
            v4 = v4 + 1;
        };
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::deposit_to_reserve<T0>(arg1, v2);
    }

    public fun pay_pot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg4);
        assert_correct_lottery_center<T0>(arg0, arg1);
        if (total_winner_ticket_count<T0>(arg0) == 0) {
            return
        };
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x2::vec_map::is_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, u64>(&v0.reward_per_ticket_map)) {
            err_pot_payouts_not_calculated();
        };
        if (0x2::vec_map::contains<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, u64>(&v0.reward_per_ticket_map, &arg2)) {
            let v1 = *0x2::vec_map::get<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, u64>(&v0.reward_per_ticket_map, &arg2);
            let v2 = 0x2::vec_map::get_mut<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&mut v0.pot_winners_distribution, &arg2);
            let v3 = 0;
            while (v3 < 0x1::u64::min(arg3, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(v2))) {
                let v4 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::pop_front<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(v2);
                let v5 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::buyer(&v4);
                if (0x1::option::is_some<address>(&v5)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.pot, v1), arg4), 0x1::option::destroy_some<address>(v5));
                } else {
                    0x1::option::destroy_none<address>(v5);
                };
                0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::emit_winning_event<T0>(v4, arg2, v1);
                v3 = v3 + 1;
            };
        };
    }

    public fun purchase<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: 0x1::option::Option<0x1::ascii::String>, arg8: 0x1::option::Option<0x1::ascii::String>, arg9: 0x1::option::Option<0x1::ascii::String>, arg10: 0x1::option::Option<0x1::ascii::String>, arg11: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = id<T0>(arg0);
        let v1 = borrow_round_data_mut<T0>(arg0);
        if (0x2::clock::timestamp_ms(arg2) >= v1.stop_purchase_time) {
            err_too_late_to_purchase();
        };
        let (v2, v3, v4) = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::payment::check_and_split<T0>(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::payment_config<T0>(arg1), arg3, arg11);
        let v5 = v2;
        v1.pot_final_balance = v1.pot_final_balance + 0x2::coin::value<T0>(&v5);
        0x2::balance::join<T0>(&mut v1.pot, 0x2::coin::into_balance<T0>(v5));
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::deposit_to_jackpot<T0>(arg1, v3);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::deposit_to_reserve<T0>(arg1, v4);
        let v6 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::picks::new(arg4, arg5);
        if (!0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::is_valid_picks(0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::draw_config<T0>(arg1), &v6)) {
            err_invalid_picks();
        };
        let v7 = if (arg6) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(0x2::tx_context::sender(arg11))
        };
        let v8 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::new(v7, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::picks::new(arg4, arg5), v0, v1.round_id, arg7, arg8, arg9, arg10);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::emit_new_ticket(&v8, v0, v1.round_id);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::push_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&mut v1.unsettled_tickets, v8);
    }

    public fun settle_tickets<T0>(arg0: &mut Lottery<T0>, arg1: &0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::BiglottoCenter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_valid_package_version<T0>(arg1);
        0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::assert_sender_is_manager<T0>(arg1, arg3);
        assert_correct_lottery_center<T0>(arg0, arg1);
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x1::option::is_none<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult>(&v0.draw_result)) {
            err_no_draw_result_to_settle();
        };
        let v1 = *0x1::option::borrow<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::draw::DrawResult>(&v0.draw_result);
        let v2 = 0;
        while (v2 < 0x1::u64::min(arg2, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&v0.unsettled_tickets))) {
            let v3 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::pop_front<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&mut v0.unsettled_tickets);
            let v4 = 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::get_combination(&v3, &v1);
            if (v4 == 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::center::jackpot_combination<T0>(arg1)) {
                0x1::vector::push_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(&mut v0.jackpot_winners, v3);
            } else if (0x2::vec_map::contains<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&v0.pot_winners_distribution, &v4)) {
                0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::push_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(0x2::vec_map::get_mut<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&mut v0.pot_winners_distribution, &v4), v3);
            };
            v2 = v2 + 1;
        };
    }

    public fun total_winner_ticket_count<T0>(arg0: &Lottery<T0>) : u64 {
        let v0 = borrow_round_data<T0>(arg0);
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&v0.pot_winners_distribution);
        0x1::vector::reverse<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(&mut v2);
            v1 = v1 + 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::length<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>(0x2::vec_map::get<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination, 0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::big_queue::BigQueue<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::ticket::Ticket>>(&v0.pot_winners_distribution, &v4));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x46476e62d3b02cf0adc5abd50260268c96f5bb7333b19741ea96583cb26601b1::combination::Combination>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

