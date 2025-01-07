module 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::strategy {
    struct StrategyDfKey has copy, drop, store {
        pool_type: 0x1::type_name::TypeName,
    }

    struct Strategy<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        performance_fee_rate: u64,
        total_token_earned: u64,
        total_flx_earned: u64,
        vault: 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::Vault<T0, T1, T2>,
        treasury: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        num_strategies: u64,
        is_paused: bool,
        version: u64,
    }

    struct PendingHarvestDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HarvetReceipt<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        steps: u8,
        token_reward: 0x2::balance::Balance<T2>,
        flx_reward: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
        intermediate_token: 0x2::balance::Balance<T0>,
        underlying_token: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
    }

    struct Harvest has copy, drop {
        strategy_id: 0x2::object::ID,
        token_earned: u64,
        flx_earned: u64,
        sender: address,
    }

    struct Deposit has copy, drop {
        strategy_id: 0x2::object::ID,
        before_balance: u64,
        before_supply: u64,
        after_balance: u64,
        after_supply: u64,
        amount: u64,
        sender: address,
    }

    struct Withdraw has copy, drop {
        strategy_id: 0x2::object::ID,
        before_balance: u64,
        before_supply: u64,
        after_balance: u64,
        after_supply: u64,
        amount: u64,
        sender: address,
    }

    struct PanicWithdraw has copy, drop {
        strategy_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct Compound has copy, drop {
        strategy_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    public fun add_liquidity_on_flowx<T0: drop, T1: drop, T2: drop>(arg0: &mut HarvetReceipt<T0, T1, T2>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.steps == 3, 3);
        if (0x2::balance::value<T0>(&arg0.intermediate_token) > 0) {
            let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg1);
            let v2 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.intermediate_token), arg2);
            let v3 = zap_x_in_direct<T0, T1>(v0, v1, v2, arg2);
            assert!(0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&v3) > 0, 2);
            0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_token, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(v3));
        };
        next_step<T0, T1, T2>(arg0);
    }

    fun assert_version(arg0: &State) {
        assert!(arg0.version == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut State) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
        assert_version(arg0);
    }

    fun calculate_amount_to_swap(arg0: u128, arg1: u128, arg2: u128) : u64 {
        (((0x2::math::sqrt_u128((20000 - arg2) * arg1 * (20000 - arg2) * arg1 / 100000000 + 4 * (10000 - arg2) * arg0 * arg1 / 10000) - (20000 - arg2) * arg1 / 10000) * 10000 / 2 * (10000 - arg2)) as u64)
    }

    public fun collect_flx_reward_direct<T0: drop>(arg0: &mut HarvetReceipt<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX, T0, 0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        assert!(arg0.steps == 2, 3);
        0x2::balance::join<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.intermediate_token, 0x2::balance::withdraw_all<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.flx_reward));
        next_step<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX, T0, 0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(arg0);
    }

    public fun collect_to_vault<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: &mut HarvetReceipt<T0, T1, T2>) {
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v1 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v0);
        assert!(arg1.steps == 4, 3);
        let v2 = 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg1.underlying_token);
        if (v2 > 0) {
            0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut v1.treasury, 0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg1.underlying_token, 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::u64::mul_div(v2, v1.performance_fee_rate, 10000)));
            0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::deposit<T0, T1, T2>(&mut v1.vault, 0x2::balance::withdraw_all<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg1.underlying_token));
        };
        next_step<T0, T1, T2>(arg1);
    }

    public fun collect_token_reward_direct<T0: drop, T1: drop>(arg0: &mut HarvetReceipt<T0, T1, T0>) {
        assert!(arg0.steps == 1, 3);
        0x2::balance::join<T0>(&mut arg0.intermediate_token, 0x2::balance::withdraw_all<T0>(&mut arg0.token_reward));
        next_step<T0, T1, T0>(arg0);
    }

    fun complate_harvest<T0: drop, T1: drop, T2: drop>(arg0: &mut Strategy<T0, T1, T2>, arg1: HarvetReceipt<T0, T1, T2>) {
        assert!(arg1.steps == 5, 3);
        let v0 = PendingHarvestDfKey{dummy_field: false};
        0x2::dynamic_field::remove<PendingHarvestDfKey, bool>(&mut arg0.id, v0);
        let HarvetReceipt {
            id                 : v1,
            steps              : _,
            token_reward       : v3,
            flx_reward         : v4,
            intermediate_token : v5,
            underlying_token   : v6,
        } = arg1;
        0x2::object::delete(v1);
        0x2::balance::destroy_zero<T2>(v3);
        0x2::balance::destroy_zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v4);
        0x2::balance::destroy_zero<T0>(v5);
        0x2::balance::destroy_zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(v6);
    }

    public entry fun compound<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: HarvetReceipt<T0, T1, T2>, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4);
        assert_version_and_upgrade(arg0);
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v1 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v0);
        complate_harvest<T0, T1, T2>(v1, arg1);
        if (0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::available<T0, T1, T2>(&v1.vault) > 0) {
            compound_<T0, T1, T2>(v1, arg2, arg3, arg4);
        };
    }

    fun compound_<T0: drop, T1: drop, T2: drop>(arg0: &mut Strategy<T0, T1, T2>, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::available<T0, T1, T2>(&arg0.vault);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::increase_position<T0, T1, T2>(arg1, 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::borrow_mut_position<T0, T1, T2>(&mut arg0.vault), 0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::withdraw<T0, T1, T2>(&mut arg0.vault, v0), arg3), arg2, arg3);
        let v1 = Compound{
            strategy_id : 0x2::object::id<Strategy<T0, T1, T2>>(arg0),
            amount      : v0,
            sender      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Compound>(v1);
    }

    public entry fun create_strategy<T0: drop, T1: drop, T2: drop>(arg0: &AdminCap, arg1: &mut State, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        create_strategy_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5);
    }

    fun create_strategy_<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::borrow_pool<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::borrow_pool_registry(arg1), arg2);
        arg0.num_strategies = arg0.num_strategies + 1;
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        0x2::dynamic_field::add<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v0, new_strategy<T0, T1, T2>(arg2, arg3, arg4));
    }

    public entry fun deposit<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: HarvetReceipt<T0, T1, T2>, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4);
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v3 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v2);
        complate_harvest<T0, T1, T2>(v3, arg1);
        let v4 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::balance<T0, T1, T2>(&v3.vault);
        let v5 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::total_supply<T0, T1, T2>(&v3.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>>(0x2::coin::from_balance<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>(0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::mint_proof_coin<T0, T1, T2>(&mut v3.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg2), arg5), arg5), v1);
        compound_<T0, T1, T2>(v3, arg3, arg4, arg5);
        let v6 = Deposit{
            strategy_id    : 0x2::object::id<Strategy<T0, T1, T2>>(v3),
            before_balance : v4,
            before_supply  : v5,
            after_balance  : 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::balance<T0, T1, T2>(&v3.vault),
            after_supply   : 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::total_supply<T0, T1, T2>(&v3.vault),
            amount         : v0,
            sender         : v1,
        };
        0x2::event::emit<Deposit>(v6);
    }

    public fun harvest<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : HarvetReceipt<T0, T1, T2> {
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v1 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v0);
        let v2 = PendingHarvestDfKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<PendingHarvestDfKey>(&v1.id, v2), 7);
        let v3 = PendingHarvestDfKey{dummy_field: false};
        0x2::dynamic_field::add<PendingHarvestDfKey, bool>(&mut v1.id, v3, true);
        let (v4, v5) = 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::harvest_<T0, T1, T2>(arg1, 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::borrow_mut_position<T0, T1, T2>(&mut v1.vault), arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::coin::value<T2>(&v7);
        let v9 = 0x2::coin::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v6);
        v1.total_token_earned = v1.total_token_earned + v8;
        v1.total_flx_earned = v1.total_flx_earned + v9;
        let v10 = HarvetReceipt<T0, T1, T2>{
            id                 : 0x2::object::new(arg3),
            steps              : 0,
            token_reward       : 0x2::coin::into_balance<T2>(v7),
            flx_reward         : 0x2::coin::into_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v6),
            intermediate_token : 0x2::balance::zero<T0>(),
            underlying_token   : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
        };
        let v11 = &mut v10;
        next_step<T0, T1, T2>(v11);
        let v12 = Harvest{
            strategy_id  : 0x2::object::id<Strategy<T0, T1, T2>>(v1),
            token_earned : v8,
            flx_earned   : v9,
            sender       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Harvest>(v12);
        v10
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id             : 0x2::object::new(arg0),
            num_strategies : 0,
            is_paused      : false,
            version        : 1,
        };
        0x2::transfer::share_object<State>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun migrate<T0: drop, T1: drop, T2: drop>(arg0: &AdminCap, arg1: &mut State, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v1 = 0x2::dynamic_field::remove<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg1.id, v0);
        arg1.num_strategies = arg1.num_strategies - 1;
        let v2 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::borrow_mut_position<T0, T1, T2>(&mut v1.vault);
        0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::deposit<T0, T1, T2>(&mut v1.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<T0, T1, T2>(arg2, v2, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v2), arg4, arg5)));
        create_strategy_<T0, T1, T2>(arg1, arg2, arg3, 0, arg5);
        let v3 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v4 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg1.id, v3);
        v4.total_token_earned = v1.total_token_earned;
        v4.total_flx_earned = v1.total_flx_earned;
        v4.performance_fee_rate = v1.performance_fee_rate;
        0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::migrate<T0, T1, T2>(&mut v1.vault, &mut v4.vault, arg5);
        if (0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::available<T0, T1, T2>(&v4.vault) > 0) {
            compound_<T0, T1, T2>(v4, arg2, arg4, arg5);
        };
        0x2::transfer::transfer<Strategy<T0, T1, T2>>(v1, @0x0);
    }

    fun new_strategy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Strategy<T0, T1, T2> {
        Strategy<T0, T1, T2>{
            id                   : 0x2::object::new(arg2),
            performance_fee_rate : arg1,
            total_token_earned   : 0,
            total_flx_earned     : 0,
            vault                : 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::new<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::new(arg0, arg2), arg2),
            treasury             : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
        }
    }

    fun next_step<T0: drop, T1: drop, T2: drop>(arg0: &mut HarvetReceipt<T0, T1, T2>) {
        arg0.steps = arg0.steps + 1;
    }

    public entry fun panic_withdraw<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: 0x2::coin::Coin<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>, arg2: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_paused, 5);
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v2 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v1);
        let v3 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::borrow_mut_position<T0, T1, T2>(&mut v2.vault);
        0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::deposit<T0, T1, T2>(&mut v2.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<T0, T1, T2>(arg2, v3, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v3), arg3, arg4)));
        let v4 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::redeem_underlying_coin<T0, T1, T2>(&mut v2.vault, 0x2::coin::into_balance<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>(arg1), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(v4, arg4), v0);
        let v5 = PanicWithdraw{
            strategy_id : 0x2::object::id<Strategy<T0, T1, T2>>(v2),
            amount      : 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&v4),
            sender      : v0,
        };
        0x2::event::emit<PanicWithdraw>(v5);
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut State) {
        assert!(!arg1.is_paused, 4);
        arg1.is_paused = true;
    }

    public entry fun set_performance_fee_rate<T0: drop, T1: drop, T2: drop>(arg0: &AdminCap, arg1: &mut State, arg2: u64) {
        assert_version_and_upgrade(arg1);
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg1.id, v0).performance_fee_rate = arg2;
    }

    public fun swap_flx_reward_on_flowx<T0: drop, T1: drop, T2: drop>(arg0: &mut HarvetReceipt<T0, T1, T2>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.steps == 2, 3);
        if (0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg0.flx_reward) > 0) {
            let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX, T0>(arg1, 0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::withdraw_all<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.flx_reward), arg2), arg2);
            assert!(0x2::coin::value<T0>(&v0) > 0, 1);
            0x2::balance::join<T0>(&mut arg0.intermediate_token, 0x2::coin::into_balance<T0>(v0));
        };
        next_step<T0, T1, T2>(arg0);
    }

    public fun swap_token_reward_on_flowx<T0: drop, T1: drop, T2: drop>(arg0: &mut HarvetReceipt<T0, T1, T2>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.steps == 1, 3);
        if (0x2::balance::value<T2>(&arg0.token_reward) > 0) {
            let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T2, T0>(arg1, 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg0.token_reward), arg2), arg2);
            assert!(0x2::coin::value<T0>(&v0) > 0, 1);
            0x2::balance::join<T0>(&mut arg0.intermediate_token, 0x2::coin::into_balance<T0>(v0));
        };
        next_step<T0, T1, T2>(arg0);
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut State) {
        assert!(arg1.is_paused, 5);
        arg1.is_paused = false;
    }

    public entry fun upgrade(arg0: &AdminCap, arg1: &mut State) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    public entry fun withdraw<T0: drop, T1: drop, T2: drop>(arg0: &mut State, arg1: HarvetReceipt<T0, T1, T2>, arg2: 0x2::coin::Coin<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4);
        assert_version_and_upgrade(arg0);
        assert!(0x2::coin::value<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>(&arg2) > 0, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        let v2 = 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg0.id, v1);
        complate_harvest<T0, T1, T2>(v2, arg1);
        let v3 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::balance<T0, T1, T2>(&v2.vault);
        let v4 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::total_supply<T0, T1, T2>(&v2.vault);
        let v5 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::borrow_mut_position<T0, T1, T2>(&mut v2.vault);
        0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::deposit<T0, T1, T2>(&mut v2.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<T0, T1, T2>(arg3, v5, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v5), arg4, arg5)));
        let v6 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::redeem_underlying_coin<T0, T1, T2>(&mut v2.vault, 0x2::coin::into_balance<0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::ProofCoin<T0, T1, T2>>(arg2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(v6, arg5), v0);
        if (0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::available<T0, T1, T2>(&v2.vault) > 0) {
            compound_<T0, T1, T2>(v2, arg3, arg4, arg5);
        };
        let v7 = Withdraw{
            strategy_id    : 0x2::object::id<Strategy<T0, T1, T2>>(v2),
            before_balance : v3,
            before_supply  : v4,
            after_balance  : 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::balance<T0, T1, T2>(&v2.vault),
            after_supply   : 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault::total_supply<T0, T1, T2>(&v2.vault),
            amount         : 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&v6),
            sender         : v0,
        };
        0x2::event::emit<Withdraw>(v7);
    }

    public entry fun withdraw_fee<T0: drop, T1: drop, T2: drop>(arg0: &AdminCap, arg1: &mut State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        let v0 = StrategyDfKey{pool_type: 0x1::type_name::get<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::Pool<T0, T1, T2>>()};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<StrategyDfKey, Strategy<T0, T1, T2>>(&mut arg1.id, v0).treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun zap_x_in_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        assert!(v0 >= 1000 && v1 >= 1000, 6);
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg2, calculate_amount_to_swap((0x2::coin::value<T0>(&arg2) as u128), (v0 as u128), (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0) as u128)), arg3), arg3);
        assert!(0x2::coin::value<T1>(&v2) >= 1, 6);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::add_liquidity_direct<T0, T1>(arg0, arg1, arg2, v2, 1, 1, arg3)
    }

    // decompiled from Move bytecode v6
}

