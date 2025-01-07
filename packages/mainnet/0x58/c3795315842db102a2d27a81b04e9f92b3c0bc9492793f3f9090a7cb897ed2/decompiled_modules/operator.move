module 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::operator {
    struct VersionDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CustodianDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeCollectorDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Earned has copy, drop {
        amount: u64,
        sender: address,
    }

    fun assert_in_emergency(arg0: &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool) {
        assert!(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::is_emergency(arg0), 1);
    }

    fun assert_not_emergency(arg0: &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool) {
        assert!(!0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::is_emergency(arg0), 0);
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::uid_mut(arg0), v0);
        if (*v1 < 1) {
            *v1 = 1;
        };
        assert_version(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::uid_mut(arg0));
    }

    public fun borrow_staked_token_custodian<T0>(arg0: &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64) : &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::Custodian<T0> {
        let v0 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<CustodianDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::Custodian<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_pool_registry(arg0), arg1)), v0)
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        create_pool_internal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    fun create_pool_internal<T0>(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mass_update_pool(arg0, arg3);
        let v0 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::create_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::started_at(arg0), 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::ended_at(arg0), arg1, arg3, arg4);
        let v1 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::add<CustodianDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::Custodian<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(&mut v0), v1, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::new<T0>());
        let v2 = FeeCollectorDfKey{dummy_field: false};
        0x2::dynamic_field::add<FeeCollectorDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::FeeCollector<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(&mut v0), v2, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::new<T0>(arg2, arg4));
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::increase_alloc_point(arg0, arg1);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::register(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry(arg0), v0);
    }

    fun decrease_for<T0>(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::decrease(arg1, arg2, arg3);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::decrease_staked_amount(arg0, arg2);
        let v0 = CustodianDfKey{dummy_field: false};
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::withdraw<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::Custodian<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(arg0), v0), arg2, arg3)
    }

    public entry fun decrease_position<T0>(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64, arg2: u64, arg3: &mut 0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::TreasuryManagement, arg4: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let (v0, v1, v2) = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry_and_position_registry_and_psh_minter(arg0);
        let v3 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(v0, arg1);
        assert_not_emergency(v3);
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry::borrow_mut_position(v1, arg1, v4);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::update_pool(v3, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::total_alloc_point(arg0), 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::reward_per_sec(arg0), arg5);
        if (0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::value(v5) > 0) {
            let v6 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::calc_pending_rewards(v3, v5);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::mint(arg3, arg4, v2, v6, arg6), v4);
            };
        };
        if (arg2 > 0) {
            let v7 = decrease_for<T0>(v3, v5, arg2, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v4);
        };
        recalc_reward_debts(v3, v5);
    }

    public entry fun decrease_position_emergency<T0>(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let (v0, v1, _) = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry_and_position_registry_and_psh_minter(arg0);
        let v3 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(v0, arg1);
        assert_in_emergency(v3);
        let v4 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry::borrow_mut_position(v1, arg1, 0x2::tx_context::sender(arg2));
        let v5 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::value(v4);
        if (v5 > 0) {
            let v6 = decrease_for<T0>(v3, v4, v5, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg2));
        };
    }

    fun increase_for<T0>(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::increase(arg1, v0, arg3);
        let v1 = CustodianDfKey{dummy_field: false};
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::deposit<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::Custodian<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(arg0), v1), arg2);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::increase_staked_amount(arg0, v0);
    }

    public entry fun increase_position<T0>(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::TreasuryManagement, arg4: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2, v3) = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry_and_position_registry_and_psh_minter(arg0);
        let v4 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(v1, arg1);
        assert_not_emergency(v4);
        if (!0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry::is_registerd(v2, arg1, v0)) {
            0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry::register(v2, arg1, v0, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::new(arg1, arg6));
        };
        let v5 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position_registry::borrow_mut_position(v2, arg1, v0);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::update_pool(v4, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::total_alloc_point(arg0), 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::reward_per_sec(arg0), arg5);
        if (0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::value(v5) > 0) {
            let v6 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::calc_pending_rewards(v4, v5);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::mint(arg3, arg4, v3, v6, arg6), v0);
                let v7 = Earned{
                    amount : v6,
                    sender : v0,
                };
                0x2::event::emit<Earned>(v7);
            };
        };
        let v8 = 0x2::coin::value<T0>(&arg2);
        if (v8 > 0) {
            let v9 = FeeCollectorDfKey{dummy_field: false};
            let v10 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::fee_amount<T0>(0x2::dynamic_field::borrow<FeeCollectorDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::FeeCollector<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid(v4), v9), v8);
            if (v10 > 0) {
                let v11 = FeeCollectorDfKey{dummy_field: false};
                0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::deposit<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::FeeCollector<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(v4), v11), 0x2::coin::split<T0>(&mut arg2, v10, arg6));
            };
            increase_for<T0>(v4, v5, arg2, arg6);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        recalc_reward_debts(v4, v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mass_update_pool(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::num_pools(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_pool_registry(arg0))) {
            0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::update_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry(arg0), v0), 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::total_alloc_point(arg0), 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::reward_per_sec(arg0), arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun migrate(arg0: &mut AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::uid_mut(arg1), v0);
        assert!(*v1 < 1, 1000);
        *v1 = 1;
    }

    fun recalc_reward_debts(arg0: &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::Position) {
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::position::change_reward_debt(arg1, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::calc_rewards_for(arg0, arg1));
    }

    public entry fun set_alloc_point(arg0: &AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version_and_upgrade(arg1);
        set_alloc_point_interanl(arg1, arg2, arg3, arg4);
    }

    fun set_alloc_point_interanl(arg0: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg0, arg3);
        let v0 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry(arg0), arg1);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::set_alloc_point(v0, arg2);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::decrease_alloc_point(arg0, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::alloc_point(v0));
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::increase_alloc_point(arg0, arg2);
    }

    public entry fun set_fee_rate<T0>(arg0: &AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg2: u64, arg3: u64) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::change_fee<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::FeeCollector<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3);
    }

    public entry fun set_reward_per_sec(arg0: &mut AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg1, arg3);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::set_reward_per_sec(arg1, arg2);
    }

    public entry fun setup(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::utils::to_seconds(0x2::clock::timestamp_ms(arg4)) && arg2 > arg1, 2);
        let v0 = 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::new(arg5, arg1, arg2);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::set_reward_per_sec(&mut v0, arg3);
        let v1 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::uid_mut(&mut v0), v1, 1);
        0x2::transfer::public_share_object<0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State>(v0);
    }

    public entry fun stop_reward(arg0: &AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State) {
        let v0 = 0;
        while (v0 < 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::num_pools(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_pool_registry(arg1))) {
            0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::set_emergency(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry(arg1), v0));
            v0 = v0 + 1;
        };
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::set_reward_per_sec(arg1, 0);
    }

    public entry fun withdraw_fee<T0>(arg0: &AdminCap, arg1: &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector::FeeCollector<T0>>(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::uid_mut(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry::borrow_mut_pool(0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

