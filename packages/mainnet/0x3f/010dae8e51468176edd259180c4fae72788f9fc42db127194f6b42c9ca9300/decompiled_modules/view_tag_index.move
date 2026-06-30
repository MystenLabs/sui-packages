module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::view_tag_index {
    struct Bucket has copy, drop, store {
        ids: vector<u64>,
    }

    struct ViewTagIndex has key {
        id: 0x2::object::UID,
        buckets: 0x2::table::Table<vector<u8>, Bucket>,
        total_indexed: u64,
    }

    struct IdIndexed has copy, drop {
        view_tag: vector<u8>,
        announcement_id: u64,
        position: u64,
    }

    public fun bucket_length(arg0: &ViewTagIndex, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, Bucket>(&arg0.buckets, arg1)) {
            0x1::vector::length<u64>(&0x2::table::borrow<vector<u8>, Bucket>(&arg0.buckets, arg1).ids)
        } else {
            0
        }
    }

    public fun first_id(arg0: &ViewTagIndex, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (0x2::table::contains<vector<u8>, Bucket>(&arg0.buckets, arg1)) {
            let v1 = &0x2::table::borrow<vector<u8>, Bucket>(&arg0.buckets, arg1).ids;
            if (0x1::vector::is_empty<u64>(v1)) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>(*0x1::vector::borrow<u64>(v1, 0))
            }
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun has_bucket(arg0: &ViewTagIndex, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Bucket>(&arg0.buckets, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ViewTagIndex{
            id            : 0x2::object::new(arg0),
            buckets       : 0x2::table::new<vector<u8>, Bucket>(arg0),
            total_indexed : 0,
        };
        0x2::transfer::share_object<ViewTagIndex>(v0);
    }

    public fun last_id(arg0: &ViewTagIndex, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (0x2::table::contains<vector<u8>, Bucket>(&arg0.buckets, arg1)) {
            let v1 = &0x2::table::borrow<vector<u8>, Bucket>(&arg0.buckets, arg1).ids;
            if (0x1::vector::is_empty<u64>(v1)) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>(*0x1::vector::borrow<u64>(v1, 0x1::vector::length<u64>(v1) - 1))
            }
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun page(arg0: &ViewTagIndex, arg1: vector<u8>, arg2: u64, arg3: u64) : vector<u64> {
        assert!(arg3 > 0, 3);
        let v0 = if (arg3 <= 256) {
            arg3
        } else {
            256
        };
        if (!0x2::table::contains<vector<u8>, Bucket>(&arg0.buckets, arg1)) {
            return 0x1::vector::empty<u64>()
        };
        let v1 = &0x2::table::borrow<vector<u8>, Bucket>(&arg0.buckets, arg1).ids;
        let v2 = 0x1::vector::length<u64>(v1);
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v5 < v2) {
            if (*0x1::vector::borrow<u64>(v1, v5) > arg2) {
                v3 = v5;
                v4 = true;
                break
            };
            v5 = v5 + 1;
        };
        if (!v4) {
            let v6 = if (v2 > 0) {
                *0x1::vector::borrow<u64>(v1, v2 - 1)
            } else {
                0
            };
            assert!(arg2 <= v6, 2);
            return 0x1::vector::empty<u64>()
        };
        let v7 = 0x1::vector::empty<u64>();
        let v8 = v3;
        let v9 = 0;
        while (v8 < v2 && v9 < v0) {
            0x1::vector::push_back<u64>(&mut v7, *0x1::vector::borrow<u64>(v1, v8));
            v8 = v8 + 1;
            v9 = v9 + 1;
        };
        v7
    }

    public(friend) entry fun record(arg0: &mut ViewTagIndex, arg1: vector<u8>, arg2: u64) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 1);
        if (!0x2::table::contains<vector<u8>, Bucket>(&arg0.buckets, arg1)) {
            let v0 = Bucket{ids: 0x1::vector::empty<u64>()};
            0x2::table::add<vector<u8>, Bucket>(&mut arg0.buckets, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<vector<u8>, Bucket>(&mut arg0.buckets, arg1);
        0x1::vector::push_back<u64>(&mut v1.ids, arg2);
        arg0.total_indexed = arg0.total_indexed + 1;
        let v2 = IdIndexed{
            view_tag        : arg1,
            announcement_id : arg2,
            position        : 0x1::vector::length<u64>(&v1.ids),
        };
        0x2::event::emit<IdIndexed>(v2);
    }

    public fun total_indexed(arg0: &ViewTagIndex) : u64 {
        arg0.total_indexed
    }

    // decompiled from Move bytecode v7
}

