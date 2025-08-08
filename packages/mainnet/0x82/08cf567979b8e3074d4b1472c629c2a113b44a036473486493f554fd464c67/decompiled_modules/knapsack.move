module 0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack {
    struct Knapsack<T0: store> has store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, vector<T0>>,
        attributes_display: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun add_attribute<T0: store>(arg0: &mut Knapsack<T0>, arg1: 0x1::string::String, arg2: T0) {
        if (!0x2::vec_map::contains<0x1::string::String, vector<T0>>(&arg0.attributes, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, vector<T0>>(&mut arg0.attributes, arg1, 0x1::vector::empty<T0>());
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes_display, arg1, 0x1::string::utf8(b""));
        };
        0x1::vector::push_back<T0>(0x2::vec_map::get_mut<0x1::string::String, vector<T0>>(&mut arg0.attributes, &arg1), arg2);
    }

    public fun get_attributes<T0: store>(arg0: &Knapsack<T0>, arg1: &0x1::string::String) : &vector<T0> {
        0x2::vec_map::get<0x1::string::String, vector<T0>>(&arg0.attributes, arg1)
    }

    public fun new_knapsack<T0: store>() : Knapsack<T0> {
        Knapsack<T0>{
            attributes         : 0x2::vec_map::empty<0x1::string::String, vector<T0>>(),
            attributes_display : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun remove_attribute<T0: store>(arg0: &mut Knapsack<T0>, arg1: 0x1::string::String, arg2: u64) : 0x1::option::Option<T0> {
        if (0x2::vec_map::contains<0x1::string::String, vector<T0>>(&arg0.attributes, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, vector<T0>>(&mut arg0.attributes, &arg1);
            if (arg2 < 0x1::vector::length<T0>(v0)) {
                if (0x1::vector::is_empty<T0>(v0)) {
                    update_attributes_display<T0>(arg0, arg1, 0x1::string::utf8(b""));
                };
                return 0x1::option::some<T0>(0x1::vector::remove<T0>(v0, arg2))
            };
        };
        update_attributes_display<T0>(arg0, arg1, 0x1::string::utf8(b""));
        0x1::option::none<T0>()
    }

    public fun update_attributes_display<T0: store>(arg0: &mut Knapsack<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes_display, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes_display, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes_display, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

