module 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::bin {
    struct BinManager has store {
        bin_step: u16,
        bins: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<Bin>,
    }

    struct Bin has store {
        id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
        price: u128,
        liquidity_supply: u128,
        rewards_growth_global: vector<u128>,
        fee_a_growth_global: u128,
        fee_b_growth_global: u128,
    }

    struct BinInfo has copy, drop {
        id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
        price: u128,
        liquidity_supply: u128,
        rewards_growth_global: vector<u128>,
        fee_a_growth_global: u128,
        fee_b_growth_global: u128,
    }

    public fun is_empty(arg0: &Bin, arg1: bool) : bool {
        arg1 && arg0.amount_a == 0 || arg0.amount_b == 0
    }

    public(friend) fun accumulate_fee(arg0: &mut Bin, arg1: u64, arg2: u64) {
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        arg0.fee_a_growth_global = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_add(arg0.fee_a_growth_global, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_growth_by_amount(arg1, arg0.liquidity_supply));
        arg0.fee_b_growth_global = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_add(arg0.fee_b_growth_global, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_growth_by_amount(arg2, arg0.liquidity_supply));
    }

    public(friend) fun accumulate_rewards(arg0: &mut Bin, arg1: vector<u128>) {
        let v0 = 0;
        assert!(arg0.liquidity_supply > 0, 13906836068424744973);
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            if (0x1::vector::length<u128>(&arg0.rewards_growth_global) <= v0) {
                0x1::vector::push_back<u128>(&mut arg0.rewards_growth_global, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*0x1::vector::borrow<u128>(&arg1, v0), 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), arg0.liquidity_supply));
            } else {
                let v1 = 0x1::vector::borrow_mut<u128>(&mut arg0.rewards_growth_global, v0);
                *v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_add(*v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*0x1::vector::borrow<u128>(&arg1, v0), 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), arg0.liquidity_supply));
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun add_bin_if_absent(arg0: &mut BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        if (!contains(arg0, arg1)) {
            let v0 = default_bin(arg1, arg0.bin_step);
            insert(arg0, arg1, v0);
        };
    }

    public fun amount_a(arg0: &Bin) : u64 {
        arg0.amount_a
    }

    public fun amount_b(arg0: &Bin) : u64 {
        arg0.amount_b
    }

    public fun bin_info(arg0: &Bin) : BinInfo {
        BinInfo{
            id                    : arg0.id,
            amount_a              : arg0.amount_a,
            amount_b              : arg0.amount_b,
            price                 : arg0.price,
            liquidity_supply      : arg0.liquidity_supply,
            rewards_growth_global : arg0.rewards_growth_global,
            fee_a_growth_global   : arg0.fee_a_growth_global,
            fee_b_growth_global   : arg0.fee_b_growth_global,
        }
    }

    public fun bin_score(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::price_math::bin_bound())));
        assert!(v0 >= 0 && v0 <= 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::price_math::bin_bound() * 2, 13906837142165913603);
        (v0 as u64)
    }

    public(friend) fun borrow_bin(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &Bin {
        assert!(contains(arg0, arg1), 13906834698329391105);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<Bin>(&arg0.bins, bin_score(arg1))
    }

    public(friend) fun borrow_bin_from_score(arg0: &BinManager, arg1: u64) : &Bin {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, arg1), 13906836369071669249);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<Bin>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<Bin>(&arg0.bins, arg1))
    }

    public(friend) fun borrow_bin_mut(arg0: &mut BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut Bin {
        assert!(contains(arg0, arg1), 13906834767048867841);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Bin>(&mut arg0.bins, bin_score(arg1))
    }

    public fun calculate_out_amount(arg0: &Bin, arg1: u128) : (u64, u64) {
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amounts_by_liquidity(arg0.amount_a, arg0.amount_b, arg1, arg0.liquidity_supply)
    }

    public fun contains(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, bin_score(arg1))
    }

    public(friend) fun decrease_liquidity(arg0: &mut Bin, arg1: u128) : (u64, u64) {
        assert!(arg1 <= arg0.liquidity_supply, 13906835265265467399);
        if (arg0.liquidity_supply == 0 || arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1) = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amounts_by_liquidity(arg0.amount_a, arg0.amount_b, arg1, arg0.liquidity_supply);
        arg0.liquidity_supply = arg0.liquidity_supply - arg1;
        arg0.amount_a = arg0.amount_a - v0;
        arg0.amount_b = arg0.amount_b - v1;
        (v0, v1)
    }

    fun default_bin(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u16) : Bin {
        Bin{
            id                    : arg0,
            amount_a              : 0,
            amount_b              : 0,
            price                 : 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::price_math::get_price_from_id(arg0, arg1),
            liquidity_supply      : 0,
            rewards_growth_global : 0x1::vector::empty<u128>(),
            fee_a_growth_global   : 0,
            fee_b_growth_global   : 0,
        }
    }

    public fun fee_a_growth_global(arg0: &Bin) : u128 {
        arg0.fee_a_growth_global
    }

    public fun fee_b_growth_global(arg0: &Bin) : u128 {
        arg0.fee_b_growth_global
    }

    public fun fetch_bins(arg0: &BinManager, arg1: vector<u32>, arg2: u64) : vector<BinInfo> {
        let v0 = 0x1::vector::empty<BinInfo>();
        let v1 = if (0x1::vector::is_empty<u32>(&arg1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::head<Bin>(&arg0.bins)
        } else {
            let v2 = bin_score(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, 0)));
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, v2), 13906836536575393793);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<Bin>(&arg0.bins, v2, true)
        };
        let v3 = v1;
        let v4 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v3)) {
            let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<Bin>(&arg0.bins, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3));
            0x1::vector::push_back<BinInfo>(&mut v0, bin_info(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<Bin>(v5)));
            v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<Bin>(v5);
            let v6 = v4 + 1;
            v4 = v6;
            if (v6 == arg2) {
                break
            };
        };
        v0
    }

    public(friend) fun first_score_for_swap(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (arg2) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<Bin>(&arg0.bins, bin_score(arg1), true)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<Bin>(&arg0.bins, bin_score(arg1), true)
        }
    }

    public fun id(arg0: &Bin) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.id
    }

    public(friend) fun increase_liquidity(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            return 0
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(id(arg0), arg3)) {
            arg0.amount_a = arg0.amount_a + arg1;
            arg0.amount_b = arg0.amount_b + arg2;
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(id(arg0), arg3)) {
            assert!(arg2 == 0, 13906835145006252037);
            arg0.amount_a = arg0.amount_a + arg1;
        } else {
            assert!(arg1 == 0, 13906835157891153925);
            arg0.amount_b = arg0.amount_b + arg2;
        };
        let v0 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_liquidity_by_amounts(arg1, arg2, arg0.price);
        assert!(arg0.liquidity_supply + v0 < 340282366920938463463374607431768211455, 13906835183661613071);
        arg0.liquidity_supply = arg0.liquidity_supply + v0;
        v0
    }

    fun insert(arg0: &mut BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: Bin) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<Bin>(&mut arg0.bins, bin_score(arg1), arg2);
    }

    public(friend) fun is_active_bin_empty(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        if (!contains(arg0, arg1)) {
            return true
        };
        borrow_bin(arg0, arg1).liquidity_supply == 0
    }

    public fun liquidity_supply(arg0: &Bin) : u128 {
        arg0.liquidity_supply
    }

    public(friend) fun new(arg0: u16, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{
            bin_step : arg0,
            bins     : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<Bin>(16, 2, arg1, arg2),
        }
    }

    public(friend) fun next_bin_for_swap(arg0: &mut BinManager, arg1: u64, arg2: bool) : (&mut Bin, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut_node<Bin>(&mut arg0.bins, arg1);
        let v1 = if (arg2) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::prev_score<Bin>(v0)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<Bin>(v0)
        };
        (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut_value<Bin>(v0), v1)
    }

    public fun price(arg0: &Bin) : u128 {
        arg0.price
    }

    public(friend) fun remove_bin(arg0: &mut BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        assert!(contains(arg0, arg1), 13906834960322396161);
        let Bin {
            id                    : _,
            amount_a              : v1,
            amount_b              : v2,
            price                 : _,
            liquidity_supply      : v4,
            rewards_growth_global : _,
            fee_a_growth_global   : _,
            fee_b_growth_global   : _,
        } = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<Bin>(&mut arg0.bins, bin_score(arg1));
        let v8 = if (v1 == 0) {
            if (v2 == 0) {
                v4 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 13906834994682658825);
    }

    public fun rewards_growth_global(arg0: &Bin) : vector<u128> {
        arg0.rewards_growth_global
    }

    public(friend) fun swap_exact_amount_in(arg0: &mut Bin, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = if (arg2) {
            let v4 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_inclusive(arg1, arg3);
            let v5 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amount_out(arg1 - v4, arg0.price, arg2);
            let (v6, v7, v8) = if (v5 <= arg0.amount_b) {
                (arg1, (v5 as u64), v4)
            } else {
                let v9 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amount_in(arg0.amount_b, arg0.price, arg2);
                let v10 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_exclusive(v9, arg3);
                let v11 = v9 + v10;
                assert!(v11 <= arg1, 13906835497193963531);
                let v7 = (arg0.amount_b as u64);
                ((v11 as u64), v7, (v10 as u64))
            };
            let v12 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_inclusive(v8, arg4);
            arg0.amount_a = arg0.amount_a + v6 - v8;
            arg0.amount_b = arg0.amount_b - v7;
            accumulate_fee(arg0, v8 - v12, 0);
            (v12, v6, v7, v8)
        } else {
            let v13 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_inclusive(arg1, arg3);
            let v14 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amount_out(arg1 - v13, arg0.price, arg2);
            let (v15, v16, v17) = if (v14 <= arg0.amount_a) {
                (arg1, (v14 as u64), v13)
            } else {
                let v18 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amount_in(arg0.amount_a, arg0.price, arg2);
                let v19 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_exclusive(v18, arg3);
                let v20 = v18 + v19;
                assert!(v20 <= arg1, 13906835613158080523);
                let v16 = (arg0.amount_a as u64);
                ((v20 as u64), v16, (v19 as u64))
            };
            let v21 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_inclusive(v17, arg4);
            arg0.amount_a = arg0.amount_a - v16;
            arg0.amount_b = arg0.amount_b + v15 - v17;
            accumulate_fee(arg0, 0, v17 - v21);
            (v21, v15, v16, v17)
        };
        (v1, v2, v3, v0)
    }

    public(friend) fun swap_exact_amount_out(arg0: &mut Bin, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        if (arg2) {
            let v4 = 0x1::u64::min(arg0.amount_b, arg1);
            let v5 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amount_in(v4, arg0.price, arg2);
            let v6 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_exclusive(v5, arg3);
            let v7 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_inclusive(v6, arg4);
            arg0.amount_a = arg0.amount_a + (v5 as u64);
            arg0.amount_b = arg0.amount_b - v4;
            accumulate_fee(arg0, v6 - v7, 0);
            (v5 + v6, v4, v6, v7)
        } else {
            let v8 = 0x1::u64::min(arg0.amount_a, arg1);
            let v9 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_amount_in(v8, arg0.price, arg2);
            let v10 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_exclusive(v9, arg3);
            let v11 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math::calculate_fee_inclusive(v10, arg4);
            arg0.amount_a = arg0.amount_a - v8;
            arg0.amount_b = arg0.amount_b + (v9 as u64);
            accumulate_fee(arg0, 0, v10 - v11);
            (v9 + v10, v8, v10, v11)
        }
    }

    // decompiled from Move bytecode v6
}

