module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth {
    struct AuthState has store {
        roles: 0x2::bag::Bag,
        role_abilities: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        role_count: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        ability_count: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Auth<phantom T0> {
        role: 0x1::type_name::TypeName,
        abilities: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
    }

    struct RoleKey<phantom T0: drop> has copy, drop, store {
        owner: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AuthState {
        AuthState{
            roles          : 0x2::bag::new(arg0),
            role_abilities : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
            role_count     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            ability_count  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    public(friend) fun total_supply<T0>(arg0: &Auth<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public(friend) fun abilities<T0>(arg0: &Auth<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.abilities
    }

    public(friend) fun ability_count<T0: drop>(arg0: &AuthState) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.ability_count, &v0)
    }

    public(friend) fun add_role<T0: drop>(arg0: &mut AuthState, arg1: address) {
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 9223372346092814343);
        let v1 = RoleKey<T0>{owner: arg1};
        0x2::bag::add<RoleKey<T0>, bool>(&mut arg0.roles, v1, false);
        let v2 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.role_count, &v2)) {
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.role_count, &v2);
            *v3 = *v3 + 1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.role_abilities, v2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.role_count, v2, 1);
        };
        let v4 = 0x2::vec_set::keys<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v2));
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(v4)) {
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.ability_count, 0x1::vector::borrow<0x1::type_name::TypeName>(v4, v5));
            *v6 = *v6 + 1;
            v5 = v5 + 1;
        };
    }

    public(friend) fun add_role_ability<T0: drop, T1: drop>(arg0: &mut AuthState) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.role_count, v0, 0);
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.role_abilities, v0, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v0), &v1), 9223372603790458881);
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.role_abilities, &v0), v1);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.ability_count, &v1)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.ability_count, &v1);
            *v2 = *v2 + *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.role_count, &v0);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.ability_count, v1, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.role_count, &v0));
        };
    }

    public(friend) fun auth_destroy<T0>(arg0: Auth<T0>) : (0x2::coin::TreasuryCap<T0>, 0x2::token::TokenPolicyCap<T0>) {
        let Auth {
            role         : _,
            abilities    : _,
            treasury_cap : v2,
            policy_cap   : v3,
        } = arg0;
        (v2, v3)
    }

    public(friend) fun auth_state_destroy(arg0: AuthState) : (0x2::bag::Bag, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>) {
        let AuthState {
            roles          : v0,
            role_abilities : v1,
            role_count     : _,
            ability_count  : _,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun authenticate<T0, T1: drop>(arg0: &AuthState, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::token::TokenPolicyCap<T0>, arg3: &0x2::tx_context::TxContext) : Auth<T0> {
        let v0 = RoleKey<T1>{owner: 0x2::tx_context::sender(arg3)};
        assert!(0x2::bag::contains<RoleKey<T1>>(&arg0.roles, v0), 9223372835718955013);
        let v1 = 0x1::type_name::get<T1>();
        Auth<T0>{
            role         : 0x1::type_name::get<T1>(),
            abilities    : *0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v1),
            treasury_cap : arg1,
            policy_cap   : arg2,
        }
    }

    public(friend) fun has_ability<T0, T1: drop>(arg0: &Auth<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.abilities, &v0)
    }

    public(friend) fun has_role<T0: drop>(arg0: &AuthState, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)
    }

    public(friend) fun owner_has_ability<T0: drop, T1: drop>(arg0: &AuthState, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        if (0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)) {
            let v2 = 0x1::type_name::get<T0>();
            let v3 = 0x1::type_name::get<T1>();
            0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v2), &v3)
        } else {
            false
        }
    }

    public(friend) fun policy_cap<T0>(arg0: &Auth<T0>) : &0x2::token::TokenPolicyCap<T0> {
        &arg0.policy_cap
    }

    public(friend) fun policy_cap_mut<T0>(arg0: &mut Auth<T0>) : &mut 0x2::token::TokenPolicyCap<T0> {
        &mut arg0.policy_cap
    }

    public(friend) fun remove_role<T0: drop>(arg0: &mut AuthState, arg1: address) {
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 9223372470646997001);
        let v1 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, bool>(&mut arg0.roles, v1);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.role_count, &v2);
        *v3 = *v3 - 1;
        let v4 = 0x2::vec_set::keys<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v2));
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(v4)) {
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.ability_count, 0x1::vector::borrow<0x1::type_name::TypeName>(v4, v5));
            *v6 = *v6 - 1;
            v5 = v5 + 1;
        };
    }

    public(friend) fun remove_role_ability<T0: drop, T1: drop>(arg0: &mut AuthState) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v0), 9223372689690329097);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.role_abilities, &v0), &v1), 9223372693984903171);
        0x2::vec_set::remove<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.role_abilities, &v0), &v1);
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.ability_count, &v1);
        *v2 = *v2 - *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.role_count, &v0);
    }

    public(friend) fun role<T0>(arg0: &Auth<T0>) : &0x1::type_name::TypeName {
        &arg0.role
    }

    public(friend) fun role_count<T0: drop>(arg0: &AuthState) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.role_count, &v0)
    }

    public(friend) fun treasury_cap<T0>(arg0: &Auth<T0>) : &0x2::coin::TreasuryCap<T0> {
        &arg0.treasury_cap
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut Auth<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    // decompiled from Move bytecode v6
}

