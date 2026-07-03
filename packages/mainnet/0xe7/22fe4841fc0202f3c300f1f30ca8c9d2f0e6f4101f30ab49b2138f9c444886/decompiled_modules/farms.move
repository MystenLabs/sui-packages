module 0x517fb485d39a4845bed030ebba5257ef33498b2af97d97ecd59d67d83138974b::farms {
    struct FARMS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardInfo has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        acc_reward_per_share: u256,
        last_update_ms: u64,
        emissions_per_second: u64,
        total_staked_liquidity: u128,
    }

    struct RewardBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_info_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FarmPosition has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        reward_info_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        liquidity: u128,
        reward_debt: u256,
        last_update_ms: u64,
    }

    struct RewardRange has copy, drop, store {
        tick_lower: u32,
        tick_upper: u32,
    }

    struct RewardRangeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardAdded has copy, drop {
        info_id: 0x2::object::ID,
        balance_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        emissions_per_second: u64,
    }

    struct EmissionsChanged has copy, drop {
        info_id: 0x2::object::ID,
        emissions_per_second: u64,
    }

    struct Topup has copy, drop {
        balance_id: 0x2::object::ID,
        amount: u64,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
    }

    struct HarvestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
    }

    struct RewardRangeSet has copy, drop {
        info_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct RewardRangeCleared has copy, drop {
        info_id: 0x2::object::ID,
    }

    public fun add_reward<T0>(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = RewardInfo{
            id                     : 0x2::object::new(arg5),
            pool_id                : arg1,
            reward_coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            acc_reward_per_share   : 0,
            last_update_ms         : 0x2::clock::timestamp_ms(arg4),
            emissions_per_second   : arg2,
            total_staked_liquidity : 0,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = RewardBalance<T0>{
            id             : v0,
            reward_info_id : v2,
            balance        : 0x2::coin::into_balance<T0>(arg3),
        };
        0x2::transfer::share_object<RewardInfo>(v1);
        0x2::transfer::share_object<RewardBalance<T0>>(v3);
        let v4 = RewardAdded{
            info_id              : v2,
            balance_id           : 0x2::object::uid_to_inner(&v0),
            pool_id              : arg1,
            reward_coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            emissions_per_second : arg2,
        };
        0x2::event::emit<RewardAdded>(v4);
    }

    fun advance_accumulator(arg0: &mut RewardInfo, arg1: u64) {
        if (arg1 <= arg0.last_update_ms) {
            return
        };
        let v0 = (arg0.total_staked_liquidity as u256);
        if (v0 == 0 || arg0.emissions_per_second == 0) {
            arg0.last_update_ms = arg1;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + ((arg1 - arg0.last_update_ms) as u256) * (arg0.emissions_per_second as u256) * 340282366920938463463374607431768211456 / 1000 / v0;
        arg0.last_update_ms = arg1;
    }

    public fun clear_reward_range(arg0: &AdminCap, arg1: &mut RewardInfo) {
        let v0 = RewardRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RewardRangeKey, RewardRange>(&arg1.id, v0)) {
            let v1 = RewardRangeKey{dummy_field: false};
            0x2::dynamic_field::remove<RewardRangeKey, RewardRange>(&mut arg1.id, v1);
            let v2 = RewardRangeCleared{info_id: 0x2::object::uid_to_inner(&arg1.id)};
            0x2::event::emit<RewardRangeCleared>(v2);
        };
    }

    public fun deposit<T0, T1>(arg0: &mut RewardInfo, arg1: &0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : FarmPosition {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::position_pool_id<T0, T1>(arg1) != arg0.pool_id) {
            abort 2
        };
        let v1 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::position_liquidity<T0, T1>(arg1);
        if (v1 == 0) {
            abort 0
        };
        let v2 = RewardRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RewardRangeKey, RewardRange>(&arg0.id, v2)) {
            let v3 = RewardRangeKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow<RewardRangeKey, RewardRange>(&arg0.id, v3);
            let (v5, v6) = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::position_ticks<T0, T1>(arg1);
            if (0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::i32_lt(v5, v4.tick_lower)) {
                abort 6
            };
            if (0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::i32_lt(v4.tick_upper, v6)) {
                abort 6
            };
        };
        let v7 = 0x2::object::id<0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>>(arg1);
        if (0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg0.id, v7)) {
            abort 4
        };
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg0.id, v7, true);
        advance_accumulator(arg0, v0);
        arg0.total_staked_liquidity = arg0.total_staked_liquidity + v1;
        let v8 = FarmPosition{
            id               : 0x2::object::new(arg3),
            pool_id          : arg0.pool_id,
            reward_info_id   : 0x2::object::uid_to_inner(&arg0.id),
            clmm_position_id : v7,
            liquidity        : v1,
            reward_debt      : arg0.acc_reward_per_share,
            last_update_ms   : v0,
        };
        let v9 = DepositEvent{
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::uid_to_inner(&v8.id),
            liquidity   : v1,
        };
        0x2::event::emit<DepositEvent>(v9);
        v8
    }

    public fun deposit_and_transfer<T0, T1>(arg0: &mut RewardInfo, arg1: &0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<FarmPosition>(deposit<T0, T1>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun discard(arg0: &mut RewardInfo, arg1: FarmPosition, arg2: &0x2::clock::Clock) {
        if (arg1.pool_id != arg0.pool_id) {
            abort 2
        };
        if (arg1.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        advance_accumulator(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = arg1.liquidity;
        let v1 = if (arg0.total_staked_liquidity >= v0) {
            arg0.total_staked_liquidity - v0
        } else {
            0
        };
        arg0.total_staked_liquidity = v1;
        if (0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg0.id, arg1.clmm_position_id)) {
            0x2::dynamic_field::remove<0x2::object::ID, bool>(&mut arg0.id, arg1.clmm_position_id);
        };
        let v2 = WithdrawEvent{
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::uid_to_inner(&arg1.id),
            liquidity   : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        let FarmPosition {
            id               : v3,
            pool_id          : _,
            reward_info_id   : _,
            clmm_position_id : _,
            liquidity        : _,
            reward_debt      : _,
            last_update_ms   : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    public fun harvest<T0>(arg0: &mut RewardInfo, arg1: &mut RewardBalance<T0>, arg2: &mut FarmPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 8
    }

    public fun harvest_v2<T0, T1, T2>(arg0: &mut RewardInfo, arg1: &mut RewardBalance<T2>, arg2: &mut FarmPosition, arg3: &0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2.liquidity == 0) {
            abort 0
        };
        if (arg2.pool_id != arg0.pool_id) {
            abort 2
        };
        if (arg2.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        if (arg1.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        if (0x2::object::id<0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>>(arg3) != arg2.clmm_position_id) {
            abort 5
        };
        advance_accumulator(arg0, v0);
        let v1 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::position_liquidity<T0, T1>(arg3);
        let v2 = if (v1 < arg2.liquidity) {
            v1
        } else {
            arg2.liquidity
        };
        let v3 = settle_position<T2>(arg0, arg1, arg2, v2, v0, arg5);
        if (v1 < arg2.liquidity) {
            let v4 = arg2.liquidity - v1;
            let v5 = if (arg0.total_staked_liquidity >= v4) {
                arg0.total_staked_liquidity - v4
            } else {
                0
            };
            arg0.total_staked_liquidity = v5;
            arg2.liquidity = v1;
        };
        v3
    }

    public fun has_reward_range(arg0: &RewardInfo) : bool {
        let v0 = RewardRangeKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RewardRangeKey, RewardRange>(&arg0.id, v0)
    }

    public fun info_acc(arg0: &RewardInfo) : u256 {
        arg0.acc_reward_per_share
    }

    public fun info_eps(arg0: &RewardInfo) : u64 {
        arg0.emissions_per_second
    }

    public fun info_pool_id(arg0: &RewardInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun info_total_staked(arg0: &RewardInfo) : u128 {
        arg0.total_staked_liquidity
    }

    fun init(arg0: FARMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<FARMS>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"5375695377617020c2b7204661726d732041646d696e"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"41646d696e206361706162696c69747920666f72207468652053756953776170206661726d73206d6f64756c6520e2809420636f6e74726f6c73207065722d706f6f6c2072657761726420656d697373696f6e732e"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swap.epinio.playunknown.com/icon.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swap.epinio.playunknown.com"));
        let v6 = 0x2::display::new_with_fields<AdminCap>(&v1, v2, v4, arg1);
        0x2::display::update_version<AdminCap>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AdminCap>>(v6, v0);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v0);
    }

    public fun pos_clmm_position_id(arg0: &FarmPosition) : 0x2::object::ID {
        arg0.clmm_position_id
    }

    public fun pos_liquidity(arg0: &FarmPosition) : u128 {
        arg0.liquidity
    }

    public fun range_tick_lower(arg0: &RewardRange) : u32 {
        arg0.tick_lower
    }

    public fun range_tick_upper(arg0: &RewardRange) : u32 {
        arg0.tick_upper
    }

    public fun reward_range(arg0: &RewardInfo) : 0x1::option::Option<RewardRange> {
        let v0 = RewardRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RewardRangeKey, RewardRange>(&arg0.id, v0)) {
            let v2 = RewardRangeKey{dummy_field: false};
            0x1::option::some<RewardRange>(*0x2::dynamic_field::borrow<RewardRangeKey, RewardRange>(&arg0.id, v2))
        } else {
            0x1::option::none<RewardRange>()
        }
    }

    public fun set_emissions_per_second(arg0: &AdminCap, arg1: &mut RewardInfo, arg2: u64, arg3: &0x2::clock::Clock) {
        advance_accumulator(arg1, 0x2::clock::timestamp_ms(arg3));
        arg1.emissions_per_second = arg2;
        let v0 = EmissionsChanged{
            info_id              : 0x2::object::uid_to_inner(&arg1.id),
            emissions_per_second : arg2,
        };
        0x2::event::emit<EmissionsChanged>(v0);
    }

    public fun set_reward_range(arg0: &AdminCap, arg1: &mut RewardInfo, arg2: u32, arg3: u32) {
        if (!0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::i32_lt(arg2, arg3)) {
            abort 7
        };
        let v0 = RewardRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RewardRangeKey, RewardRange>(&arg1.id, v0)) {
            let v1 = RewardRangeKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<RewardRangeKey, RewardRange>(&mut arg1.id, v1);
            v2.tick_lower = arg2;
            v2.tick_upper = arg3;
        } else {
            let v3 = RewardRangeKey{dummy_field: false};
            let v4 = RewardRange{
                tick_lower : arg2,
                tick_upper : arg3,
            };
            0x2::dynamic_field::add<RewardRangeKey, RewardRange>(&mut arg1.id, v3, v4);
        };
        let v5 = RewardRangeSet{
            info_id    : 0x2::object::uid_to_inner(&arg1.id),
            tick_lower : arg2,
            tick_upper : arg3,
        };
        0x2::event::emit<RewardRangeSet>(v5);
    }

    fun settle_position<T0>(arg0: &RewardInfo, arg1: &mut RewardBalance<T0>, arg2: &mut FarmPosition, arg3: u128, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg0.acc_reward_per_share > arg2.reward_debt) {
            arg0.acc_reward_per_share - arg2.reward_debt
        } else {
            0
        };
        let v1 = v0 * (arg3 as u256) / 340282366920938463463374607431768211456;
        let v2 = (0x2::balance::value<T0>(&arg1.balance) as u256);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        if (v3 >= v1) {
            arg2.reward_debt = arg0.acc_reward_per_share;
        } else if (arg3 > 0) {
            arg2.reward_debt = arg2.reward_debt + v3 * 340282366920938463463374607431768211456 / (arg3 as u256);
        };
        arg2.last_update_ms = arg4;
        if (v3 > 0) {
            let v5 = (v3 as u64);
            if (0x2::balance::value<T0>(&arg1.balance) < v5) {
                abort 1
            };
            let v6 = HarvestEvent{
                pool_id          : arg0.pool_id,
                position_id      : 0x2::object::uid_to_inner(&arg2.id),
                reward_coin_type : 0x1::type_name::with_defining_ids<T0>(),
                amount           : v5,
            };
            0x2::event::emit<HarvestEvent>(v6);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v5), arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        }
    }

    public fun topup_rewards<T0>(arg0: &mut RewardBalance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Topup{
            balance_id : 0x2::object::uid_to_inner(&arg0.id),
            amount     : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Topup>(v0);
    }

    public fun withdraw<T0>(arg0: &mut RewardInfo, arg1: &mut RewardBalance<T0>, arg2: FarmPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 8
    }

    public fun withdraw_v2<T0, T1, T2>(arg0: &mut RewardInfo, arg1: &mut RewardBalance<T2>, arg2: FarmPosition, arg3: &0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2.pool_id != arg0.pool_id) {
            abort 2
        };
        if (arg2.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        if (arg1.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        if (0x2::object::id<0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::Position<T0, T1>>(arg3) != arg2.clmm_position_id) {
            abort 5
        };
        advance_accumulator(arg0, v0);
        let v1 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool::position_liquidity<T0, T1>(arg3);
        let v2 = arg2.liquidity;
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = &mut arg2;
        let v5 = if (arg0.total_staked_liquidity >= v2) {
            arg0.total_staked_liquidity - v2
        } else {
            0
        };
        arg0.total_staked_liquidity = v5;
        0x2::dynamic_field::remove<0x2::object::ID, bool>(&mut arg0.id, arg2.clmm_position_id);
        let v6 = WithdrawEvent{
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::uid_to_inner(&arg2.id),
            liquidity   : v2,
        };
        0x2::event::emit<WithdrawEvent>(v6);
        let FarmPosition {
            id               : v7,
            pool_id          : _,
            reward_info_id   : _,
            clmm_position_id : _,
            liquidity        : _,
            reward_debt      : _,
            last_update_ms   : _,
        } = arg2;
        0x2::object::delete(v7);
        settle_position<T2>(arg0, arg1, v4, v3, v0, arg5)
    }

    // decompiled from Move bytecode v7
}

