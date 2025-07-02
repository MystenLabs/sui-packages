module 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth {
    struct Auth<phantom T0> has store, key {
        id: 0x2::object::UID,
        roles: 0x2::bag::Bag,
        owner_count: u8,
    }

    struct OwnerCap has drop, store {
        dummy_field: bool,
    }

    struct PauserCap has drop, store {
        dummy_field: bool,
    }

    struct SolverCap has drop, store {
        dummy_field: bool,
    }

    struct ClaimerCap has drop, store {
        dummy_field: bool,
    }

    struct UpdateExchangeRateCap has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct AddCapabilityEvent<phantom T0> has copy, drop {
        account: address,
        cap_type: 0x1::type_name::TypeName,
    }

    struct RemoveCapabilityEvent<phantom T0> has copy, drop {
        account: address,
        cap_type: 0x1::type_name::TypeName,
    }

    public(friend) fun add_cap<T0, T1: drop + store>(arg0: &mut Auth<T0>, arg1: address, arg2: T1) {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::add<RoleKey<T1>, T1>(&mut arg0.roles, v0, arg2);
    }

    public fun add_capability<T0, T1: drop + store>(arg0: &mut Auth<T0>, arg1: address, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, OwnerCap>(arg0, 0x2::tx_context::sender(arg3)), 1);
        assert!(!has_cap<T0, T1>(arg0, arg1), 2);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<OwnerCap>()) {
            let v0 = owner_count_mut<T0>(arg0);
            let v1 = *v0 + 1;
            let v2 = owner_count_mut<T0>(arg0);
            *v2 = v1;
        };
        add_cap<T0, T1>(arg0, arg1, arg2);
        let v3 = AddCapabilityEvent<T0>{
            account  : arg1,
            cap_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<AddCapabilityEvent<T0>>(v3);
    }

    public fun has_cap<T0, T1: store>(arg0: &Auth<T0>, arg1: address) : bool {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::contains<RoleKey<T1>>(&arg0.roles, v0)
    }

    public(friend) fun new_auth<T0>(arg0: &mut 0x2::tx_context::TxContext) : Auth<T0> {
        Auth<T0>{
            id          : 0x2::object::new(arg0),
            roles       : 0x2::bag::new(arg0),
            owner_count : 1,
        }
    }

    public fun new_claimer_cap() : ClaimerCap {
        ClaimerCap{dummy_field: false}
    }

    public fun new_owner_cap() : OwnerCap {
        OwnerCap{dummy_field: false}
    }

    public fun new_pauser_cap() : PauserCap {
        PauserCap{dummy_field: false}
    }

    public fun new_solver_cap() : SolverCap {
        SolverCap{dummy_field: false}
    }

    public fun new_update_exchange_rate_cap() : UpdateExchangeRateCap {
        UpdateExchangeRateCap{dummy_field: false}
    }

    public(friend) fun owner_count<T0>(arg0: &Auth<T0>) : &u8 {
        &arg0.owner_count
    }

    public(friend) fun owner_count_mut<T0>(arg0: &mut Auth<T0>) : &mut u8 {
        &mut arg0.owner_count
    }

    public(friend) fun remove_cap<T0, T1: drop + store>(arg0: &mut Auth<T0>, arg1: address) : T1 {
        let v0 = RoleKey<T1>{owner: arg1};
        0x2::bag::remove<RoleKey<T1>, T1>(&mut arg0.roles, v0)
    }

    public fun remove_capability<T0, T1: drop + store>(arg0: &mut Auth<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, OwnerCap>(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(has_cap<T0, T1>(arg0, arg1), 1);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<OwnerCap>()) {
            let v0 = owner_count_mut<T0>(arg0);
            assert!(*v0 > 1, 3);
            let v1 = owner_count_mut<T0>(arg0);
            let v2 = *v1 - 1;
            let v3 = owner_count_mut<T0>(arg0);
            *v3 = v2;
        };
        remove_cap<T0, T1>(arg0, arg1);
        let v4 = RemoveCapabilityEvent<T0>{
            account  : arg1,
            cap_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<RemoveCapabilityEvent<T0>>(v4);
    }

    // decompiled from Move bytecode v6
}

