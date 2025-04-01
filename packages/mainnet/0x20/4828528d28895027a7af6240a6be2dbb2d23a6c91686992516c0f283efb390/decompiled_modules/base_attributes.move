module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes {
    struct Attributes has store {
        static: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        dynamic: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        misc: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        hash: 0x1::string::String,
    }

    public fun hash(arg0: &Attributes) : 0x1::string::String {
        arg0.hash
    }

    fun borrow_attribute_map_value(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &0x1::string::String) : &0x1::string::String {
        0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, arg1)
    }

    public fun borrow_dynamic_value(arg0: &Attributes, arg1: &0x1::string::String) : &0x1::string::String {
        borrow_attribute_map_value(&arg0.dynamic, arg1)
    }

    public fun borrow_misc_value(arg0: &Attributes, arg1: &0x1::string::String) : &0x1::string::String {
        borrow_attribute_map_value(&arg0.misc, arg1)
    }

    public fun borrow_static_value(arg0: &Attributes, arg1: &0x1::string::String) : &0x1::string::String {
        borrow_attribute_map_value(&arg0.static, arg1)
    }

    fun fold_attribute_values(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: vector<0x1::string::String>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = v0;
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            0x1::string::append(&mut v2, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, &v3));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        v0
    }

    fun insert_attribute_map_value(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(arg0, arg1, arg2);
    }

    public(friend) fun insert_misc_value(arg0: &mut Attributes, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = &mut arg0.misc;
        insert_attribute_map_value(v0, arg1, arg2);
    }

    public(friend) fun new(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) : Attributes {
        Attributes{
            static  : new_attribute_map(arg0),
            dynamic : new_attribute_map(arg1),
            misc    : new_attribute_map(arg2),
            hash    : 0x1::string::utf8(b""),
        }
    }

    fun new_attribute_map(arg0: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (0x1::vector::length<0x1::string::String>(&arg0) > v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), 0x1::string::utf8(b""));
            v1 = v1 + 1;
        };
        v0
    }

    fun remove_attribute_map_value(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(arg0, arg1);
    }

    public(friend) fun remove_misc_value(arg0: &mut Attributes, arg1: &0x1::string::String) {
        let v0 = &mut arg0.misc;
        remove_attribute_map_value(v0, arg1);
    }

    fun update_attribute_map_value(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &0x1::string::String, arg2: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(arg0, arg1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(arg0, *arg1, arg2);
    }

    public(friend) fun update_dynamic_value(arg0: &mut Attributes, arg1: &0x1::string::String, arg2: 0x1::string::String) {
        let v0 = &mut arg0.dynamic;
        update_attribute_map_value(v0, arg1, arg2);
    }

    public(friend) fun update_hash_value(arg0: &mut Attributes) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, fold_attribute_values(&arg0.static, 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0.static)));
        0x1::string::append(&mut v0, fold_attribute_values(&arg0.dynamic, 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0.dynamic)));
        arg0.hash = 0x1::string::utf8(0x2::hex::encode(0x2::hash::blake2b256(0x1::string::as_bytes(&v0))));
    }

    public(friend) fun update_misc_value(arg0: &mut Attributes, arg1: &0x1::string::String, arg2: 0x1::string::String) {
        let v0 = &mut arg0.misc;
        update_attribute_map_value(v0, arg1, arg2);
    }

    public(friend) fun update_static_value(arg0: &mut Attributes, arg1: &0x1::string::String, arg2: 0x1::string::String) {
        let v0 = &mut arg0.static;
        update_attribute_map_value(v0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

