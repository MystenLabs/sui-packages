module 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct PositionManager has store {
        bin_step: u16,
        position_index: u64,
        positions: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
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
    }

    struct PositionInfo has store {
        id: 0x2::object::ID,
        fee_owned_a: u64,
        fee_owned_b: u64,
        rewards_owned: vector<u64>,
        stats: vector<BinStat>,
    }

    struct BinStat has store {
        bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_share: u128,
        fee_a_growth: u128,
        fee_b_growth: u128,
        rewards_growth: vector<u128>,
    }

    struct OpenPositionArg {
        bin_stats: vector<BinStat>,
        liquidity_shares: vector<u128>,
    }

    struct ClosePositionCert {
        position_info: PositionInfo,
        amount_a: u64,
        amount_b: u64,
    }

    public fun push_back(arg0: &mut OpenPositionArg, arg1: BinStat) {
        if (0x1::vector::length<BinStat>(&arg0.bin_stats) > 0) {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x1::vector::borrow<BinStat>(&arg0.bin_stats, 0x1::vector::length<BinStat>(&arg0.bin_stats) - 1).bin_id, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), arg1.bin_id), 13906834968912723975);
        };
        assert!(0x1::vector::length<BinStat>(&arg0.bin_stats) <= (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::constants::max_bin_per_position() as u64), 13906834977502789641);
        0x1::vector::push_back<u128>(&mut arg0.liquidity_shares, arg1.liquidity_share);
        0x1::vector::push_back<BinStat>(&mut arg0.bin_stats, arg1);
    }

    public(friend) fun new(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            bin_step       : arg0,
            position_index : 0,
            positions      : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PositionInfo>(arg1),
        }
    }

    public(friend) fun decrease_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin, arg3: u128) {
        let v0 = arg1.lower_bin_id;
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), arg1.upper_bin_id), 13906836029770039309);
        let v1 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), v0)) as u64);
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(arg1));
        let v3 = 0x1::vector::borrow_mut<BinStat>(&mut v2.stats, v1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v3.bin_id, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2)), 13906836051244482567);
        let v4 = &mut v2.fee_owned_a;
        let v5 = &mut v2.fee_owned_b;
        update_fee_per_bin(v3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_a_growth_global(arg2), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_b_growth_global(arg2), v4, v5);
        let v6 = &mut v2.rewards_owned;
        update_reward_per_bin(v3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::rewards_growth_global(arg2), v6);
        *0x1::vector::borrow_mut<u128>(&mut arg1.liquidity_shares, v1) = decrease_liquidity_per_bin(v3, arg3);
    }

    public fun amount_a(arg0: &ClosePositionCert) : u64 {
        arg0.amount_a
    }

    public fun amount_b(arg0: &ClosePositionCert) : u64 {
        arg0.amount_b
    }

    public fun arg_bin_stats(arg0: &OpenPositionArg) : &vector<BinStat> {
        &arg0.bin_stats
    }

    public fun arg_liquidity_shares(arg0: &OpenPositionArg) : &vector<u128> {
        &arg0.liquidity_shares
    }

    public fun bin_id(arg0: &BinStat) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.bin_id
    }

    public fun bin_idx(arg0: &Position, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0.lower_bin_id)) as u64)
    }

    public fun bin_step(arg0: &PositionManager) : u16 {
        arg0.bin_step
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13906837313965916183);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public(friend) fun cert_rewards_owned(arg0: &ClosePositionCert) : &vector<u64> {
        &arg0.position_info.rewards_owned
    }

    public(friend) fun cert_stats(arg0: &ClosePositionCert) : &vector<BinStat> {
        &arg0.position_info.stats
    }

    public(friend) fun close_position(arg0: &mut PositionManager, arg1: Position) : ClosePositionCert {
        let v0 = ClosePositionCert{
            position_info : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(&arg1)),
            amount_a      : 0,
            amount_b      : 0,
        };
        destroy(arg1);
        v0
    }

    public(friend) fun close_position_bin(arg0: &mut ClosePositionCert, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin, arg2: BinStat) : (u64, u64) {
        let v0 = &mut arg2;
        let v1 = &mut arg0.position_info.fee_owned_a;
        let v2 = &mut arg0.position_info.fee_owned_b;
        update_fee_per_bin(v0, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_a_growth_global(arg1), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_b_growth_global(arg1), v1, v2);
        let v3 = &mut arg2;
        let v4 = &mut arg0.position_info.rewards_owned;
        update_reward_per_bin(v3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::rewards_growth_global(arg1), v4);
        let BinStat {
            bin_id          : _,
            liquidity_share : v6,
            fee_a_growth    : _,
            fee_b_growth    : _,
            rewards_growth  : _,
        } = arg2;
        let (v10, v11) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::decrease_liquidity(arg1, v6);
        arg0.amount_a = arg0.amount_a + v10;
        arg0.amount_b = arg0.amount_b + v11;
        (v10, v11)
    }

    fun decrease_liquidity_per_bin(arg0: &mut BinStat, arg1: u128) : u128 {
        assert!(arg0.liquidity_share >= arg1, 13906838615339696131);
        arg0.liquidity_share = arg0.liquidity_share - arg1;
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
            position_info : v0,
            amount_a      : v1,
            amount_b      : v2,
        } = arg0;
        let PositionInfo {
            id            : _,
            fee_owned_a   : v4,
            fee_owned_b   : v5,
            rewards_owned : v6,
            stats         : v7,
        } = v0;
        let v8 = v7;
        assert!(0x1::vector::length<BinStat>(&v8) == 0, 13906836991843237909);
        0x1::vector::destroy_empty<BinStat>(v8);
        assert!(v1 + v4 == 0, 13906837000432779279);
        assert!(v2 + v5 == 0, 13906837004727877649);
        let v9 = v6;
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v9)) {
            assert!(0x1::vector::pop_back<u64>(&mut v9) == 0, 13906837013317943315);
            v10 = v10 + 1;
        };
        0x1::vector::destroy_empty<u64>(v9);
    }

    public fun fee_a_growth(arg0: &BinStat) : u128 {
        arg0.fee_a_growth
    }

    public fun fee_b_growth(arg0: &BinStat) : u128 {
        arg0.fee_b_growth
    }

    public(friend) fun increase_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin, arg3: u128) {
        let v0 = arg1.lower_bin_id;
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), arg1.upper_bin_id), 13906835845086445581);
        let v1 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), v0)) as u64);
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(arg1));
        let v3 = 0x1::vector::borrow_mut<BinStat>(&mut v2.stats, v1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v3.bin_id, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2)), 13906835866560888839);
        let v4 = &mut v2.fee_owned_a;
        let v5 = &mut v2.fee_owned_b;
        update_fee_per_bin(v3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_a_growth_global(arg2), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_b_growth_global(arg2), v4, v5);
        let v6 = &mut v2.rewards_owned;
        update_reward_per_bin(v3, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::rewards_growth_global(arg2), v6);
        *0x1::vector::borrow_mut<u128>(&mut arg1.liquidity_shares, v1) = increase_liquidity_per_bin(v3, arg3);
    }

    fun increase_liquidity_per_bin(arg0: &mut BinStat, arg1: u128) : u128 {
        assert!(340282366920938463463374607431768211455 - arg0.liquidity_share >= arg1, 13906838550915055617);
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

    public fun name(arg0: &Position) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new_bin_stat(arg0: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin, arg1: u128) : BinStat {
        BinStat{
            bin_id          : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg0),
            liquidity_share : arg1,
            fee_a_growth    : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_a_growth_global(arg0),
            fee_b_growth    : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_b_growth_global(arg0),
            rewards_growth  : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::rewards_growth_global(arg0),
        }
    }

    public fun new_open_position_arg() : OpenPositionArg {
        OpenPositionArg{
            bin_stats        : 0x1::vector::empty<BinStat>(),
            liquidity_shares : 0x1::vector::empty<u128>(),
        }
    }

    fun new_position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Cetus DLMM LP | Pool");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg1));
        v0
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: OpenPositionArg, arg5: &mut 0x2::tx_context::TxContext) : Position {
        assert!(0x1::vector::length<BinStat>(&arg4.bin_stats) > 0, 13906835613158080523);
        let OpenPositionArg {
            bin_stats        : v0,
            liquidity_shares : v1,
        } = arg4;
        let v2 = v0;
        let v3 = Position{
            id               : 0x2::object::new(arg5),
            pool_id          : arg1,
            index            : arg0.position_index,
            coin_type_a      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_type_b      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            description      : 0x1::string::utf8(b"Cetus DLMM Position"),
            name             : new_position_name(arg2, arg0.position_index),
            uri              : arg3,
            lower_bin_id     : 0x1::vector::borrow<BinStat>(&v2, 0).bin_id,
            upper_bin_id     : 0x1::vector::borrow<BinStat>(&v2, 0x1::vector::length<BinStat>(&v2) - 1).bin_id,
            liquidity_shares : v1,
        };
        let v4 = PositionInfo{
            id            : 0x2::object::id<Position>(&v3),
            fee_owned_a   : 0,
            fee_owned_b   : 0,
            rewards_owned : 0x1::vector::empty<u64>(),
            stats         : v2,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(&v3), v4);
        arg0.position_index = arg0.position_index + 1;
        v3
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

    public fun take_fee_from_position(arg0: &mut PositionManager, arg1: &Position) : (u64, u64) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(arg1));
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public(friend) fun take_reward_from_close_cert(arg0: &mut ClosePositionCert, arg1: u64) : u64 {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.position_info.rewards_owned, arg1);
        *v0 = 0;
        *v0
    }

    public fun take_reward_from_position(arg0: &mut PositionManager, arg1: &Position, arg2: u64) : u64 {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, 0x2::object::id<Position>(arg1));
        if (0x1::vector::length<u64>(&v0.rewards_owned) <= arg2) {
            return 0
        };
        let v1 = 0x1::vector::borrow_mut<u64>(&mut v0.rewards_owned, arg2);
        *v1 = 0;
        *v1
    }

    public(friend) fun update_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut v0.stats, (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), lower_bin_id_on_position_info(v0))) as u64));
        let v2 = &mut v0.fee_owned_a;
        let v3 = &mut v0.fee_owned_b;
        update_fee_per_bin(v1, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_a_growth_global(arg2), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::fee_b_growth_global(arg2), v2, v3);
    }

    fun update_fee_per_bin(arg0: &mut BinStat, arg1: u128, arg2: u128, arg3: &mut u64, arg4: &mut u64) {
        arg0.fee_a_growth = arg1;
        arg0.fee_b_growth = arg2;
        *arg3 = *arg3 + (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_amount_by_growth(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg1, arg0.fee_a_growth), arg0.liquidity_share) as u64);
        *arg4 = *arg4 + (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_amount_by_growth(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg2, arg0.fee_b_growth), arg0.liquidity_share) as u64);
    }

    fun update_reward_per_bin(arg0: &mut BinStat, arg1: vector<u128>, arg2: &mut vector<u64>) {
        if (0x1::vector::is_empty<u128>(&arg1)) {
            return
        };
        let v0 = 0x1::vector::length<u128>(&arg1);
        let v1 = 0x1::vector::length<u128>(&arg0.rewards_growth);
        assert!(v1 <= v0, 13906838705534140421);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u128>(&arg1, v2);
            let v4 = if (v1 > v2) {
                let v5 = 0x1::vector::borrow_mut<u128>(&mut arg0.rewards_growth, (v2 as u64));
                *v5 = v3;
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_amount_by_growth(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(v3, *v5), arg0.liquidity_share)
            } else {
                0x1::vector::push_back<u128>(&mut arg0.rewards_growth, v3);
                0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::dlmm_math::calculate_amount_by_growth(v3, arg0.liquidity_share)
            };
            if (0x1::vector::length<u64>(arg2) <= v2) {
                0x1::vector::push_back<u64>(arg2, (v4 as u64));
            } else {
                let v6 = 0x1::vector::borrow_mut<u64>(arg2, v2);
                *v6 = *v6 + (v4 as u64);
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::Bin) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
        let v1 = 0x1::vector::borrow_mut<BinStat>(&mut v0.stats, (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::id(arg2), lower_bin_id_on_position_info(v0))) as u64));
        let v2 = &mut v0.rewards_owned;
        update_reward_per_bin(v1, 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::bin::rewards_growth_global(arg2), v2);
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
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0.upper_bin_id, arg0.lower_bin_id)) as u16)
    }

    public fun width_on_position_info(arg0: &PositionInfo) : u64 {
        0x1::vector::length<BinStat>(&arg0.stats)
    }

    // decompiled from Move bytecode v6
}

