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
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2)), 13906836150029582356);
        let v2 = &mut arg0.fee_owned_a;
        let v3 = &mut arg0.fee_owned_b;
        update_fee_per_bin(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_a_growth_global(arg2), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_b_growth_global(arg2), v2, v3);
        let v4 = &mut arg0.rewards_owned;
        update_reward_per_bin(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::rewards_growth_global(arg2), v4);
        *0x1::vector::borrow_mut<u128>(&mut arg1.liquidity_shares, v0) = decrease_liquidity_per_bin(v1, arg3);
    }

    public(friend) fun add_liquidity(arg0: &mut PositionInfo, arg1: &mut Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg3: u128) {
        let v0 = bin_idx(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2));
        assert!(0x1::vector::length<BinStat>(&arg0.stats) == v0, 13906835845086904340);
        0x1::vector::push_back<BinStat>(&mut arg0.stats, new_bin_stat(arg2, 0));
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, v0);
        0x1::vector::push_back<u128>(&mut arg1.liquidity_shares, increase_liquidity_per_bin(v1, arg3));
    }

    public fun amount_a(arg0: &ClosePositionCert) : u64 {
        arg0.amount_a
    }

    public fun amount_b(arg0: &ClosePositionCert) : u64 {
        arg0.amount_b
    }

    public(friend) fun assert_no_pending_add(arg0: &Position) {
        assert!(arg0.flash_count == 0, 13906837601729314848);
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
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906835278151876638);
        0x2::table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1)
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906837700513431582);
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

    public(friend) fun clear_pending_add(arg0: &mut Position) {
        assert!(arg0.flash_count > 0, 13906837550189838370);
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
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg2.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836661130690580);
        let v0 = &mut arg2;
        let v1 = &mut arg0.position_info.fee_owned_a;
        let v2 = &mut arg0.position_info.fee_owned_b;
        update_fee_per_bin(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_a_growth_global(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_b_growth_global(arg1), v1, v2);
        let v3 = &mut arg2;
        let v4 = &mut arg0.position_info.rewards_owned;
        update_reward_per_bin(v3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::rewards_growth_global(arg1), v4);
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
        assert!(arg0.liquidity_share >= arg1, 13906839147916492816);
        arg0.liquidity_share = arg0.liquidity_share - arg1;
        if (arg0.liquidity_share == 0) {
            arg0.fee_a_growth = 0;
            arg0.fee_b_growth = 0;
            arg0.rewards_growth = 0x1::vector::empty<u128>();
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
        assert!(0x1::vector::length<BinStat>(&v9) == 0, 13906837232361865244);
        0x1::vector::destroy_empty<BinStat>(v9);
        assert!(v2 + v5 == 0, 13906837240951406614);
        assert!(v3 + v6 == 0, 13906837245246504984);
        let v10 = v7;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v10)) {
            assert!(0x1::vector::pop_back<u64>(&mut v10) == 0, 13906837253836570650);
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<u64>(v10);
    }

    public(friend) fun extract_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906835346871353374);
        0x2::table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1)
    }

    public fun fee_a_growth(arg0: &BinStat) : u128 {
        arg0.fee_a_growth
    }

    public fun fee_b_growth(arg0: &BinStat) : u128 {
        arg0.fee_b_growth
    }

    public(friend) fun increase_liquidity(arg0: &mut PositionInfo, arg1: &mut Position, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg3: u128) {
        let v0 = bin_idx(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2));
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg2)), 13906835973935923220);
        let v2 = &mut arg0.fee_owned_a;
        let v3 = &mut arg0.fee_owned_b;
        update_fee_per_bin(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_a_growth_global(arg2), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_b_growth_global(arg2), v2, v3);
        let v4 = &mut arg0.rewards_owned;
        update_reward_per_bin(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::rewards_growth_global(arg2), v4);
        *0x1::vector::borrow_mut<u128>(&mut arg1.liquidity_shares, v0) = increase_liquidity_per_bin(v1, arg3);
    }

    fun increase_liquidity_per_bin(arg0: &mut BinStat, arg1: u128) : u128 {
        assert!(340282366920938463463374607431768211455 - arg0.liquidity_share >= arg1, 13906839083491852302);
        arg0.liquidity_share = arg0.liquidity_share + arg1;
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
        BinStat{
            bin_id          : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg0),
            liquidity_share : arg1,
            fee_a_growth    : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_a_growth_global(arg0),
            fee_b_growth    : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_b_growth_global(arg0),
            rewards_growth  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::rewards_growth_global(arg0),
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
            liquidity_shares : 0x1::vector::empty<u128>(),
            flash_count      : 0,
        };
        let v1 = PositionInfo{
            id            : 0x2::object::id<Position>(&v0),
            fee_owned_a   : 0,
            fee_owned_b   : 0,
            rewards_owned : 0x1::vector::empty<u64>(),
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

    public(friend) fun restore_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: PositionInfo) {
        assert!(!0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906835424181157924);
        0x2::table::add<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1, arg2);
    }

    public fun rewards_growth(arg0: &BinStat) : vector<u128> {
        arg0.rewards_growth
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
        assert!(0x1::vector::length<u64>(&arg0.position_info.rewards_owned) > arg1, 13906836940303433746);
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
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836270288666644);
        if (liquidity_share(v0) == 0) {
            return
        };
        let v1 = &mut arg0.fee_owned_a;
        let v2 = &mut arg0.fee_owned_b;
        update_fee_per_bin(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_a_growth_global(arg1), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::fee_b_growth_global(arg1), v1, v2);
    }

    fun update_fee_per_bin(arg0: &mut BinStat, arg1: u128, arg2: u128, arg3: &mut u64, arg4: &mut u64) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_by_growth(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg1, arg0.fee_a_growth), arg0.liquidity_share);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_by_growth(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg2, arg0.fee_b_growth), arg0.liquidity_share);
        arg0.fee_a_growth = arg1;
        arg0.fee_b_growth = arg2;
        assert!(18446744073709551615 - *arg3 >= v0, 13906839500105252902);
        assert!(18446744073709551615 - *arg4 >= v1, 13906839504400220198);
        *arg3 = *arg3 + v0;
        *arg4 = *arg4 + v1;
    }

    fun update_reward_per_bin(arg0: &mut BinStat, arg1: vector<u128>, arg2: &mut vector<u64>) {
        if (0x1::vector::is_empty<u128>(&arg1)) {
            return
        };
        let v0 = 0x1::vector::length<u128>(&arg1);
        let v1 = 0x1::vector::length<u128>(&arg0.rewards_growth);
        assert!(v1 <= v0, 13906839259585773586);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u128>(&arg1, v2);
            let v4 = if (v1 > v2) {
                let v5 = 0x1::vector::borrow_mut<u128>(&mut arg0.rewards_growth, (v2 as u64));
                *v5 = v3;
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_by_growth(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(v3, *v5), arg0.liquidity_share)
            } else {
                0x1::vector::push_back<u128>(&mut arg0.rewards_growth, v3);
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_by_growth(v3, arg0.liquidity_share)
            };
            if (0x1::vector::length<u64>(arg2) <= v2) {
                0x1::vector::push_back<u64>(arg2, v4);
            } else {
                let v6 = 0x1::vector::borrow_mut<u64>(arg2, v2);
                assert!(18446744073709551615 - *v6 >= v4, 13906839362666430504);
                *v6 = *v6 + v4;
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_rewards(arg0: &mut PositionInfo, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin) {
        let v0 = 0x1::vector::borrow_mut<BinStat>(&mut arg0.stats, bin_idx_on_position_info(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0.bin_id, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg1)), 13906836369072914452);
        if (liquidity_share(v0) == 0) {
            return
        };
        let v1 = &mut arg0.rewards_owned;
        update_reward_per_bin(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::rewards_growth_global(arg1), v1);
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

    public fun width(arg0: &Position) : u16 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0.upper_bin_id, arg0.lower_bin_id), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u16)
    }

    public fun width_on_position_info(arg0: &PositionInfo) : u64 {
        0x1::vector::length<BinStat>(&arg0.stats)
    }

    // decompiled from Move bytecode v6
}

