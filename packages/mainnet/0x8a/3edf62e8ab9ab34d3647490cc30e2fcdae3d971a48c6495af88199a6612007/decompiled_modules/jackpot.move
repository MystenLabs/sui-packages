module 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot {
    struct Tick has drop, store {
        id: u64,
        user: address,
        probability: u64,
    }

    struct JackpotStore<phantom T0> has store {
        min_bonus: u64,
        max_bonus: u64,
        prize_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        round: u64,
        total_probability: u64,
        ticks: vector<Tick>,
        latest_bonus_timestamp: u64,
        total_bonus: u64,
        total_bonus_usd: u64,
        total_ticks: u64,
        price_id_bytes: vector<u8>,
        sui_price: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price,
    }

    public(friend) fun add_price_balance<T0>(arg0: &mut JackpotStore<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_balance, arg1);
    }

    public(friend) fun create_jackpot<T0>(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject) : JackpotStore<T0> {
        JackpotStore<T0>{
            min_bonus              : 1000000000,
            max_bonus              : 25000000000000,
            prize_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            round                  : 0,
            total_probability      : 0,
            ticks                  : 0x1::vector::empty<Tick>(),
            latest_bonus_timestamp : 0,
            total_bonus            : 0,
            total_bonus_usd        : 0,
            total_ticks            : 0,
            price_id_bytes         : get_price_id_bytes_from_info_object(arg0),
            sui_price              : get_price_from_info_object(arg0),
        }
    }

    fun get_positive_price(arg0: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price, arg1: u64) : u64 {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_price(&arg0);
        if (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::i64::get_is_negative(&v0)) {
            0
        } else {
            let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_expo(&arg0);
            if (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::i64::get_is_negative(&v2)) {
                0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(arg1, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::i64::get_magnitude_if_positive(&v0), 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::pow(10, ((0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::i64::get_magnitude_if_negative(&v2) - 9) as u8)))
            } else {
                arg1 * 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::i64::get_magnitude_if_positive(&v0) * 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::pow(10, ((0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::i64::get_magnitude_if_positive(&v2) - 9) as u8))
            }
        }
    }

    fun get_price_from_info_object(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_info_from_price_info_object(arg0);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(&v0))
    }

    fun get_price_id_bytes_from_info_object(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject) : vector<u8> {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_identifier(&v0);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::get_bytes(&v1)
    }

    fun get_random(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v0));
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = &mut v2;
        to_u64(v3) % arg1
    }

    fun get_tick_probability_by_type(arg0: u64) : u64 {
        if (arg0 == 10) {
            10
        } else if (arg0 == 9) {
            9
        } else if (arg0 == 8) {
            8
        } else if (arg0 == 7) {
            7
        } else if (arg0 == 6) {
            6
        } else if (arg0 == 5) {
            5
        } else if (arg0 == 4) {
            4
        } else if (arg0 == 3) {
            3
        } else if (arg0 == 2) {
            2
        } else if (arg0 == 1) {
            1
        } else {
            0
        }
    }

    fun get_tick_type_with_anchor_amount(arg0: u64) : u64 {
        if (arg0 > 1000) {
            10
        } else {
            arg0 / 100
        }
    }

    public(friend) fun lottery<T0>(arg0: &0x2::clock::Clock, arg1: &mut JackpotStore<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_balance);
        assert!(v0 >= arg1.min_bonus, 2);
        assert!(arg1.total_probability > 0, 4);
        arg1.latest_bonus_timestamp = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::length<Tick>(&arg1.ticks);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow<Tick>(&arg1.ticks, v3);
            let v5 = v2 + v4.probability;
            v2 = v5;
            if (get_random(arg0, arg1.total_probability, 0x2::tx_context::epoch_timestamp_ms(arg2)) < v5) {
                let v6 = if (v0 > arg1.max_bonus) {
                    arg1.max_bonus
                } else {
                    v0
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.prize_balance), arg2), v4.user);
                arg1.total_bonus = arg1.total_bonus + v6;
                arg1.total_bonus_usd = arg1.total_bonus_usd + get_positive_price(arg1.sui_price, v6);
                0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::event::winner_event<T0>(v4.id, arg1.round, v4.user, v6);
                v3 = v1;
            };
            v3 = v3 + 1;
        };
        arg1.round = arg1.round + 1;
        arg1.total_probability = 0;
        arg1.ticks = 0x1::vector::empty<Tick>();
    }

    fun to_u64(arg0: &mut vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 3);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 8) {
            let v2 = v1 + (0x1::vector::pop_back<u8>(arg0) as u64);
            v1 = v2 << v0;
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun trade_event<T0>(arg0: u64, arg1: u64, arg2: &mut JackpotStore<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_positive_price(arg2.sui_price, arg1);
        let v2 = get_tick_type_with_anchor_amount(v1);
        if (v2 > 0) {
            let v3 = get_tick_probability_by_type(v2);
            let v4 = Tick{
                id          : 0x1::vector::length<Tick>(&arg2.ticks) + 1,
                user        : v0,
                probability : v3,
            };
            0x1::vector::push_back<Tick>(&mut arg2.ticks, v4);
            arg2.total_probability = arg2.total_probability + v3;
            arg2.total_ticks = arg2.total_ticks + 1;
            0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::event::new_tick_event<T0>(arg2.round, v0, v3, arg0, v1);
        };
    }

    public(friend) fun update_bonus<T0>(arg0: &mut JackpotStore<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 < arg1, 1);
        arg0.min_bonus = arg2;
        arg0.max_bonus = arg1;
    }

    public(friend) fun update_price<T0>(arg0: &mut JackpotStore<T0>, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::comparator::compare_u8_vector(arg0.price_id_bytes, get_price_id_bytes_from_info_object(arg2));
        assert!(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::comparator::is_equal(&v0), 5);
        let v1 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::pyth::get_price_unsafe(arg2);
        if (0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::abs_diff(0x2::clock::timestamp_ms(arg3) / 1000, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_timestamp(&v1)) > 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::get_stale_price_threshold_secs(arg1)) {
            arg0.sui_price = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::pyth::get_price(arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

