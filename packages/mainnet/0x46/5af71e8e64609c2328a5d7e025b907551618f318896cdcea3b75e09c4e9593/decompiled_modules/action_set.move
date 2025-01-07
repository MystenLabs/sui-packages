module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set {
    struct ActionSet has copy, drop, store {
        general: vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>,
        on_types: 0x2::vec_map::VecMap<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>,
        on_objects: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>,
    }

    public(friend) fun empty() : ActionSet {
        ActionSet{
            general    : 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(),
            on_types   : 0x2::vec_map::empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(),
            on_objects : 0x2::vec_map::empty<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(),
        }
    }

    public(friend) fun intersection(arg0: &ActionSet, arg1: &ActionSet) : ActionSet {
        ActionSet{
            general    : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::intersection(&arg0.general, &arg1.general),
            on_types   : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::vec_map_intersection<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg0.on_types, &arg1.general, &arg1.on_types),
            on_objects : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::vec_map_intersection<0x2::object::ID>(&arg0.on_objects, &arg1.general, &arg1.on_objects),
        }
    }

    public(friend) fun new(arg0: vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>) : ActionSet {
        ActionSet{
            general    : arg0,
            on_types   : 0x2::vec_map::empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(),
            on_objects : 0x2::vec_map::empty<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(),
        }
    }

    public(friend) fun add_action_for_objects<T0>(arg0: &mut ActionSet, arg1: vector<0x2::object::ID>) {
        while (0x1::vector::length<0x2::object::ID>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::push_back_unique<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_objects, &v0, 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>()), 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>());
        };
    }

    public(friend) fun add_action_for_types<T0>(arg0: &mut ActionSet, arg1: vector<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>) {
        while (0x1::vector::length<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut arg1);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::push_back_unique<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_types, &v0, 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>()), 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>());
        };
    }

    public(friend) fun add_general<T0>(arg0: &mut ActionSet) {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::push_back_unique<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut arg0.general, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>());
    }

    public(friend) fun add_general_(arg0: &mut ActionSet, arg1: vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>) {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::merge<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut arg0.general, arg1);
    }

    public fun general(arg0: &ActionSet) : &vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action> {
        &arg0.general
    }

    public(friend) fun merge(arg0: &mut ActionSet, arg1: ActionSet) {
        let ActionSet {
            general    : v0,
            on_types   : v1,
            on_objects : v2,
        } = arg1;
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::add(&mut arg0.general, v0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::vec_map_join<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut arg0.on_types, v1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::vec_map_join<0x2::object::ID>(&mut arg0.on_objects, v2);
    }

    public fun on_objects(arg0: &ActionSet) : &0x2::vec_map::VecMap<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>> {
        &arg0.on_objects
    }

    public fun on_types(arg0: &ActionSet) : &0x2::vec_map::VecMap<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>> {
        &arg0.on_types
    }

    public(friend) fun remove_action_for_objects<T0>(arg0: &mut ActionSet, arg1: vector<0x2::object::ID>) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>();
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let v2 = 0x2::vec_map::get_idx_opt<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_objects, &v1);
            if (0x1::option::is_some<u64>(&v2)) {
                let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_objects, 0x1::option::destroy_some<u64>(v2));
                0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::remove_maybe<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(v4, &v0);
            };
        };
    }

    public(friend) fun remove_action_for_types<T0>(arg0: &mut ActionSet, arg1: vector<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>();
        while (!0x1::vector::is_empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut arg1);
            let v2 = 0x2::vec_map::get_idx_opt<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_types, &v1);
            if (0x1::option::is_some<u64>(&v2)) {
                let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_types, 0x1::option::destroy_some<u64>(v2));
                0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::remove_maybe<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(v4, &v0);
            };
        };
    }

    public(friend) fun remove_all_actions_for_objects(arg0: &mut ActionSet, arg1: vector<0x2::object::ID>) {
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::remove_maybe<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_objects, &v0);
        };
    }

    public(friend) fun remove_all_actions_for_types(arg0: &mut ActionSet, arg1: vector<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>) {
        while (!0x1::vector::is_empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut arg1);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::remove_maybe<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.on_types, &v0);
        };
    }

    public(friend) fun remove_all_general(arg0: &mut ActionSet) {
        arg0.general = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
    }

    public(friend) fun remove_general<T0>(arg0: &mut ActionSet) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>();
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::remove_maybe<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut arg0.general, &v0);
    }

    // decompiled from Move bytecode v6
}

