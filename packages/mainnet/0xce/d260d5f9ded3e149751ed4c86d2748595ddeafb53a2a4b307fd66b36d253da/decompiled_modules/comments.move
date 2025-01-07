module 0xced260d5f9ded3e149751ed4c86d2748595ddeafb53a2a4b307fd66b36d253da::comments {
    struct Application has store, key {
        id: 0x2::object::UID,
        comments: 0x2::table::Table<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>,
    }

    struct Comment has store {
        sender: address,
        content: 0x1::string::String,
        create_time: u64,
        up_votes: u64,
        down_votes: u64,
        quote: u64,
        voters: 0x2::table::Table<address, bool>,
    }

    public fun comment(arg0: &mut Application, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>(&arg0.comments, arg1)) {
            0x2::table::add<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>(&mut arg0.comments, arg1, 0x2::table_vec::empty<Comment>(arg5));
        };
        let v0 = Comment{
            sender      : 0x2::tx_context::sender(arg5),
            content     : 0x1::string::utf8(arg2),
            create_time : 0x2::clock::timestamp_ms(arg4),
            up_votes    : 0,
            down_votes  : 0,
            quote       : arg3,
            voters      : 0x2::table::new<address, bool>(arg5),
        };
        0x2::table_vec::push_back<Comment>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>(&mut arg0.comments, arg1), v0);
    }

    public fun create_app(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Application{
            id       : 0x2::object::new(arg0),
            comments : 0x2::table::new<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>(arg0),
        };
        0x2::transfer::share_object<Application>(v0);
    }

    public fun vote(arg0: &mut Application, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>(&arg0.comments, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table_vec::TableVec<Comment>>(&mut arg0.comments, arg1);
        assert!(0x2::table_vec::length<Comment>(v1) > arg2, 2);
        let v2 = 0x2::table_vec::borrow_mut<Comment>(v1, arg2);
        assert!(!0x2::table::contains<address, bool>(&v2.voters, v0), 3);
        0x2::table::add<address, bool>(&mut v2.voters, v0, arg3);
        if (arg3) {
            v2.up_votes = v2.up_votes + 1;
        } else {
            v2.down_votes = v2.down_votes + 1;
        };
    }

    // decompiled from Move bytecode v6
}

