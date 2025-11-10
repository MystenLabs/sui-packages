module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin {
    struct BinManager has store {
        pool_id: 0x2::object::ID,
        bin_step: u16,
        bins: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<BinGroupRef>,
    }

    struct BinGroupRef has store {
        pool_id: 0x2::object::ID,
        group: BinGroup,
    }

    struct BinGroup has store {
        idx: u32,
        used_bins_mask: u16,
        bins: vector<Bin>,
    }

    struct Bin has store {
        id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
        price: u128,
        liquidity_share: u128,
        rewards_growth_global: vector<u128>,
        fee_a_growth_global: u128,
        fee_b_growth_global: u128,
    }

    struct BinInfo has copy, drop {
        id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
        price: u128,
        liquidity_share: u128,
        rewards_growth_global: vector<u128>,
        fee_a_growth_global: u128,
        fee_b_growth_global: u128,
    }

    public(friend) fun accumulate_fee(arg0: &mut Bin, arg1: u64, arg2: u64) {
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        arg0.fee_a_growth_global = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_add(arg0.fee_a_growth_global, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_growth_by_amount(arg1, arg0.liquidity_share));
        arg0.fee_b_growth_global = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_add(arg0.fee_b_growth_global, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_growth_by_amount(arg2, arg0.liquidity_share));
    }

    public(friend) fun accumulate_rewards(arg0: &mut Bin, arg1: vector<u128>) {
        let v0 = 0;
        assert!(arg0.liquidity_share > 0, 13906838112829046795);
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            if (0x1::vector::length<u128>(&arg0.rewards_growth_global) <= v0) {
                0x1::vector::push_back<u128>(&mut arg0.rewards_growth_global, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*0x1::vector::borrow<u128>(&arg1, v0), 18446744073709551616, arg0.liquidity_share));
            } else {
                let v1 = 0x1::vector::borrow_mut<u128>(&mut arg0.rewards_growth_global, v0);
                *v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_add(*v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*0x1::vector::borrow<u128>(&arg1, v0), 18446744073709551616, arg0.liquidity_share));
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun add_bin_in_group_if_absent(arg0: &mut BinGroup, arg1: u8) : &mut Bin {
        arg0.used_bins_mask = arg0.used_bins_mask | 1 << arg1;
        borrow_mut_bin_from_group(arg0, arg1)
    }

    public(friend) fun add_group_if_absent(arg0: &mut BinManager, arg1: u64) : &mut BinGroupRef {
        let v0 = arg0.bin_step;
        if (!contains_group(arg0, arg1)) {
            let v1 = 0x1::vector::empty<Bin>();
            let v2 = 0;
            let v3 = bin_id_from_score(compose_score(arg1, 0));
            let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v3, v0);
            while (v2 < 16) {
                0x1::vector::push_back<Bin>(&mut v1, default_bin_v2(v3, v4));
                v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(v4, ((10000 + (v0 as u64)) as u128), 10000);
                v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                v2 = v2 + 1;
            };
            let v5 = BinGroup{
                idx            : (arg1 as u32),
                used_bins_mask : 0,
                bins           : v1,
            };
            let v6 = BinGroupRef{
                pool_id : arg0.pool_id,
                group   : v5,
            };
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<BinGroupRef>(&mut arg0.bins, (arg1 as u64), v6);
        };
        borrow_mut_group_ref(arg0, arg1)
    }

    public fun amount_a(arg0: &Bin) : u64 {
        arg0.amount_a
    }

    public fun amount_b(arg0: &Bin) : u64 {
        arg0.amount_b
    }

    public(friend) fun apply_active_bin_composition_fees(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        if (arg1 == 0 && arg2 == 0) {
            return (0, 0, 0, 0)
        };
        if (liquidity_share(arg0) == 0) {
            return (0, 0, 0, 0)
        };
        let (v0, v1) = get_composition_fees(arg0, arg1, arg2, arg3);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v0, arg4);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v1, arg4);
        accumulate_fee(arg0, v0 - v2, v1 - v3);
        (v0, v1, v2, v3)
    }

    public fun bin_id_from_score(arg0: u64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        assert!(arg0 >= 0 && (arg0 as u32) <= 887272, 13906839929599688707);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg0 as u32)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636))
    }

    public fun bin_info(arg0: &Bin) : BinInfo {
        BinInfo{
            id                    : arg0.id,
            amount_a              : arg0.amount_a,
            amount_b              : arg0.amount_b,
            price                 : arg0.price,
            liquidity_share       : arg0.liquidity_share,
            rewards_growth_global : arg0.rewards_growth_global,
            fee_a_growth_global   : arg0.fee_a_growth_global,
            fee_b_growth_global   : arg0.fee_b_growth_global,
        }
    }

    public fun bin_score(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636)));
        assert!(v0 >= 0 && v0 <= 887272, 13906839878060081155);
        (v0 as u64)
    }

    public(friend) fun borrow_bin(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &Bin {
        let (v0, v1) = resolve_bin_position(bin_score(arg1));
        let v2 = borrow_group(arg0, v0);
        assert!(contain_in_group(v2, v1), 13906835454243635201);
        borrow_bin_from_group(v2, v1)
    }

    public(friend) fun borrow_bin_by_score(arg0: &BinManager, arg1: u64) : &Bin {
        let (v0, v1) = resolve_bin_position(arg1);
        let v2 = borrow_group(arg0, v0);
        assert!(contain_in_group(v2, v1), 13906838486490546177);
        borrow_bin_from_group(v2, v1)
    }

    public fun borrow_bin_from_group(arg0: &BinGroup, arg1: u8) : &Bin {
        0x1::vector::borrow<Bin>(&arg0.bins, (arg1 as u64))
    }

    public fun borrow_bin_group(arg0: &BinGroupRef) : &BinGroup {
        &arg0.group
    }

    public(friend) fun borrow_bin_group_mut(arg0: &mut BinGroupRef) : &mut BinGroup {
        &mut arg0.group
    }

    public(friend) fun borrow_group(arg0: &BinManager, arg1: u64) : &BinGroup {
        assert!(contains_group(arg0, arg1), 13906835226611286031);
        borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinGroupRef>(&arg0.bins, (arg1 as u64)))
    }

    public(friend) fun borrow_group_ref(arg0: &BinManager, arg1: u64) : &BinGroupRef {
        assert!(contains_group(arg0, arg1), 13906835295330762767);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinGroupRef>(&arg0.bins, (arg1 as u64))
    }

    public(friend) fun borrow_mut_bin(arg0: &mut BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut Bin {
        let (v0, v1) = resolve_bin_position(bin_score(arg1));
        let v2 = borrow_mut_group_ref(arg0, v0);
        let v3 = borrow_bin_group_mut(v2);
        assert!(contain_in_group(v3, v1), 13906835531553046529);
        borrow_mut_bin_from_group(v3, v1)
    }

    public(friend) fun borrow_mut_bin_from_group(arg0: &mut BinGroup, arg1: u8) : &mut Bin {
        0x1::vector::borrow_mut<Bin>(&mut arg0.bins, (arg1 as u64))
    }

    public(friend) fun borrow_mut_group_ref(arg0: &mut BinManager, arg1: u64) : &mut BinGroupRef {
        assert!(contains_group(arg0, arg1), 13906835376935141391);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<BinGroupRef>(&mut arg0.bins, (arg1 as u64))
    }

    public fun calculate_out_amount(arg0: &Bin, arg1: u128) : (u64, u64) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amounts_by_liquidity(arg0.amount_a, arg0.amount_b, arg1, arg0.liquidity_share)
    }

    public fun compose_score(arg0: u64, arg1: u8) : u64 {
        arg0 * 16 + (arg1 as u64)
    }

    public(friend) fun contain_in_group(arg0: &BinGroup, arg1: u8) : bool {
        arg0.used_bins_mask >> arg1 & 1 == 1
    }

    public(friend) fun contains(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        let (v0, v1) = resolve_bin_position(bin_score(arg1));
        contains_by_idx_offset(arg0, v0, v1)
    }

    public(friend) fun contains_by_idx_offset(arg0: &BinManager, arg1: u64, arg2: u8) : bool {
        if (!contains_group(arg0, arg1)) {
            return false
        };
        contain_in_group(borrow_group(arg0, arg1), arg2)
    }

    public(friend) fun contains_group(arg0: &BinManager, arg1: u64) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinGroupRef>(&arg0.bins, arg1)
    }

    public(friend) fun decrease_liquidity(arg0: &mut Bin, arg1: u128) : (u64, u64) {
        assert!(arg1 <= arg0.liquidity_share, 13906837309669769221);
        if (arg0.liquidity_share == 0 || arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amounts_by_liquidity(arg0.amount_a, arg0.amount_b, arg1, arg0.liquidity_share);
        arg0.liquidity_share = arg0.liquidity_share - arg1;
        arg0.amount_a = arg0.amount_a - v0;
        arg0.amount_b = arg0.amount_b - v1;
        (v0, v1)
    }

    fun default_bin(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u16) : Bin {
        Bin{
            id                    : arg0,
            amount_a              : 0,
            amount_b              : 0,
            price                 : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(arg0, arg1),
            liquidity_share       : 0,
            rewards_growth_global : 0x1::vector::empty<u128>(),
            fee_a_growth_global   : 0,
            fee_b_growth_global   : 0,
        }
    }

    fun default_bin_v2(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u128) : Bin {
        Bin{
            id                    : arg0,
            amount_a              : 0,
            amount_b              : 0,
            price                 : arg1,
            liquidity_share       : 0,
            rewards_growth_global : 0x1::vector::empty<u128>(),
            fee_a_growth_global   : 0,
            fee_b_growth_global   : 0,
        }
    }

    public fun destroy_zero_bin_group_ref(arg0: BinGroupRef) {
        let BinGroupRef {
            pool_id : _,
            group   : v1,
        } = arg0;
        let BinGroup {
            idx            : _,
            used_bins_mask : _,
            bins           : v4,
        } = v1;
        0x1::vector::destroy_empty<Bin>(v4);
    }

    public fun fee_a_growth_global(arg0: &Bin) : u128 {
        arg0.fee_a_growth_global
    }

    public fun fee_b_growth_global(arg0: &Bin) : u128 {
        arg0.fee_b_growth_global
    }

    public fun fetch_bins(arg0: &BinManager, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<BinInfo> {
        if (arg2 == 0) {
            return 0x1::vector::empty<BinInfo>()
        };
        let v0 = 0x1::vector::empty<BinInfo>();
        let (v1, v2) = if (0x1::option::is_none<u32>(&arg1)) {
            (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::head<BinGroupRef>(&arg0.bins), 0)
        } else {
            let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::option::borrow<u32>(&arg1));
            let (v4, v5) = resolve_bin_position(bin_score(v3));
            assert!(contains(arg0, v3), 13906839096375902209);
            (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v4), v5)
        };
        let v6 = v2;
        let v7 = v1;
        let v8 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v7)) {
            let v9 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<BinGroupRef>(&arg0.bins, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v7));
            let v10 = borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<BinGroupRef>(v9));
            while (v6 < 16) {
                if (contain_in_group(v10, v6)) {
                    0x1::vector::push_back<BinInfo>(&mut v0, bin_info(borrow_bin_from_group(v10, v6)));
                    v8 = v8 + 1;
                };
                if (v8 == arg2) {
                    return v0
                };
                v6 = v6 + 1;
            };
            v7 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<BinGroupRef>(v9);
            v6 = 0;
        };
        v0
    }

    public(friend) fun first_score_for_swap(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (arg2) {
            prev_bin_score(arg0, bin_score(arg1), true)
        } else {
            next_bin_score(arg0, bin_score(arg1), true)
        }
    }

    public fun get_composition_fees(arg0: &Bin, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (liquidity_share(arg0) == 0) {
            return (0, 0)
        };
        if (arg1 == 0 && arg2 == 0) {
            return (0, 0)
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(liquidity_share(arg0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(arg1, arg2, arg0.price), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(amount_a(arg0), amount_b(arg0), arg0.price));
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amounts_by_liquidity(amount_a(arg0) + arg1, amount_b(arg0) + arg2, v0, liquidity_share(arg0) + v0);
        let v3 = 0;
        let v4 = 0;
        if (v1 > arg1 && arg2 > v2) {
            v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_composition_fee(arg2 - v2, arg3);
        } else if (v2 > arg2 && arg1 > v1) {
            v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_composition_fee(arg1 - v1, arg3);
        };
        (v3, v4)
    }

    public fun group_bins(arg0: &BinGroup) : &vector<Bin> {
        &arg0.bins
    }

    public fun group_idx(arg0: &BinGroup) : u32 {
        arg0.idx
    }

    public fun id(arg0: &Bin) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.id
    }

    public(friend) fun increase_liquidity(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u64, u64, u128) {
        if (arg1 == 0 && arg2 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(id(arg0), arg3)) {
            arg0.amount_a = arg0.amount_a + arg1;
            arg0.amount_b = arg0.amount_b + arg2;
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(id(arg0), arg3)) {
            v1 = arg2;
            arg0.amount_a = arg0.amount_a + arg1;
        } else {
            v0 = arg1;
            arg0.amount_b = arg0.amount_b + arg2;
        };
        let v2 = if (arg0.liquidity_share == 0) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(arg1 - v0, arg2 - v1, arg0.price)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0.liquidity_share, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(arg1 - v0, arg2 - v1, arg0.price), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(arg0.amount_a, arg0.amount_b, arg0.price))
        };
        assert!(v2 > 0, 13906837206591733783);
        assert!(340282366920938463463374607431768211455 - arg0.liquidity_share >= v2, 13906837223770947597);
        arg0.liquidity_share = arg0.liquidity_share + v2;
        (v0, v1, v2)
    }

    public(friend) fun is_active_bin_empty(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        if (!contains(arg0, arg1)) {
            return true
        };
        borrow_bin(arg0, arg1).liquidity_share == 0
    }

    public fun is_empty(arg0: &Bin, arg1: bool) : bool {
        arg1 && arg0.amount_a == 0 || arg0.amount_b == 0
    }

    public fun is_empty_group(arg0: &BinGroup) : bool {
        arg0.used_bins_mask == 0
    }

    public fun liquidity_share(arg0: &Bin) : u128 {
        arg0.liquidity_share
    }

    public(friend) fun new_bin_manager(arg0: 0x2::object::ID, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{
            pool_id  : arg0,
            bin_step : arg1,
            bins     : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<BinGroupRef>(16, 2, arg2, arg3),
        }
    }

    public(friend) fun next_bin_for_swap(arg0: &mut BinManager, arg1: u64, arg2: bool) : (&mut Bin, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64) {
        let (v0, v1) = resolve_bin_position(arg1);
        let v2 = if (arg2) {
            prev_bin_score(arg0, arg1, false)
        } else {
            next_bin_score(arg0, arg1, false)
        };
        let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut_value<BinGroupRef>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut_node<BinGroupRef>(&mut arg0.bins, v0));
        let v4 = borrow_bin_group_mut(v3);
        (borrow_mut_bin_from_group(v4, v1), v2)
    }

    public(friend) fun next_bin_score(arg0: &BinManager, arg1: u64, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let (v0, v1) = resolve_bin_position(arg1);
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<BinGroupRef>(&arg0.bins, v0, true);
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2);
            let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<BinGroupRef>(&arg0.bins, v3);
            let v5 = v3 != v0 || arg2;
            let v6 = if (v3 == v0) {
                v1
            } else {
                0
            };
            let v7 = next_score_in_group(borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<BinGroupRef>(v4)), v6, v5);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v7)) {
                return v7
            };
            v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<BinGroupRef>(v4);
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
    }

    public(friend) fun next_score_in_group(arg0: &BinGroup, arg1: u8, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (arg0.used_bins_mask == 0) {
            return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
        };
        let v0 = if (arg2) {
            arg1
        } else {
            arg1 + 1
        };
        let v1 = v0;
        assert!(v0 <= 16, 13906836175799451669);
        while (v1 < 16) {
            if (arg0.used_bins_mask >> v1 & 1 != 0) {
                return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(compose_score((arg0.idx as u64), v1))
            };
            v1 = v1 + 1;
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
    }

    public fun pool_id(arg0: &BinGroupRef) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun prev_bin_score(arg0: &BinManager, arg1: u64, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let (v0, v1) = resolve_bin_position(arg1);
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<BinGroupRef>(&arg0.bins, v0, true);
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2);
            let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<BinGroupRef>(&arg0.bins, v3);
            let v5 = v3 != v0 || arg2;
            let v6 = if (v3 == v0) {
                v1
            } else {
                15
            };
            let v7 = prev_score_in_group(borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<BinGroupRef>(v4)), v6, v5);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v7)) {
                return v7
            };
            v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::prev_score<BinGroupRef>(v4);
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
    }

    public(friend) fun prev_score_in_group(arg0: &BinGroup, arg1: u8, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (arg0.used_bins_mask == 0) {
            return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
        };
        if (!arg2 && arg1 == 0) {
            return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
        };
        let v0 = if (arg2) {
            arg1
        } else {
            arg1 - 1
        };
        let v1 = v0;
        loop {
            if (arg0.used_bins_mask >> v1 & 1 != 0) {
                break
            };
            if (v1 == 0) {
                return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
            };
            v1 = v1 - 1;
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(compose_score((arg0.idx as u64), v1))
    }

    public fun price(arg0: &Bin) : u128 {
        arg0.price
    }

    public(friend) fun remove_bin_from_group(arg0: &mut BinGroup, arg1: u8) {
        assert!(contain_in_group(arg0, arg1), 13906836055540105233);
        arg0.used_bins_mask = arg0.used_bins_mask & 65535 - (1 << arg1);
        let v0 = 0x1::vector::borrow_mut<Bin>(&mut arg0.bins, (arg1 as u64));
        let v1 = if (v0.amount_a == 0) {
            if (v0.amount_b == 0) {
                v0.liquidity_share == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906836068424351751);
    }

    public(friend) fun remove_group(arg0: &mut BinManager, arg1: u64) {
        if (!contains_group(arg0, arg1)) {
            return
        };
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<BinGroupRef>(&mut arg0.bins, arg1);
        assert!(v0.group.used_bins_mask == 0, 13906834930258804755);
        let BinGroupRef {
            pool_id : _,
            group   : v2,
        } = v0;
        let BinGroup {
            idx            : _,
            used_bins_mask : _,
            bins           : v5,
        } = v2;
        let v6 = v5;
        while (0x1::vector::length<Bin>(&v6) > 0) {
            let Bin {
                id                    : _,
                amount_a              : v8,
                amount_b              : v9,
                price                 : _,
                liquidity_share       : v11,
                rewards_growth_global : _,
                fee_a_growth_global   : _,
                fee_b_growth_global   : _,
            } = 0x1::vector::pop_back<Bin>(&mut v6);
            let v15 = if (v8 == 0) {
                if (v9 == 0) {
                    v11 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v15, 13906835011862396935);
        };
        0x1::vector::destroy_empty<Bin>(v6);
    }

    public fun resolve_bin_position(arg0: u64) : (u64, u8) {
        (arg0 >> 4, ((arg0 & 15) as u8))
    }

    public fun rewards_growth_global(arg0: &Bin) : vector<u128> {
        arg0.rewards_growth_global
    }

    public(friend) fun swap_exact_amount_in(arg0: &mut Bin, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = if (arg2) {
            let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(arg1, arg3);
            let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_out(arg1 - v4, arg0.price, arg2);
            let (v6, v7, v8) = if (v5 <= arg0.amount_b) {
                (arg1, (v5 as u64), v4)
            } else {
                let v9 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(arg0.amount_b, arg0.price, arg2);
                let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v9, arg3);
                let v11 = v9 + v10;
                assert!(v11 <= arg1, 13906837541598265353);
                let v7 = (arg0.amount_b as u64);
                ((v11 as u64), v7, (v10 as u64))
            };
            let v12 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v8, arg4);
            arg0.amount_a = arg0.amount_a + v6 - v8;
            arg0.amount_b = arg0.amount_b - v7;
            accumulate_fee(arg0, v8 - v12, 0);
            (v12, v6, v7, v8)
        } else {
            let v13 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(arg1, arg3);
            let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_out(arg1 - v13, arg0.price, arg2);
            let (v15, v16, v17) = if (v14 <= arg0.amount_a) {
                (arg1, (v14 as u64), v13)
            } else {
                let v18 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(arg0.amount_a, arg0.price, arg2);
                let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v18, arg3);
                let v20 = v18 + v19;
                assert!(v20 <= arg1, 13906837657562382345);
                let v16 = (arg0.amount_a as u64);
                ((v20 as u64), v16, (v19 as u64))
            };
            let v21 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v17, arg4);
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
            let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(v4, arg0.price, arg2);
            let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v5, arg3);
            let v7 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v6, arg4);
            arg0.amount_a = arg0.amount_a + v5;
            arg0.amount_b = arg0.amount_b - v4;
            accumulate_fee(arg0, v6 - v7, 0);
            (v5 + v6, v4, v6, v7)
        } else {
            let v8 = 0x1::u64::min(arg0.amount_a, arg1);
            let v9 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(v8, arg0.price, arg2);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v9, arg3);
            let v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v10, arg4);
            arg0.amount_a = arg0.amount_a - v8;
            arg0.amount_b = arg0.amount_b + v9;
            accumulate_fee(arg0, 0, v10 - v11);
            (v9 + v10, v8, v10, v11)
        }
    }

    public fun zero_bin_group_ref() : BinGroupRef {
        let v0 = BinGroup{
            idx            : 0,
            used_bins_mask : 0,
            bins           : 0x1::vector::empty<Bin>(),
        };
        BinGroupRef{
            pool_id : 0x2::object::id_from_address(@0x0),
            group   : v0,
        }
    }

    // decompiled from Move bytecode v6
}

