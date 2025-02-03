module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag {
    struct StructTag has copy, drop, store {
        package_id: 0x2::object::ID,
        module_name: 0x1::string::String,
        struct_name: 0x1::string::String,
        generics: vector<0x1::string::String>,
    }

    public fun contains(arg0: &vector<StructTag>, arg1: &StructTag) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StructTag>(arg0)) {
            if (match(0x1::vector::borrow<StructTag>(arg0, v0), arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun generics(arg0: &StructTag) : vector<0x1::string::String> {
        arg0.generics
    }

    public fun get<T0>() : StructTag {
        let (v0, v1, v2, v3) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name_decomposed<T0>();
        StructTag{
            package_id  : v0,
            module_name : v1,
            struct_name : v2,
            generics    : v3,
        }
    }

    public fun get_abstract<T0>() : StructTag {
        let (v0, v1, v2, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name_decomposed<T0>();
        StructTag{
            package_id  : v0,
            module_name : v1,
            struct_name : v2,
            generics    : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun into_string(arg0: &StructTag) : 0x1::string::String {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2::empty();
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::object::id_to_bytes(&arg0.package_id)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, arg0.module_name);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, arg0.struct_name);
        if (0x1::vector::length<0x1::string::String>(&arg0.generics) > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"<"));
            let v1 = true;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&arg0.generics)) {
                if (!v1) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b", "));
                };
                0x1::string::append(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0.generics, v2));
                v2 = v2 + 1;
                v1 = false;
            };
            0x1::string::append(&mut v0, 0x1::string::utf8(b">"));
        };
        v0
    }

    public fun is_same_abstract_type(arg0: &StructTag, arg1: &StructTag) : bool {
        arg0.package_id == arg1.package_id && arg0.module_name == arg1.module_name && arg0.struct_name == arg1.struct_name
    }

    public fun is_same_module(arg0: &StructTag, arg1: &StructTag) : bool {
        arg0.package_id == arg1.package_id && arg0.module_name == arg1.module_name
    }

    public fun is_same_type(arg0: &StructTag, arg1: &StructTag) : bool {
        arg0.package_id == arg1.package_id && arg0.module_name == arg1.module_name && arg0.struct_name == arg1.struct_name && arg0.generics == arg1.generics
    }

    public fun match(arg0: &StructTag, arg1: &StructTag) : bool {
        arg0.package_id == arg1.package_id && arg0.module_name == arg1.module_name && arg0.struct_name == arg1.struct_name && (arg0.struct_name == arg1.struct_name || 0x1::vector::length<0x1::string::String>(&arg0.generics) == 0)
    }

    public fun module_name(arg0: &StructTag) : 0x1::string::String {
        arg0.module_name
    }

    public fun package_id(arg0: &StructTag) : 0x2::object::ID {
        arg0.package_id
    }

    public fun struct_name(arg0: &StructTag) : 0x1::string::String {
        arg0.struct_name
    }

    // decompiled from Move bytecode v6
}

