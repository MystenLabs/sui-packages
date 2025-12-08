module 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply {
    struct Supply has store {
        value: u64,
        outcome_index: u64,
    }

    struct SupplyState has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        supplies: vector<Supply>,
    }

    struct SupplyCap has store, key {
        id: 0x2::object::UID,
        supply_state_id: 0x2::object::ID,
    }

    public fun burn(arg0: &SupplyCap, arg1: &mut SupplyState, arg2: 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share) : u64 {
        assert!(arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        burn_internal(arg1, arg2)
    }

    fun burn_internal(arg0: &mut SupplyState, arg1: 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share) : u64 {
        let (v0, v1, v2) = 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::destroy(arg1);
        assert!(v0 == arg0.market_id, 1);
        assert!(v1 < 0x1::vector::length<Supply>(&arg0.supplies), 0);
        let v3 = 0x1::vector::borrow_mut<Supply>(&mut arg0.supplies, v1);
        assert!(v3.value >= v2, 2);
        v3.value = v3.value - v2;
        v2
    }

    public fun burn_vec(arg0: &SupplyCap, arg1: &mut SupplyState, arg2: vector<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>) {
        assert!(arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>(&arg2)) {
            burn_internal(arg1, 0x1::vector::pop_back<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>(arg2);
    }

    public fun cap_id(arg0: &SupplyCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun create(arg0: &mut 0x2::object::UID, arg1: u64) : (SupplyState, SupplyCap) {
        let v0 = 0x1::vector::empty<Supply>();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = Supply{
                value         : 0,
                outcome_index : v1,
            };
            0x1::vector::push_back<Supply>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = SupplyState{
            id        : 0x2::derived_object::claim<vector<u8>>(arg0, b"SUPPLY_STATE"),
            market_id : 0x2::object::uid_to_inner(arg0),
            supplies  : v0,
        };
        let v4 = SupplyCap{
            id              : 0x2::derived_object::claim<vector<u8>>(&mut v3.id, b"SUPPLY_CAP"),
            supply_state_id : 0x2::object::uid_to_inner(&v3.id),
        };
        (v3, v4)
    }

    public fun id(arg0: &SupplyState) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_state_cap(arg0: &SupplyCap, arg1: &SupplyState) : bool {
        arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id)
    }

    public fun market_id(arg0: &SupplyState) : 0x2::object::ID {
        arg0.market_id
    }

    public fun mint(arg0: &SupplyCap, arg1: &mut SupplyState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share {
        assert!(arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        assert!(arg2 < 0x1::vector::length<Supply>(&arg1.supplies), 0);
        mint_internal(arg1, arg2, arg3, arg4)
    }

    fun mint_internal(arg0: &mut SupplyState, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share {
        let v0 = 0x1::vector::borrow_mut<Supply>(&mut arg0.supplies, arg1);
        assert!(arg2 <= 18446744073709551615 - v0.value, 3);
        v0.value = v0.value + arg2;
        0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::new(arg0.market_id, arg1, arg2, arg3)
    }

    public fun mint_vec(arg0: &SupplyCap, arg1: &mut SupplyState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share> {
        assert!(arg0.supply_state_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        let v0 = 0x1::vector::empty<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Supply>(&arg1.supplies)) {
            0x1::vector::push_back<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>(&mut v0, mint_internal(arg1, v1, arg2, arg3));
            v1 = v1 + 1;
        };
        v0
    }

    public fun num_outcomes(arg0: &SupplyState) : u64 {
        0x1::vector::length<Supply>(&arg0.supplies)
    }

    public fun supply_state_id(arg0: &SupplyCap) : 0x2::object::ID {
        arg0.supply_state_id
    }

    public fun supply_values(arg0: &SupplyState) : vector<u64> {
        let v0 = &arg0.supplies;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Supply>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Supply>(v0, v2).value);
            v2 = v2 + 1;
        };
        v1
    }

    public fun total_supply(arg0: &SupplyState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Supply>(&arg0.supplies), 0);
        0x1::vector::borrow<Supply>(&arg0.supplies, arg1).value
    }

    // decompiled from Move bytecode v6
}

