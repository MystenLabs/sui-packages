module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action {
    struct Action has copy, drop, store {
        inner: 0x1::string::String,
    }

    struct ADMIN {
        dummy_field: bool,
    }

    struct MANAGER {
        dummy_field: bool,
    }

    struct ANY {
        dummy_field: bool,
    }

    public fun contains<T0>(arg0: &vector<Action>) : bool {
        if (contains_admin(arg0) || contains_manager(arg0)) {
            return true
        };
        if (is_any<T0>() && 0x1::vector::length<Action>(arg0) > 0) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Action>(arg0)) {
            if (0x1::vector::borrow<Action>(arg0, v0).inner == 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<T0>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun add(arg0: &mut vector<Action>, arg1: vector<Action>) {
        let v0 = manager();
        let v1 = admin();
        if (contains_admin(arg0)) {
            return
        };
        if (0x1::vector::contains<Action>(&arg1, &v1)) {
            let v2 = 0x1::vector::empty<Action>();
            0x1::vector::push_back<Action>(&mut v2, v1);
            *arg0 = v2;
            return
        };
        if (0x1::vector::contains<Action>(&arg1, &v0)) {
            let v3 = 0x1::vector::empty<Action>();
            0x1::vector::push_back<Action>(&mut v3, v0);
            *arg0 = v3;
            return
        };
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::merge<Action>(arg0, arg1);
    }

    public(friend) fun add_(arg0: &vector<Action>, arg1: vector<Action>) : vector<Action> {
        let v0 = manager();
        let v1 = admin();
        if (contains_admin(arg0)) {
            return *arg0
        };
        if (0x1::vector::contains<Action>(&arg1, &v1)) {
            let v2 = 0x1::vector::empty<Action>();
            0x1::vector::push_back<Action>(&mut v2, v1);
            return v2
        };
        if (0x1::vector::contains<Action>(&arg1, &v0)) {
            let v3 = 0x1::vector::empty<Action>();
            0x1::vector::push_back<Action>(&mut v3, v0);
            return v3
        };
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::merge_<Action>(arg0, &arg1)
    }

    public(friend) fun admin() : Action {
        Action{inner: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<ADMIN>()}
    }

    public fun contains_admin(arg0: &vector<Action>) : bool {
        let v0 = admin();
        0x1::vector::contains<Action>(arg0, &v0)
    }

    public fun contains_excluding_manager<T0>(arg0: &vector<Action>) : bool {
        if (contains_manager(arg0)) {
            return false
        };
        contains<T0>(arg0)
    }

    public fun contains_manager(arg0: &vector<Action>) : bool {
        let v0 = manager();
        0x1::vector::contains<Action>(arg0, &v0)
    }

    public(friend) fun intersection(arg0: &vector<Action>, arg1: &vector<Action>) : vector<Action> {
        if (contains_admin(arg1)) {
            return *arg0
        };
        if (contains_manager(arg1)) {
            if (contains_admin(arg0)) {
                let v0 = 0x1::vector::empty<Action>();
                0x1::vector::push_back<Action>(&mut v0, manager());
                return v0
            };
            return *arg0
        };
        if (contains_admin(arg0) || contains_manager(arg0)) {
            return *arg1
        };
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::intersection<Action>(arg0, arg1)
    }

    public fun is_admin_action<T0>() : bool {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::is_same_type<T0, ADMIN>()
    }

    public fun is_admin_action_(arg0: &Action) : bool {
        arg0.inner == 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<ADMIN>()
    }

    public fun is_any<T0>() : bool {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<T0>() == 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<ANY>()
    }

    public fun is_any_(arg0: &Action) : bool {
        arg0.inner == 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<ANY>()
    }

    public fun is_manager_action<T0>() : bool {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::is_same_type<T0, MANAGER>()
    }

    public fun is_manager_action_(arg0: &Action) : bool {
        arg0.inner == 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<MANAGER>()
    }

    public(friend) fun manager() : Action {
        Action{inner: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<MANAGER>()}
    }

    public(friend) fun new<T0>() : Action {
        Action{inner: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<T0>()}
    }

    public(friend) fun vec_map_intersection<T0: copy + drop>(arg0: &0x2::vec_map::VecMap<T0, vector<Action>>, arg1: &vector<Action>, arg2: &0x2::vec_map::VecMap<T0, vector<Action>>) : 0x2::vec_map::VecMap<T0, vector<Action>> {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, vector<Action>>();
        while (v0 < 0x2::vec_map::size<T0, vector<Action>>(arg0)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<T0, vector<Action>>(arg0, v0);
            let v4 = 0x2::vec_map::try_get<T0, vector<Action>>(arg2, v2);
            let v5 = if (0x1::option::is_some<vector<Action>>(&v4)) {
                let v6 = add_(arg1, 0x1::option::destroy_some<vector<Action>>(v4));
                intersection(v3, &v6)
            } else {
                intersection(v3, arg1)
            };
            0x2::vec_map::insert<T0, vector<Action>>(&mut v1, *v2, v5);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun vec_map_join<T0: copy + drop>(arg0: &mut 0x2::vec_map::VecMap<T0, vector<Action>>, arg1: 0x2::vec_map::VecMap<T0, vector<Action>>) {
        while (0x2::vec_map::size<T0, vector<Action>>(&arg1) > 0) {
            let (v0, v1) = 0x2::vec_map::pop<T0, vector<Action>>(&mut arg1);
            let v2 = v0;
            let v3 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<T0, vector<Action>>(arg0, &v2, 0x1::vector::empty<Action>());
            add(v3, v1);
        };
    }

    // decompiled from Move bytecode v6
}

