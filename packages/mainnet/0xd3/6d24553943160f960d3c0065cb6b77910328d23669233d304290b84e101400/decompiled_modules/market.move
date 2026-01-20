module 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        position_holder: 0x2::object_bag::ObjectBag,
        num_positions: u64,
        fees: 0x2::bag::Bag,
        open_fee_rate: u64,
        close_fee_rate: u64,
        permissions: u32,
    }

    struct Markets has store, key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, MarketSimpleInfo>,
        index: u64,
    }

    struct MarketSimpleInfo has copy, drop, store {
        market_id: 0x2::object::ID,
        market_key: 0x2::object::ID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
    }

    struct CreateMarketEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_key: 0x2::object::ID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        position_holder_id: 0x2::object::ID,
        open_fee_rate: u64,
        close_fee_rate: u64,
        permissions: u32,
    }

    struct InitEvent has copy, drop {
        markets_id: 0x2::object::ID,
    }

    struct MarketUpdatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        open_fee_rate: u64,
        close_fee_rate: u64,
    }

    struct UpdateMarketOpenPositionPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct UpdateMarketClosePositionPausePermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct UpdateMarketDepositPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct UpdateMarketBorrowPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct UpdateMarketWithdrawPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct UpdateMarketRepayPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct UpdateMarketClaimRewardPermissionEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_pause: bool,
        sender: address,
    }

    struct FeeCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_open: bool,
        fee_amount: u64,
        fee_coin_type: 0x1::type_name::TypeName,
    }

    struct ClaimFeeEvent has copy, drop {
        market_id: 0x2::object::ID,
        recipient: address,
        base_fee_amount: u64,
        quote_fee_amount: u64,
    }

    public fun permissions(arg0: &Market) : u32 {
        arg0.permissions
    }

    public(friend) fun add_position_into_position_holder<T0>(arg0: &mut Market, arg1: 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0>) {
        let v0 = 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::create_position_df_key(0x2::object::id<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0>>(&arg1));
        if (0x2::object_bag::contains<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey>(&arg0.position_holder, v0)) {
            abort 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_position_already_exists()
        };
        0x2::object_bag::add<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0>>(&mut arg0.position_holder, v0, arg1);
        arg0.num_positions = arg0.num_positions + 1;
    }

    public fun base_token(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.base_token
    }

    public(friend) fun borrow_mut_position<T0>(arg0: &mut Market, arg1: 0x2::object::ID) : &mut 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0> {
        let v0 = 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::create_position_df_key(arg1);
        if (!0x2::object_bag::contains<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey>(&arg0.position_holder, v0)) {
            abort 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_position_not_found()
        };
        0x2::object_bag::borrow_mut<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0>>(&mut arg0.position_holder, v0)
    }

    public(friend) fun borrow_position<T0>(arg0: &Market, arg1: 0x2::object::ID) : &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0> {
        let v0 = 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::create_position_df_key(arg1);
        if (!0x2::object_bag::contains<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey>(&arg0.position_holder, v0)) {
            abort 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_position_not_found()
        };
        0x2::object_bag::borrow<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0>>(&arg0.position_holder, v0)
    }

    public(friend) fun check_borrow_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::borrow_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public(friend) fun check_claim_reward_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::claim_reward_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public(friend) fun check_close_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::close_position_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public(friend) fun check_deposit_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::deposit_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public(friend) fun check_open_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::open_position_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public(friend) fun check_repay_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::repay_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public(friend) fun check_withdraw_permission(arg0: &Market) {
        assert!(0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg0.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::withdraw_permission()), 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_market_permission());
    }

    public fun claim_fees<T0, T1>(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fees, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v0)
        } else {
            0x2::balance::zero<T0>()
        };
        let v3 = v2;
        let v4 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fees, v1)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.fees, v1)
        } else {
            0x2::balance::zero<T1>()
        };
        let v5 = v4;
        let v6 = ClaimFeeEvent{
            market_id        : 0x2::object::id<Market>(arg1),
            recipient        : 0x2::tx_context::sender(arg3),
            base_fee_amount  : 0x2::balance::value<T0>(&v3),
            quote_fee_amount : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<ClaimFeeEvent>(v6);
        (0x2::coin::from_balance<T0>(v3, arg3), 0x2::coin::from_balance<T1>(v5, arg3))
    }

    public fun close_fee_rate(arg0: &Market) : u64 {
        arg0.close_fee_rate
    }

    public fun create_market<T0, T1>(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::config::GlobalConfig, arg2: &mut Markets, arg3: u64, arg4: u64, arg5: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg5);
        assert!(arg3 <= 100000, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_fee_rate());
        assert!(arg4 <= 100000, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_fee_rate());
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = new_market_key(v2, v3);
        if (0x2::table::contains<0x2::object::ID, MarketSimpleInfo>(&arg2.list, v4)) {
            abort 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_market_already_exists()
        };
        let v5 = 0x2::object_bag::new(arg6);
        let v6 = Market{
            id              : v0,
            base_token      : v2,
            quote_token     : v3,
            position_holder : v5,
            num_positions   : 0,
            fees            : 0x2::bag::new(arg6),
            open_fee_rate   : arg3,
            close_fee_rate  : arg4,
            permissions     : 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::config::permissions(arg1),
        };
        let v7 = MarketSimpleInfo{
            market_id   : v1,
            market_key  : v4,
            base_token  : v2,
            quote_token : v3,
        };
        0x2::table::add<0x2::object::ID, MarketSimpleInfo>(&mut arg2.list, v4, v7);
        arg2.index = arg2.index + 1;
        let v8 = CreateMarketEvent{
            market_id          : v1,
            market_key         : v4,
            base_token         : v2,
            quote_token        : v3,
            position_holder_id : 0x2::object::id<0x2::object_bag::ObjectBag>(&v5),
            open_fee_rate      : arg3,
            close_fee_rate     : arg4,
            permissions        : v6.permissions,
        };
        0x2::event::emit<CreateMarketEvent>(v8);
        0x2::transfer::share_object<Market>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Markets{
            id    : 0x2::object::new(arg0),
            list  : 0x2::table::new<0x2::object::ID, MarketSimpleInfo>(arg0),
            index : 0,
        };
        let v1 = InitEvent{markets_id: 0x2::object::id<Markets>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<Markets>(v0);
    }

    public(friend) fun join_fee<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0), arg1);
        };
        let v1 = FeeCollectedEvent{
            market_id     : 0x2::object::id<Market>(arg0),
            is_open       : arg2,
            fee_amount    : 0x2::balance::value<T0>(&arg1),
            fee_coin_type : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    public fun market_id(arg0: &Market) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun new_market_key(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : 0x2::object::ID {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg1));
        assert!(v0 != v1, 10001);
        0x1::vector::append<u8>(&mut v0, v1);
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun num_positions(arg0: &Market) : u64 {
        arg0.num_positions
    }

    public fun open_fee_rate(arg0: &Market) : u64 {
        arg0.open_fee_rate
    }

    public fun quote_token(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.quote_token
    }

    public(friend) fun remove_position_from_position_holder<T0>(arg0: &mut Market, arg1: 0x2::object::ID) : 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0> {
        let v0 = 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::create_position_df_key(arg1);
        if (!0x2::object_bag::contains<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey>(&arg0.position_holder, v0)) {
            abort 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_position_not_found()
        };
        arg0.num_positions = arg0.num_positions - 1;
        0x2::object_bag::remove<0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::PositionDfKey, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::position::Position<T0>>(&mut arg0.position_holder, v0)
    }

    public fun set_fee_rate(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: u64, arg3: u64, arg4: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg4);
        assert!(arg2 <= 100000, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_fee_rate());
        assert!(arg3 <= 100000, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::errors::err_invalid_fee_rate());
        if (arg1.open_fee_rate == arg2 && arg1.close_fee_rate == arg3) {
            return
        };
        arg1.open_fee_rate = arg2;
        arg1.close_fee_rate = arg3;
        let v0 = MarketUpdatedEvent{
            market_id      : 0x2::object::id<Market>(arg1),
            open_fee_rate  : arg2,
            close_fee_rate : arg3,
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun update_market_borrow_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::borrow_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::borrow_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::borrow_permission());
        };
        let v0 = UpdateMarketBorrowPermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketBorrowPermissionEvent>(v0);
    }

    public fun update_market_claim_reward_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::claim_reward_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::claim_reward_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::claim_reward_permission());
        };
        let v0 = UpdateMarketClaimRewardPermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketClaimRewardPermissionEvent>(v0);
    }

    public fun update_market_close_position_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::close_position_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::close_position_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::close_position_permission());
        };
        let v0 = UpdateMarketClosePositionPausePermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketClosePositionPausePermissionEvent>(v0);
    }

    public fun update_market_deposit_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::deposit_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::deposit_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::deposit_permission());
        };
        let v0 = UpdateMarketDepositPermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketDepositPermissionEvent>(v0);
    }

    public fun update_market_open_position_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::open_position_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::open_position_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::open_position_permission());
        };
        let v0 = UpdateMarketOpenPositionPermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketOpenPositionPermissionEvent>(v0);
    }

    public fun update_market_repay_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::repay_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::repay_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::repay_permission());
        };
        let v0 = UpdateMarketRepayPermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketRepayPermissionEvent>(v0);
    }

    public fun update_market_withdraw_permission(arg0: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::admin_cap::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::versioned::check_version(arg3);
        if (!arg2 == 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::check_permission(arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::withdraw_permission())) {
            return
        };
        if (!arg2) {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::set_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::withdraw_permission());
        } else {
            0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::unset_permission(&mut arg1.permissions, 0xd36d24553943160f960d3c0065cb6b77910328d23669233d304290b84e101400::permissions::withdraw_permission());
        };
        let v0 = UpdateMarketWithdrawPermissionEvent{
            market_id : 0x2::object::id<Market>(arg1),
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpdateMarketWithdrawPermissionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

