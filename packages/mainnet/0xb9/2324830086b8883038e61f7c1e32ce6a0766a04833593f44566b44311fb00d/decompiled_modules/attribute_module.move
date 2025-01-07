module 0xb92324830086b8883038e61f7c1e32ce6a0766a04833593f44566b44311fb00d::attribute_module {
    struct AttributeContainer has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        elements: vector<0x2::object::ID>,
    }

    struct Attribute has store, key {
        id: 0x2::object::UID,
        attributes: vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
    }

    public fun change_admin_address(arg0: &mut AttributeContainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg2), 0);
        arg0.admin_address = arg1;
    }

    public fun create_attribute_container(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Attribute{
            id         : 0x2::object::new(arg0),
            attributes : 0x1::vector::empty<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(),
        };
        let v1 = 0x2::object::id<Attribute>(&v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, v1);
        let v3 = AttributeContainer{
            id            : 0x2::object::new(arg0),
            admin_address : 0x2::tx_context::sender(arg0),
            elements      : v2,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Attribute>(&mut v3.id, v1, v0);
        0x2::transfer::share_object<AttributeContainer>(v3);
        0x2::object::id<AttributeContainer>(&v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun pop_attributes(arg0: &mut AttributeContainer) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = arg0.elements;
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v4 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Attribute>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            let v5 = v4.attributes;
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&v5) != 0) {
                v3 = true;
                v0 = 0x1::vector::pop_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v4.attributes);
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3 == true, 3);
        v0
    }

    public fun push_attributes(arg0: &mut AttributeContainer, arg1: vector<vector<0x1::string::String>>, arg2: vector<vector<0x1::string::String>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<0x1::string::String>>(&arg1);
        assert!(v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::remove<vector<0x1::string::String>>(&mut arg1, v1);
            let v3 = 0x1::vector::remove<vector<0x1::string::String>>(&mut arg2, v1);
            let v4 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x1::string::String>(&v2)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, 0x1::vector::pop_back<0x1::string::String>(&mut v2), 0x1::vector::pop_back<0x1::string::String>(&mut v3));
                v5 = v5 + 1;
            };
            let v6 = arg0.elements;
            let v7 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Attribute>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v6, 0x1::vector::length<0x2::object::ID>(&v6) - 1));
            let v8 = v7.attributes;
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&v8) < 3000) {
                0x1::vector::push_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v7.attributes, v4);
            } else {
                0x1::vector::push_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v7.attributes, v4);
                let v9 = Attribute{
                    id         : 0x2::object::new(arg3),
                    attributes : 0x1::vector::empty<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(),
                };
                let v10 = 0x2::object::id<Attribute>(&v9);
                0x1::vector::push_back<0x2::object::ID>(&mut arg0.elements, v10);
                0x2::dynamic_object_field::add<0x2::object::ID, Attribute>(&mut arg0.id, v10, v9);
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

