module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct PositionManager has store {
        bin_step: u16,
        position_index: u64,
        positions: 0x2::table::Table<0x2::object::ID, PositionInfo>,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        index: u64,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
        uri: 0x1::string::String,
        lower_bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_shares: vector<u128>,
        flash_count: u64,
    }

    struct PositionInfo has copy, store {
        id: 0x2::object::ID,
        fee_owned_a: u64,
        fee_owned_b: u64,
        rewards_owned: vector<u64>,
        stats: vector<BinStat>,
    }

    struct BinStat has copy, store {
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_share: u128,
        fee_a_growth: u128,
        fee_b_growth: u128,
        rewards_growth: vector<u128>,
    }

    struct PositionGrowthV2 has copy, drop {
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_share: u128,
        fee_a: u256,
        fee_b: u256,
        rewards: vector<u256>,
        initialized_count: u64,
        expanded: bool,
    }

    struct PositionCheckpointExpanded has copy, drop {
        position: 0x2::object::ID,
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        schema: u8,
    }

    struct ClosePositionCert {
        pool_id: 0x2::object::ID,
        position_info: PositionInfo,
        amount_a: u64,
        amount_b: u64,
    }

    public(friend) fun decrease_liquidity(arg0: &mut PositionInfo, arg1: &mut Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg3: u128) {
        if (arg3 == 0) {
            return
        };
        let v0 = bin_idx(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2));
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2)), 13906836253108862997);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_is_extended_raw(&v1.rewards_growth);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg2);
        let v4 = arg3 != v1.liquidity_share;
        let v5 = &mut arg0.fee_owned_a;
        let v6 = &mut arg0.fee_owned_b;
        let v7 = &mut arg0.rewards_owned;
        settle_growth(v1, &v3, v5, v6, v7, v4);
        let v8 = decrease_liquidity_per_bin(v1, arg3);
        *0x1::vector::borrow_mut<u128>(&mut arg1.liquidity_shares, v0) = v8;
        emit_checkpoint_expanded(arg0.id, v1, v2);
    }

    public fun growth_view(arg0: &BinStat) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::CheckpointView {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_view(arg0.fee_a_growth, arg0.fee_b_growth, &arg0.rewards_growth)
    }

    public(friend) fun add_liquidity(arg0: &mut PositionInfo, arg1: &mut Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg3: u128) {
        let v0 = bin_idx(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2));
        assert!(0x1::vector::length<BinStat>(&arg0.stats) == v0, 13906835956756119573);
        0x1::vector::push_back<BinStat>(&mut arg0.stats, new_bin_stat(arg2, 0));
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, v0);
        emit_checkpoint_expanded(arg0.id, v1, false);
        0x1::vector::push_back<u128>(&mut arg1.liquidity_shares, increase_liquidity_per_bin(v1, arg3));
    }

    public fun amount_a(arg0: &ClosePositionCert) : u64 {
        arg0.amount_a
    }

    public fun amount_b(arg0: &ClosePositionCert) : u64 {
        arg0.amount_b
    }

    public(friend) fun assert_no_pending_add(arg0: &Position) {
        assert!(arg0.flash_count == 0, 13906837769233104929);
    }

    fun assert_zero_payout_exit(arg0: u128, arg1: u128, arg2: u64, arg3: u64) {
        assert!(arg0 >= arg1, 13906839590298189841);
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 != 0) {
            true
        } else if (arg3 != 0) {
            true
        } else {
            arg1 == arg0
        };
        assert!(v0, 13906839594594992173);
    }

    public fun bin_id(arg0: &BinStat) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.bin_id
    }

    public fun bin_idx(arg0: &Position, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0.lower_bin_id)) as u64)
    }

    public fun bin_idx_on_position_info(arg0: &PositionInfo, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, lower_bin_id_on_position_info(arg0))) as u64)
    }

    public fun bin_step(arg0: &PositionManager) : u16 {
        arg0.bin_step
    }

    public(friend) fun borrow_mut_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : &mut PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906835411295928351);
        0x2::table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1)
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906837868017221663);
        0x2::table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public(friend) fun cert_pool_id(arg0: &ClosePositionCert) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun cert_rewards_owned(arg0: &ClosePositionCert) : &vector<u64> {
        &arg0.position_info.rewards_owned
    }

    public(friend) fun cert_stats(arg0: &ClosePositionCert) : &vector<BinStat> {
        &arg0.position_info.stats
    }

    fun checked_checkpoint(arg0: &BinStat, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::CheckpointView {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_view(arg0.fee_a_growth, arg0.fee_b_growth, &arg0.rewards_growth);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_count(&v0);
        assert!(v1 <= 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_count(arg1), 13906840041269886995);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_a(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_a(&v0));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_b(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_b(&v0));
        let v2 = 0;
        while (v2 < v1) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_reward(arg1, v2), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_reward(&v0, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun clear_pending_add(arg0: &mut Position) {
        assert!(arg0.flash_count > 0, 13906837717693628451);
        arg0.flash_count = arg0.flash_count - 1;
    }

    public(friend) fun close_position(arg0: &mut PositionManager, arg1: Position) : ClosePositionCert {
        let v0 = ClosePositionCert{
            pool_id       : arg1.pool_id,
            position_info : 0x2::table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(&arg1)),
            amount_a      : 0,
            amount_b      : 0,
        };
        destroy(arg1);
        v0
    }

    public(friend) fun close_position_bin(arg0: &mut ClosePositionCert, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg2: BinStat) : (u64, u64) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg2.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836820044546069);
        if (arg2.liquidity_share == 0) {
            destroy_bin_stat(arg2);
            return (0, 0)
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg1);
        let v1 = &mut arg2;
        let v2 = &mut arg0.position_info.fee_owned_a;
        let v3 = &mut arg0.position_info.fee_owned_b;
        let v4 = &mut arg0.position_info.rewards_owned;
        settle_growth(v1, &v0, v2, v3, v4, false);
        let BinStat {
            bin_id          : _,
            liquidity_share : v6,
            fee_a_growth    : _,
            fee_b_growth    : _,
            rewards_growth  : _,
        } = arg2;
        let (v10, v11) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::decrease_liquidity(arg1, v6);
        arg0.amount_a = arg0.amount_a + v10;
        arg0.amount_b = arg0.amount_b + v11;
        (v10, v11)
    }

    public fun coin_type_a(arg0: &Position) : 0x1::string::String {
        arg0.coin_type_a
    }

    public fun coin_type_b(arg0: &Position) : 0x1::string::String {
        arg0.coin_type_b
    }

    fun decrease_liquidity_per_bin(arg0: &mut BinStat, arg1: u128) : u128 {
        assert!(arg0.liquidity_share >= arg1, 13906839706262306833);
        let v0 = arg0.liquidity_share - arg1;
        assert!(v0 == 0 || v0 > 100000000, 13906839723443879979);
        arg0.liquidity_share = v0;
        if (arg0.liquidity_share == 0) {
            let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::empty_checkpoint();
            arg0.fee_a_growth = v1;
            arg0.fee_b_growth = v2;
            arg0.rewards_growth = v3;
        };
        arg0.liquidity_share
    }

    public fun description(arg0: &Position) : 0x1::string::String {
        arg0.description
    }

    fun destroy(arg0: Position) {
        let Position {
            id               : v0,
            pool_id          : _,
            index            : _,
            coin_type_a      : _,
            coin_type_b      : _,
            description      : _,
            name             : _,
            uri              : _,
            lower_bin_id     : _,
            upper_bin_id     : _,
            liquidity_shares : _,
            flash_count      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun destroy_bin_stat(arg0: BinStat) {
        let BinStat {
            bin_id          : _,
            liquidity_share : _,
            fee_a_growth    : _,
            fee_b_growth    : _,
            rewards_growth  : _,
        } = arg0;
    }

    public(friend) fun destroy_cert(arg0: ClosePositionCert) {
        let ClosePositionCert {
            pool_id       : _,
            position_info : v1,
            amount_a      : v2,
            amount_b      : v3,
        } = arg0;
        let PositionInfo {
            id            : _,
            fee_owned_a   : v5,
            fee_owned_b   : v6,
            rewards_owned : v7,
            stats         : v8,
        } = v1;
        let v9 = v8;
        assert!(0x1::vector::length<BinStat>(&v9) == 0, 13906837399865655325);
        0x1::vector::destroy_empty<BinStat>(v9);
        assert!(v2 + v5 == 0, 13906837408455196695);
        assert!(v3 + v6 == 0, 13906837412750295065);
        let v10 = v7;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v10)) {
            assert!(0x1::vector::pop_back<u64>(&mut v10) == 0, 13906837421340360731);
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<u64>(v10);
    }

    fun emit_checkpoint_expanded(arg0: 0x2::object::ID, arg1: &BinStat, arg2: bool) {
        if (!arg2 && 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_is_extended_raw(&arg1.rewards_growth)) {
            let v0 = PositionCheckpointExpanded{
                position : arg0,
                bin_id   : arg1.bin_id,
                schema   : 2,
            };
            0x2::event::emit<PositionCheckpointExpanded>(v0);
        };
    }

    public(friend) fun extract_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906835480015405087);
        0x2::table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1)
    }

    public fun fee_a_growth(arg0: &BinStat) : u128 {
        arg0.fee_a_growth
    }

    public fun fee_b_growth(arg0: &BinStat) : u128 {
        arg0.fee_b_growth
    }

    public fun growth_v2_bin_id(arg0: &PositionGrowthV2) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.bin_id
    }

    public fun growth_v2_expanded(arg0: &PositionGrowthV2) : bool {
        arg0.expanded
    }

    public fun growth_v2_fee_a(arg0: &PositionGrowthV2) : u256 {
        arg0.fee_a
    }

    public fun growth_v2_fee_b(arg0: &PositionGrowthV2) : u256 {
        arg0.fee_b
    }

    public fun growth_v2_initialized_count(arg0: &PositionGrowthV2) : u64 {
        arg0.initialized_count
    }

    public fun growth_v2_liquidity_share(arg0: &PositionGrowthV2) : u128 {
        arg0.liquidity_share
    }

    public fun growth_v2_page(arg0: &PositionInfo, arg1: u64, arg2: u64) : vector<PositionGrowthV2> {
        let v0 = 0x1::vector::empty<PositionGrowthV2>();
        while (arg1 < 0x1::vector::length<BinStat>(&arg0.stats) && arg2 > 0) {
            let v1 = 0x1::vector::borrow<BinStat>(&arg0.stats, arg1);
            let v2 = growth_view(v1);
            let v3 = vector[];
            let v4 = 0;
            while (v4 < 5) {
                0x1::vector::push_back<u256>(&mut v3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_reward(&v2, v4));
                v4 = v4 + 1;
            };
            let v5 = PositionGrowthV2{
                bin_id            : v1.bin_id,
                liquidity_share   : v1.liquidity_share,
                fee_a             : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_a(&v2),
                fee_b             : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_b(&v2),
                rewards           : v3,
                initialized_count : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_count(&v2),
                expanded          : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_expanded(&v2),
            };
            0x1::vector::push_back<PositionGrowthV2>(&mut v0, v5);
            arg1 = arg1 + 1;
            arg2 = arg2 - 1;
        };
        v0
    }

    public fun growth_v2_rewards(arg0: &PositionGrowthV2) : vector<u256> {
        arg0.rewards
    }

    public(friend) fun increase_liquidity(arg0: &mut PositionInfo, arg1: &mut Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg3: u128) {
        let v0 = bin_idx(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2));
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2)), 13906836089900105749);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_is_extended_raw(&v1.rewards_growth);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg2);
        let v4 = &mut arg0.fee_owned_a;
        let v5 = &mut arg0.fee_owned_b;
        let v6 = &mut arg0.rewards_owned;
        settle_growth(v1, &v3, v4, v5, v6, true);
        let v7 = increase_liquidity_per_bin(v1, arg3);
        *0x1::vector::borrow_mut<u128>(&mut arg1.liquidity_shares, v0) = v7;
        emit_checkpoint_expanded(arg0.id, v1, v2);
    }

    fun increase_liquidity_per_bin(arg0: &mut BinStat, arg1: u128) : u128 {
        assert!(340282366920938463463374607431768211455 - arg0.liquidity_share >= arg1, 13906839487218843663);
        let v0 = arg0.liquidity_share + arg1;
        if (arg1 > 0) {
            assert!(v0 > 100000000, 13906839508695515179);
        };
        arg0.liquidity_share = v0;
        arg0.liquidity_share
    }

    public fun index(arg0: &Position) : u64 {
        arg0.index
    }

    public fun info_fees(arg0: &PositionInfo) : (u64, u64) {
        (arg0.fee_owned_a, arg0.fee_owned_b)
    }

    public fun info_rewards(arg0: &PositionInfo) : &vector<u64> {
        &arg0.rewards_owned
    }

    public fun info_stats(arg0: &PositionInfo) : &vector<BinStat> {
        &arg0.stats
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.cetus.zone/pools"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus"));
        let v4 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Position>(&v4, v0, v2, arg1);
        0x2::display::update_version<Position>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun liquidity_share(arg0: &BinStat) : u128 {
        arg0.liquidity_share
    }

    public fun liquidity_shares(arg0: &Position) : vector<u128> {
        arg0.liquidity_shares
    }

    public fun lower_bin_id(arg0: &Position) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.lower_bin_id
    }

    public fun lower_bin_id_on_position_info(arg0: &PositionInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x1::vector::borrow<BinStat>(&arg0.stats, 0).bin_id
    }

    public(friend) fun mark_add_pending(arg0: &mut Position) {
        arg0.flash_count = arg0.flash_count + 1;
    }

    public fun name(arg0: &Position) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new_bin_stat(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg1: u128) : BinStat {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::new_checkpoint(&v0);
        BinStat{
            bin_id          : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg0),
            liquidity_share : arg1,
            fee_a_growth    : v1,
            fee_b_growth    : v2,
            rewards_growth  : v3,
        }
    }

    public(friend) fun new_position_manager(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            bin_step       : arg0,
            position_index : 0,
            positions      : 0x2::table::new<0x2::object::ID, PositionInfo>(arg1),
        }
    }

    fun new_position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Cetus DLMM LP | Pool");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg1));
        v0
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Position {
        let v0 = Position{
            id               : 0x2::object::new(arg6),
            pool_id          : arg1,
            index            : arg0.position_index,
            coin_type_a      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            coin_type_b      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
            description      : 0x1::string::utf8(b"Cetus DLMM Position"),
            name             : new_position_name(arg2, arg0.position_index),
            uri              : arg5,
            lower_bin_id     : arg3,
            upper_bin_id     : arg4,
            liquidity_shares : vector[],
            flash_count      : 0,
        };
        let v1 = PositionInfo{
            id            : 0x2::object::id<Position>(&v0),
            fee_owned_a   : 0,
            fee_owned_b   : 0,
            rewards_owned : vector[],
            stats         : 0x1::vector::empty<BinStat>(),
        };
        0x2::table::add<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(&v0), v1);
        arg0.position_index = arg0.position_index + 1;
        v0
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun pop_position_bin(arg0: &mut ClosePositionCert) : BinStat {
        0x1::vector::pop_back<BinStat>(&mut arg0.position_info.stats)
    }

    public fun position_info(arg0: &ClosePositionCert) : &PositionInfo {
        &arg0.position_info
    }

    fun rebase_if_empty(arg0: &mut BinStat, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView) : bool {
        if (arg0.liquidity_share != 0) {
            return false
        };
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::new_checkpoint(arg1);
        arg0.fee_a_growth = v0;
        arg0.fee_b_growth = v1;
        arg0.rewards_growth = v2;
        true
    }

    public(friend) fun restore_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: PositionInfo) {
        assert!(!0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906835557325209637);
        0x2::table::add<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1, arg2);
    }

    public fun rewards_growth(arg0: &BinStat) : vector<u128> {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_view(arg0.fee_a_growth, arg0.fee_b_growth, &arg0.rewards_growth);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::legacy_checkpoint_rewards(&v0)
    }

    fun settle_growth(arg0: &mut BinStat, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView, arg2: &mut u64, arg3: &mut u64, arg4: &mut vector<u64>, arg5: bool) {
        if (arg0.liquidity_share == 0) {
            if (arg5) {
                rebase_if_empty(arg0, arg1);
            };
            return
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_view(arg0.fee_a_growth, arg0.fee_b_growth, &arg0.rewards_growth);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_count(arg1);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_count(&v0) <= v1, 13906840144349102099);
        *arg2 = *arg2 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::amount(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_a(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_a(&v0)), arg0.liquidity_share, *arg2);
        *arg3 = *arg3 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::amount(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_b(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_b(&v0)), arg0.liquidity_share, *arg3);
        let v2 = 0;
        while (v2 < v1) {
            if (0x1::vector::length<u64>(arg4) <= v2) {
                0x1::vector::push_back<u64>(arg4, 0);
            };
            let v3 = *0x1::vector::borrow<u64>(arg4, v2);
            *0x1::vector::borrow_mut<u64>(arg4, v2) = v3 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::amount(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_reward(arg1, v2), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_reward(&v0, v2)), arg0.liquidity_share, v3);
            v2 = v2 + 1;
        };
        if (arg5) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::write_all_checkpoints(&mut arg0.fee_a_growth, &mut arg0.fee_b_growth, &mut arg0.rewards_growth, arg1);
        };
    }

    public(friend) fun take_amounts_from_close_cert(arg0: &mut ClosePositionCert) : (u64, u64) {
        arg0.amount_a = 0;
        arg0.amount_b = 0;
        (arg0.amount_a, arg0.amount_b)
    }

    public(friend) fun take_fee_from_close_cert(arg0: &mut ClosePositionCert) : (u64, u64) {
        arg0.position_info.fee_owned_a = 0;
        arg0.position_info.fee_owned_b = 0;
        (arg0.position_info.fee_owned_a, arg0.position_info.fee_owned_b)
    }

    public(friend) fun take_fee_from_position(arg0: &mut PositionManager, arg1: &Position) : (u64, u64) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(arg1));
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public(friend) fun take_reward_from_close_cert(arg0: &mut ClosePositionCert, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(&arg0.position_info.rewards_owned) <= arg1) {
            return 0
        };
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.position_info.rewards_owned, arg1);
        *v0 = 0;
        *v0
    }

    public(friend) fun take_reward_from_position(arg0: &mut PositionManager, arg1: &Position, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(arg1));
        if (0x1::vector::length<u64>(&v0.rewards_owned) <= arg2) {
            return 0
        };
        let v1 = 0x1::vector::borrow_mut<u64>(&mut v0.rewards_owned, arg2);
        *v1 = 0;
        *v1
    }

    public(friend) fun update_fee(arg0: &mut PositionInfo, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin) {
        let v0 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, bin_idx_on_position_info(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836364778012693);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_is_extended_raw(&v0.rewards_growth);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg1);
        let v3 = &mut arg0.fee_owned_a;
        let v4 = &mut arg0.fee_owned_b;
        update_fee_per_bin(v0, &v2, v3, v4);
        emit_checkpoint_expanded(arg0.id, v0, v1);
    }

    fun update_fee_per_bin(arg0: &mut BinStat, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView, arg2: &mut u64, arg3: &mut u64) {
        if (rebase_if_empty(arg0, arg1)) {
            return
        };
        let v0 = checked_checkpoint(arg0, arg1);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_a(arg1);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_fee_b(arg1);
        *arg2 = *arg2 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::amount(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_a(&v0)), arg0.liquidity_share, *arg2);
        *arg3 = *arg3 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::amount(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(v2, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_fee_b(&v0)), arg0.liquidity_share, *arg3);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::write_fee_checkpoints(&mut arg0.fee_a_growth, &mut arg0.fee_b_growth, &mut arg0.rewards_growth, v1, v2);
    }

    public(friend) fun update_growth(arg0: &mut PositionInfo, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin) {
        let v0 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, bin_idx_on_position_info(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836523691802645);
        if (v0.liquidity_share == 0) {
            return
        };
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_is_extended_raw(&v0.rewards_growth);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg1);
        let v3 = &mut arg0.fee_owned_a;
        let v4 = &mut arg0.fee_owned_b;
        let v5 = &mut arg0.rewards_owned;
        settle_growth(v0, &v2, v3, v4, v5, true);
        emit_checkpoint_expanded(arg0.id, v0, v1);
    }

    fun update_reward_per_bin(arg0: &mut BinStat, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::BinGrowthView, arg2: &mut vector<u64>) {
        if (rebase_if_empty(arg0, arg1)) {
            return
        };
        let v0 = checked_checkpoint(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_count(arg1)) {
            if (0x1::vector::length<u64>(arg2) <= v1) {
                0x1::vector::push_back<u64>(arg2, 0);
            };
            let v2 = *0x1::vector::borrow<u64>(arg2, v1);
            *0x1::vector::borrow_mut<u64>(arg2, v1) = v2 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::amount(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math::growth_delta(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_reward(arg1, v1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_reward(&v0, v1)), arg0.liquidity_share, v2);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::write_reward_checkpoint(arg0.fee_a_growth, arg0.fee_b_growth, &mut arg0.rewards_growth, v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::bin_reward(arg1, v1));
            v1 = v1 + 1;
        };
    }

    public(friend) fun update_rewards(arg0: &mut PositionInfo, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin) {
        let v0 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, bin_idx_on_position_info(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836459267293205);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec::checkpoint_is_extended_raw(&v0.rewards_growth);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::growth_view(arg1);
        let v3 = &mut arg0.rewards_owned;
        update_reward_per_bin(v0, &v2, v3);
        emit_checkpoint_expanded(arg0.id, v0, v1);
    }

    public fun upper_bin_id(arg0: &Position) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.upper_bin_id
    }

    public fun upper_bin_id_on_position_info(arg0: &PositionInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x1::vector::borrow<BinStat>(&arg0.stats, 0x1::vector::length<BinStat>(&arg0.stats) - 1).bin_id
    }

    public fun uri(arg0: &Position) : 0x1::string::String {
        arg0.uri
    }

    public(friend) fun validate_removal_payout(arg0: &PositionInfo, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg2: u128, arg3: u64, arg4: u64) {
        let v0 = 0x1::vector::borrow<BinStat>(&arg0.stats, bin_idx_on_position_info(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906839564528648213);
        assert_zero_payout_exit(v0.liquidity_share, arg2, arg3, arg4);
    }

    public fun width(arg0: &Position) : u16 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0.upper_bin_id, arg0.lower_bin_id), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u16)
    }

    public fun width_on_position_info(arg0: &PositionInfo) : u64 {
        0x1::vector::length<BinStat>(&arg0.stats)
    }

    // decompiled from Move bytecode v7
}

