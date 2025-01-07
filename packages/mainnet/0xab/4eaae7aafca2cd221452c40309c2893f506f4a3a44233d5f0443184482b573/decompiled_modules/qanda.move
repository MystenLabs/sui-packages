module 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::qanda {
    struct QandaCreatedEvent has copy, drop {
        qanda_id: 0x2::object::ID,
    }

    struct CommentChild has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        comment: 0x1::string::String,
        create_date: u64,
        owner: address,
    }

    struct Qanda has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        comment: 0x1::string::String,
        community_id: 0x2::object::ID,
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

    public entry fun question(arg0: &mut 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Qanda{
            id              : 0x2::object::new(arg3),
            title           : arg1,
            comment         : arg2,
            community_id    : 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::get_id(arg0),
            total_child     : 0,
            votes           : 0,
            downvotes       : 0,
            child_comments  : 0x2::vec_map::empty<u64, CommentChild>(),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg3),
            owner           : 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::get_address_admin(),
            users_voted     : 0x1::vector::empty<address>(),
            users_downvoted : 0x1::vector::empty<address>(),
        };
        let v1 = QandaCreatedEvent{qanda_id: 0x2::object::id<Qanda>(&v0)};
        0x2::event::emit<QandaCreatedEvent>(v1);
        0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::update_qandas(arg0, arg3);
        0x2::transfer::share_object<Qanda>(v0);
    }

    public entry fun question_by_admin(arg0: &mut 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Qanda{
            id              : 0x2::object::new(arg4),
            title           : arg1,
            comment         : arg2,
            community_id    : 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::get_id(arg0),
            total_child     : 0,
            votes           : 0,
            downvotes       : 0,
            child_comments  : 0x2::vec_map::empty<u64, CommentChild>(),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg4),
            owner           : 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::get_address_admin(),
            users_voted     : 0x1::vector::empty<address>(),
            users_downvoted : 0x1::vector::empty<address>(),
        };
        let v1 = QandaCreatedEvent{qanda_id: 0x2::object::id<Qanda>(&v0)};
        0x2::event::emit<QandaCreatedEvent>(v1);
        let v2 = &mut v0;
        reply_qanda(arg0, v2, arg3, arg4);
        0x2::transfer::share_object<Qanda>(v0);
    }

    public entry fun reply_qanda(arg0: &mut 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::Community, arg1: &mut Qanda, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::validate_owner_community(arg0, arg3);
        let v0 = CommentChild{
            id           : 0x2::object::new(arg3),
            community_id : 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community::get_id(arg0),
            comment      : arg2,
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            owner        : 0x2::tx_context::sender(arg3),
        };
        0x2::vec_map::insert<u64, CommentChild>(&mut arg1.child_comments, arg1.total_child, v0);
        arg1.total_child = arg1.total_child + 1;
    }

    public entry fun votes(arg0: &mut Qanda, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.users_voted, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.users_voted, v0);
        arg0.votes = arg0.votes + 1;
    }

    // decompiled from Move bytecode v6
}

