module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<Tick>,
    }

    struct Tick has copy, drop, store {
        index: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::I128,
        liquidity_gross: u128,
        fee_growth_outside_a: u256,
        fee_growth_outside_b: u256,
        rewards_growth_outside: vector<u256>,
    }

    public fun borrow_tick(arg0: &TickManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : &Tick {
        let v0 = tick_score(arg1);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v0), 13835903768702877703);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<Tick>(&arg0.ticks, v0)
    }

    public fun borrow_tick_for_swap(arg0: &TickManager, arg1: u64, arg2: bool) : (&Tick, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, arg1), 13835903571134382087);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<Tick>(&arg0.ticks, arg1);
        let v1 = if (arg2) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::prev_score<Tick>(v0)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<Tick>(v0)
        };
        (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<Tick>(v0), v1)
    }

    public fun cross_by_swap(arg0: &mut TickManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: bool, arg3: u128, arg4: u256, arg5: u256, arg6: vector<u256>) : u128 {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Tick>(&mut arg0.ticks, tick_score(arg1));
        let v1 = if (arg2) {
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::neg(v0.liquidity_net)
        } else {
            v0.liquidity_net
        };
        let v2 = if (!0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::is_neg(v1)) {
            let v3 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::abs_u128(v1);
            assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::add_check(v3, arg3), 13835341587548340227);
            arg3 + v3
        } else {
            let v4 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::abs_u128(v1);
            assert!(arg3 >= v4, 13835341609023176707);
            arg3 - v4
        };
        v0.fee_growth_outside_a = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg4, v0.fee_growth_outside_a);
        v0.fee_growth_outside_b = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg5, v0.fee_growth_outside_b);
        let v5 = 0x1::vector::length<u256>(&arg6);
        if (v5 > 0) {
            let v6 = 0;
            while (v6 < v5) {
                if (0x1::vector::length<u256>(&v0.rewards_growth_outside) > v6) {
                    *0x1::vector::borrow_mut<u256>(&mut v0.rewards_growth_outside, v6) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(*0x1::vector::borrow<u256>(&arg6, v6), *0x1::vector::borrow<u256>(&v0.rewards_growth_outside, v6));
                } else {
                    0x1::vector::push_back<u256>(&mut v0.rewards_growth_outside, *0x1::vector::borrow<u256>(&arg6, v6));
                };
                v6 = v6 + 1;
            };
        };
        v2
    }

    public fun decrease_liquidity(arg0: &mut TickManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg3: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg4: u128, arg5: u256, arg6: u256, arg7: vector<u256>) {
        if (arg4 == 0) {
            return
        };
        let v0 = tick_score(arg2);
        let v1 = tick_score(arg3);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v0), 13835903201767194631);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v1), 13835903206062161927);
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Tick>(&mut arg0.ticks, v0);
        if (update_by_liquidity(v2, arg1, arg4, false, false, false, arg5, arg6, arg7) == 0) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<Tick>(&mut arg0.ticks, v0);
        };
        let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Tick>(&mut arg0.ticks, v1);
        if (update_by_liquidity(v3, arg1, arg4, false, false, true, arg5, arg6, arg7) == 0) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<Tick>(&mut arg0.ticks, v1);
        };
    }

    fun default(arg0: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : Tick {
        Tick{
            index                  : arg0,
            sqrt_price             : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_sqrt_price_at_tick(arg0),
            liquidity_net          : 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::from(0),
            liquidity_gross        : 0,
            fee_growth_outside_a   : 0,
            fee_growth_outside_b   : 0,
            rewards_growth_outside : 0x1::vector::empty<u256>(),
        }
    }

    fun default_rewards_growth_outside(arg0: u64) : vector<u256> {
        if (arg0 <= 0) {
            0x1::vector::empty<u256>()
        } else {
            let v1 = 0x1::vector::empty<u256>();
            let v2 = 0;
            while (v2 < arg0) {
                0x1::vector::push_back<u256>(&mut v1, 0);
                v2 = v2 + 1;
            };
            v1
        }
    }

    public fun fee_growth_outside(arg0: &Tick) : (u256, u256) {
        (arg0.fee_growth_outside_a, arg0.fee_growth_outside_b)
    }

    public fun fetch_ticks(arg0: &TickManager, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<Tick> {
        if (arg2 == 0) {
            return 0x1::vector::empty<Tick>()
        };
        let v0 = 0x1::vector::empty<Tick>();
        let v1 = if (0x1::option::is_none<u32>(&arg1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::head<Tick>(&arg0.ticks)
        } else {
            let v2 = tick_score(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from_u32(*0x1::option::borrow<u32>(&arg1)));
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v2), 13835904790905094151);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v2)
        };
        let v3 = v1;
        let v4 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v3)) {
            let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<Tick>(&arg0.ticks, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3));
            0x1::vector::push_back<Tick>(&mut v0, *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<Tick>(v5));
            v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<Tick>(v5);
            let v6 = v4 + 1;
            v4 = v6;
            if (v6 == arg2) {
                break
            };
        };
        v0
    }

    public fun first_score_for_swap(arg0: &TickManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (arg2) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<Tick>(&arg0.ticks, tick_score(arg1), true)
        } else if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::eq(arg1, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::neg_from(443637))) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<Tick>(&arg0.ticks, tick_score(0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::min_tick()), true)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<Tick>(&arg0.ticks, tick_score(arg1), false)
        }
    }

    public fun get_fee_in_range(arg0: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg1: u256, arg2: u256, arg3: 0x1::option::Option<Tick>, arg4: 0x1::option::Option<Tick>) : (u256, u256) {
        let (v0, v1) = if (0x1::option::is_none<Tick>(&arg3)) {
            (arg1, arg2)
        } else {
            let v2 = 0x1::option::borrow<Tick>(&arg3);
            if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0, v2.index)) {
                (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg1, v2.fee_growth_outside_a), 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg2, v2.fee_growth_outside_b))
            } else {
                (v2.fee_growth_outside_a, v2.fee_growth_outside_b)
            }
        };
        let (v3, v4) = if (0x1::option::is_none<Tick>(&arg4)) {
            (0, 0)
        } else {
            let v5 = 0x1::option::borrow<Tick>(&arg4);
            if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0, v5.index)) {
                (v5.fee_growth_outside_a, v5.fee_growth_outside_b)
            } else {
                (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg1, v5.fee_growth_outside_a), 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg2, v5.fee_growth_outside_b))
            }
        };
        (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg1, v0), v3), 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg2, v1), v4))
    }

    public fun get_reward_growth_outside(arg0: &Tick, arg1: u64) : u256 {
        if (0x1::vector::length<u256>(&arg0.rewards_growth_outside) <= arg1) {
            0
        } else {
            *0x1::vector::borrow<u256>(&arg0.rewards_growth_outside, arg1)
        }
    }

    public fun get_rewards_in_range(arg0: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg1: vector<u256>, arg2: 0x1::option::Option<Tick>, arg3: 0x1::option::Option<Tick>) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg1)) {
            let v2 = *0x1::vector::borrow<u256>(&arg1, v1);
            let v3 = if (0x1::option::is_none<Tick>(&arg2)) {
                v2
            } else {
                let v4 = 0x1::option::borrow<Tick>(&arg2);
                if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0, v4.index)) {
                    0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(v2, get_reward_growth_outside(v4, v1))
                } else {
                    get_reward_growth_outside(v4, v1)
                }
            };
            let v5 = if (0x1::option::is_none<Tick>(&arg3)) {
                0
            } else {
                let v6 = 0x1::option::borrow<Tick>(&arg3);
                if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0, v6.index)) {
                    get_reward_growth_outside(v6, v1)
                } else {
                    0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(v2, get_reward_growth_outside(v6, v1))
                }
            };
            0x1::vector::push_back<u256>(&mut v0, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(v2, v3), v5));
            v1 = v1 + 1;
        };
        v0
    }

    public fun increase_liquidity(arg0: &mut TickManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg3: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg4: u128, arg5: u256, arg6: u256, arg7: vector<u256>) {
        if (arg4 == 0) {
            return
        };
        let v0 = tick_score(arg2);
        let v1 = tick_score(arg3);
        let v2 = false;
        let v3 = false;
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v0)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<Tick>(&mut arg0.ticks, v0, default(arg2));
            v3 = true;
        };
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<Tick>(&mut arg0.ticks, v1, default(arg3));
            v2 = true;
        };
        let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Tick>(&mut arg0.ticks, v0);
        update_by_liquidity(v4, arg1, arg4, v3, true, false, arg5, arg6, arg7);
        let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Tick>(&mut arg0.ticks, v1);
        update_by_liquidity(v5, arg1, arg4, v2, true, true, arg5, arg6, arg7);
    }

    public fun index(arg0: &Tick) : 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32 {
        arg0.index
    }

    public fun liquidity_gross(arg0: &Tick) : u128 {
        arg0.liquidity_gross
    }

    public fun liquidity_net(arg0: &Tick) : 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::I128 {
        arg0.liquidity_net
    }

    public(friend) fun new(arg0: u32, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TickManager {
        TickManager{
            tick_spacing : arg0,
            ticks        : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<Tick>(16, 2, arg1, arg2),
        }
    }

    public fun rewards_growth_outside(arg0: &Tick) : &vector<u256> {
        &arg0.rewards_growth_outside
    }

    public fun sqrt_price(arg0: &Tick) : u128 {
        arg0.sqrt_price
    }

    public fun tick_count(arg0: &TickManager) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::length<Tick>(&arg0.ticks)
    }

    fun tick_score(arg0: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : u64 {
        let v0 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::as_u32(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::add(arg0, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from(443636)));
        assert!(v0 >= 0 && v0 <= 887272, 13835624363900272645);
        (v0 as u64)
    }

    public fun tick_spacing(arg0: &TickManager) : u32 {
        arg0.tick_spacing
    }

    public fun try_borrow_tick(arg0: &TickManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : 0x1::option::Option<Tick> {
        let v0 = tick_score(arg1);
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Tick>(&arg0.ticks, v0)) {
            return 0x1::option::none<Tick>()
        };
        0x1::option::some<Tick>(*0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<Tick>(&arg0.ticks, v0))
    }

    fun update_by_liquidity(arg0: &mut Tick, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: u128, arg3: bool, arg4: bool, arg5: bool, arg6: u256, arg7: u256, arg8: vector<u256>) : u128 {
        let v0 = if (arg4) {
            assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::add_check(arg0.liquidity_gross, arg2), 13835060967269990401);
            arg0.liquidity_gross + arg2
        } else {
            assert!(arg0.liquidity_gross >= arg2, 13835342455131734019);
            arg0.liquidity_gross - arg2
        };
        if (v0 == 0) {
            return v0
        };
        let (v1, v2, v3) = if (arg3) {
            if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg1, arg0.index)) {
                (0, 0, default_rewards_growth_outside(0x1::vector::length<u256>(&arg8)))
            } else {
                (arg6, arg7, arg8)
            }
        } else {
            (arg0.fee_growth_outside_a, arg0.fee_growth_outside_b, arg0.rewards_growth_outside)
        };
        let (v4, v5) = if (arg4) {
            if (arg5) {
                0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::overflowing_sub(arg0.liquidity_net, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::from(arg2))
            } else {
                0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::overflowing_add(arg0.liquidity_net, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::from(arg2))
            }
        } else if (arg5) {
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::overflowing_add(arg0.liquidity_net, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::from(arg2))
        } else {
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::overflowing_sub(arg0.liquidity_net, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i128::from(arg2))
        };
        if (v5) {
            abort 13835061117593845761
        };
        arg0.liquidity_gross = v0;
        arg0.liquidity_net = v4;
        arg0.fee_growth_outside_a = v1;
        arg0.fee_growth_outside_b = v2;
        arg0.rewards_growth_outside = v3;
        v0
    }

    // decompiled from Move bytecode v6
}

