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

    struct BinInfoV2 has copy, drop {
        id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
        price: u128,
        liquidity_share: u128,
        growth: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView,
    }

    public(friend) fun accumulate_fee(arg0: &mut Bin, arg1: u64, arg2: u64) {
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        assert!(arg0.liquidity_share > 0, 13906838795728846859);
        let v0 = growth_view(arg0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::write_fee_globals(&mut arg0.fee_a_growth_global, &mut arg0.fee_b_growth_global, &mut arg0.rewards_growth_global, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::add_growth(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_a(&v0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::fee_delta(arg1, arg0.liquidity_share)), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::add_growth(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_b(&v0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::fee_delta(arg2, arg0.liquidity_share)));
    }

    public(friend) fun accumulate_rewards(arg0: &mut Bin, arg1: vector<u128>) {
        let v0 = 0;
        assert!(arg0.liquidity_share > 0, 13906838894513094667);
        let v1 = growth_view(arg0);
        assert!(0x1::vector::length<u128>(&arg1) >= 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_count(&v1) && 0x1::vector::length<u128>(&arg1) <= 5, 13906838903104077851);
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::write_reward_global(arg0.fee_a_growth_global, arg0.fee_b_growth_global, &mut arg0.rewards_growth_global, v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::add_growth(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_reward(&v1, v0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::reward_delta(*0x1::vector::borrow<u128>(&arg1, v0), arg0.liquidity_share)));
            v0 = v0 + 1;
        };
    }

    public(friend) fun add_bin_in_group_if_absent(arg0: &mut BinGroup, arg1: u8) : &mut Bin {
        arg0.used_bins_mask = arg0.used_bins_mask | 1 << arg1;
        borrow_mut_bin_from_group(arg0, arg1)
    }

    public(friend) fun add_group_if_absent(arg0: &mut BinManager, arg1: u64) : &mut BinGroupRef {
        if (!contains_group(arg0, arg1)) {
            let v0 = 0x1::vector::empty<Bin>();
            let v1 = 0;
            let v2 = bin_id_from_score(compose_score(arg1, 0));
            let v3 = calculate_group_prices(arg1, arg0.bin_step);
            assert_adjacent_group_prices_valid(arg0, arg1, &v3);
            while (v1 < 16) {
                0x1::vector::push_back<Bin>(&mut v0, default_bin_v2(v2, *0x1::vector::borrow<u128>(&v3, (v1 as u64))));
                v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                v1 = v1 + 1;
            };
            let v4 = BinGroup{
                idx            : (arg1 as u32),
                used_bins_mask : 0,
                bins           : v0,
            };
            let v5 = BinGroupRef{
                pool_id : arg0.pool_id,
                group   : v4,
            };
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<BinGroupRef>(&mut arg0.bins, (arg1 as u64), v5);
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

    fun assert_adjacent_group_prices_valid(arg0: &BinManager, arg1: u64, arg2: &vector<u128>) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<BinGroupRef>(&arg0.bins, arg1, false);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0)) {
            assert!(price(borrow_bin_from_group(borrow_group(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0)), 15)) < *0x1::vector::borrow<u128>(arg2, 0), 13906837013318729759);
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<BinGroupRef>(&arg0.bins, arg1, false);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
            assert!(*0x1::vector::borrow<u128>(arg2, 15) < price(borrow_bin_from_group(borrow_group(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1)), 0)), 13906837064858337311);
        };
    }

    public(friend) fun assert_bitmap_available(arg0: &BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::assert_bitmap_available<BinGroupRef>(&arg0.bins);
    }

    public(friend) fun assert_group_prices_valid(arg0: u64, arg1: u16) {
        calculate_group_prices(arg0, arg1);
    }

    public fun bin_id_from_score(arg0: u64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        assert!(arg0 >= 0 && (arg0 as u32) <= 887272, 13906840900262297603);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg0 as u32)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636))
    }

    public fun bin_info(arg0: &Bin) : BinInfo {
        BinInfo{
            id                    : arg0.id,
            amount_a              : arg0.amount_a,
            amount_b              : arg0.amount_b,
            price                 : arg0.price,
            liquidity_share       : arg0.liquidity_share,
            rewards_growth_global : rewards_growth_global(arg0),
            fee_a_growth_global   : arg0.fee_a_growth_global,
            fee_b_growth_global   : arg0.fee_b_growth_global,
        }
    }

    public fun bin_info_amount_a(arg0: &BinInfo) : u64 {
        arg0.amount_a
    }

    public fun bin_info_amount_b(arg0: &BinInfo) : u64 {
        arg0.amount_b
    }

    public fun bin_info_fee_a_growth_global(arg0: &BinInfo) : u128 {
        arg0.fee_a_growth_global
    }

    public fun bin_info_fee_b_growth_global(arg0: &BinInfo) : u128 {
        arg0.fee_b_growth_global
    }

    public fun bin_info_id(arg0: &BinInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.id
    }

    public fun bin_info_liquidity_share(arg0: &BinInfo) : u128 {
        arg0.liquidity_share
    }

    public fun bin_info_price(arg0: &BinInfo) : u128 {
        arg0.price
    }

    public fun bin_info_rewards_growth_global(arg0: &BinInfo) : vector<u128> {
        arg0.rewards_growth_global
    }

    public fun bin_info_v2(arg0: &Bin) : BinInfoV2 {
        BinInfoV2{
            id              : arg0.id,
            amount_a        : arg0.amount_a,
            amount_b        : arg0.amount_b,
            price           : arg0.price,
            liquidity_share : arg0.liquidity_share,
            growth          : growth_view(arg0),
        }
    }

    public fun bin_info_v2_amount_a(arg0: &BinInfoV2) : u64 {
        arg0.amount_a
    }

    public fun bin_info_v2_amount_b(arg0: &BinInfoV2) : u64 {
        arg0.amount_b
    }

    public fun bin_info_v2_growth_view(arg0: &BinInfoV2) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView {
        arg0.growth
    }

    public fun bin_info_v2_id(arg0: &BinInfoV2) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.id
    }

    public fun bin_info_v2_liquidity_share(arg0: &BinInfoV2) : u128 {
        arg0.liquidity_share
    }

    public fun bin_info_v2_price(arg0: &BinInfoV2) : u128 {
        arg0.price
    }

    public fun bin_score(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636)));
        assert!(v0 >= 0 && v0 <= 887272, 13906840848722690051);
        (v0 as u64)
    }

    public(friend) fun bitmap_begin(arg0: &mut BinManager) {
        let (v0, v1, v2) = bitmap_mapping(arg0);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_begin<BinGroupRef>(&mut arg0.bins, v0, v1, v2);
    }

    public(friend) fun bitmap_build_batch(arg0: &mut BinManager, arg1: u64, arg2: bool) {
        let v0 = if (arg2) {
            5
        } else {
            1
        };
        assert!(bitmap_mode(arg0) == v0, 13906842875949350947);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_check_limit(arg1);
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_cursor<BinGroupRef>(&arg0.bins);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v2)) {
                break
            };
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2);
            assert!((0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinGroupRef>(&arg0.bins, v3).group.idx as u64) == v3, 13906842906012024835);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_build_step<BinGroupRef>(&mut arg0.bins);
            v1 = v1 + 1;
        };
    }

    public(friend) fun bitmap_cancel_batch(arg0: &mut BinManager, arg1: u64) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_cancel_batch<BinGroupRef>(&mut arg0.bins, arg1);
    }

    public(friend) fun bitmap_cancel_begin(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_cancel_begin<BinGroupRef>(&mut arg0.bins);
    }

    public(friend) fun bitmap_cancel_finish(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_cancel_finish<BinGroupRef>(&mut arg0.bins);
    }

    public(friend) fun bitmap_check_mapping(arg0: &BinManager) {
        let (v0, v1, v2) = bitmap_mapping(arg0);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_check_mapping<BinGroupRef>(&arg0.bins, v0, v1, v2);
    }

    public(friend) fun bitmap_cleanup_done(arg0: &BinManager) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_cleanup_done<BinGroupRef>(&arg0.bins)
    }

    public(friend) fun bitmap_finalize(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_finalize<BinGroupRef>(&mut arg0.bins);
    }

    public(friend) fun bitmap_mapping(arg0: &BinManager) : (u64, u64, u64) {
        (0, 55454, 1)
    }

    public fun bitmap_mode(arg0: &BinManager) : u8 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_mode<BinGroupRef>(&arg0.bins)
    }

    public fun bitmap_mode_active() : u8 {
        3
    }

    public fun bitmap_mode_cancelling() : u8 {
        2
    }

    public fun bitmap_mode_legacy() : u8 {
        0
    }

    public fun bitmap_mode_migrating() : u8 {
        1
    }

    public fun bitmap_mode_repair_building() : u8 {
        5
    }

    public fun bitmap_mode_repair_clearing() : u8 {
        4
    }

    public(friend) fun bitmap_repair_begin(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_repair_begin<BinGroupRef>(&mut arg0.bins);
    }

    public(friend) fun bitmap_repair_clear_batch(arg0: &mut BinManager, arg1: u64) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_repair_clear_batch<BinGroupRef>(&mut arg0.bins, arg1);
    }

    public(friend) fun bitmap_repair_clear_finish(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_repair_clear_finish<BinGroupRef>(&mut arg0.bins);
    }

    public(friend) fun bitmap_repair_finalize(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_repair_finalize<BinGroupRef>(&mut arg0.bins);
    }

    public(friend) fun bitmap_repair_restart(arg0: &mut BinManager) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_repair_restart<BinGroupRef>(&mut arg0.bins);
    }

    public fun bitmap_status(arg0: &BinManager) : (u8, u64, u64, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64, u8, u64) {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_status<BinGroupRef>(&arg0.bins)
    }

    public(friend) fun borrow_bin(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &Bin {
        let (v0, v1) = resolve_bin_position(bin_score(arg1));
        let v2 = borrow_group(arg0, v0);
        assert!(contain_in_group(v2, v1), 13906835574502719489);
        borrow_bin_from_group(v2, v1)
    }

    public(friend) fun borrow_bin_by_score(arg0: &BinManager, arg1: u64) : &Bin {
        let (v0, v1) = resolve_bin_position(arg1);
        let v2 = borrow_group(arg0, v0);
        assert!(contain_in_group(v2, v1), 13906839255289692161);
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
        assert!(contains_group(arg0, arg1), 13906835346870370319);
        borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinGroupRef>(&arg0.bins, (arg1 as u64)))
    }

    public(friend) fun borrow_group_ref(arg0: &BinManager, arg1: u64) : &BinGroupRef {
        assert!(contains_group(arg0, arg1), 13906835415589847055);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinGroupRef>(&arg0.bins, (arg1 as u64))
    }

    public(friend) fun borrow_mut_bin(arg0: &mut BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut Bin {
        let (v0, v1) = resolve_bin_position(bin_score(arg1));
        let v2 = borrow_mut_group_ref(arg0, v0);
        let v3 = borrow_bin_group_mut(v2);
        assert!(contain_in_group(v3, v1), 13906835651812130817);
        borrow_mut_bin_from_group(v3, v1)
    }

    public(friend) fun borrow_mut_bin_from_group(arg0: &mut BinGroup, arg1: u8) : &mut Bin {
        0x1::vector::borrow_mut<Bin>(&mut arg0.bins, (arg1 as u64))
    }

    public(friend) fun borrow_mut_group_ref(arg0: &mut BinManager, arg1: u64) : &mut BinGroupRef {
        assert!(contains_group(arg0, arg1), 13906835497194225679);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<BinGroupRef>(&mut arg0.bins, (arg1 as u64))
    }

    fun calculate_group_prices(arg0: u64, arg1: u16) : vector<u128> {
        let v0 = vector[];
        let v1 = bin_id_from_score(compose_score(arg0, 0));
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id_v2(v1, arg1);
        let v3 = v2;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id_v2(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(15)), arg1);
        0x1::vector::push_back<u128>(&mut v0, v2);
        let v4 = 1;
        while (v4 < 16) {
            v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(v3, ((10000 + (arg1 as u64)) as u128), 10000);
            0x1::vector::push_back<u128>(&mut v0, v3);
            v4 = v4 + 1;
        };
        v0
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
        assert!(arg1 <= arg0.liquidity_share, 13906838022634340357);
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
            price                 : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id_v2(arg0, arg1),
            liquidity_share       : 0,
            rewards_growth_global : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::new_bin_growth(),
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
            rewards_growth_global : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::new_bin_growth(),
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

    public(friend) fun effective_bin_price(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = effective_bin_prices(arg0, arg1, arg1);
        0x1::vector::pop_back<u128>(&mut v0)
    }

    public(friend) fun effective_bin_prices(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : vector<u128> {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, arg2), 13906837180822323229);
        let v0 = vector[];
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, arg2)) {
            let (v1, v2) = resolve_bin_position(bin_score(arg1));
            let v3 = v2;
            if (contains_group(arg0, v1)) {
                let v4 = borrow_group(arg0, v1);
                while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, arg2) && v3 < 16) {
                    0x1::vector::push_back<u128>(&mut v0, price(borrow_bin_from_group(v4, v3)));
                    arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                    v3 = v3 + 1;
                };
            } else {
                let v5 = calculate_group_prices(v1, arg0.bin_step);
                while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, arg2) && v3 < 16) {
                    0x1::vector::push_back<u128>(&mut v0, *0x1::vector::borrow<u128>(&v5, (v3 as u64)));
                    arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                    v3 = v3 + 1;
                };
            };
        };
        v0
    }

    public fun fee_a_growth_global(arg0: &Bin) : u128 {
        arg0.fee_a_growth_global
    }

    public fun fee_b_growth_global(arg0: &Bin) : u128 {
        arg0.fee_b_growth_global
    }

    fun fetch_bin_ids(arg0: &BinManager, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32> {
        if (arg2 == 0) {
            return 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>()
        };
        let v0 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let (v1, v2) = if (0x1::option::is_none<u32>(&arg1)) {
            (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::head<BinGroupRef>(&arg0.bins), 0)
        } else {
            let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::option::borrow<u32>(&arg1));
            let (v4, v5) = resolve_bin_position(bin_score(v3));
            assert!(contains(arg0, v3), 13906839976844197889);
            (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v4), v5)
        };
        let v6 = v2;
        let v7 = v1;
        let v8 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v7)) {
            let v9 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v7);
            let v10 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<BinGroupRef>(&arg0.bins, v9);
            let v11 = borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<BinGroupRef>(v10));
            assert!((v11.idx as u64) == v9, 13906840028383936515);
            while (v6 < 16) {
                if (contain_in_group(v11, v6)) {
                    0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v0, id(borrow_bin_from_group(v11, v6)));
                    v8 = v8 + 1;
                };
                if (v8 == arg2) {
                    return v0
                };
                v6 = v6 + 1;
            };
            let v12 = if (is_bitmap_active(arg0)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_checked_neighbor<BinGroupRef>(&arg0.bins, v9, true)
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<BinGroupRef>(v10)
            };
            v7 = v12;
            v6 = 0;
        };
        v0
    }

    public fun fetch_bins(arg0: &BinManager, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<BinInfo> {
        let v0 = 0x1::vector::empty<BinInfo>();
        let v1 = fetch_bin_ids(arg0, arg1, arg2);
        0x1::vector::reverse<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&v1)) {
            0x1::vector::push_back<BinInfo>(&mut v0, bin_info(borrow_bin(arg0, 0x1::vector::pop_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v1))));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(v1);
        v0
    }

    public fun fetch_bins_v2(arg0: &BinManager, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<BinInfoV2> {
        let v0 = 0x1::vector::empty<BinInfoV2>();
        let v1 = fetch_bin_ids(arg0, arg1, arg2);
        0x1::vector::reverse<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&v1)) {
            0x1::vector::push_back<BinInfoV2>(&mut v0, bin_info_v2(borrow_bin(arg0, 0x1::vector::pop_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v1))));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(v1);
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

    public fun growth_view(arg0: &Bin) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_view(arg0.fee_a_growth_global, arg0.fee_b_growth_global, &arg0.rewards_growth_global)
    }

    public fun id(arg0: &Bin) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.id
    }

    public(friend) fun increase_liquidity(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u64, u64, u128) {
        if (arg1 == 0 && arg2 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(arg0.amount_a, arg0.amount_b, arg0.price);
        let v1 = 0;
        let v2 = 0;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(id(arg0), arg3)) {
            arg0.amount_a = arg0.amount_a + arg1;
            arg0.amount_b = arg0.amount_b + arg2;
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(id(arg0), arg3)) {
            v2 = arg2;
            arg0.amount_a = arg0.amount_a + arg1;
        } else {
            v1 = arg1;
            arg0.amount_b = arg0.amount_b + arg2;
        };
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_liquidity_by_amounts(arg1 - v1, arg2 - v2, arg0.price);
        let v4 = if (arg0.liquidity_share == 0) {
            v3
        } else {
            let v5 = (arg0.liquidity_share as u256) * (v3 as u256);
            assert!(v5 % (v0 as u256) <= v5 / 1000, 13906837885197221921);
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0.liquidity_share, v3, v0)
        };
        assert!(v4 > 0, 13906837919556304919);
        assert!(340282366920938463463374607431768211455 - arg0.liquidity_share >= v4, 13906837936735518733);
        arg0.liquidity_share = arg0.liquidity_share + v4;
        (v1, v2, v4)
    }

    public(friend) fun is_active_bin_empty(arg0: &BinManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        if (!contains(arg0, arg1)) {
            return true
        };
        borrow_bin(arg0, arg1).liquidity_share == 0
    }

    fun is_bitmap_active(arg0: &BinManager) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_mode<BinGroupRef>(&arg0.bins) == 3
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
            let v5 = borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<BinGroupRef>(v4));
            assert!((v5.idx as u64) == v3, 13906835759186444291);
            let v6 = v3 != v0 || arg2;
            let v7 = if (v3 == v0) {
                v1
            } else {
                0
            };
            let v8 = next_score_in_group(v5, v7, v6);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v8)) {
                return v8
            };
            let v9 = if (is_bitmap_active(arg0)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_checked_neighbor<BinGroupRef>(&arg0.bins, v3, true)
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<BinGroupRef>(v4)
            };
            v2 = v9;
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
        assert!(v0 <= 16, 13906836364778012693);
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
            let v5 = borrow_bin_group(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_value<BinGroupRef>(v4));
            assert!((v5.idx as u64) == v3, 13906835918100234243);
            let v6 = v3 != v0 || arg2;
            let v7 = if (v3 == v0) {
                v1
            } else {
                15
            };
            let v8 = prev_score_in_group(v5, v7, v6);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v8)) {
                return v8
            };
            let v9 = if (is_bitmap_active(arg0)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::bitmap_checked_neighbor<BinGroupRef>(&arg0.bins, v3, false)
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::prev_score<BinGroupRef>(v4)
            };
            v2 = v9;
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
        assert!(contain_in_group(arg0, arg1), 13906836244518666257);
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
        assert!(v1, 13906836257402912775);
    }

    public(friend) fun remove_group(arg0: &mut BinManager, arg1: u64) {
        if (!contains_group(arg0, arg1)) {
            return
        };
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<BinGroupRef>(&mut arg0.bins, arg1);
        assert!(v0.group.used_bins_mask == 0, 13906835050517889043);
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
            assert!(v15, 13906835132121481223);
        };
        0x1::vector::destroy_empty<Bin>(v6);
    }

    public fun resolve_bin_position(arg0: u64) : (u64, u8) {
        (arg0 >> 4, ((arg0 & 15) as u8))
    }

    public fun rewards_growth_global(arg0: &Bin) : vector<u128> {
        let v0 = growth_view(arg0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::legacy_bin_rewards(&v0)
    }

    public fun rewards_growth_global_raw(arg0: &Bin) : vector<u128> {
        arg0.rewards_growth_global
    }

    public(friend) fun swap_exact_amount_in(arg0: &mut Bin, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        let v0 = if (arg0.liquidity_share == 0) {
            if (arg0.amount_a == 0) {
                arg0.amount_b == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return (0, 0, 0, 0)
        };
        let (v1, v2, v3, v4) = if (arg2) {
            let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(arg1, arg3);
            let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_out(arg1 - v5, arg0.price, arg2);
            let (v7, v8, v9) = if (v6 <= arg0.amount_b) {
                (arg1, (v6 as u64), v5)
            } else {
                let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(arg0.amount_b, arg0.price, arg2);
                let v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v10, arg3);
                let v12 = v10 + v11;
                assert!(v12 <= arg1, 13906838288922574857);
                let v8 = (arg0.amount_b as u64);
                ((v12 as u64), v8, (v11 as u64))
            };
            let v13 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v9, arg4);
            arg0.amount_a = arg0.amount_a + v7 - v9;
            arg0.amount_b = arg0.amount_b - v8;
            accumulate_fee(arg0, v9 - v13, 0);
            (v9, v13, v7, v8)
        } else {
            let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(arg1, arg3);
            let v15 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_out(arg1 - v14, arg0.price, arg2);
            let (v16, v17, v18) = if (v15 <= arg0.amount_a) {
                (arg1, (v15 as u64), v14)
            } else {
                let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(arg0.amount_a, arg0.price, arg2);
                let v20 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v19, arg3);
                let v21 = v19 + v20;
                assert!(v21 <= arg1, 13906838404886691849);
                let v17 = (arg0.amount_a as u64);
                ((v21 as u64), v17, (v20 as u64))
            };
            let v22 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v18, arg4);
            arg0.amount_a = arg0.amount_a - v17;
            arg0.amount_b = arg0.amount_b + v16 - v18;
            accumulate_fee(arg0, 0, v18 - v22);
            (v18, v22, v16, v17)
        };
        (v3, v4, v1, v2)
    }

    public(friend) fun swap_exact_amount_out(arg0: &mut Bin, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        let v0 = if (arg0.liquidity_share == 0) {
            if (arg0.amount_a == 0) {
                arg0.amount_b == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return (0, 0, 0, 0)
        };
        if (arg2) {
            let v5 = 0x1::u64::min(arg0.amount_b, arg1);
            let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(v5, arg0.price, arg2);
            let v7 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v6, arg3);
            let v8 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v7, arg4);
            arg0.amount_a = arg0.amount_a + v6;
            arg0.amount_b = arg0.amount_b - v5;
            accumulate_fee(arg0, v7 - v8, 0);
            (v6 + v7, v5, v7, v8)
        } else {
            let v9 = 0x1::u64::min(arg0.amount_a, arg1);
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(v9, arg0.price, arg2);
            let v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v10, arg3);
            let v12 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v11, arg4);
            arg0.amount_a = arg0.amount_a - v9;
            arg0.amount_b = arg0.amount_b + v10;
            accumulate_fee(arg0, 0, v11 - v12);
            (v10 + v11, v9, v11, v12)
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

    // decompiled from Move bytecode v7
}

