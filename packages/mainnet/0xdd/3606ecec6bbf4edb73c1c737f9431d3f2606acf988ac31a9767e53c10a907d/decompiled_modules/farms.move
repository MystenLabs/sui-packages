module 0x612a0ae31e0cb8cd9edc735a4f98280f87c8f59a9703daa382ed2f3115004cbb::farms {
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
    }

    struct RewardBalance<T0: store> has store, key {
        id: 0x2::object::UID,
        reward_info_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FarmPosition has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        reward_info_id: 0x2::object::ID,
        liquidity: u128,
        reward_debt: u256,
        last_update_ms: u64,
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

    public fun add_reward<T0: store>(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = RewardInfo{
            id                   : 0x2::object::new(arg5),
            pool_id              : arg1,
            reward_coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            acc_reward_per_share : 0,
            last_update_ms       : arg4,
            emissions_per_second : arg2,
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
        let v0 = 1;
        if (v0 == 0 || arg0.emissions_per_second == 0) {
            arg0.last_update_ms = arg1;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + ((arg1 - arg0.last_update_ms) as u256) * (arg0.emissions_per_second as u256) * 340282366920938463463374607431768211456 / v0;
        arg0.last_update_ms = arg1;
    }

    public fun deposit(arg0: &mut RewardInfo, arg1: u128, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : FarmPosition {
        if (arg1 == 0) {
            abort 0
        };
        let v0 = FarmPosition{
            id             : 0x2::object::new(arg3),
            pool_id        : arg0.pool_id,
            reward_info_id : 0x2::object::uid_to_inner(&arg0.id),
            liquidity      : arg1,
            reward_debt    : arg0.acc_reward_per_share,
            last_update_ms : arg2,
        };
        let v1 = DepositEvent{
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::uid_to_inner(&v0.id),
            liquidity   : arg1,
        };
        0x2::event::emit<DepositEvent>(v1);
        v0
    }

    public fun deposit_and_transfer(arg0: &mut RewardInfo, arg1: u128, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<FarmPosition>(deposit(arg0, arg1, arg2, arg4), arg3);
    }

    public fun harvest<T0: store>(arg0: &mut RewardInfo, arg1: &mut RewardBalance<T0>, arg2: &mut FarmPosition, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2.liquidity == 0) {
            abort 0
        };
        if (arg2.pool_id != arg0.pool_id) {
            abort 2
        };
        if (arg2.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        advance_accumulator(arg0, arg3);
        let v0 = if (arg0.acc_reward_per_share > arg2.reward_debt) {
            arg0.acc_reward_per_share - arg2.reward_debt
        } else {
            0
        };
        let v1 = v0 * (arg2.liquidity as u256) / 340282366920938463463374607431768211456;
        let v2 = (0x2::balance::value<T0>(&arg1.balance) as u256);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg2.reward_debt = arg0.acc_reward_per_share;
        arg2.last_update_ms = arg3;
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
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v5), arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        }
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

    public fun pos_liquidity(arg0: &FarmPosition) : u128 {
        arg0.liquidity
    }

    public fun set_emissions_per_second(arg0: &AdminCap, arg1: &mut RewardInfo, arg2: u64) {
        arg1.emissions_per_second = arg2;
        let v0 = EmissionsChanged{
            info_id              : 0x2::object::uid_to_inner(&arg1.id),
            emissions_per_second : arg2,
        };
        0x2::event::emit<EmissionsChanged>(v0);
    }

    public fun topup_rewards<T0: store>(arg0: &mut RewardBalance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Topup{
            balance_id : 0x2::object::uid_to_inner(&arg0.id),
            amount     : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Topup>(v0);
    }

    public fun withdraw<T0: store>(arg0: &mut RewardInfo, arg1: &mut RewardBalance<T0>, arg2: FarmPosition, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2.pool_id != arg0.pool_id) {
            abort 2
        };
        if (arg2.reward_info_id != 0x2::object::uid_to_inner(&arg0.id)) {
            abort 3
        };
        advance_accumulator(arg0, arg3);
        let v0 = if (arg0.acc_reward_per_share > arg2.reward_debt) {
            arg0.acc_reward_per_share - arg2.reward_debt
        } else {
            0
        };
        let v1 = v0 * (arg2.liquidity as u256) / 340282366920938463463374607431768211456;
        let v2 = (0x2::balance::value<T0>(&arg1.balance) as u256);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        let v4 = if (v3 > 0) {
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
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v5), arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        };
        let v7 = WithdrawEvent{
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::uid_to_inner(&arg2.id),
            liquidity   : arg2.liquidity,
        };
        0x2::event::emit<WithdrawEvent>(v7);
        let FarmPosition {
            id             : v8,
            pool_id        : _,
            reward_info_id : _,
            liquidity      : _,
            reward_debt    : _,
            last_update_ms : _,
        } = arg2;
        0x2::object::delete(v8);
        v4
    }

    // decompiled from Move bytecode v7
}

