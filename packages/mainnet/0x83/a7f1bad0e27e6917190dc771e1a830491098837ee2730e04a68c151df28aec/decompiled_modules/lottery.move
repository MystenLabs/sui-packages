module 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::lottery {
    struct LotteryCreatedEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        jackpot_id: 0x2::object::ID,
        payment_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::PaymentConfig,
        draw_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawConfig,
        payouts_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::PayoutsConfig,
        jackpot_combination: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination,
        bls_pub_key: vector<u8>,
        manager: address,
    }

    struct LotteryNewRoundEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        round_id: u64,
        start_time: u64,
        end_time: u64,
    }

    struct LotteryDrawResultEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        round_id: u64,
        draw_seed: vector<u8>,
        bls_sig: vector<u8>,
        draw_result: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult,
    }

    struct RoundData<phantom T0> has store {
        round_id: u64,
        pot_final_balance: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance::AccountingBalance,
        start_time: u64,
        end_time: u64,
        draw_seed: vector<u8>,
        draw_result: 0x1::option::Option<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>,
        unsettled_tickets: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>,
        pot_winners_distribution: 0x2::vec_map::VecMap<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>,
        reward_per_ticket_map: 0x2::vec_map::VecMap<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, u64>,
        jackpot_winners: vector<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>,
        payouts_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::PayoutsConfig,
    }

    struct Lottery<phantom T0> has key {
        id: 0x2::object::UID,
        jackpot_id: 0x2::object::ID,
        payment_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::PaymentConfig,
        draw_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawConfig,
        payouts_config: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::PayoutsConfig,
        jackpot_combination: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination,
        bls_pub_key: vector<u8>,
        manager: address,
        current_round_id: u64,
        round_data: 0x1::option::Option<RoundData<T0>>,
    }

    public fun id<T0>(arg0: &Lottery<T0>) : 0x2::object::ID {
        0x2::object::id<Lottery<T0>>(arg0)
    }

    public fun draw<T0>(arg0: &mut Lottery<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg2);
        let v0 = bls_pub_key<T0>(arg0);
        let v1 = draw_config<T0>(arg0);
        let v2 = borrow_round_data_mut<T0>(arg0);
        if (0x1::vector::is_empty<u8>(&v2.draw_seed)) {
            err_no_draw_seed_to_get_result();
        };
        if (0x1::option::is_some<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&v2.draw_result)) {
            err_already_has_draw_result();
        };
        let v3 = v2.draw_seed;
        if (!0x2::bls12381::bls12381_min_pk_verify(&arg1, &v0, &v3)) {
            err_invalid_bls_signature();
        };
        let v4 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::get_result(&v1, arg1);
        0x1::option::fill<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&mut v2.draw_result, v4);
        let v5 = LotteryDrawResultEvent{
            lottery_id  : id<T0>(arg0),
            round_id    : arg0.current_round_id,
            draw_seed   : v3,
            bls_sig     : arg1,
            draw_result : v4,
        };
        0x2::event::emit<LotteryDrawResultEvent>(v5);
    }

    fun assert_correct_jackpot<T0>(arg0: &Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>) {
        if (jackpot_id<T0>(arg0) != 0x2::object::id<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>>(arg1)) {
            err_wrong_jackpot();
        };
    }

    fun assert_sender_is_manager<T0>(arg0: &Lottery<T0>, arg1: &0x2::tx_context::TxContext) {
        if (arg0.manager != 0x2::tx_context::sender(arg1)) {
            err_sender_is_not_manager();
        };
    }

    public fun bls_pub_key<T0>(arg0: &Lottery<T0>) : vector<u8> {
        arg0.bls_pub_key
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

    public fun calc_payouts<T0>(arg0: &mut Lottery<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg1);
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&v0.unsettled_tickets) > 0) {
            err_still_has_unsettled_tickets();
        };
        let v1 = 0;
        let v2 = &mut v0.payouts_config;
        let v3 = 0x2::vec_map::keys<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::Payout>(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::inner(v2));
        while (0x1::vector::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(&v3) > 0) {
            let v4 = 0x1::vector::pop_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(&mut v3);
            let v5 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(0x2::vec_map::get<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&v0.pot_winners_distribution, &v4));
            if (v5 > 0) {
                let v6 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::get_payout_amount(0x2::vec_map::get<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::Payout>(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::inner(v2), &v4), 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance::value(&v0.pot_final_balance));
                v1 = v1 + v6;
                0x2::vec_map::insert<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, u64>(&mut v0.reward_per_ticket_map, v4, v6 / v5);
                continue
            };
            0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::adjust_payouts(v2, &v4);
        };
    }

    public fun create<T0>(arg0: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>, arg2: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::PaymentConfig, arg3: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawConfig, arg4: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::PayoutsConfig, arg5: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, arg6: vector<u8>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>>(arg1);
        let v1 = Lottery<T0>{
            id                  : 0x2::object::new(arg8),
            jackpot_id          : v0,
            payment_config      : arg2,
            draw_config         : arg3,
            payouts_config      : arg4,
            jackpot_combination : arg5,
            bls_pub_key         : arg6,
            manager             : arg7,
            current_round_id    : 0,
            round_data          : 0x1::option::none<RoundData<T0>>(),
        };
        let v2 = LotteryCreatedEvent{
            lottery_id          : 0x2::object::id<Lottery<T0>>(&v1),
            jackpot_id          : v0,
            payment_config      : arg2,
            draw_config         : arg3,
            payouts_config      : arg4,
            jackpot_combination : arg5,
            bls_pub_key         : arg6,
            manager             : arg7,
        };
        0x2::event::emit<LotteryCreatedEvent>(v2);
        0x2::transfer::share_object<Lottery<T0>>(v1);
    }

    public fun destroy_current_round<T0>(arg0: &mut Lottery<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg1);
        if (total_winner_ticket_count<T0>(arg0) > 0) {
            err_winners_not_all_paid();
        };
        let RoundData {
            round_id                 : _,
            pot_final_balance        : _,
            start_time               : _,
            end_time                 : _,
            draw_seed                : _,
            draw_result              : _,
            unsettled_tickets        : v6,
            pot_winners_distribution : v7,
            reward_per_ticket_map    : _,
            jackpot_winners          : v9,
            payouts_config           : _,
        } = 0x1::option::extract<RoundData<T0>>(&mut arg0.round_data);
        let v11 = v9;
        let v12 = v7;
        let v13 = v6;
        if (!0x1::vector::is_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&v11)) {
            err_cannot_destroy_lottery();
        };
        if (!0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::is_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&v13)) {
            err_cannot_destroy_lottery();
        };
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::destroy_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(v13);
        let v14 = 0;
        while (v14 < 0x2::vec_map::size<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&v12)) {
            let (_, v16) = 0x2::vec_map::pop<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&mut v12);
            let v17 = v16;
            if (!0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::is_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&v17)) {
                err_cannot_destroy_lottery();
            };
            0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::destroy_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(v17);
            v14 = v14 + 1;
        };
        0x2::vec_map::destroy_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(v12);
    }

    public fun draw_config<T0>(arg0: &Lottery<T0>) : 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawConfig {
        arg0.draw_config
    }

    public fun emit_fake_jackpot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg8);
        assert_correct_jackpot<T0>(arg0, arg1);
        let v0 = id<T0>(arg0);
        let v1 = jackpot_combination<T0>(arg0);
        let v2 = borrow_round_data_mut<T0>(arg0);
        let v3 = 0x1::option::borrow<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&v2.draw_result);
        let v4 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::new(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(*0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::normal_numbers(v3), *0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::special_numbers(v3)), v0, v2.round_id, arg2, arg4, arg5, arg6, arg7, arg3);
        let v5 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_balance<T0>(arg1);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_new_ticket(&v4, v0, v2.round_id);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_winning_event<T0>(v4, v1, v5, true);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_sub<T0>(arg1, v5);
    }

    public fun emit_jackpot_winners<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg2);
        assert_correct_jackpot<T0>(arg0, arg1);
        let v0 = jackpot_combination<T0>(arg0);
        let v1 = borrow_round_data_mut<T0>(arg0);
        let v2 = 0x1::vector::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&v1.jackpot_winners);
        if (v2 == 0) {
            return
        };
        let v3 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_balance<T0>(arg1) / v2;
        let v4 = 0;
        while (v4 < v2) {
            0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_winning_event<T0>(0x1::vector::pop_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&mut v1.jackpot_winners), v0, v3, true);
            v4 = v4 + 1;
        };
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_sub<T0>(arg1, v3 * v2);
    }

    public fun emit_pot_winners<T0>(arg0: &mut Lottery<T0>, arg1: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg3);
        if (total_winner_ticket_count<T0>(arg0) == 0) {
            return
        };
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x2::vec_map::is_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, u64>(&v0.reward_per_ticket_map)) {
            err_pot_payouts_not_calculated();
        };
        if (0x2::vec_map::contains<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, u64>(&v0.reward_per_ticket_map, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&mut v0.pot_winners_distribution, &arg1);
            let v2 = 0;
            while (v2 < 0x1::u64::min(arg2, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(v1))) {
                0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_winning_event<T0>(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::pop_front<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(v1), arg1, *0x2::vec_map::get<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, u64>(&v0.reward_per_ticket_map, &arg1), false);
                v2 = v2 + 1;
            };
        };
    }

    fun err_already_has_draw_result() {
        abort 709
    }

    fun err_already_has_draw_seed() {
        abort 706
    }

    fun err_cannot_destroy_lottery() {
        abort 714
    }

    fun err_invalid_bls_signature() {
        abort 708
    }

    fun err_invalid_picks() {
        abort 704
    }

    fun err_no_draw_result_to_settle() {
        abort 710
    }

    fun err_no_draw_seed_to_get_result() {
        abort 707
    }

    fun err_pot_payouts_not_calculated() {
        abort 712
    }

    fun err_round_data_already_exists() {
        abort 701
    }

    fun err_round_data_not_found() {
        abort 700
    }

    fun err_sender_is_not_manager() {
        abort 715
    }

    fun err_still_has_unsettled_tickets() {
        abort 711
    }

    fun err_too_early_to_draw() {
        abort 705
    }

    fun err_too_late_to_purchase() {
        abort 703
    }

    fun err_winners_not_all_paid() {
        abort 713
    }

    fun err_wrong_jackpot() {
        abort 702
    }

    entry fun gen_draw_seed<T0>(arg0: &mut Lottery<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg3);
        let v0 = borrow_round_data_mut<T0>(arg0);
        if (0x2::clock::timestamp_ms(arg2) <= v0.end_time) {
            err_too_early_to_draw();
        };
        if (!0x1::vector::is_empty<u8>(&v0.draw_seed)) {
            err_already_has_draw_seed();
        };
        let v1 = 0x2::random::new_generator(arg1, arg3);
        v0.draw_seed = 0x2::random::generate_bytes(&mut v1, 256);
    }

    fun increase_round_id<T0>(arg0: &mut Lottery<T0>) : u64 {
        arg0.current_round_id = arg0.current_round_id + 1;
        arg0.current_round_id
    }

    public fun jackpot_combination<T0>(arg0: &Lottery<T0>) : 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination {
        arg0.jackpot_combination
    }

    public fun jackpot_id<T0>(arg0: &Lottery<T0>) : 0x2::object::ID {
        arg0.jackpot_id
    }

    public fun new_round<T0>(arg0: &mut Lottery<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg3);
        if (0x1::option::is_some<RoundData<T0>>(&arg0.round_data)) {
            err_round_data_already_exists();
        };
        let v0 = payouts_config<T0>(arg0);
        let v1 = 0x2::vec_map::keys<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::Payout>(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::inner(&v0));
        let v2 = payouts_config<T0>(arg0);
        let v3 = increase_round_id<T0>(arg0);
        let v4 = 0x1::vector::empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(&v1)) {
            0x1::vector::push_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&mut v4, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::new<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(200, arg3));
            v5 = v5 + 1;
        };
        let v6 = RoundData<T0>{
            round_id                 : v3,
            pot_final_balance        : 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance::zero(),
            start_time               : 0x2::clock::timestamp_ms(arg1),
            end_time                 : arg2,
            draw_seed                : b"",
            draw_result              : 0x1::option::none<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(),
            unsettled_tickets        : 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::new<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(200, arg3),
            pot_winners_distribution : 0x2::vec_map::from_keys_values<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(v1, v4),
            reward_per_ticket_map    : 0x2::vec_map::empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, u64>(),
            jackpot_winners          : 0x1::vector::empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(),
            payouts_config           : v2,
        };
        let v7 = LotteryNewRoundEvent{
            lottery_id : id<T0>(arg0),
            round_id   : v6.round_id,
            start_time : v6.start_time,
            end_time   : v6.end_time,
        };
        0x2::event::emit<LotteryNewRoundEvent>(v7);
        0x1::option::fill<RoundData<T0>>(&mut arg0.round_data, v6);
    }

    public fun payment_config<T0>(arg0: &Lottery<T0>) : 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::PaymentConfig {
        arg0.payment_config
    }

    public fun payouts_config<T0>(arg0: &Lottery<T0>) : 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::PayoutsConfig {
        arg0.payouts_config
    }

    public fun purchase<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg10);
        assert_correct_jackpot<T0>(arg0, arg1);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::assert_jackpot_not_hit<T0>(arg1);
        let v0 = id<T0>(arg0);
        let v1 = ticket_cost<T0>(arg0);
        let v2 = payment_config<T0>(arg0);
        let (v3, v4) = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::split(&v2);
        let v5 = draw_config<T0>(arg0);
        let v6 = borrow_round_data_mut<T0>(arg0);
        if (0x2::clock::timestamp_ms(arg2) >= v6.end_time) {
            err_too_late_to_purchase();
        };
        if (0x1::option::is_some<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&v6.draw_result)) {
            err_already_has_draw_result();
        };
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance::add(&mut v6.pot_final_balance, v3);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_add<T0>(arg1, v4);
        let v7 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(arg3, arg4);
        if (!0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::is_valid_picks(&v5, &v7)) {
            err_invalid_picks();
        };
        let v8 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::new(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(arg3, arg4), v0, v6.round_id, arg5, arg6, arg7, arg8, arg9, v1);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_new_ticket(&v8, v0, v6.round_id);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::push_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&mut v6.unsettled_tickets, v8);
    }

    public fun purchase_with_cost<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg11);
        assert_correct_jackpot<T0>(arg0, arg1);
        let v0 = id<T0>(arg0);
        let v1 = payment_config<T0>(arg0);
        let (v2, v3) = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::split(&v1);
        let v4 = draw_config<T0>(arg0);
        let v5 = borrow_round_data_mut<T0>(arg0);
        if (0x2::clock::timestamp_ms(arg2) >= v5.end_time) {
            err_too_late_to_purchase();
        };
        if (0x1::option::is_some<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&v5.draw_result)) {
            err_already_has_draw_result();
        };
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance::add(&mut v5.pot_final_balance, v2);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_add<T0>(arg1, v3);
        let v6 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(arg3, arg4);
        if (!0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::is_valid_picks(&v4, &v6)) {
            err_invalid_picks();
        };
        let v7 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::new(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(arg3, arg4), v0, v5.round_id, arg5, arg7, arg8, arg9, arg10, arg6);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_new_ticket(&v7, v0, v5.round_id);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::push_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&mut v5.unsettled_tickets, v7);
    }

    public fun set_bls_pub_key<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: vector<u8>) {
        arg0.bls_pub_key = arg2;
    }

    public fun set_jackpot_id<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: 0x2::object::ID) {
        arg0.jackpot_id = arg2;
    }

    public fun set_manager<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: address) {
        arg0.manager = arg2;
    }

    public fun settle_tickets<T0>(arg0: &mut Lottery<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg2);
        let v0 = jackpot_combination<T0>(arg0);
        let v1 = borrow_round_data_mut<T0>(arg0);
        if (0x1::option::is_none<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&v1.draw_result)) {
            err_no_draw_result_to_settle();
        };
        let v2 = *0x1::option::borrow<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawResult>(&v1.draw_result);
        let v3 = 0;
        while (v3 < 0x1::u64::min(arg1, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&v1.unsettled_tickets))) {
            let v4 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::pop_front<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&mut v1.unsettled_tickets);
            let v5 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::get_combination(&v4, &v2);
            if (v5 == v0) {
                0x1::vector::push_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&mut v1.jackpot_winners, v4);
            } else if (0x2::vec_map::contains<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&v1.pot_winners_distribution, &v5)) {
                0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::push_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(0x2::vec_map::get_mut<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&mut v1.pot_winners_distribution, &v5), v4);
            };
            v3 = v3 + 1;
        };
    }

    public fun test_only_purchase<T0>(arg0: &mut Lottery<T0>, arg1: &mut 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::Jackpot<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0>(arg0, arg10);
        assert_correct_jackpot<T0>(arg0, arg1);
        let v0 = id<T0>(arg0);
        let v1 = payment_config<T0>(arg0);
        let (v2, v3) = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::split(&v1);
        let v4 = draw_config<T0>(arg0);
        let v5 = borrow_round_data_mut<T0>(arg0);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance::add(&mut v5.pot_final_balance, v2);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::jackpot::accounting_add<T0>(arg1, v3);
        let v6 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(arg2, arg3);
        if (!0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::is_valid_picks(&v4, &v6)) {
            err_invalid_picks();
        };
        let v7 = 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::new(0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::picks::new(arg2, arg3), v0, v5.round_id, arg4, arg6, arg7, arg8, arg9, arg5);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::emit_new_ticket(&v7, v0, v5.round_id);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::push_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(&mut v5.unsettled_tickets, v7);
    }

    public fun ticket_cost<T0>(arg0: &Lottery<T0>) : u64 {
        let v0 = payment_config<T0>(arg0);
        0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::ticket_cost(&v0)
    }

    public fun total_winner_ticket_count<T0>(arg0: &Lottery<T0>) : u64 {
        let v0 = borrow_round_data<T0>(arg0);
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&v0.pot_winners_distribution);
        0x1::vector::reverse<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(&v2)) {
            let v4 = 0x1::vector::pop_back<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(&mut v2);
            v1 = v1 + 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::length<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>(0x2::vec_map::get<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination, 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::big_queue::BigQueue<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::ticket::Ticket>>(&v0.pot_winners_distribution, &v4));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination>(v2);
        v1
    }

    public fun update_draw_config<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::draw::DrawConfig) {
        arg0.draw_config = arg2;
    }

    public fun update_jackpot_combination<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::combination::Combination) {
        arg0.jackpot_combination = arg2;
    }

    public fun update_payment_config<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payment::PaymentConfig) {
        arg0.payment_config = arg2;
    }

    public fun update_payouts_config<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::payouts::PayoutsConfig) {
        arg0.payouts_config = arg2;
    }

    public fun update_round_end_time<T0>(arg0: &mut Lottery<T0>, arg1: &0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::admin::AdminCap, arg2: u64) {
        0x1::option::borrow_mut<RoundData<T0>>(&mut arg0.round_data).end_time = arg2;
    }

    // decompiled from Move bytecode v6
}

