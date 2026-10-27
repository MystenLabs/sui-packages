module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item {
    struct Item<phantom T0> has store, key {
        id: 0x2::object::UID,
        class: 0x2::object::ID,
        kind: u64,
        serial: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attrs: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        rev: u64,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) : Item<T0> {
        let v0 = Item<T0>{
            id          : 0x2::object::new(arg8),
            class       : arg0,
            kind        : arg1,
            serial      : arg2,
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            attrs       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            rev         : 0,
        };
        let v1 = &mut v0;
        write<T0>(v1, arg6, arg7);
        v0
    }

    public fun attr<T0>(arg0: &Item<T0>, arg1: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attrs, &arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attrs, &arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun attrs<T0>(arg0: &Item<T0>) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attrs
    }

    public(friend) fun bump_rev<T0>(arg0: &mut Item<T0>) : u64 {
        arg0.rev = arg0.rev + 1;
        arg0.rev
    }

    public fun class<T0>(arg0: &Item<T0>) : 0x2::object::ID {
        arg0.class
    }

    public fun description<T0>(arg0: &Item<T0>) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun destroy<T0>(arg0: Item<T0>) : (0x2::object::ID, 0x2::object::ID, u64, u64) {
        let Item {
            id          : v0,
            class       : v1,
            kind        : v2,
            serial      : v3,
            name        : _,
            description : _,
            image_url   : _,
            attrs       : _,
            rev         : _,
        } = arg0;
        let v9 = v0;
        0x2::object::delete(v9);
        (0x2::object::uid_to_inner(&v9), v1, v2, v3)
    }

    public fun image_url<T0>(arg0: &Item<T0>) : 0x1::string::String {
        arg0.image_url
    }

    public fun kind<T0>(arg0: &Item<T0>) : u64 {
        arg0.kind
    }

    public fun name<T0>(arg0: &Item<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun rev<T0>(arg0: &Item<T0>) : u64 {
        arg0.rev
    }

    public fun serial<T0>(arg0: &Item<T0>) : u64 {
        arg0.serial
    }

    public(friend) fun write<T0>(arg0: &mut Item<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 601);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            let v3 = if (0x1::string::length(&v1) > 0) {
                if (0x1::string::length(&v1) <= 64) {
                    0x1::string::length(&v2) <= 512
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 601);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attrs, &v1)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attrs, &v1) = v2;
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attrs, v1, v2);
            };
            v0 = v0 + 1;
        };
        assert!(0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&arg0.attrs) <= 64, 602);
    }

    // decompiled from Move bytecode v7
}

