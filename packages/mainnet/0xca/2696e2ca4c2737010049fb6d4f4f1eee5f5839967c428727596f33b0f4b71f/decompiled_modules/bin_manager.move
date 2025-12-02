module 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::bin_manager {
    struct BinManager has store {
        bins: 0x2::table::Table<u32, PackedBins>,
        tree: 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::TreeUint24,
    }

    struct PackedBins has drop, store {
        active_bins_bitmap: u8,
        bin_data: vector<Bin>,
    }

    struct Bin has copy, drop, store {
        bin_id: u32,
        reserve_x: u64,
        reserve_y: u64,
        price: u128,
        fee_growth_x: u128,
        fee_growth_y: u128,
        reward_growths: vector<u128>,
        total_supply: u128,
    }

    public(friend) fun contains(arg0: &BinManager, arg1: u32) : bool {
        let (v0, v1) = resolve_bin_group_index(arg1);
        !0x2::table::contains<u32, PackedBins>(&arg0.bins, v0) && false || is_bin_active_in_bitmap(0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0).active_bins_bitmap, v1)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{
            bins : 0x2::table::new<u32, PackedBins>(arg0),
            tree : 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::empty(arg0),
        }
    }

    public(friend) fun add_fee_growth(arg0: &mut Bin, arg1: u64, arg2: u64) : bool {
        if (arg0.total_supply == 0 || arg1 == 0 && arg2 == 0) {
            false
        } else {
            arg0.fee_growth_x = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(arg0.fee_growth_x, ((arg1 as u128) << 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::scale_offset()) / arg0.total_supply);
            arg0.fee_growth_y = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(arg0.fee_growth_y, ((arg2 as u128) << 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::scale_offset()) / arg0.total_supply);
            true
        }
    }

    public(friend) fun add_reserves_and_supply(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u128) {
        arg0.reserve_x = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_y, arg2);
        arg0.total_supply = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(arg0.total_supply, arg3);
    }

    public(friend) fun batch_add_bins_to_tree(arg0: &mut BinManager, arg1: &vector<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(arg1)) {
            0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::add(&mut arg0.tree, *0x1::vector::borrow<u32>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun bin_empty(arg0: &Bin) : bool {
        arg0.total_supply == 0
    }

    public(friend) fun bin_exists_in_pack(arg0: &PackedBins, arg1: u8) : bool {
        is_bin_active_in_bitmap(arg0.active_bins_bitmap, arg1)
    }

    public(friend) fun borrow_bins_table(arg0: &BinManager) : &0x2::table::Table<u32, PackedBins> {
        &arg0.bins
    }

    public(friend) fun borrow_bins_table_mut(arg0: &mut BinManager) : &mut 0x2::table::Table<u32, PackedBins> {
        &mut arg0.bins
    }

    fun clear_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 & 255 - (1 << arg1)
    }

    fun count_active_bins(arg0: u8) : u8 {
        let v0 = arg0 - (arg0 >> 1 & 85);
        let v1 = (v0 & 51) + (v0 >> 2 & 51);
        (v1 & 15) + (v1 >> 4)
    }

    fun count_active_bins_before_position(arg0: u8, arg1: u8) : u8 {
        assert!(arg1 < 8, 708);
        if (arg1 == 0) {
            return 0
        };
        count_active_bins(arg0 & (1 << arg1) - 1)
    }

    public(friend) fun create_bin_in_pack(arg0: &mut PackedBins, arg1: u32, arg2: u8, arg3: u16) {
        let v0 = arg0.active_bins_bitmap;
        0x1::vector::insert<Bin>(&mut arg0.bin_data, new_bin(arg1, arg3, 0, 0), (count_active_bins_before_position(v0, arg2) as u64));
        arg0.active_bins_bitmap = set_bit_in_bitmap(v0, arg2);
    }

    public(friend) fun create_empty_pack() : PackedBins {
        PackedBins{
            active_bins_bitmap : 0,
            bin_data           : 0x1::vector::empty<Bin>(),
        }
    }

    public(friend) fun fee_growth_and_supply(arg0: &Bin) : (u128, u128, u128) {
        (arg0.fee_growth_x, arg0.fee_growth_y, arg0.total_supply)
    }

    public(friend) fun get_amount_out_of_bin(arg0: &Bin, arg1: u128, arg2: u128) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        get_amount_out_of_bin_(arg0.reserve_x, arg0.reserve_y, arg1, arg2)
    }

    fun get_amount_out_of_bin_(arg0: u64, arg1: u64, arg2: u128, arg3: u128) : (u64, u64) {
        (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::u128_to_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::mul_div_round_down_u128(arg2, (arg0 as u128), arg3)), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::u128_to_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::mul_div_round_down_u128(arg2, (arg1 as u128), arg3)))
    }

    public(friend) fun get_amounts(arg0: &Bin, arg1: &0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::pair_parameter_helper::PairParameters, arg2: u16, arg3: bool, arg4: u64, arg5: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.price;
        let v1 = if (arg3) {
            arg0.reserve_y
        } else {
            arg0.reserve_x
        };
        if (v1 == 0) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v2 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::max_input_for_exact_output(v1, v0, arg3);
        let v3 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::pair_parameter_helper::get_total_fee_rate(arg1, arg2);
        let v4 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::fee_helper::get_fee_amount_exclusive(v2, v3);
        let v5 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(v2, v4);
        let v6 = if (arg3) {
            arg4
        } else {
            arg5
        };
        let (v7, v8, v9) = if (v6 >= v5) {
            (v5, v1, v4)
        } else {
            let v10 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::fee_helper::get_fee_amount_inclusive(v6, v3);
            (v6, 0x1::u64::min(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::swap_amount_out(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(v6, v10), v0, arg3), v1), v10)
        };
        let (v11, v12, v13, v14, v15, v16) = if (arg3) {
            (v9, 0, v7, 0, 0, v8)
        } else {
            (0, v9, 0, v7, v8, 0)
        };
        let (v17, v18) = if (arg3) {
            (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_x, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(v7, v9)), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(arg0.reserve_y, v8))
        } else {
            (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(arg0.reserve_x, v8), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_y, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(v7, v9)))
        };
        assert!(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::liquidity(v17, v18, v0) <= 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::max_liquidity_per_bin(), 702);
        (v13, v14, v15, v16, v11, v12)
    }

    public(friend) fun get_bin(arg0: &BinManager, arg1: u32) : &Bin {
        let (v0, v1) = resolve_bin_group_index(arg1);
        assert!(0x2::table::contains<u32, PackedBins>(&arg0.bins, v0), 706);
        let v2 = 0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0);
        assert!(is_bin_active_in_bitmap(v2.active_bins_bitmap, v1), 706);
        0x1::vector::borrow<Bin>(&v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64))
    }

    public(friend) fun get_bin_from_pack(arg0: &PackedBins, arg1: u64) : &Bin {
        0x1::vector::borrow<Bin>(&arg0.bin_data, arg1)
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
        let (v0, v1) = resolve_bin_group_index(arg1);
        if (!0x2::table::contains<u32, PackedBins>(&arg0.bins, v0)) {
            return (0, 0)
        };
        let v2 = 0x2::table::borrow<u32, PackedBins>(&arg0.bins, v0);
        if (!is_bin_active_in_bitmap(v2.active_bins_bitmap, v1)) {
            return (0, 0)
        };
        let v3 = 0x1::vector::borrow<Bin>(&v2.bin_data, (count_active_bins_before_position(v2.active_bins_bitmap, v1) as u64));
        (v3.reserve_x, v3.reserve_y)
    }

    public(friend) fun get_bin_reserves_supply(arg0: &BinManager, arg1: u32) : (u64, u64, u128) {
        let v0 = get_bin(arg0, arg1);
        (v0.reserve_x, v0.reserve_y, v0.total_supply)
    }

    public(friend) fun get_composition_fees(arg0: &Bin, arg1: &0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::pair_parameter_helper::PairParameters, arg2: u16, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (u64, u64) {
        if (arg6 == 0) {
            return (0, 0)
        };
        let (v0, v1) = get_amount_out_of_bin_(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_x, arg3), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_y, arg4), arg6, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(arg5, arg6));
        if (v0 > arg3 && arg4 > v1) {
            (0, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::fee_helper::get_composition_fee(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(arg4, v1), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::pair_parameter_helper::get_total_fee_rate(arg1, arg2)))
        } else if (v1 > arg4 && arg3 > v0) {
            (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::fee_helper::get_composition_fee(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(arg3, v0), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::pair_parameter_helper::get_total_fee_rate(arg1, arg2)), 0)
        } else {
            (0, 0)
        }
    }

    public(friend) fun get_fee_growth_x(arg0: &Bin) : u128 {
        arg0.fee_growth_x
    }

    public(friend) fun get_fee_growth_y(arg0: &Bin) : u128 {
        arg0.fee_growth_y
    }

    public(friend) fun get_next_non_empty_bin(arg0: &BinManager, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::find_first_right(&arg0.tree, arg2)
        } else {
            0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::find_first_left(&arg0.tree, arg2)
        };
        if (v0 == 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::max_id()) {
            0
        } else {
            v0
        }
    }

    public(friend) fun get_price(arg0: &Bin) : u128 {
        arg0.price
    }

    public(friend) fun get_range_id(arg0: &BinManager) : (u32, u32) {
        let v0 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::find_first_right(&arg0.tree, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::max_id());
        if (v0 == 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::max_id()) {
            (0, 0)
        } else {
            (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::find_first_left(&arg0.tree, 0), v0)
        }
    }

    public(friend) fun get_reserves(arg0: &Bin) : (u64, u64) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    public(friend) fun get_reward_growths(arg0: &Bin) : vector<u128> {
        arg0.reward_growths
    }

    public(friend) fun get_shares_and_effective_amounts_in(arg0: &Bin, arg1: u64, arg2: u64, arg3: u128) : (u128, u64, u64) {
        let v0 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::liquidity(arg1, arg2, arg3);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = arg0.total_supply;
        let v2 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::liquidity(arg0.reserve_x, arg0.reserve_y, arg3);
        if (v2 == 0 || v1 == 0) {
            return (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::sqrt(v0), arg1, arg2)
        };
        let v3 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::mul_div_round_down_u128(v0, v1, v2);
        if (v3 == 0) {
            return (0, 0, 0)
        };
        let v4 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::mul_div_round_up_u128(v3, v2, v1);
        let (v5, v6) = if (v0 > v4) {
            let v7 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u128(v0, v4);
            let v8 = v7;
            let v9 = arg1;
            let v10 = arg2;
            if (v7 > 0 && arg2 > 0) {
                let v11 = 0x1::u64::min(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::u128_to_u64(v7), arg2);
                v10 = arg2 - v11;
                v8 = v7 - (v11 as u128);
            };
            let v12 = if (v8 > 0) {
                if (arg3 > 0) {
                    arg1 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                v9 = arg1 - 0x1::u64::min(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::mul_div_u128_to_u64(v8, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::scale(), arg3), arg1);
            };
            (v9, v10)
        } else {
            (arg1, arg2)
        };
        assert!(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::liquidity(arg0.reserve_x + v5, arg0.reserve_y + v6, arg3) <= 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::max_liquidity_per_bin(), 702);
        (v3, v5, v6)
    }

    public(friend) fun get_total_supply(arg0: &Bin) : u128 {
        arg0.total_supply
    }

    fun is_bin_active_in_bitmap(arg0: u8, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public(friend) fun is_empty(arg0: &Bin, arg1: bool) : bool {
        arg1 && arg0.reserve_x == 0 || arg0.reserve_y == 0
    }

    fun new_bin(arg0: u32, arg1: u16, arg2: u64, arg3: u64) : Bin {
        0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::price_helper::validate_bin_id(arg0);
        Bin{
            bin_id         : arg0,
            reserve_x      : arg2,
            reserve_y      : arg3,
            price          : 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::price_helper::get_price_from_id(arg0, arg1),
            fee_growth_x   : 0,
            fee_growth_y   : 0,
            reward_growths : 0x1::vector::empty<u128>(),
            total_supply   : 0,
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
            0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::add(&mut arg0.tree, arg1);
            return
        };
        let v3 = 0x2::table::borrow_mut<u32, PackedBins>(&mut arg0.bins, v0);
        if (is_bin_active_in_bitmap(v3.active_bins_bitmap, v1)) {
            *0x1::vector::borrow_mut<Bin>(&mut v3.bin_data, (count_active_bins_before_position(v3.active_bins_bitmap, v1) as u64)) = arg2;
        } else {
            0x1::vector::insert<Bin>(&mut v3.bin_data, arg2, (count_active_bins_before_position(v3.active_bins_bitmap, v1) as u64));
            v3.active_bins_bitmap = set_bit_in_bitmap(v3.active_bins_bitmap, v1);
            0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::add(&mut arg0.tree, arg1);
        };
    }

    public(friend) fun remove_bins(arg0: &mut BinManager, arg1: vector<u32>) {
        let v0 = 0x1::vector::length<u32>(&arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0x1::vector::empty<u32>();
        let v2 = 0;
        let v3 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::max_u32();
        let v4 = create_empty_pack();
        let v5 = &mut v4;
        while (v2 < v0) {
            let v6 = *0x1::vector::borrow<u32>(&arg1, v2);
            let (v7, v8) = resolve_bin_group_index(v6);
            if (v7 != v3) {
                let v9 = if (v3 != 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::max_u32()) {
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
                0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::tree_math::remove(&mut arg0.tree, v6);
            };
            v2 = v2 + 1;
        };
        let v10 = if (v3 != 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::max_u32()) {
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

    fun set_bit_in_bitmap(arg0: u8, arg1: u8) : u8 {
        arg0 | 1 << arg1
    }

    public(friend) fun settle_active_bin_reward_growths(arg0: &mut Bin, arg1: &mut 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::rewarder::RewarderManager, arg2: &0x2::clock::Clock) : vector<u128> {
        let v0 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::rewarder::settle_reward(arg1, arg2);
        if (arg0.total_supply == 0) {
            return arg0.reward_growths
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&v0)) {
            let v2 = *0x1::vector::borrow<u128>(&v0, v1);
            if (v2 > 0) {
                let v3 = if (v1 < 0x1::vector::length<u128>(&arg0.reward_growths)) {
                    *0x1::vector::borrow<u128>(&arg0.reward_growths, v1)
                } else {
                    0
                };
                if (v1 < 0x1::vector::length<u128>(&arg0.reward_growths)) {
                    *0x1::vector::borrow_mut<u128>(&mut arg0.reward_growths, v1) = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(v3, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::div_u128(v2, arg0.total_supply));
                } else {
                    0x1::vector::push_back<u128>(&mut arg0.reward_growths, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(v3, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::div_u128(v2, arg0.total_supply)));
                };
            } else if (v1 >= 0x1::vector::length<u128>(&arg0.reward_growths)) {
                0x1::vector::push_back<u128>(&mut arg0.reward_growths, 0);
            };
            v1 = v1 + 1;
        };
        arg0.reward_growths
    }

    public(friend) fun settle_active_bin_reward_growths2(arg0: &mut BinManager, arg1: u32, arg2: &mut 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::rewarder::RewarderManager, arg3: &0x2::clock::Clock) {
        abort 0
    }

    public fun simulate_settle_active_bin_reward_growths(arg0: &Bin, arg1: &0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::rewarder::RewarderManager, arg2: &0x2::clock::Clock) : vector<u128> {
        if (arg0.total_supply == 0) {
            return arg0.reward_growths
        };
        let v0 = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::rewarder::calc_reward_emission(arg1, arg2);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u128>();
        while (v1 < 0x1::vector::length<u128>(&v0)) {
            let v3 = *0x1::vector::borrow<u128>(&v0, v1);
            if (v3 > 0) {
                let v4 = if (v1 < 0x1::vector::length<u128>(&arg0.reward_growths)) {
                    *0x1::vector::borrow<u128>(&arg0.reward_growths, v1)
                } else {
                    0
                };
                0x1::vector::push_back<u128>(&mut v2, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u128(v4, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::div_u128(v3, arg0.total_supply)));
            } else if (v1 < 0x1::vector::length<u128>(&arg0.reward_growths)) {
                0x1::vector::push_back<u128>(&mut v2, *0x1::vector::borrow<u128>(&arg0.reward_growths, v1));
            } else {
                0x1::vector::push_back<u128>(&mut v2, 0);
            };
            v1 = v1 + 1;
        };
        v2
    }

    public(friend) fun subtract_bin(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u128) {
        arg0.reserve_x = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(arg0.reserve_y, arg2);
        arg0.total_supply = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u128(arg0.total_supply, arg3);
    }

    public(friend) fun update_reserves_fees(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.reserve_x = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_x, arg1), arg2);
        arg0.reserve_y = 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg0.reserve_y, arg3), arg4);
    }

    public(friend) fun verify_lp_amounts(arg0: u64, arg1: u64, arg2: u32, arg3: u32) {
        if (arg3 < arg2 && arg0 > 0 || arg3 > arg2 && arg1 > 0) {
            abort 700
        };
    }

    // decompiled from Move bytecode v6
}

