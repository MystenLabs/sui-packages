module 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::operator {
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

    fun assert_in_emergency(arg0: &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::Pool) {
        assert!(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::is_emergency(arg0), 1);
    }

    fun assert_not_emergency(arg0: &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::Pool) {
        assert!(!0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::is_emergency(arg0), 0);
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::uid_mut(arg0), v0);
        if (*v1 < 1) {
            *v1 = 1;
        };
        assert_version(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::uid_mut(arg0));
    }

    public fun borrow_staked_token_custodian<T0>(arg0: &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: u64) : &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::Custodian<T0> {
        let v0 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<CustodianDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::Custodian<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_pool_registry(arg0), arg1)), v0)
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        create_pool_internal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    fun create_pool_internal<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mass_update_pool(arg0, arg3);
        let v0 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::create_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::started_at(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::ended_at(arg0), arg1, arg3, arg4);
        let v1 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::add<CustodianDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::Custodian<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(&mut v0), v1, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::new<T0>());
        let v2 = FeeCollectorDfKey{dummy_field: false};
        0x2::dynamic_field::add<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(&mut v0), v2, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::new<T0>(arg2, arg4));
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::increase_alloc_point(arg0, arg1);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::register(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg0), v0);
    }

    fun decrease_for<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::Pool, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::decrease(arg1, arg2, arg3);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::decrease_staked_amount(arg0, arg2);
        let v0 = CustodianDfKey{dummy_field: false};
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::withdraw<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::Custodian<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(arg0), v0), arg2, arg3)
    }

    public entry fun decrease_position<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: u64, arg3: &mut 0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::TreasuryManagement, arg4: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = decrease_position_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x1::option::destroy_some<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(v0), 0x2::tx_context::sender(arg6));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(v0);
        };
    }

    public fun decrease_position_<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: u64, arg3: &mut 0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::TreasuryManagement, arg4: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>> {
        assert_version_and_upgrade(arg0);
        let (v0, v1) = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry_and_psh_minter(arg0);
        let v2 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(v0, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::pool_idx(arg1));
        assert_not_emergency(v2);
        let v3 = 0x2::tx_context::sender(arg6);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::update_pool(v2, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::total_alloc_point(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::reward_per_sec(arg0), arg5);
        let v4 = if (0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::value(arg1) > 0) {
            let v5 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::calc_pending_rewards(v2, arg1);
            if (v5 > 0) {
                let v6 = Earned{
                    amount : v5,
                    sender : v3,
                };
                0x2::event::emit<Earned>(v6);
                0x1::option::some<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::mint(arg3, arg4, v1, v5, arg6))
            } else {
                0x1::option::none<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>()
            }
        } else {
            0x1::option::none<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>()
        };
        if (arg2 > 0) {
            let v7 = decrease_for<T0>(v2, arg1, arg2, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v3);
        };
        recalc_reward_debts(v2, arg1);
        v4
    }

    public entry fun decrease_position_emergency<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::pool_idx(arg1));
        assert_in_emergency(v0);
        let v1 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::value(arg1);
        if (v1 > 0) {
            let v2 = decrease_for<T0>(v0, arg1, v1, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        };
    }

    fun increase_for<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::Pool, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::increase(arg1, v0, arg3);
        let v1 = CustodianDfKey{dummy_field: false};
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::deposit<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian::Custodian<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(arg0), v1), arg2);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::increase_staked_amount(arg0, v0);
    }

    public entry fun increase_position<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::TreasuryManagement, arg4: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = increase_position_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x1::option::destroy_some<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(v0), 0x2::tx_context::sender(arg6));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(v0);
        };
    }

    public fun increase_position_<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::TreasuryManagement, arg4: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>> {
        assert_version_and_upgrade(arg0);
        let (v0, v1) = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry_and_psh_minter(arg0);
        let v2 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(v0, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::pool_idx(arg1));
        assert_not_emergency(v2);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::update_pool(v2, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::total_alloc_point(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::reward_per_sec(arg0), arg5);
        let v3 = if (0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::value(arg1) > 0) {
            let v4 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::calc_pending_rewards(v2, arg1);
            if (v4 > 0) {
                let v5 = Earned{
                    amount : v4,
                    sender : 0x2::tx_context::sender(arg6),
                };
                0x2::event::emit<Earned>(v5);
                0x1::option::some<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::mint(arg3, arg4, v1, v4, arg6))
            } else {
                0x1::option::none<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>()
            }
        } else {
            0x1::option::none<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>()
        };
        let v6 = 0x2::coin::value<T0>(&arg2);
        if (v6 > 0) {
            let v7 = FeeCollectorDfKey{dummy_field: false};
            let v8 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::fee_amount<T0>(0x2::dynamic_field::borrow<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid(v2), v7), v6);
            if (v8 > 0) {
                let v9 = FeeCollectorDfKey{dummy_field: false};
                0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::deposit<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(v2), v9), 0x2::coin::split<T0>(&mut arg2, v8, arg6));
            };
            increase_for<T0>(v2, arg1, arg2, arg6);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        recalc_reward_debts(v2, arg1);
        v3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mass_update_pool(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::num_pools(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_pool_registry(arg0))) {
            0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::update_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg0), v0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::total_alloc_point(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::reward_per_sec(arg0), arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun migrate(arg0: &mut AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::uid_mut(arg1), v0);
        assert!(*v1 < 1, 1000);
        *v1 = 1;
    }

    public entry fun open_position<T0>(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg0), arg1);
        assert_not_emergency(v0);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::update_pool(v0, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::total_alloc_point(arg0), 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::reward_per_sec(arg0), arg3);
        let v1 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::new(arg1, arg4);
        let v2 = 0x2::coin::value<T0>(&arg2);
        if (v2 > 0) {
            let v3 = FeeCollectorDfKey{dummy_field: false};
            let v4 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::fee_amount<T0>(0x2::dynamic_field::borrow<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid(v0), v3), v2);
            if (v4 > 0) {
                let v5 = FeeCollectorDfKey{dummy_field: false};
                0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::deposit<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(v0), v5), 0x2::coin::split<T0>(&mut arg2, v4, arg4));
            };
            let v6 = &mut v1;
            increase_for<T0>(v0, v6, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        let v7 = &mut v1;
        recalc_reward_debts(v0, v7);
        0x2::transfer::public_transfer<0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position>(v1, 0x2::tx_context::sender(arg4));
    }

    fun recalc_reward_debts(arg0: &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::Pool, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::Position) {
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::position::change_reward_debt(arg1, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::calc_rewards_for(arg0, arg1));
    }

    public entry fun set_alloc_point(arg0: &AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version_and_upgrade(arg1);
        set_alloc_point_interanl(arg1, arg2, arg3, arg4);
    }

    fun set_alloc_point_interanl(arg0: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg0, arg3);
        let v0 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg0), arg1);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::set_alloc_point(v0, arg2);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::decrease_alloc_point(arg0, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::alloc_point(v0));
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::increase_alloc_point(arg0, arg2);
    }

    public entry fun set_fee_rate<T0>(arg0: &AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg2: u64, arg3: u64) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::change_fee<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3);
    }

    public entry fun set_reward_per_sec(arg0: &mut AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg1, arg3);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::set_reward_per_sec(arg1, arg2);
    }

    public entry fun setup(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::utils::to_seconds(0x2::clock::timestamp_ms(arg4)) && arg2 > arg1, 2);
        let v0 = 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::new(arg5, arg1, arg2);
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::set_reward_per_sec(&mut v0, arg3);
        let v1 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::uid_mut(&mut v0), v1, 1);
        0x2::transfer::public_share_object<0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State>(v0);
    }

    public entry fun stop_reward(arg0: &AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State) {
        let v0 = 0;
        while (v0 < 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::num_pools(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_pool_registry(arg1))) {
            0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::set_emergency(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg1), v0));
            v0 = v0 + 1;
        };
        0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::set_reward_per_sec(arg1, 0);
    }

    public entry fun withdraw_fee<T0>(arg0: &AdminCap, arg1: &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::fee_collector::FeeCollector<T0>>(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool::uid_mut(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::borrow_mut_pool(0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

