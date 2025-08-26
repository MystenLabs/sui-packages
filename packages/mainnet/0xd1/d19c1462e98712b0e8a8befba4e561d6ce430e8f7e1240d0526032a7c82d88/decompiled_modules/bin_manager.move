module 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::bin_manager {
    struct BinManager has store {
        bins: 0x2::table::Table<u32, PackedBins>,
        tree: 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::TreeUint24,
    }

    struct PackedBins has drop, store {
        active_bins_bitmap: u8,
        bin_data: vector<Bin>,
    }

    struct Bin has copy, drop, store {
        bin_id: u32,
        reserve_x: u64,
        reserve_y: u64,
        fee_x: u64,
        fee_y: u64,
        price: u128,
        fee_growth_x: u128,
        fee_growth_y: u128,
        reward_growth: vector<u128>,
        total_supply: u128,
    }

    public fun contains(arg0: &BinManager, arg1: u32) : bool {
        let (v0, v1) = resolve_bin_group_index(arg1);
        !0x2::table::contains<u32, PackedBins>(&arg0.bins, v0) && false || is_bin_active_in_bitmap(0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0).active_bins_bitmap, v1)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{
            bins : 0x2::table::new<u32, PackedBins>(arg0),
            tree : 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::empty(arg0),
        }
    }

    public(friend) fun add_fee_growth(arg0: &mut Bin, arg1: u128, arg2: u128) {
        arg0.fee_growth_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u128(arg0.fee_growth_x, arg1);
        arg0.fee_growth_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u128(arg0.fee_growth_y, arg2);
    }

    public(friend) fun add_reserves_fees_and_supply(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        arg0.reserve_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_y, arg2);
        arg0.fee_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.fee_x, arg3);
        arg0.fee_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.fee_y, arg4);
        arg0.total_supply = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u128(arg0.total_supply, arg5);
    }

    public(friend) fun add_reward_growth(arg0: &mut Bin, arg1: u64, arg2: u128) {
        while (0x1::vector::length<u128>(&arg0.reward_growth) <= arg1) {
            0x1::vector::push_back<u128>(&mut arg0.reward_growth, 0);
        };
        let v0 = 0x1::vector::borrow_mut<u128>(&mut arg0.reward_growth, arg1);
        *v0 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u128(*v0, arg2);
    }

    public(friend) fun batch_add_bins_to_tree(arg0: &mut BinManager, arg1: &vector<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(arg1)) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::add(&mut arg0.tree, *0x1::vector::borrow<u32>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun bin_empty(arg0: &Bin) : bool {
        if (arg0.total_supply == 0) {
            if (arg0.fee_x == 0) {
                arg0.fee_y == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun bin_exists_in_pack(arg0: &PackedBins, arg1: u8) : bool {
        is_bin_active_in_bitmap(arg0.active_bins_bitmap, arg1)
    }

    public(friend) fun borrow_bins_table_mut(arg0: &mut BinManager) : &mut 0x2::table::Table<u32, PackedBins> {
        &mut arg0.bins
    }

    public(friend) fun clear_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 & 255 - (1 << arg1)
    }

    public(friend) fun count_active_bins(arg0: u8) : u8 {
        let v0 = arg0 - (arg0 >> 1 & 85);
        let v1 = (v0 & 51) + (v0 >> 2 & 51);
        (v1 & 15) + (v1 >> 4)
    }

    public(friend) fun count_active_bins_before_position(arg0: u8, arg1: u8) : u8 {
        if (arg1 == 0) {
            return 0
        };
        count_active_bins(arg0 & (1 << arg1) - 1)
    }

    public(friend) fun create_bin_in_pack(arg0: &mut PackedBins, arg1: u32, arg2: u8, arg3: u16) {
        let v0 = arg0.active_bins_bitmap;
        0x1::vector::insert<Bin>(&mut arg0.bin_data, new_bin(arg1, 0, 0, 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::price_helper::get_price_from_id(arg1, arg3)), (count_active_bins_before_position(v0, arg2) as u64));
        arg0.active_bins_bitmap = set_bit_in_bitmap(v0, arg2);
    }

    public(friend) fun create_empty_pack() : PackedBins {
        PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<Bin>(),
        }
    }

    public fun fee_as_y(arg0: &Bin, arg1: bool, arg2: u64, arg3: u64) : u128 {
        if (arg1) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(arg2, 0, get_price(arg0))
        } else {
            (arg3 as u128)
        }
    }

    public fun fee_growth_and_supply(arg0: &Bin) : (u128, u128, u128) {
        (arg0.fee_growth_x, arg0.fee_growth_y, arg0.total_supply)
    }

    public fun get_all_reward_growth(arg0: &Bin) : &vector<u128> {
        &arg0.reward_growth
    }

    public fun get_amount_out_of_bin(arg0: &Bin, arg1: u128, arg2: u128) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let v0 = arg0.reserve_x;
        let v1 = arg0.reserve_y;
        let v2 = if (v0 > 0) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128_to_u64(arg1, (v0 as u128), arg2)
        } else {
            0
        };
        let v3 = if (v1 > 0) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128_to_u64(arg1, (v1 as u128), arg2)
        } else {
            0
        };
        (v2, v3)
    }

    public(friend) fun get_bin(arg0: &BinManager, arg1: u32) : &Bin {
        let (v0, v1) = resolve_bin_group_index(arg1);
        assert!(0x2::table::contains<u32, PackedBins>(&arg0.bins, v0), 706);
        let v2 = 0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 706);
        0x1::vector::borrow<Bin>(&v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    public(friend) fun get_bin_index_in_pack(arg0: &PackedBins, arg1: u8) : u64 {
        (count_active_bins_before_position(arg0.active_bins_bitmap, arg1) as u64)
    }

    public(friend) fun get_bin_mut(arg0: &mut BinManager, arg1: u32) : &mut Bin {
        let (v0, v1) = resolve_bin_group_index(arg1);
        assert!(0x2::table::contains<u32, PackedBins>(&arg0.bins, v0), 706);
        let v2 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 706);
        0x1::vector::borrow_mut<Bin>(&mut v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    public(friend) fun get_bin_mut_from_pack(arg0: &mut PackedBins, arg1: u64) : &mut Bin {
        0x1::vector::borrow_mut<Bin>(&mut arg0.bin_data, arg1)
    }

    public(friend) fun get_bin_reserves(arg0: &BinManager, arg1: u32) : (u64, u64) {
        let v0 = get_bin(arg0, arg1);
        (v0.reserve_x, v0.reserve_y)
    }

    public(friend) fun get_bin_reserves_supply(arg0: &BinManager, arg1: u32) : (u64, u64, u128) {
        let v0 = get_bin(arg0, arg1);
        (v0.reserve_x, v0.reserve_y, v0.total_supply)
    }

    public fun get_composition_fees(arg0: &Bin, arg1: &0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::pair_parameter_helper::PairParameters, arg2: u16, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (u64, u64) {
        if (arg6 == 0) {
            return (0, 0)
        };
        let v0 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u128(arg5, arg6);
        let v1 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_x, arg3);
        let v2 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_y, arg4);
        let v3 = if (v1 > 0) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128_to_u64(arg6, (v1 as u128), v0)
        } else {
            0
        };
        let v4 = if (v2 > 0) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128_to_u64(arg6, (v2 as u128), v0)
        } else {
            0
        };
        if (v3 > arg3 && arg4 > v4) {
            (0, 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::fee_helper::get_composition_fee(arg4 - v4, 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::pair_parameter_helper::get_total_fee_rate(arg1, arg2)))
        } else if (v4 > arg4 && arg3 > v3) {
            (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::fee_helper::get_composition_fee(arg3 - v3, 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::pair_parameter_helper::get_total_fee_rate(arg1, arg2)), 0)
        } else {
            (0, 0)
        }
    }

    public fun get_fee_growth_x(arg0: &Bin) : u128 {
        arg0.fee_growth_x
    }

    public fun get_fee_growth_y(arg0: &Bin) : u128 {
        arg0.fee_growth_y
    }

    public fun get_liquidity_from_reserves(arg0: &Bin, arg1: u128) : u128 {
        0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(arg0.reserve_x, arg0.reserve_y, arg1)
    }

    public fun get_next_non_empty_bin(arg0: &BinManager, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::find_first_right(&arg0.tree, arg2)
        } else {
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::find_first_left(&arg0.tree, arg2)
        };
        if (v0 == 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::max_id()) {
            0
        } else {
            v0
        }
    }

    public fun get_price(arg0: &Bin) : u128 {
        arg0.price
    }

    public fun get_reserves(arg0: &Bin) : (u64, u64) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    public fun get_reward_growth(arg0: &Bin, arg1: u64) : u128 {
        if (arg1 < 0x1::vector::length<u128>(&arg0.reward_growth)) {
            *0x1::vector::borrow<u128>(&arg0.reward_growth, arg1)
        } else {
            0
        }
    }

    public(friend) fun get_shares_and_effective_amounts_in(arg0: &Bin, arg1: u64, arg2: u64, arg3: u128) : (u128, u64, u64) {
        let v0 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(arg1, arg2, arg3);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = arg0.total_supply;
        let v2 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(arg0.reserve_x, arg0.reserve_y, arg3);
        if (v2 == 0 || v1 == 0) {
            let v3 = 0x1::u128::max(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sqrt_u128(v0), 1000);
            assert!(v3 <= 17179869184, 705);
            return (v3, arg1, arg2)
        };
        let v4 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128(v0, v1, v2);
        if (v4 == 0) {
            return (0, 0, 0)
        };
        assert!(v4 <= 17179869184, 705);
        let v5 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128(v4, v2, v1);
        let (v6, v7) = if (v0 > v5) {
            let v8 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128(v5, (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::precision() as u128), v0);
            (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128_to_u64((arg1 as u128), v8, (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::precision() as u128)), 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128_to_u64((arg2 as u128), v8, (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::precision() as u128)))
        } else {
            (arg1, arg2)
        };
        assert!(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_x, v6), 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_y, v7), arg3) <= 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::max_liquidity_per_bin(), 702);
        (v4, v6, v7)
    }

    public fun get_swap_amounts(arg0: &Bin, arg1: &0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::pair_parameter_helper::PairParameters, arg2: u16, arg3: bool, arg4: u64, arg5: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.price;
        let v1 = if (arg3) {
            arg0.reserve_y
        } else {
            arg0.reserve_x
        };
        if (v1 == 0) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v2 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::max_input_for_exact_output(v1, v0, arg3);
        let v3 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::pair_parameter_helper::get_total_fee_rate(arg1, arg2);
        let v4 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::fee_helper::get_fee_amount_exclusive(v2, v3);
        let v5 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(v2, v4);
        let v6 = if (arg3) {
            arg4
        } else {
            arg5
        };
        let (v7, v8, v9) = if (v6 >= v5) {
            (v5, v1, v4)
        } else {
            let v10 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::fee_helper::get_fee_amount_inclusive(v6, v3);
            (v6, 0x1::u64::min(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::swap_amount_out(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(v6, v10), v0, arg3), v1), v10)
        };
        let (v11, v12) = if (arg3) {
            (v7, 0)
        } else {
            (0, v7)
        };
        let (v13, v14) = if (arg3) {
            (0, v8)
        } else {
            (v8, 0)
        };
        let (v15, v16) = if (arg3) {
            (v9, 0)
        } else {
            (0, v9)
        };
        let (v17, v18) = if (arg3) {
            (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_x, 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(v7, v9)), 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.reserve_y, v8))
        } else {
            (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.reserve_x, v8), 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_y, 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(v7, v9)))
        };
        assert!(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(v17, v18, v0) <= 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::max_liquidity_per_bin(), 702);
        (v11, v12, v13, v14, v15, v16)
    }

    public fun get_total_amounts(arg0: &Bin) : (u64, u64) {
        (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_x, arg0.fee_x), 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_y, arg0.fee_y))
    }

    public fun get_total_supply(arg0: &Bin) : u128 {
        arg0.total_supply
    }

    public(friend) fun is_bin_active_in_bitmap(arg0: u8, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public fun is_empty(arg0: &Bin, arg1: bool) : bool {
        arg1 && arg0.reserve_x == 0 || arg0.reserve_y == 0
    }

    public fun new_bin(arg0: u32, arg1: u64, arg2: u64, arg3: u128) : Bin {
        Bin{
            bin_id        : arg0,
            reserve_x     : arg1,
            reserve_y     : arg2,
            fee_x         : 0,
            fee_y         : 0,
            price         : arg3,
            fee_growth_x  : 0,
            fee_growth_y  : 0,
            reward_growth : 0x1::vector::empty<u128>(),
            total_supply  : 0,
        }
    }

    public(friend) fun put_bin(arg0: &mut BinManager, arg1: u32, arg2: Bin) {
        let (v0, v1) = resolve_bin_group_index(arg1);
        if (!0x2::table::contains<u32, PackedBins>(&arg0.bins, v0)) {
            let v2 = PackedBins{
                active_bins_bitmap : 1 << v1,
                bin_data           : 0x1::vector::singleton<Bin>(arg2),
            };
            0x2::table::add<u32, PackedBins>(&mut arg0.bins, v0, v2);
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::add(&mut arg0.tree, arg1);
            return
        };
        let v3 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        if (is_bin_active_in_bitmap(v3.active_bins_bitmap, v1)) {
            *0x1::vector::borrow_mut<Bin>(&mut v3.bin_data, (count_active_bins_before_position(v3.active_bins_bitmap, v1) as u64)) = arg2;
        } else {
            0x1::vector::insert<Bin>(&mut v3.bin_data, arg2, (count_active_bins_before_position(v3.active_bins_bitmap, v1) as u64));
            v3.active_bins_bitmap = set_bit_in_bitmap(v3.active_bins_bitmap, v1);
            0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::add(&mut arg0.tree, arg1);
        };
    }

    public(friend) fun remove_bin(arg0: &mut BinManager, arg1: u32) {
        let (v0, v1) = resolve_bin_group_index(arg1);
        if (!0x2::table::contains<u32, PackedBins>(&arg0.bins, v0)) {
            return
        };
        let v2 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        if (!is_bin_active_in_bitmap(v2.active_bins_bitmap, v1)) {
            return
        };
        0x1::vector::remove<Bin>(&mut v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64));
        v2.active_bins_bitmap = clear_bit_in_bitmap(v2.active_bins_bitmap, v1);
        if (v2.active_bins_bitmap == 0) {
            0x2::table::remove<u32, PackedBins>(&mut arg0.bins, v0);
        };
        0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::remove(&mut arg0.tree, arg1);
    }

    public(friend) fun remove_bins(arg0: &mut BinManager, arg1: vector<u32>) {
        let v0 = 0x1::vector::length<u32>(&arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0x1::vector::empty<u32>();
        let v2 = 0;
        let v3 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::max_u32();
        let v4 = create_empty_pack();
        let v5 = &mut v4;
        while (v2 < v0) {
            let v6 = *0x1::vector::borrow<u32>(&arg1, v2);
            let (v7, v8) = resolve_bin_group_index(v6);
            if (v7 != v3) {
                let v9 = if (v3 != 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::max_u32()) {
                    if (v5.active_bins_bitmap == 0) {
                        !0x1::vector::contains<u32>(&v1, &v3)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v9) {
                    0x1::vector::push_back<u32>(&mut v1, v3);
                };
                v5 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v7);
                v3 = v7;
            };
            if (is_bin_active_in_bitmap(v5.active_bins_bitmap, v8)) {
                0x1::vector::remove<Bin>(&mut v5.bin_data, (count_active_bins_before_position(v5.active_bins_bitmap, v8) as u64));
                v5.active_bins_bitmap = clear_bit_in_bitmap(v5.active_bins_bitmap, v8);
                0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::tree_math::remove(&mut arg0.tree, v6);
            };
            v2 = v2 + 1;
        };
        let v10 = if (v3 != 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::max_u32()) {
            if (v5.active_bins_bitmap == 0) {
                !0x1::vector::contains<u32>(&v1, &v3)
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            0x1::vector::push_back<u32>(&mut v1, v3);
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<u32>(&v1)) {
            0x2::table::remove<u32, PackedBins>(&mut arg0.bins, *0x1::vector::borrow<u32>(&v1, v11));
            v11 = v11 + 1;
        };
    }

    public(friend) fun resolve_bin_group_index(arg0: u32) : (u32, u8) {
        (arg0 >> 3, ((arg0 & 7) as u8))
    }

    public(friend) fun set_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 | 1 << arg1
    }

    public(friend) fun sub_fees(arg0: &mut Bin, arg1: u64, arg2: u64) {
        arg0.fee_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.fee_x, arg1);
        arg0.fee_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.fee_y, arg2);
    }

    public(friend) fun subtract_bin(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        arg0.reserve_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.reserve_y, arg2);
        arg0.fee_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.fee_x, arg3);
        arg0.fee_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(arg0.fee_y, arg4);
        arg0.total_supply = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u128(arg0.total_supply, arg5);
    }

    public(friend) fun update_reserves_fees(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.reserve_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_x, arg1), arg2);
        arg0.reserve_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::sub_u64(0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.reserve_y, arg3), arg4);
        arg0.fee_x = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.fee_x, arg5);
        arg0.fee_y = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::add_u64(arg0.fee_y, arg6);
    }

    public(friend) fun update_reward_growth(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: &vector<u128>) {
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        let v0 = arg0.total_supply;
        if (v0 == 0) {
            return
        };
        let v1 = 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::q64x64::liquidity_from_amounts(arg1, arg2, arg0.price);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg3)) {
            let v3 = *0x1::vector::borrow<u128>(arg3, v2);
            if (v3 > 0 && v1 > 0) {
                add_reward_growth(arg0, v2, (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math::mul_div_u128(v1, v3, (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::constants::precision() as u128)) << 64) / v0);
            };
            v2 = v2 + 1;
        };
    }

    public fun verify_lp_amounts(arg0: u64, arg1: u64, arg2: u32, arg3: u32) {
        if (arg3 < arg2 && arg0 > 0 || arg3 > arg2 && arg1 > 0) {
            abort 700
        };
    }

    // decompiled from Move bytecode v6
}

