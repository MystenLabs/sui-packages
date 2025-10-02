module 0xcc33b62e4bc361090070e1dbfa504884e2aaf823cc605e33fddc41572b99eb48::lp_burn {
    struct LP_BURN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<0x2::object::ID, BurnedPositionInfo>,
        supported_version: u64,
        must_have_full_range: bool,
    }

    struct BurnedPositionInfo has copy, drop, store {
        burned_position_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct BluefinLPBurn has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        position: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position,
    }

    struct MustHaveFullRangeUpdated has copy, drop {
        must_have_full_range: bool,
    }

    struct SupportedVersionUpdated has copy, drop {
        previous_version: u64,
        current_version: u64,
    }

    public fun burn<T0, T1>(arg0: &mut Manager, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: &mut 0x2::tx_context::TxContext) : BluefinLPBurn {
        verify_version(arg0);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&arg2), 2);
        if (arg0.must_have_full_range) {
            verify_full_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg2)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg2)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::tick_spacing(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg1)));
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_pool_name<T0, T1>(arg1);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2);
        let v2 = BluefinLPBurn{
            id          : 0x2::object::new(arg3),
            name        : create_name(v0),
            description : create_description(v0),
            image_url   : 0x1::string::utf8(b"https://bluefin.io/images/nfts/default-locked.gif"),
            position    : arg2,
        };
        let v3 = BurnedPositionInfo{
            burned_position_id : 0x2::object::id<BluefinLPBurn>(&v2),
            position_id        : v1,
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1),
        };
        0x2::table::add<0x2::object::ID, BurnedPositionInfo>(&mut arg0.positions, v1, v3);
        0x2::event::emit<BurnedPositionInfo>(v3);
        v2
    }

    entry fun burn_lp<T0, T1>(arg0: &mut Manager, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = burn<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<BluefinLPBurn>(v0, 0x2::tx_context::sender(arg3));
    }

    entry fun claim_fees<T0, T1>(arg0: &Manager, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut BluefinLPBurn, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = collect_fees<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        assert!(v0 > 0 || v1 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg5), 0x2::tx_context::sender(arg5));
    }

    entry fun claim_rewards<T0, T1, T2>(arg0: &Manager, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut BluefinLPBurn, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(collect_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg5), 0x2::tx_context::sender(arg5));
    }

    public fun collect_fees<T0, T1>(arg0: &Manager, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut BluefinLPBurn, arg4: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        verify_version(arg0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg1, arg2, &mut arg3.position)
    }

    public fun collect_rewards<T0, T1, T2>(arg0: &Manager, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut BluefinLPBurn, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        verify_version(arg0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg1, arg2, &mut arg3.position)
    }

    fun create_description(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"This NFT is a proof of this ");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" LP position being locked and burnt on Bluefin. The owner of this NFT can claim rewards and fees but not withdraw funds from the LP position"));
        v0
    }

    fun create_name(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Bluefin LP Burn, ");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    entry fun increment_supported_version(arg0: &mut Manager, arg1: &AdminCap) {
        assert!(arg0.supported_version < 1, 4);
        arg0.supported_version = arg0.supported_version + 1;
        let v0 = SupportedVersionUpdated{
            previous_version : arg0.supported_version,
            current_version  : arg0.supported_version,
        };
        0x2::event::emit<SupportedVersionUpdated>(v0);
    }

    fun init(arg0: LP_BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"pool"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{pool}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://trade.bluefin.io"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Bluefin"));
        let v2 = 0x2::package::claim<LP_BURN>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<BluefinLPBurn>(&v2, v0, v1, arg1);
        0x2::display::update_version<BluefinLPBurn>(&mut v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = Manager{
            id                   : 0x2::object::new(arg1),
            positions            : 0x2::table::new<0x2::object::ID, BurnedPositionInfo>(arg1),
            supported_version    : 1,
            must_have_full_range : true,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BluefinLPBurn>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Manager>(v5);
    }

    entry fun set_must_have_full_range(arg0: &mut Manager, arg1: &AdminCap, arg2: bool) {
        verify_version(arg0);
        assert!(arg2 != arg0.must_have_full_range, 3);
        arg0.must_have_full_range = arg2;
        let v0 = MustHaveFullRangeUpdated{must_have_full_range: arg2};
        0x2::event::emit<MustHaveFullRangeUpdated>(v0);
    }

    public fun verify_full_range(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: u32) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::tick_bound() % arg2);
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::eq(arg0, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()), v0)), 1);
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::eq(arg1, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick()), v0)), 1);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.supported_version == 1, 0);
    }

    // decompiled from Move bytecode v6
}

