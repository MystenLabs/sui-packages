module 0x1f486267c1982b1a9d788a775994016962dcd04ba1a6ff7e79e3600b608c1c11::cep {
    struct ContentInfo has store, key {
        id: 0x2::object::UID,
        content_used_points: 0x2::table::Table<0x1::string::String, u64>,
        total_accrued_points: 0x2::table::Table<address, u64>,
        content_like_count: 0x2::table::Table<0x1::string::String, 0x2::vec_set::VecSet<address>>,
        registered_content: vector<address>,
        content_creator: 0x2::table::Table<0x1::string::String, address>,
    }

    struct Content has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        owner: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        tag: 0x1::string::String,
        file_type: 0x1::string::String,
    }

    public fun check_content_like(arg0: &ContentInfo, arg1: 0x1::string::String, arg2: address) : bool {
        0x2::vec_set::contains<address>(0x2::table::borrow<0x1::string::String, 0x2::vec_set::VecSet<address>>(&arg0.content_like_count, arg1), &arg2)
    }

    public fun content_incentivized(arg0: &0x1f486267c1982b1a9d788a775994016962dcd04ba1a6ff7e79e3600b608c1c11::roles::AdminCap, arg1: 0x1::string::String, arg2: &mut ContentInfo) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg2.content_used_points, arg1);
        *v0 = *v0 + 1;
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg2.total_accrued_points, *0x2::table::borrow<0x1::string::String, address>(&arg2.content_creator, arg1));
        *v1 = *v1 + 1;
    }

    public fun get_content_accrued_points(arg0: &ContentInfo, arg1: 0x1::string::String) : u64 {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.content_used_points, arg1), 4);
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.content_used_points, arg1)
    }

    public fun get_content_liked_address(arg0: &ContentInfo, arg1: 0x1::string::String) : 0x2::vec_set::VecSet<address> {
        assert!(0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<address>>(&arg0.content_like_count, arg1), 4);
        *0x2::table::borrow<0x1::string::String, 0x2::vec_set::VecSet<address>>(&arg0.content_like_count, arg1)
    }

    public fun get_like(arg0: &ContentInfo, arg1: 0x1::string::String) : u64 {
        assert!(0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<address>>(&arg0.content_like_count, arg1), 4);
        0x2::vec_set::size<address>(0x2::table::borrow<0x1::string::String, 0x2::vec_set::VecSet<address>>(&arg0.content_like_count, arg1))
    }

    public fun get_registered_content(arg0: &ContentInfo) : vector<address> {
        arg0.registered_content
    }

    public fun get_total_accrued_points(arg0: &ContentInfo, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.total_accrued_points, arg1), 100);
        *0x2::table::borrow<address, u64>(&arg0.total_accrued_points, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ContentInfo{
            id                   : 0x2::object::new(arg0),
            content_used_points  : 0x2::table::new<0x1::string::String, u64>(arg0),
            total_accrued_points : 0x2::table::new<address, u64>(arg0),
            content_like_count   : 0x2::table::new<0x1::string::String, 0x2::vec_set::VecSet<address>>(arg0),
            registered_content   : 0x1::vector::empty<address>(),
            content_creator      : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<ContentInfo>(v0);
    }

    public fun like_content(arg0: 0x1::string::String, arg1: &mut ContentInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg1.content_like_count, arg0);
        assert!(!0x2::vec_set::contains<address>(v1, &v0), 2);
        0x2::vec_set::insert<address>(v1, v0);
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg1.total_accrued_points, *0x2::table::borrow<0x1::string::String, address>(&arg1.content_creator, arg0));
        *v2 = *v2 + 1;
    }

    public fun mint_content(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut ContentInfo, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<address>>(&arg5.content_like_count, arg4), 101);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = Content{
            id          : 0x2::object::new(arg6),
            blob_id     : arg4,
            owner       : v0,
            title       : arg0,
            description : arg1,
            tag         : arg2,
            file_type   : arg3,
        };
        0x2::table::add<0x1::string::String, address>(&mut arg5.content_creator, arg4, v0);
        0x2::table::add<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg5.content_like_count, arg4, 0x2::vec_set::empty<address>());
        0x1::vector::push_back<address>(&mut arg5.registered_content, 0x2::object::uid_to_address(&v1.id));
        0x2::table::add<0x1::string::String, u64>(&mut arg5.content_used_points, arg4, 0);
        if (!0x2::table::contains<address, u64>(&arg5.total_accrued_points, v0)) {
            0x2::table::add<address, u64>(&mut arg5.total_accrued_points, v0, 0);
        };
        0x2::transfer::transfer<Content>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

