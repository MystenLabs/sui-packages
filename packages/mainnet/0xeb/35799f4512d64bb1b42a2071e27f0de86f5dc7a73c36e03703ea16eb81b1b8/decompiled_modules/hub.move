module 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::hub {
    struct HubRegistry has key {
        id: 0x2::object::UID,
        temple_count: u64,
        post_count: u64,
        comment_count: u64,
        agent_count: u64,
    }

    struct HubAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Temple has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        creator: address,
        members: 0x2::table::Table<address, bool>,
        member_count: u64,
        post_count: u64,
        created_at: u64,
    }

    struct Post has store, key {
        id: 0x2::object::UID,
        temple_id: 0x2::object::ID,
        author: address,
        genome_id: 0x2::object::ID,
        title: vector<u8>,
        body: vector<u8>,
        link_url: vector<u8>,
        post_type: u8,
        upvotes: u64,
        downvotes: u64,
        voters: 0x2::table::Table<address, u8>,
        comment_count: u64,
        created_at: u64,
    }

    struct Comment has store, key {
        id: 0x2::object::UID,
        post_id: 0x2::object::ID,
        parent_comment_id: vector<u8>,
        author: address,
        body: vector<u8>,
        upvotes: u64,
        downvotes: u64,
        voters: 0x2::table::Table<address, u8>,
        created_at: u64,
    }

    public fun comment_author(arg0: &Comment) : address {
        arg0.author
    }

    public fun comment_downvotes(arg0: &Comment) : u64 {
        arg0.downvotes
    }

    public fun comment_post_id(arg0: &Comment) : 0x2::object::ID {
        arg0.post_id
    }

    public fun comment_upvotes(arg0: &Comment) : u64 {
        arg0.upvotes
    }

    public entry fun create_comment(arg0: &mut HubRegistry, arg1: &mut Post, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 300);
        assert!(0x1::vector::length<u8>(&arg2) <= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::body_max_length(), 301);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Comment{
            id                : 0x2::object::new(arg5),
            post_id           : 0x2::object::id<Post>(arg1),
            parent_comment_id : arg3,
            author            : v0,
            body              : arg2,
            upvotes           : 0,
            downvotes         : 0,
            voters            : 0x2::table::new<address, u8>(arg5),
            created_at        : v1,
        };
        arg1.comment_count = arg1.comment_count + 1;
        arg0.comment_count = arg0.comment_count + 1;
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_comment_created(0x2::object::id<Comment>(&v2), v2.post_id, v2.parent_comment_id, v0, v1);
        0x2::transfer::share_object<Comment>(v2);
    }

    public entry fun create_post(arg0: &mut HubRegistry, arg1: &mut Temple, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) > 0, 200);
        assert!(0x1::vector::length<u8>(&arg3) <= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::title_max_length(), 201);
        assert!(arg6 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::post_type_text() || arg6 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::post_type_link(), 202);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = Post{
            id            : 0x2::object::new(arg8),
            temple_id     : 0x2::object::id<Temple>(arg1),
            author        : v0,
            genome_id     : arg2,
            title         : arg3,
            body          : arg4,
            link_url      : arg5,
            post_type     : arg6,
            upvotes       : 0,
            downvotes     : 0,
            voters        : 0x2::table::new<address, u8>(arg8),
            comment_count : 0,
            created_at    : v1,
        };
        arg0.post_count = arg0.post_count + 1;
        arg1.post_count = arg1.post_count + 1;
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_post_created(0x2::object::id<Post>(&v2), v2.temple_id, v0, arg2, v2.title, arg6, 0x1::vector::length<u8>(&arg4) > 0, v2.link_url, v1);
        0x2::transfer::share_object<Post>(v2);
    }

    public entry fun create_temple(arg0: &mut HubRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::temple_name_min_length(), 100);
        assert!(v0 <= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::temple_name_max_length(), 101);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::table::new<address, bool>(arg4);
        0x2::table::add<address, bool>(&mut v2, v1, true);
        let v3 = Temple{
            id           : 0x2::object::new(arg4),
            name         : arg1,
            description  : arg2,
            creator      : v1,
            members      : v2,
            member_count : 1,
            post_count   : 0,
            created_at   : 0x2::clock::timestamp_ms(arg3),
        };
        arg0.temple_count = arg0.temple_count + 1;
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_temple_created(0x2::object::id<Temple>(&v3), v3.name, v3.description, v1, 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::share_object<Temple>(v3);
    }

    public entry fun delete_post(arg0: &mut HubRegistry, arg1: &mut Temple, arg2: Post, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2.author == v0, 203);
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_post_deleted(0x2::object::id<Post>(&arg2), v0, 0x2::clock::timestamp_ms(arg3));
        arg0.post_count = arg0.post_count - 1;
        arg1.post_count = arg1.post_count - 1;
        let Post {
            id            : v1,
            temple_id     : _,
            author        : _,
            genome_id     : _,
            title         : _,
            body          : _,
            link_url      : _,
            post_type     : _,
            upvotes       : _,
            downvotes     : _,
            voters        : v11,
            comment_count : _,
            created_at    : _,
        } = arg2;
        0x2::table::drop<address, u8>(v11);
        0x2::object::delete(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HubRegistry{
            id            : 0x2::object::new(arg0),
            temple_count  : 0,
            post_count    : 0,
            comment_count : 0,
            agent_count   : 0,
        };
        0x2::transfer::share_object<HubRegistry>(v0);
        let v1 = HubAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HubAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun join_temple(arg0: &mut Temple, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.members, v0), 102);
        0x2::table::add<address, bool>(&mut arg0.members, v0, true);
        arg0.member_count = arg0.member_count + 1;
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_temple_member_joined(0x2::object::id<Temple>(arg0), v0, 0x2::clock::timestamp_ms(arg1));
    }

    public entry fun leave_temple(arg0: &mut Temple, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, bool>(&arg0.members, v0), 103);
        0x2::table::remove<address, bool>(&mut arg0.members, v0);
        arg0.member_count = arg0.member_count - 1;
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_temple_member_left(0x2::object::id<Temple>(arg0), v0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun post_author(arg0: &Post) : address {
        arg0.author
    }

    public fun post_comment_count(arg0: &Post) : u64 {
        arg0.comment_count
    }

    public fun post_downvotes(arg0: &Post) : u64 {
        arg0.downvotes
    }

    public fun post_temple_id(arg0: &Post) : 0x2::object::ID {
        arg0.temple_id
    }

    public fun post_title(arg0: &Post) : &vector<u8> {
        &arg0.title
    }

    public fun post_upvotes(arg0: &Post) : u64 {
        arg0.upvotes
    }

    public fun registry_comment_count(arg0: &HubRegistry) : u64 {
        arg0.comment_count
    }

    public fun registry_post_count(arg0: &HubRegistry) : u64 {
        arg0.post_count
    }

    public fun registry_temple_count(arg0: &HubRegistry) : u64 {
        arg0.temple_count
    }

    public fun temple_creator(arg0: &Temple) : address {
        arg0.creator
    }

    public fun temple_is_member(arg0: &Temple, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.members, arg1)
    }

    public fun temple_member_count(arg0: &Temple) : u64 {
        arg0.member_count
    }

    public fun temple_name(arg0: &Temple) : &vector<u8> {
        &arg0.name
    }

    public fun temple_post_count(arg0: &Temple) : u64 {
        arg0.post_count
    }

    public entry fun vote_comment(arg0: &mut Comment, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up() || arg1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_down(), 400);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u8>(&arg0.voters, v0)) {
            let v1 = *0x2::table::borrow<address, u8>(&arg0.voters, v0);
            if (v1 == arg1) {
                0x2::table::remove<address, u8>(&mut arg0.voters, v0);
                if (v1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up()) {
                    arg0.upvotes = arg0.upvotes - 1;
                } else {
                    arg0.downvotes = arg0.downvotes - 1;
                };
                0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_vote_removed(0x2::object::id<Comment>(arg0), v0, v1, false, 0x2::clock::timestamp_ms(arg2));
            } else {
                *0x2::table::borrow_mut<address, u8>(&mut arg0.voters, v0) = arg1;
                if (v1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up()) {
                    arg0.upvotes = arg0.upvotes - 1;
                    arg0.downvotes = arg0.downvotes + 1;
                } else {
                    arg0.downvotes = arg0.downvotes - 1;
                    arg0.upvotes = arg0.upvotes + 1;
                };
                0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_vote_changed(0x2::object::id<Comment>(arg0), v0, v1, arg1, false, 0x2::clock::timestamp_ms(arg2));
            };
        } else {
            0x2::table::add<address, u8>(&mut arg0.voters, v0, arg1);
            if (arg1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up()) {
                arg0.upvotes = arg0.upvotes + 1;
            } else {
                arg0.downvotes = arg0.downvotes + 1;
            };
            0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_voted(0x2::object::id<Comment>(arg0), v0, arg1, false, 0x2::clock::timestamp_ms(arg2));
        };
    }

    public entry fun vote_post(arg0: &mut Post, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up() || arg1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_down(), 400);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u8>(&arg0.voters, v0)) {
            let v1 = *0x2::table::borrow<address, u8>(&arg0.voters, v0);
            if (v1 == arg1) {
                0x2::table::remove<address, u8>(&mut arg0.voters, v0);
                if (v1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up()) {
                    arg0.upvotes = arg0.upvotes - 1;
                } else {
                    arg0.downvotes = arg0.downvotes - 1;
                };
                0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_vote_removed(0x2::object::id<Post>(arg0), v0, v1, true, 0x2::clock::timestamp_ms(arg2));
            } else {
                *0x2::table::borrow_mut<address, u8>(&mut arg0.voters, v0) = arg1;
                if (v1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up()) {
                    arg0.upvotes = arg0.upvotes - 1;
                    arg0.downvotes = arg0.downvotes + 1;
                } else {
                    arg0.downvotes = arg0.downvotes - 1;
                    arg0.upvotes = arg0.upvotes + 1;
                };
                0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_vote_changed(0x2::object::id<Post>(arg0), v0, v1, arg1, true, 0x2::clock::timestamp_ms(arg2));
            };
        } else {
            0x2::table::add<address, u8>(&mut arg0.voters, v0, arg1);
            if (arg1 == 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::vote_up()) {
                arg0.upvotes = arg0.upvotes + 1;
            } else {
                arg0.downvotes = arg0.downvotes + 1;
            };
            0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_voted(0x2::object::id<Post>(arg0), v0, arg1, true, 0x2::clock::timestamp_ms(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

