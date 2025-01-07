module 0xf0b959281763f3cb9e216c04eb15e26fbd07cf3a7405e0fee05069376bbbb49b::qanda {
    struct QandaCreatedEvent has copy, drop {
        qanda_id: 0x2::object::ID,
    }

    struct CommentChild has store, key {
        id: 0x2::object::UID,
        community_id: address,
        comment: 0x1::string::String,
        create_date: u64,
        owner: address,
    }

    struct Qanda has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        comment: 0x1::string::String,
        community_id: address,
        total_child: u64,
        votes: u64,
        downvotes: u64,
        child_comments: 0x2::vec_map::VecMap<u64, CommentChild>,
        create_date: u64,
        owner: address,
        users_voted: vector<address>,
        users_downvoted: vector<address>,
    }

    public entry fun down_votes(arg0: &mut Qanda, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.users_downvoted, &v0), 3);
        0x1::vector::push_back<address>(&mut arg0.users_downvoted, v0);
        arg0.downvotes = arg0.downvotes + 1;
    }

    public entry fun question(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Qanda{
            id              : 0x2::object::new(arg3),
            title           : arg0,
            comment         : arg1,
            community_id    : arg2,
            total_child     : 0,
            votes           : 0,
            downvotes       : 0,
            child_comments  : 0x2::vec_map::empty<u64, CommentChild>(),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg3),
            owner           : 0xf0b959281763f3cb9e216c04eb15e26fbd07cf3a7405e0fee05069376bbbb49b::community::get_address_admin(),
            users_voted     : 0x1::vector::empty<address>(),
            users_downvoted : 0x1::vector::empty<address>(),
        };
        let v1 = QandaCreatedEvent{qanda_id: 0x2::object::id<Qanda>(&v0)};
        0x2::event::emit<QandaCreatedEvent>(v1);
        0x2::transfer::public_transfer<Qanda>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun question_by_admin(arg0: &mut 0xf0b959281763f3cb9e216c04eb15e26fbd07cf3a7405e0fee05069376bbbb49b::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Qanda{
            id              : 0x2::object::new(arg5),
            title           : arg1,
            comment         : arg2,
            community_id    : arg4,
            total_child     : 0,
            votes           : 0,
            downvotes       : 0,
            child_comments  : 0x2::vec_map::empty<u64, CommentChild>(),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg5),
            owner           : 0xf0b959281763f3cb9e216c04eb15e26fbd07cf3a7405e0fee05069376bbbb49b::community::get_address_admin(),
            users_voted     : 0x1::vector::empty<address>(),
            users_downvoted : 0x1::vector::empty<address>(),
        };
        let v1 = QandaCreatedEvent{qanda_id: 0x2::object::id<Qanda>(&v0)};
        0x2::event::emit<QandaCreatedEvent>(v1);
        let v2 = &mut v0;
        reply_qanda(arg0, arg4, v2, arg3, arg5);
        0x2::transfer::public_transfer<Qanda>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun reply_qanda(arg0: &mut 0xf0b959281763f3cb9e216c04eb15e26fbd07cf3a7405e0fee05069376bbbb49b::community::Community, arg1: address, arg2: &mut Qanda, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0b959281763f3cb9e216c04eb15e26fbd07cf3a7405e0fee05069376bbbb49b::community::validate_owner_community(arg0, arg4);
        let v0 = CommentChild{
            id           : 0x2::object::new(arg4),
            community_id : arg1,
            comment      : arg3,
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg4),
            owner        : 0x2::tx_context::sender(arg4),
        };
        0x2::vec_map::insert<u64, CommentChild>(&mut arg2.child_comments, arg2.total_child, v0);
        arg2.total_child = arg2.total_child + 1;
    }

    public entry fun votes(arg0: &mut Qanda, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.users_voted, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.users_voted, v0);
        arg0.votes = arg0.votes + 1;
    }

    // decompiled from Move bytecode v6
}

