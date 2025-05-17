module 0xabb57e8cb9476076a14fda88e008fc1b8502115a1547114f02d9addc7941ebf0::sui_rss {
    struct RSSRegistry has key {
        id: 0x2::object::UID,
        feeds: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct RSSAdminCap has store, key {
        id: 0x2::object::UID,
        rss_id: 0x2::object::ID,
    }

    struct RSSPublishCap has store, key {
        id: 0x2::object::UID,
        rss_id: 0x2::object::ID,
    }

    struct Authorization {
        pos0: 0x2::object::ID,
        pos1: 0x2::object::ID,
        pos2: bool,
        pos3: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct RSSItem has drop, store {
        pos0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct RSS has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        cap_id: 0x2::object::ID,
        is_public: bool,
        publishers: 0x2::vec_set::VecSet<0x2::object::ID>,
        suins_id: 0x2::object::ID,
        last_updated_ms: u64,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        items: 0x2::table_vec::TableVec<RSSItem>,
    }

    public fun add_item(arg0: &mut RSS, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Authorization {
        let v0 = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg1, arg2);
        let v1 = vector[b"title", b"name", b"guid", b"pubDate"];
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v1)) {
            let v3 = 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut v1));
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v3)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"pubDate"), utc_date_time(0x2::clock::timestamp_ms(arg3)));
        let v6 = arg0.name;
        0x1::string::append_utf8(&mut v6, b"/");
        0x1::string::append(&mut v6, 0x1::u64::to_string(0x2::table_vec::length<RSSItem>(&arg0.items)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"guid"), v6);
        arg0.last_updated_ms = 0x2::clock::timestamp_ms(arg3);
        let v7 = RSSItem{pos0: v0};
        0x2::table_vec::push_back<RSSItem>(&mut arg0.items, v7);
        Authorization{
            pos0 : 0x2::object::uid_to_inner(&arg0.id),
            pos1 : arg0.cap_id,
            pos2 : arg0.is_public,
            pos3 : arg0.publishers,
        }
    }

    public fun confirm_admin(arg0: Authorization, arg1: &RSSAdminCap) {
        let Authorization {
            pos0 : v0,
            pos1 : v1,
            pos2 : _,
            pos3 : _,
        } = arg0;
        assert!(v0 == arg1.rss_id, 2);
        assert!(v1 == 0x2::object::uid_to_inner(&arg1.id), 4);
    }

    public fun confirm_public(arg0: Authorization) {
        let Authorization {
            pos0 : _,
            pos1 : _,
            pos2 : v2,
            pos3 : _,
        } = arg0;
        assert!(v2, 1);
    }

    public fun confirm_publisher(arg0: Authorization, arg1: &RSSPublishCap) {
        let Authorization {
            pos0 : v0,
            pos1 : _,
            pos2 : _,
            pos3 : v3,
        } = arg0;
        let v4 = v3;
        assert!(v0 == arg1.rss_id, 7);
        let v5 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v4, &v5), 7);
    }

    public fun give_up_publisher(arg0: &mut RSS, arg1: RSSPublishCap) {
        let RSSPublishCap {
            id     : v0,
            rss_id : v1,
        } = arg1;
        let v2 = v0;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v1, 7);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.publishers, 0x2::object::uid_as_inner(&v2))) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.publishers, 0x2::object::uid_as_inner(&v2));
        };
        0x2::object::delete(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RSSRegistry{
            id    : 0x2::object::new(arg0),
            feeds : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<RSSRegistry>(v0);
    }

    public fun new_publisher(arg0: &mut RSS, arg1: &RSSAdminCap, arg2: &mut 0x2::tx_context::TxContext) : RSSPublishCap {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.rss_id, 2);
        assert!(arg0.cap_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        let v0 = 0x2::object::new(arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.publishers, 0x2::object::uid_to_inner(&v0));
        RSSPublishCap{
            id     : v0,
            rss_id : 0x2::object::uid_to_inner(&arg0.id),
        }
    }

    public fun new_rss(arg0: &mut RSSRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (RSS, RSSAdminCap) {
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg2), 0);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.feeds, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg1)), 3);
        let v0 = 0x2::object::new(arg3);
        let v1 = RSSAdminCap{
            id     : 0x2::object::new(arg3),
            rss_id : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.feeds, v2, 0x2::object::uid_to_inner(&v0));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"title"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v4, v2);
        let v5 = RSS{
            id              : v0,
            name            : v2,
            cap_id          : 0x2::object::uid_to_inner(&v1.id),
            is_public       : false,
            publishers      : 0x2::vec_set::empty<0x2::object::ID>(),
            suins_id        : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1),
            last_updated_ms : 0x2::clock::timestamp_ms(arg2),
            metadata        : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v3, v4),
            items           : 0x2::table_vec::empty<RSSItem>(arg3),
        };
        (v5, v1)
    }

    fun pad_zero(arg0: u64) : 0x1::string::String {
        if (arg0 < 10) {
            let v1 = 0x1::string::utf8(b"0");
            0x1::string::append(&mut v1, 0x1::u64::to_string(arg0));
            v1
        } else {
            0x1::u64::to_string(arg0)
        }
    }

    fun print_rss(arg0: &RSS, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : 0x1::string::String {
        let v0 = 0x2::table_vec::length<RSSItem>(&arg0.items);
        let v1 = if (v0 >= arg1 + arg2) {
            v0 - arg1 - arg2
        } else {
            0
        };
        let v2 = 0x1::string::utf8(b"<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        0x1::string::append_utf8(&mut v2, b"<rss version=\"2.0\">");
        0x1::string::append_utf8(&mut v2, x"0a3c6368616e6e656c3e");
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&arg0.metadata)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&arg0.metadata, v3);
            0x1::string::append(&mut v2, print_xml(*v4, *v5));
            v3 = v3 + 1;
        };
        0x1::string::append(&mut v2, print_xml(0x1::string::utf8(b"pubDate"), utc_date_time(arg0.last_updated_ms)));
        0x1::string::append(&mut v2, print_xml(0x1::string::utf8(b"lastBuildDate"), utc_date_time(0x2::clock::timestamp_ms(arg3))));
        let v6 = 0;
        while (v6 < v0 - arg2 - v1) {
            let v7 = &0x2::table_vec::borrow<RSSItem>(&arg0.items, v6 + v1).pos0;
            0x1::string::append_utf8(&mut v2, x"0a3c6974656d3e");
            let v8 = 0;
            while (v8 < 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(v7)) {
                let (v9, v10) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(v7, v8);
                0x1::string::append(&mut v2, print_xml(*v9, *v10));
                v8 = v8 + 1;
            };
            0x1::string::append_utf8(&mut v2, b"</item>");
            v6 = v6 + 1;
        };
        0x1::string::append_utf8(&mut v2, b"</channel>");
        0x1::string::append_utf8(&mut v2, b"</rss>");
        v2
    }

    fun print_xml(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b">"));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b">"));
        v0
    }

    public fun revoke_publisher(arg0: &mut RSS, arg1: &RSSAdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.rss_id, 2);
        assert!(arg0.cap_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.publishers, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.publishers, &arg2);
        };
    }

    public fun set_metadata(arg0: &mut RSS, arg1: &RSSAdminCap, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.rss_id, 2);
        assert!(arg0.cap_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        let v0 = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3);
        let v1 = vector[b"name", b"timestamp", b"pubDate"];
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v1)) {
            let v3 = 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut v1));
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v3)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        arg0.last_updated_ms = 0x2::clock::timestamp_ms(arg4);
        arg0.metadata = v0;
    }

    public fun share_rss(arg0: RSS) {
        0x2::transfer::share_object<RSS>(arg0);
    }

    public fun take_over(arg0: &mut RSSRegistry, arg1: &mut RSS, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : RSSAdminCap {
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg2, arg3), 0);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.feeds, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg2)), 5);
        let v0 = 0x1::string::utf8(b"name");
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg2) == *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg1.metadata, &v0), 6);
        assert!(arg1.suins_id != 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg2), 6);
        let v1 = 0x2::object::new(arg4);
        arg1.cap_id = 0x2::object::uid_to_inner(&v1);
        arg1.suins_id = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg2);
        RSSAdminCap{
            id     : v1,
            rss_id : 0x2::object::uid_to_inner(&arg1.id),
        }
    }

    fun utc_date_time(arg0: u64) : 0x1::string::String {
        let v0 = arg0 / 1000;
        let v1 = v0 / 60;
        let v2 = v0 / 86400;
        let v3 = 1970;
        loop {
            let v4 = if (v3 % 4 == 0 && v3 % 100 != 0 || v3 % 400 == 0) {
                366
            } else {
                365
            };
            if (v2 < v4) {
                break
            };
            v3 = v3 + 1;
            v2 = v2 - v4;
        };
        let v5 = 0;
        let v6 = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        loop {
            let v7 = if ((v3 % 4 == 0 && v3 % 100 != 0 || v3 % 400 == 0) && v5 == 1) {
                29
            } else {
                *0x1::vector::borrow<u64>(&v6, v5)
            };
            if (v2 < v7) {
                break
            };
            v5 = v5 + 1;
            v2 = v2 - v7;
        };
        let v8 = 0x1::string::utf8(b"");
        let v9 = vector[b"Sun", b"Mon", b"Tue", b"Wed", b"Thu", b"Fri", b"Sat"];
        0x1::string::append_utf8(&mut v8, *0x1::vector::borrow<vector<u8>>(&v9, (v0 / 86400 + 4) % 7));
        0x1::string::append_utf8(&mut v8, b", ");
        0x1::string::append(&mut v8, pad_zero(v2 + 1));
        0x1::string::append_utf8(&mut v8, b" ");
        let v10 = vector[b"Jan", b"Feb", b"Mar", b"Apr", b"May", b"Jun", b"Jul", b"Aug", b"Sep", b"Oct", b"Nov", b"Dec"];
        0x1::string::append_utf8(&mut v8, *0x1::vector::borrow<vector<u8>>(&v10, v5));
        0x1::string::append_utf8(&mut v8, b" ");
        0x1::string::append(&mut v8, 0x1::u16::to_string(v3));
        0x1::string::append_utf8(&mut v8, b" ");
        0x1::string::append(&mut v8, pad_zero(v1 / 60 % 24));
        0x1::string::append_utf8(&mut v8, b":");
        0x1::string::append(&mut v8, pad_zero(v1 % 60));
        0x1::string::append_utf8(&mut v8, b":");
        0x1::string::append(&mut v8, pad_zero(v0 % 60));
        0x1::string::append_utf8(&mut v8, b" GMT");
        v8
    }

    // decompiled from Move bytecode v6
}

