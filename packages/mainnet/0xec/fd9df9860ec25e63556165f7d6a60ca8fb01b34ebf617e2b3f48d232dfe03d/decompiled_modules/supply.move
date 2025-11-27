module 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply {
    struct Supply<phantom T0> has store {
        value: u64,
        outcome_index: u64,
    }

    struct SupplyState<phantom T0> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        supplies: vector<Supply<T0>>,
    }

    struct SupplyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply_state_id: 0x2::object::ID,
    }

    struct SupplyStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SupplyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &SupplyCap<T0>, arg1: &mut SupplyState<T0>, arg2: 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::Share<T0>) : u64 {
        assert!(arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        let (v0, v1, v2) = 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::destroy<T0>(arg2);
        assert!(v0 == arg1.market_id, 1);
        assert!(v1 < 0x1::vector::length<Supply<T0>>(&arg1.supplies), 0);
        let v3 = 0x1::vector::borrow_mut<Supply<T0>>(&mut arg1.supplies, v1);
        assert!(v3.value >= v2, 2);
        v3.value = v3.value - v2;
        v2
    }

    public fun cap_id<T0>(arg0: &SupplyCap<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun create<T0: drop>(arg0: T0, arg1: &mut 0x2::object::UID, arg2: u64) : (SupplyState<T0>, SupplyCap<T0>) {
        let v0 = 0x1::vector::empty<Supply<T0>>();
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = Supply<T0>{
                value         : 0,
                outcome_index : v1,
            };
            0x1::vector::push_back<Supply<T0>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = SupplyStateKey{dummy_field: false};
        let v4 = SupplyState<T0>{
            id        : 0x2::derived_object::claim<SupplyStateKey>(arg1, v3),
            market_id : 0x2::object::uid_to_inner(arg1),
            supplies  : v0,
        };
        let v5 = SupplyCapKey{dummy_field: false};
        let v6 = SupplyCap<T0>{
            id              : 0x2::derived_object::claim<SupplyCapKey>(&mut v4.id, v5),
            supply_state_id : 0x2::object::uid_to_inner(&v4.id),
        };
        (v4, v6)
    }

    public fun id<T0>(arg0: &SupplyState<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_state_cap<T0>(arg0: &SupplyCap<T0>, arg1: &SupplyState<T0>) : bool {
        arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id)
    }

    public fun market_id<T0>(arg0: &SupplyState<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun mint<T0>(arg0: &SupplyCap<T0>, arg1: &mut SupplyState<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::Share<T0> {
        assert!(arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        assert!(arg2 < 0x1::vector::length<Supply<T0>>(&arg1.supplies), 0);
        let v0 = 0x1::vector::borrow_mut<Supply<T0>>(&mut arg1.supplies, arg2);
        assert!(arg3 < 18446744073709551615 - v0.value, 3);
        v0.value = v0.value + arg3;
        0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::new<T0>(arg1.market_id, arg2, arg3, arg4)
    }

    public fun num_outcomes<T0>(arg0: &SupplyState<T0>) : u64 {
        0x1::vector::length<Supply<T0>>(&arg0.supplies)
    }

    public fun supply_state_id<T0>(arg0: &SupplyCap<T0>) : 0x2::object::ID {
        arg0.supply_state_id
    }

    public fun supply_values<T0>(arg0: &SupplyState<T0>) : vector<u64> {
        let v0 = &arg0.supplies;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Supply<T0>>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Supply<T0>>(v0, v2).value);
            v2 = v2 + 1;
        };
        v1
    }

    public fun total_supply<T0>(arg0: &SupplyState<T0>, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Supply<T0>>(&arg0.supplies), 0);
        0x1::vector::borrow<Supply<T0>>(&arg0.supplies, arg1).value
    }

    // decompiled from Move bytecode v6
}

