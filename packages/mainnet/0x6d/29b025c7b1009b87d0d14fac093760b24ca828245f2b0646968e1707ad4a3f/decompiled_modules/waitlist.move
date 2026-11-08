module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist {
    struct Layout has copy, drop {
        version_at: u64,
        version: u64,
        deadline_at: u64,
        deadline_end: u64,
        deadline: 0x1::string::String,
        seats_at: u64,
        seats_max: u64,
        badges: vector<u64>,
        badges_end: u64,
        signature_at: u64,
    }

    public fun declaration() : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Declaration {
        let v0 = 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Placed>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Placed>(v1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::placed(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::request(), b"party_and_host", b"room"));
        0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Placed>(v1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::placed(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::withdraw(), b"party_and_host", b"party_and_host"));
        let v2 = 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v3, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::request());
        0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v3, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::withdraw());
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::without_hold(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::new(0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), v0, vector[], v2))
    }

    public fun charter_badges(arg0: &vector<u8>) : 0x1::option::Option<vector<u64>> {
        let v0 = layout(arg0);
        if (0x1::option::is_none<Layout>(&v0)) {
            0x1::option::none<vector<u64>>()
        } else {
            let v2 = 0x1::option::destroy_some<Layout>(v0);
            0x1::option::some<vector<u64>>(v2.badges)
        }
    }

    fun in_chain(arg0: &vector<u8>, arg1: address, arg2: &vector<vector<u8>>) : bool {
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(arg0) == arg1) {
            return true
        };
        let v0 = 0x1::vector::length<vector<u8>>(arg2);
        let v1 = if (v0 < 2) {
            true
        } else if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(0x1::vector::borrow<vector<u8>>(arg2, 0)) != arg1) {
            true
        } else {
            0x1::vector::borrow<vector<u8>>(arg2, v0 - 1) != arg0
        };
        if (v1) {
            return false
        };
        let v2 = 1;
        while (v2 < v0) {
            if (!narrows(0x1::vector::borrow<vector<u8>>(arg2, v2 - 1), 0x1::vector::borrow<vector<u8>>(arg2, v2))) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun is_waitlist(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView) : bool {
        let v0 = b"waitlist";
        0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg0)) == &v0
    }

    public fun layout(arg0: &vector<u8>) : 0x1::option::Option<Layout> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::new(*arg0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        let v1 = 0;
        while (v1 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
            let v2 = 0;
            while (v2 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
                let v3 = &mut v0;
                skip_ulebs(v3);
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
                v2 = v2 + 1;
            };
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_bool(&mut v0);
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) == 1) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
            };
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_bool(&mut v0);
            v1 = v1 + 1;
        };
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
        if (v4 == 0) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0);
        } else if (v4 == 1 || v4 == 2) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        } else {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::fail(&mut v0);
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) == 1) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
        };
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
        v1 = 0;
        while (v1 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            v1 = v1 + 1;
        };
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0);
        let v5 = &mut v0;
        skip_predicate(v5);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_bool(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::option_bool(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        v1 = 0;
        while (v1 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            let v6 = &mut v0;
            skip_ulebs(v6);
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
            };
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
            };
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            v1 = v1 + 1;
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        };
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0) || 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) != 1) {
            return 0x1::option::none<Layout>()
        };
        let v7 = vector[];
        v1 = 0;
        while (v1 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x1::vector::push_back<u64>(&mut v7, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0));
            v1 = v1 + 1;
        };
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0);
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::present(&mut v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0);
        };
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::ok(&v0)) {
            return 0x1::option::none<Layout>()
        };
        let v8 = Layout{
            version_at   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0),
            version      : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            deadline_at  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0),
            deadline_end : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0),
            deadline     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            seats_at     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0),
            seats_max    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            badges       : v7,
            badges_end   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0),
            signature_at : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0),
        };
        0x1::option::some<Layout>(v8)
    }

    public fun leaves(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind) : bool {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::withdraw();
        arg0 == &v0
    }

    public fun member_quota_fits(arg0: u64) : bool {
        arg0 == 1
    }

    public fun narrows(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = layout(arg1);
        let v1 = layout(arg0);
        if (0x1::option::is_none<Layout>(&v1) || 0x1::option::is_none<Layout>(&v0)) {
            return false
        };
        let v2 = 0x1::option::destroy_some<Layout>(v0);
        let v3 = 0x1::option::destroy_some<Layout>(v1);
        if (v2.version == 0 || v2.version - 1 != v3.version) {
            return false
        };
        if (!same(arg0, 0, v3.version_at, arg1, 0, v2.version_at)) {
            return false
        };
        if (!same(arg0, v3.version_at + 8, v3.deadline_at, arg1, v2.version_at + 8, v2.deadline_at)) {
            return false
        };
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(&v2.deadline);
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(&v3.deadline);
        let v6 = if (0x1::option::is_none<u64>(&v5)) {
            true
        } else if (0x1::option::is_none<u64>(&v4)) {
            true
        } else {
            *0x1::option::borrow<u64>(&v4) > *0x1::option::borrow<u64>(&v5)
        };
        if (v6) {
            return false
        };
        if (!same(arg0, v3.deadline_end, v3.seats_at, arg1, v2.deadline_end, v2.seats_at)) {
            return false
        };
        if (v2.seats_max > v3.seats_max) {
            return false
        };
        if (!shortens(&v3.badges, &v2.badges)) {
            return false
        };
        let v7 = 3;
        let v8 = if (0x1::vector::contains<u64>(&v3.badges, &v7)) {
            let v9 = 3;
            !0x1::vector::contains<u64>(&v2.badges, &v9)
        } else {
            false
        };
        if (v8) {
            return false
        };
        same(arg0, v3.badges_end, v3.signature_at, arg1, v2.badges_end, v2.signature_at)
    }

    public fun place_open(arg0: bool) : bool {
        !arg0
    }

    public fun proposal_schema() : vector<u8> {
        b"rooms:template:waitlist:1:proposal"
    }

    public fun request_fits(arg0: &vector<u8>, arg1: &0x1::option::Option<address>, arg2: &vector<vector<u8>>, arg3: bool, arg4: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>) : bool {
        if (!arg3) {
            return false
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(arg4, b"rules");
        if (0x1::option::is_none<0x1::string::String>(&v0)) {
            return false
        };
        let v1 = if (0x1::option::is_some<address>(arg1)) {
            *0x1::option::borrow<address>(arg1)
        } else {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(arg0)
        };
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::hex_of(v1);
        if (0x1::option::borrow<0x1::string::String>(&v0) != &v2) {
            return false
        };
        if (0x1::option::is_some<address>(arg1) && !in_chain(arg0, v1, arg2)) {
            return false
        };
        let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(arg4, b"badge");
        if (0x1::option::is_none<0x1::string::String>(&v3)) {
            return false
        };
        let v4 = vector[b"business", b"agent_maker", b"following", b"none"];
        let (v5, v6) = 0x1::vector::index_of<vector<u8>>(&v4, 0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&v3)));
        let v7 = v6;
        if (!v5) {
            return false
        };
        let v8 = charter_badges(arg0);
        0x1::option::is_some<vector<u64>>(&v8) && 0x1::vector::contains<u64>(0x1::option::borrow<vector<u64>>(&v8), &v7)
    }

    fun same(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: u64) : bool {
        let v0 = if (arg2 < arg1) {
            true
        } else if (arg5 < arg4) {
            true
        } else {
            arg2 - arg1 != arg5 - arg4
        };
        if (v0) {
            return false
        };
        if (arg2 > 0x1::vector::length<u8>(arg0) || arg5 > 0x1::vector::length<u8>(arg3)) {
            return false
        };
        let v1 = 0;
        while (v1 < arg2 - arg1) {
            if (*0x1::vector::borrow<u8>(arg0, arg1 + v1) != *0x1::vector::borrow<u8>(arg3, arg4 + v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun shortens(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        if (0x1::vector::is_empty<u64>(arg1)) {
            return false
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            while (v0 < 0x1::vector::length<u64>(arg0) && *0x1::vector::borrow<u64>(arg0, v0) != *0x1::vector::borrow<u64>(arg1, v1)) {
                v0 = v0 + 1;
            };
            if (v0 == 0x1::vector::length<u64>(arg0)) {
                return false
            };
            v0 = v0 + 1;
            v1 = v1 + 1;
        };
        true
    }

    fun skip_predicate(arg0: &mut 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::Cursor) {
        let v0 = vector[1];
        while (!0x1::vector::is_empty<u64>(&v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(arg0)) {
            let v1 = 0x1::vector::length<u64>(&v0) - 1;
            if (*0x1::vector::borrow<u64>(&v0, v1) == 0) {
                0x1::vector::pop_back<u64>(&mut v0);
                continue
            };
            *0x1::vector::borrow_mut<u64>(&mut v0, v1) = *0x1::vector::borrow<u64>(&v0, v1) - 1;
            let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(arg0);
            if (v2 == 0) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(arg0);
                continue
            };
            if (v2 == 1) {
                0x1::vector::push_back<u64>(&mut v0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(arg0));
                continue
            };
            if (v2 == 3) {
                let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(arg0);
                if (v3 == 1) {
                    0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(arg0);
                    continue
                };
                if (v3 != 0) {
                    0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::fail(arg0);
                    continue
                } else {
                    continue
                };
            };
            let v4 = if (v2 != 2) {
                if (v2 != 4) {
                    v2 != 5
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::fail(arg0);
            };
        };
    }

    fun skip_ulebs(arg0: &mut 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::Cursor) {
        let v0 = 0;
        while (v0 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(arg0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(arg0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(arg0);
            v0 = v0 + 1;
        };
    }

    public fun template() : vector<u8> {
        b"waitlist"
    }

    // decompiled from Move bytecode v7
}

