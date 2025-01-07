module 0x7db2d08896f064c8abac8cab1c06df82e8b939a85e89bded6b8031754d4601e5::items {
    struct Items has store {
        bags: 0x2::bag::Bag,
        link_table: 0x2::linked_table::LinkedTable<0x1::string::String, u16>,
    }

    struct ItemGlobal has key {
        id: 0x2::object::UID,
        desc_table: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun destroy_empty(arg0: Items) {
        let Items {
            bags       : v0,
            link_table : v1,
        } = arg0;
        0x2::linked_table::drop<0x1::string::String, u16>(v1);
        0x2::bag::destroy_empty(v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Items {
        Items{
            bags       : 0x2::bag::new(arg0),
            link_table : 0x2::linked_table::new<0x1::string::String, u16>(arg0),
        }
    }

    public(friend) fun extract_item<T0: store>(arg0: &mut Items, arg1: 0x1::string::String) : T0 {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.bags, arg1), 1);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, vector<T0>>(&mut arg0.bags, arg1);
        assert!(0x1::vector::length<T0>(v0) > 0, 2);
        let v1 = 0x1::vector::pop_back<T0>(v0);
        let v2 = 0x1::vector::length<T0>(v0);
        let v3 = &mut arg0.link_table;
        set_items_num(v3, arg1, (v2 as u16));
        v1
    }

    public(friend) fun extract_items<T0: store>(arg0: &mut Items, arg1: 0x1::string::String, arg2: u64) : vector<T0> {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.bags, arg1), 1);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, vector<T0>>(&mut arg0.bags, arg1);
        assert!(0x1::vector::length<T0>(v0) >= arg2, 3);
        let v1 = 0x1::vector::empty<T0>();
        let v2 = 0;
        while (v2 < arg2) {
            0x1::vector::push_back<T0>(&mut v1, 0x1::vector::pop_back<T0>(v0));
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::length<T0>(v0);
        let v4 = &mut arg0.link_table;
        set_items_num(v4, arg1, (v3 as u16));
        v1
    }

    public fun get_desc_by_name(arg0: &ItemGlobal, arg1: 0x1::string::String) : 0x1::string::String {
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.desc_table, arg1)) {
            return *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.desc_table, arg1)
        };
        0x1::string::utf8(b"None")
    }

    public(friend) fun get_items_info(arg0: &ItemGlobal, arg1: &Items) : 0x1::string::String {
        let v0 = 0x1::ascii::byte(0x1::ascii::char(58));
        let v1 = 0x1::ascii::byte(0x1::ascii::char(59));
        let v2 = 0x1::ascii::byte(0x1::ascii::char(44));
        let v3 = &arg1.link_table;
        if (0x2::linked_table::is_empty<0x1::string::String, u16>(v3)) {
            return 0x1::string::utf8(b"none")
        };
        let v4 = 0x1::string::utf8(b"");
        let v5 = *0x1::string::bytes(&v4);
        let v6 = 0x2::linked_table::front<0x1::string::String, u16>(v3);
        let v7 = *0x1::option::borrow<0x1::string::String>(v6);
        0x1::vector::append<u8>(&mut v5, *0x1::string::bytes(&v7));
        0x1::vector::push_back<u8>(&mut v5, v0);
        0x1::vector::append<u8>(&mut v5, numbers_to_ascii_vector(*0x2::linked_table::borrow<0x1::string::String, u16>(v3, v7)));
        0x1::vector::push_back<u8>(&mut v5, v2);
        let v8 = get_desc_by_name(arg0, v7);
        0x1::vector::append<u8>(&mut v5, *0x1::string::bytes(&v8));
        0x1::vector::push_back<u8>(&mut v5, v1);
        let v9 = 0x2::linked_table::next<0x1::string::String, u16>(v3, *0x1::option::borrow<0x1::string::String>(v6));
        while (0x1::option::is_some<0x1::string::String>(v9)) {
            let v10 = *0x1::option::borrow<0x1::string::String>(v9);
            0x1::vector::append<u8>(&mut v5, *0x1::string::bytes(&v10));
            0x1::vector::push_back<u8>(&mut v5, v0);
            0x1::vector::append<u8>(&mut v5, numbers_to_ascii_vector(*0x2::linked_table::borrow<0x1::string::String, u16>(v3, v10)));
            0x1::vector::push_back<u8>(&mut v5, v2);
            let v11 = get_desc_by_name(arg0, v10);
            0x1::vector::append<u8>(&mut v5, *0x1::string::bytes(&v11));
            0x1::vector::push_back<u8>(&mut v5, v1);
            v9 = 0x2::linked_table::next<0x1::string::String, u16>(v3, v10);
        };
        0x1::string::utf8(v5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ItemGlobal{
            id         : 0x2::object::new(arg0),
            desc_table : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
        };
        let v1 = &mut v0;
        init_items_desc(v1);
        0x2::transfer::share_object<ItemGlobal>(v0);
    }

    fun init_items_desc(arg0: &mut ItemGlobal) {
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"LuckyBox"), 0x1::string::utf8(b"Fruit desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Water element Holy"), 0x1::string::utf8(b"holy water element desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Water element Blood"), 0x1::string::utf8(b"blood water element desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Water element Resurrect"), 0x1::string::utf8(b"resurrect water element desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Water element Life"), 0x1::string::utf8(b"life water element desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Water element Memory"), 0x1::string::utf8(b"memory water element desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Fragment Holy"), 0x1::string::utf8(b"holy water element fragment desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Fragment Blood"), 0x1::string::utf8(b"holy water element fragment desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Fragment Resurrect"), 0x1::string::utf8(b"holy water element fragment desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Fragment Life"), 0x1::string::utf8(b"holy water element fragment desc"));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.desc_table, 0x1::string::utf8(b"Fragment Memory"), 0x1::string::utf8(b"holy water element fragment desc"));
    }

    fun numbers_to_ascii_vector(arg0: u16) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun set_items_num(arg0: &mut 0x2::linked_table::LinkedTable<0x1::string::String, u16>, arg1: 0x1::string::String, arg2: u16) {
        if (0x2::linked_table::contains<0x1::string::String, u16>(arg0, arg1)) {
            if (arg2 == 0) {
                0x2::linked_table::remove<0x1::string::String, u16>(arg0, arg1);
                return
            };
            *0x2::linked_table::borrow_mut<0x1::string::String, u16>(arg0, arg1) = arg2;
        } else {
            0x2::linked_table::push_back<0x1::string::String, u16>(arg0, arg1, arg2);
        };
    }

    public(friend) fun store_item<T0: store>(arg0: &mut Items, arg1: 0x1::string::String, arg2: T0) {
        if (0x2::bag::contains<0x1::string::String>(&arg0.bags, arg1)) {
            let v0 = 0x2::bag::borrow_mut<0x1::string::String, vector<T0>>(&mut arg0.bags, arg1);
            0x1::vector::push_back<T0>(v0, arg2);
            let v1 = 0x1::vector::length<T0>(v0);
            let v2 = &mut arg0.link_table;
            set_items_num(v2, arg1, (v1 as u16));
        } else {
            let v3 = 0x1::vector::empty<T0>();
            0x1::vector::push_back<T0>(&mut v3, arg2);
            0x2::bag::add<0x1::string::String, vector<T0>>(&mut arg0.bags, arg1, v3);
            let v4 = &mut arg0.link_table;
            set_items_num(v4, arg1, 1);
        };
    }

    public(friend) fun store_items<T0: store>(arg0: &mut Items, arg1: 0x1::string::String, arg2: vector<T0>) {
        if (0x2::bag::contains<0x1::string::String>(&arg0.bags, arg1)) {
            let v0 = 0x2::bag::borrow_mut<0x1::string::String, vector<T0>>(&mut arg0.bags, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<T0>(&arg2)) {
                0x1::vector::push_back<T0>(v0, 0x1::vector::pop_back<T0>(&mut arg2));
                v1 = v1 + 1;
            };
            let v2 = 0x1::vector::length<T0>(v0);
            let v3 = &mut arg0.link_table;
            set_items_num(v3, arg1, (v2 as u16));
        } else {
            let v4 = 0x1::vector::empty<T0>();
            let v5 = 0x1::vector::length<T0>(&arg2);
            let v6 = 0;
            while (v6 < v5) {
                0x1::vector::push_back<T0>(&mut v4, 0x1::vector::pop_back<T0>(&mut arg2));
                v6 = v6 + 1;
            };
            0x2::bag::add<0x1::string::String, vector<T0>>(&mut arg0.bags, arg1, v4);
            let v7 = &mut arg0.link_table;
            set_items_num(v7, arg1, (v5 as u16));
        };
        0x1::vector::destroy_empty<T0>(arg2);
    }

    // decompiled from Move bytecode v6
}

