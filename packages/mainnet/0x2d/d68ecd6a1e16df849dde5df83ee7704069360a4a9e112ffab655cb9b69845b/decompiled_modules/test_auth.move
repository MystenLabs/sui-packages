module 0x2dd68ecd6a1e16df849dde5df83ee7704069360a4a9e112ffab655cb9b69845b::test_auth {
    struct Auth has store {
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

    struct UpdateExchangeRateCap has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    public(friend) fun add_cap<T0: drop + store>(arg0: &mut Auth, arg1: address, arg2: T0) {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::add<RoleKey<T0>, T0>(&mut arg0.roles, v0, arg2);
    }

    public fun has_cap<T0: store>(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)
    }

    public fun new_auth(arg0: &mut 0x2::tx_context::TxContext) : Auth {
        Auth{
            roles       : 0x2::bag::new(arg0),
            owner_count : 1,
        }
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

    public(friend) fun owner_count(arg0: &Auth) : &u8 {
        &arg0.owner_count
    }

    public(friend) fun owner_count_mut(arg0: &mut Auth) : &mut u8 {
        &mut arg0.owner_count
    }

    public(friend) fun remove_cap<T0: drop + store>(arg0: &mut Auth, arg1: address) : T0 {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v0)
    }

    // decompiled from Move bytecode v6
}

