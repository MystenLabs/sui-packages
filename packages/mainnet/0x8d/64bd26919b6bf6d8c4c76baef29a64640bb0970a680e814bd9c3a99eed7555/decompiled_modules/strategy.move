module 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::strategy {
    struct Strategy<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        total_underlying_earned: u64,
        vault: 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::Vault<T0, T1, T2>,
        treasury: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
    }

    struct StrategyCreatedEvent has copy, drop, store {
        strategy_id: 0x2::object::ID,
        pool_index: u64,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        reward_token: 0x1::type_name::TypeName,
        sender: address,
    }

    struct HarvestedEvent has copy, drop, store {
        strategy_id: 0x2::object::ID,
        token_earned: u64,
        flx_earned: u64,
        sender: address,
    }

    struct DepositedEvent has copy, drop, store {
        strategy_id: 0x2::object::ID,
        before_balance: u64,
        before_supply: u64,
        after_balance: u64,
        after_supply: u64,
        amount: u64,
        sender: address,
    }

    struct WithdrawnEvent has copy, drop, store {
        strategy_id: 0x2::object::ID,
        before_balance: u64,
        before_supply: u64,
        after_balance: u64,
        after_supply: u64,
        amount: u64,
        sender: address,
    }

    struct ProtocolFeeChangedEvent has copy, drop, store {
        strategy_id: 0x2::object::ID,
        fee_rate: u64,
        sender: address,
    }

    struct WithdrawProtocolFee has copy, drop, store {
        strategy_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct CompoundedEvent has copy, drop, store {
        strategy_id: 0x2::object::ID,
        amount: u64,
        fee_amount: u64,
        sender: address,
    }

    public fun borrow_vault<T0: drop, T1: drop, T2: drop>(arg0: &Strategy<T0, T1, T2>) : &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::Vault<T0, T1, T2> {
        &arg0.vault
    }

    fun calculate_amount_to_swap(arg0: u128, arg1: u128, arg2: u128) : u64 {
        (((0x1::u128::sqrt((20000 - arg2) * arg1 * (20000 - arg2) * arg1 / 100000000 + 4 * (10000 - arg2) * arg0 * arg1 / 10000) - (20000 - arg2) * arg1 / 10000) * 10000 / 2 * (10000 - arg2)) as u64)
    }

    public fun compound<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg1: &mut Strategy<T0, T1, T2>, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_not_pause(arg0);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg0);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_operator(arg0, arg5);
        assert!(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::borrow_position<T0, T1, T2>(borrow_vault<T0, T1, T2>(arg1))) > 0, 2);
        let v0 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::math::mul_div(0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2), arg1.fee_rate, 10000);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg1.treasury, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::coin::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg2, v0, arg5)));
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::deposit_underlying<T0, T1, T2>(&mut arg1.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg2));
        let v1 = compound_internal<T0, T1, T2>(arg1, arg3, arg4, arg5);
        arg1.total_underlying_earned = arg1.total_underlying_earned + v1;
        let v2 = CompoundedEvent{
            strategy_id : 0x2::object::id<Strategy<T0, T1, T2>>(arg1),
            amount      : v1,
            fee_amount  : v0,
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CompoundedEvent>(v2);
    }

    fun compound_internal<T0: drop, T1: drop, T2: drop>(arg0: &mut Strategy<T0, T1, T2>, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::underlying_available<T0, T1, T2>(&arg0.vault);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::increase_position<T0, T1, T2>(arg1, 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::borrow_mut_position<T0, T1, T2>(&mut arg0.vault), 0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::withdraw_underlying<T0, T1, T2>(&mut arg0.vault, v0), arg3), arg2, arg3);
        v0
    }

    public entry fun create_strategy<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg2: &mut 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::strategy_registry::StrategyRegistry, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_not_pause(arg1);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg1);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::strategy_registry::register_strategy<T0, T1, T2>(arg2, create_strategy_internal<T0, T1, T2>(arg3, arg4, arg5, arg6));
    }

    fun create_strategy_internal<T0: drop, T1: drop, T2: drop>(arg0: &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::borrow_pool<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::borrow_pool_registry(arg0), arg1);
        let v0 = Strategy<T0, T1, T2>{
            id                      : 0x2::object::new(arg3),
            fee_rate                : 0,
            total_underlying_earned : 0,
            vault                   : 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::new<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::new(arg1, arg3), arg3),
            treasury                : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
        };
        let v1 = &mut v0;
        set_protocol_fee_internal<T0, T1, T2>(v1, arg2, arg3);
        let v2 = 0x2::object::id<Strategy<T0, T1, T2>>(&v0);
        0x2::transfer::public_share_object<Strategy<T0, T1, T2>>(v0);
        let v3 = StrategyCreatedEvent{
            strategy_id  : v2,
            pool_index   : arg1,
            base_token   : 0x1::type_name::get<T0>(),
            quote_token  : 0x1::type_name::get<T1>(),
            reward_token : 0x1::type_name::get<T2>(),
            sender       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StrategyCreatedEvent>(v3);
        v2
    }

    public entry fun deposit<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg1: &mut Strategy<T0, T1, T2>, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_not_pause(arg0);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg0);
        let v0 = 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2);
        assert!(v0 > 0, 0);
        prepare_compound<T0, T1, T2>(arg1, arg3, arg4, arg5);
        let v1 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::underlying_balance<T0, T1, T2>(&arg1.vault);
        let v2 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::total_supply<T0, T1, T2>(&arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::CCoin<T0, T1, T2>>>(0x2::coin::from_balance<0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::CCoin<T0, T1, T2>>(0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::mint_c_coin<T0, T1, T2>(&mut arg1.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg2), arg5), arg5), 0x2::tx_context::sender(arg5));
        compound_internal<T0, T1, T2>(arg1, arg3, arg4, arg5);
        let v3 = DepositedEvent{
            strategy_id    : 0x2::object::id<Strategy<T0, T1, T2>>(arg1),
            before_balance : v1,
            before_supply  : v2,
            after_balance  : 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::underlying_balance<T0, T1, T2>(&arg1.vault),
            after_supply   : 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::total_supply<T0, T1, T2>(&arg1.vault),
            amount         : v0,
            sender         : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DepositedEvent>(v3);
    }

    public fun fee_rate<T0: drop, T1: drop, T2: drop>(arg0: &Strategy<T0, T1, T2>) : u64 {
        arg0.fee_rate
    }

    fun harvest<T0: drop, T1: drop, T2: drop>(arg0: &mut Strategy<T0, T1, T2>, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        let (v0, v1) = 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::harvest_<T0, T1, T2>(arg1, 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::borrow_mut_position<T0, T1, T2>(&mut arg0.vault), arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = HarvestedEvent{
            strategy_id  : 0x2::object::id<Strategy<T0, T1, T2>>(arg0),
            token_earned : 0x2::coin::value<T2>(&v3),
            flx_earned   : 0x2::coin::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v2),
            sender       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<HarvestedEvent>(v4);
        (v3, v2)
    }

    public entry fun migrate<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg2: &mut Strategy<T0, T1, T2>, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_not_pause(arg1);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg1);
        prepare_compound<T0, T1, T2>(arg2, arg3, arg5, arg6);
        let v0 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::borrow_mut_position<T0, T1, T2>(&mut arg2.vault);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::deposit_underlying<T0, T1, T2>(&mut arg2.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<T0, T1, T2>(arg3, v0, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v0), arg5, arg6)));
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::borrow_pool<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::borrow_pool_registry(arg3), arg4);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::migrate<T0, T1, T2>(&mut arg2.vault, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::new(arg4, arg6));
        compound_internal<T0, T1, T2>(arg2, arg3, arg5, arg6);
    }

    fun prepare_compound<T0: drop, T1: drop, T2: drop>(arg0: &mut Strategy<T0, T1, T2>, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = harvest<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::deposit_pending_rewards<T0, T1, T2>(&mut arg0.vault, 0x2::coin::into_balance<T2>(v0), 0x2::coin::into_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v1));
    }

    public fun protocol_fees<T0: drop, T1: drop, T2: drop>(arg0: &Strategy<T0, T1, T2>) : u64 {
        0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.treasury)
    }

    public entry fun set_protocol_fee<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg2: &mut Strategy<T0, T1, T2>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_pause(arg1);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg1);
        set_protocol_fee_internal<T0, T1, T2>(arg2, arg3, arg4);
    }

    fun set_protocol_fee_internal<T0: drop, T1: drop, T2: drop>(arg0: &mut Strategy<T0, T1, T2>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 < 1000, 1);
        arg0.fee_rate = arg1;
        let v0 = ProtocolFeeChangedEvent{
            strategy_id : 0x2::object::id<Strategy<T0, T1, T2>>(arg0),
            fee_rate    : arg1,
            sender      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProtocolFeeChangedEvent>(v0);
    }

    public fun take_pending_rewards<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg1: &mut Strategy<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_not_pause(arg0);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg0);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_operator(arg0, arg6);
        prepare_compound<T0, T1, T2>(arg1, arg4, arg5, arg6);
        let (v0, v1) = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::withdraw_pending_rewards<T0, T1, T2>(&mut arg1.vault, arg2, arg3);
        (0x2::coin::from_balance<T2>(v0, arg6), 0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v1, arg6))
    }

    public fun total_underlying_earned<T0: drop, T1: drop, T2: drop>(arg0: &Strategy<T0, T1, T2>) : u64 {
        arg0.total_underlying_earned
    }

    public entry fun withdraw<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg1: &mut Strategy<T0, T1, T2>, arg2: 0x2::coin::Coin<0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::CCoin<T0, T1, T2>>, arg3: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_not_pause(arg0);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg0);
        assert!(0x2::coin::value<0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::CCoin<T0, T1, T2>>(&arg2) > 0, 0);
        prepare_compound<T0, T1, T2>(arg1, arg3, arg4, arg5);
        let v0 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::underlying_balance<T0, T1, T2>(&arg1.vault);
        let v1 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::total_supply<T0, T1, T2>(&arg1.vault);
        let v2 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::borrow_mut_position<T0, T1, T2>(&mut arg1.vault);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::deposit_underlying<T0, T1, T2>(&mut arg1.vault, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<T0, T1, T2>(arg3, v2, 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(v2), arg4, arg5)));
        let v3 = 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::redeem_underlying_coin<T0, T1, T2>(&mut arg1.vault, 0x2::coin::into_balance<0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::CCoin<T0, T1, T2>>(arg2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(v3, arg5), 0x2::tx_context::sender(arg5));
        if (0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::underlying_available<T0, T1, T2>(&arg1.vault) > 0) {
            compound_internal<T0, T1, T2>(arg1, arg3, arg4, arg5);
        };
        let v4 = WithdrawnEvent{
            strategy_id    : 0x2::object::id<Strategy<T0, T1, T2>>(arg1),
            before_balance : v0,
            before_supply  : v1,
            after_balance  : 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::underlying_balance<T0, T1, T2>(&arg1.vault),
            after_supply   : 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::vault::total_supply<T0, T1, T2>(&arg1.vault),
            amount         : 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&v3),
            sender         : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<WithdrawnEvent>(v4);
    }

    public entry fun withdraw_protocol_fee<T0: drop, T1: drop, T2: drop>(arg0: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::admin_cap::AdminCap, arg1: &0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::State, arg2: &mut Strategy<T0, T1, T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_pause(arg1);
        0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::state::assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg2.treasury, arg3), arg4), 0x2::tx_context::sender(arg4));
        let v0 = WithdrawProtocolFee{
            strategy_id : 0x2::object::id<Strategy<T0, T1, T2>>(arg2),
            amount      : arg3,
            sender      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawProtocolFee>(v0);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg0);
        let (v2, _) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::add_liquidity_direct<T0, T1>(v0, v1, arg1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(v0, 0x2::coin::split<T0>(&mut arg1, calculate_amount_to_swap((0x2::coin::value<T0>(&arg1) as u128), (v2 as u128), (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0) as u128)), arg2), arg2), 1, 1, arg2)
    }

    // decompiled from Move bytecode v6
}

