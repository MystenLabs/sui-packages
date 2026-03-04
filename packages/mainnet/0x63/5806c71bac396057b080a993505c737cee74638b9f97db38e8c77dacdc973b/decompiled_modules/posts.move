module 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts {
    struct PostInfoWithoutBlob has copy, drop {
        blob_id: u256,
        creation_time_ms: u64,
        creator: address,
        votes: u32,
        parent_prompt_id: 0x1::option::Option<u256>,
        voters: vector<address>,
    }

    struct Post has store {
        creator: address,
        creation_time_ms: u64,
        blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
        votes: u32,
        parent_prompt_id: 0x1::option::Option<u256>,
    }

    struct RankedPosts has store {
        posts: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Post>,
        last_votes: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u32, u256>,
    }

    public(friend) fun length(arg0: &RankedPosts) : u32 {
        (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::length<u256, Post>(&arg0.posts) as u32)
    }

    public(friend) fun destroy_empty(arg0: RankedPosts) {
        let RankedPosts {
            posts      : v0,
            last_votes : v1,
        } = arg0;
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u256, Post>(v0);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u32, u256>(v1);
    }

    public(friend) fun is_empty(arg0: &RankedPosts) : bool {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, Post>(&arg0.posts)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : RankedPosts {
        RankedPosts{
            posts      : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u256, Post>(arg0),
            last_votes : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u32, u256>(arg0),
        }
    }

    public(friend) fun add(arg0: &mut RankedPosts, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg2: 0x1::option::Option<u256>, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(&arg1), 3);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::game_utils::validate_blob_lifetime(&arg1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3));
        let v0 = create_post(arg1, arg2, arg4, arg5);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v0.blob);
        assert!(!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, v1), 0);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Post>(&mut arg0.posts, v1, v0);
        if (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, 0)) {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u32, u256>(&mut arg0.last_votes, 0, v1);
        } else {
            *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, 0) = v1;
        };
    }

    public(friend) fun check_user_has_submit_post(arg0: &RankedPosts, arg1: address, arg2: u256) : bool {
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v0)) {
            let v1 = *0x1::option::borrow<u256>(v0);
            let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v1);
            let v3 = if (v2.creator == arg1) {
                if (0x1::option::is_some<u256>(&v2.parent_prompt_id)) {
                    *0x1::option::borrow<u256>(&v2.parent_prompt_id) == arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                return true
            };
            v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v1);
        };
        false
    }

    public(friend) fun contains_post(arg0: &RankedPosts, arg1: u256) : bool {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, arg1)
    }

    public(friend) fun create_post(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: 0x1::option::Option<u256>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : Post {
        Post{
            creator          : 0x2::tx_context::sender(arg3),
            creation_time_ms : 0x2::clock::timestamp_ms(arg2),
            blob             : arg0,
            votes            : 0,
            parent_prompt_id : arg1,
        }
    }

    public(friend) fun delete_blob_and_return_storage(arg0: Post, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        let Post {
            creator          : _,
            creation_time_ms : _,
            blob             : v2,
            votes            : _,
            parent_prompt_id : _,
        } = arg0;
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, v2)
    }

    public(friend) fun delete_blob_from_post_and_send_storage(arg0: Post, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: address) : u64 {
        let Post {
            creator          : _,
            creation_time_ms : _,
            blob             : v2,
            votes            : _,
            parent_prompt_id : _,
        } = arg0;
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, v2);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v5, arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v5)
    }

    public(friend) fun destroy(arg0: RankedPosts, arg1: &mut 0x2::tx_context::TxContext) {
        let RankedPosts {
            posts      : v0,
            last_votes : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, Post>(&v3)) {
            let (_, v5) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u256, Post>(&mut v3);
            let Post {
                creator          : v6,
                creation_time_ms : _,
                blob             : v8,
                votes            : _,
                parent_prompt_id : _,
            } = v5;
            0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v8, v6);
        };
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u32, u256>(&v2)) {
            let (_, _) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u32, u256>(&mut v2);
        };
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u256, Post>(v3);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u32, u256>(v2);
    }

    public(friend) fun extract_empty_tables(arg0: RankedPosts) : (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Post>, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u32, u256>) {
        let RankedPosts {
            posts      : v0,
            last_votes : v1,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun get_all_posts(arg0: &RankedPosts) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v1)) {
            let v2 = *0x1::option::borrow<u256>(v1);
            0x1::vector::push_back<u256>(&mut v0, v2);
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v2);
        };
        v0
    }

    public(friend) fun get_blob_creation_time_from_info(arg0: &PostInfoWithoutBlob) : u64 {
        arg0.creation_time_ms
    }

    public(friend) fun get_blob_from_post(arg0: &Post) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &arg0.blob
    }

    public(friend) fun get_blob_id_from_info(arg0: &PostInfoWithoutBlob) : u256 {
        arg0.blob_id
    }

    public(friend) fun get_blob_mut_from_post(arg0: &mut Post) : &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &mut arg0.blob
    }

    public(friend) fun get_creation_time_from_post_struct(arg0: &Post) : u64 {
        arg0.creation_time_ms
    }

    public(friend) fun get_parent_prompt_from_post_struct(arg0: &Post) : &0x1::option::Option<u256> {
        &arg0.parent_prompt_id
    }

    public(friend) fun get_post(arg0: &RankedPosts, arg1: u256) : &Post {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1)
    }

    public(friend) fun get_post_blob(arg0: &RankedPosts, arg1: u256) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1).blob
    }

    public(friend) fun get_post_by_blob_id(arg0: &RankedPosts, arg1: u256) : &Post {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1)
    }

    public(friend) fun get_post_creator(arg0: &RankedPosts, arg1: u256) : address {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1).creator
    }

    public(friend) fun get_post_creator_from_post(arg0: &Post) : address {
        arg0.creator
    }

    public(friend) fun get_post_parent_prompt(arg0: &RankedPosts, arg1: u256) : &0x1::option::Option<u256> {
        &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1).parent_prompt_id
    }

    public(friend) fun get_post_votes(arg0: &RankedPosts, arg1: u256) : u32 {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1).votes
    }

    public(friend) fun get_post_with_info(arg0: &RankedPosts, arg1: u256) : 0x1::option::Option<PostInfoWithoutBlob> {
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, arg1)) {
            let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1);
            let v2 = PostInfoWithoutBlob{
                blob_id          : arg1,
                creation_time_ms : v1.creation_time_ms,
                creator          : v1.creator,
                votes            : v1.votes,
                parent_prompt_id : v1.parent_prompt_id,
                voters           : 0x1::vector::empty<address>(),
            };
            0x1::option::some<PostInfoWithoutBlob>(v2)
        } else {
            0x1::option::none<PostInfoWithoutBlob>()
        }
    }

    public(friend) fun get_posts_by_parent_prompt(arg0: &RankedPosts, arg1: u256) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v1)) {
            let v2 = *0x1::option::borrow<u256>(v1);
            let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v2);
            if (0x1::option::is_some<u256>(&v3.parent_prompt_id) && *0x1::option::borrow<u256>(&v3.parent_prompt_id) == arg1) {
                0x1::vector::push_back<u256>(&mut v0, v2);
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v2);
        };
        v0
    }

    public(friend) fun get_posts_by_parent_prompt_with_info(arg0: &RankedPosts, arg1: u256) : vector<PostInfoWithoutBlob> {
        let v0 = 0x1::vector::empty<PostInfoWithoutBlob>();
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v1)) {
            let v2 = *0x1::option::borrow<u256>(v1);
            let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v2);
            if (0x1::option::is_some<u256>(&v3.parent_prompt_id) && *0x1::option::borrow<u256>(&v3.parent_prompt_id) == arg1) {
                let v4 = PostInfoWithoutBlob{
                    blob_id          : v2,
                    creation_time_ms : v3.creation_time_ms,
                    creator          : v3.creator,
                    votes            : v3.votes,
                    parent_prompt_id : v3.parent_prompt_id,
                    voters           : 0x1::vector::empty<address>(),
                };
                0x1::vector::push_back<PostInfoWithoutBlob>(&mut v0, v4);
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v2);
        };
        v0
    }

    public(friend) fun get_posts_count_by_parent_prompt(arg0: &RankedPosts, arg1: u256) : u32 {
        let v0 = 0;
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v1)) {
            let v2 = *0x1::option::borrow<u256>(v1);
            let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v2);
            if (0x1::option::is_some<u256>(&v3.parent_prompt_id) && *0x1::option::borrow<u256>(&v3.parent_prompt_id) == arg1) {
                v0 = v0 + 1;
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v2);
        };
        v0
    }

    public(friend) fun get_posts_with_vote_count(arg0: &RankedPosts, arg1: u32) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        if (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, arg1)) {
            return v0
        };
        let v1 = 0x1::option::some<u256>(*0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u32, u256>(&arg0.last_votes, arg1));
        while (0x1::option::is_some<u256>(&v1)) {
            let v2 = *0x1::option::borrow<u256>(&v1);
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v2).votes == arg1) {
                0x1::vector::push_back<u256>(&mut v0, v2);
                v1 = *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::prev<u256, Post>(&arg0.posts, v2);
            } else {
                break
            };
        };
        v0
    }

    public(friend) fun get_top_posts_by_votes(arg0: &RankedPosts, arg1: u64) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u32>();
        let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v3)) {
            let v4 = *0x1::option::borrow<u256>(v3);
            0x1::vector::push_back<u256>(&mut v1, v4);
            0x1::vector::push_back<u32>(&mut v2, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v4).votes);
            v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v4);
        };
        let v5 = 0x1::vector::length<u256>(&v1);
        let v6 = 0;
        while (v6 < arg1 && v6 < v5) {
            let v7 = 0;
            let v8 = false;
            let v9 = 0;
            while (v9 < v5) {
                if (*0x1::vector::borrow<u256>(&v1, v9) != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                    if (!v8 || *0x1::vector::borrow<u32>(&v2, v9) > 0) {
                        v8 = true;
                    };
                };
                v9 = v9 + 1;
            };
            if (v8) {
                0x1::vector::push_back<u256>(&mut v0, *0x1::vector::borrow<u256>(&v1, v7));
                *0x1::vector::borrow_mut<u256>(&mut v1, v7) = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
                v6 = v6 + 1;
            } else {
                break
            };
        };
        v0
    }

    public(friend) fun get_votes_from_post_struct(arg0: &Post) : u32 {
        arg0.votes
    }

    public(friend) fun post_to_summary(arg0: &Post) : (u256, 0x2::object::ID, address, u64, u32, 0x1::option::Option<u256>) {
        (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg0.blob), 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob), arg0.creator, arg0.creation_time_ms, arg0.votes, arg0.parent_prompt_id)
    }

    public(friend) fun remove_winner_mut(arg0: &mut RankedPosts, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : (Post, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Post>) {
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u256, Post>(arg2);
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, Post>(&arg0.posts)) {
            let (v1, v2) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u256, Post>(&mut arg0.posts);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Post>(&mut v0, v1, v2);
        };
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u32, u256>(&arg0.last_votes)) {
            let (_, _) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u32, u256>(&mut arg0.last_votes);
        };
        (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Post>(&mut arg0.posts, arg1), v0)
    }

    public(friend) fun remove_winners(arg0: RankedPosts, arg1: u32) : (vector<Post>, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Post>, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u32, u256>) {
        let v0 = get_top_posts_by_votes(&arg0, (arg1 as u64));
        let RankedPosts {
            posts      : v1,
            last_votes : v2,
        } = arg0;
        let v3 = v1;
        let v4 = (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::length<u256, Post>(&v3) as u32);
        let v5 = if (v4 < arg1) {
            v4
        } else {
            arg1
        };
        let v6 = v5;
        let v7 = 0x1::vector::empty<Post>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u256>(&v0) && v6 > 0) {
            let v9 = *0x1::vector::borrow<u256>(&v0, v8);
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&v3, v9)) {
                0x1::vector::push_back<Post>(&mut v7, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Post>(&mut v3, v9));
                v6 = v6 - 1;
            };
            v8 = v8 + 1;
        };
        (v7, v3, v2)
    }

    public(friend) fun select_winner(arg0: &RankedPosts, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u256> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        let v2 = false;
        let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        while (0x1::option::is_some<u256>(v3)) {
            let v4 = *0x1::option::borrow<u256>(v3);
            let v5 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v4);
            v2 = true;
            if (v5.votes > v0) {
                v0 = v5.votes;
                v1 = 0x1::vector::empty<u256>();
                0x1::vector::push_back<u256>(&mut v1, v4);
            } else if (v5.votes == v0) {
                0x1::vector::push_back<u256>(&mut v1, v4);
            };
            v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v4);
        };
        if (!v2 || 0x1::vector::is_empty<u256>(&v1)) {
            return 0x1::option::none<u256>()
        };
        if (0x1::vector::length<u256>(&v1) == 1) {
            return 0x1::option::some<u256>(*0x1::vector::borrow<u256>(&v1, 0))
        };
        let v6 = 0;
        let v7 = 0x1::vector::empty<u256>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u256>(&v1)) {
            let v9 = *0x1::vector::borrow<u256>(&v1, v8);
            let v10 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(&0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v9).blob);
            if (v10 > v6) {
                v7 = 0x1::vector::empty<u256>();
                0x1::vector::push_back<u256>(&mut v7, v9);
            } else if (v10 == v6) {
                0x1::vector::push_back<u256>(&mut v7, v9);
            };
            v8 = v8 + 1;
        };
        if (0x1::vector::length<u256>(&v7) == 1) {
            return 0x1::option::some<u256>(*0x1::vector::borrow<u256>(&v7, 0))
        };
        let v11 = 0x2::random::new_generator(arg1, arg2);
        0x1::option::some<u256>(*0x1::vector::borrow<u256>(&v7, 0x2::random::generate_u64_in_range(&mut v11, 0, 0x1::vector::length<u256>(&v7) - 1)))
    }

    public(friend) fun set_post_info_voters(arg0: &mut PostInfoWithoutBlob, arg1: vector<address>) {
        arg0.voters = arg1;
    }

    public(friend) fun transfer_blob_from_post(arg0: Post, arg1: address) {
        let Post {
            creator          : _,
            creation_time_ms : _,
            blob             : v2,
            votes            : _,
            parent_prompt_id : _,
        } = arg0;
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v2, arg1);
    }

    public fun unvote(arg0: &mut RankedPosts, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, arg1), 1);
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Post>(&mut arg0.posts, arg1);
        let v1 = v0.votes;
        assert!(v1 > 0, 2);
        let v2 = v1 - 1;
        v0.votes = v2;
        if (v2 > 0) {
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, v2)) {
                let v3 = *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u32, u256>(&arg0.last_votes, v2);
                if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, v3)) {
                    0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::insert_after<u256, Post>(&mut arg0.posts, v3, arg1, v0);
                    *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, v2) = arg1;
                } else {
                    0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u256, Post>(&mut arg0.posts, arg1, v0);
                    *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, v2) = arg1;
                };
            } else {
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Post>(&mut arg0.posts, arg1, v0);
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u32, u256>(&mut arg0.last_votes, v2, arg1);
            };
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Post>(&mut arg0.posts, arg1, v0);
        };
        let v4 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Post>(&arg0.posts);
        let v5 = 0x1::option::none<u256>();
        while (0x1::option::is_some<u256>(v4)) {
            let v6 = *0x1::option::borrow<u256>(v4);
            if (v6 != arg1 && 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, v6).votes == v1) {
                v5 = 0x1::option::some<u256>(v6);
                break
            };
            v4 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Post>(&arg0.posts, v6);
        };
        let v7 = v5;
        if (0x1::option::is_some<u256>(&v7)) {
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, v1)) {
                *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, v1) = 0x1::option::extract<u256>(&mut v7);
            };
        } else if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, v1)) {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u32, u256>(&mut arg0.last_votes, v1);
        };
    }

    public fun vote(arg0: &mut RankedPosts, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, arg1), 1);
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::prev<u256, Post>(&arg0.posts, arg1);
        let v1 = if (0x1::option::is_some<u256>(v0) && 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, *0x1::option::borrow<u256>(v0)).votes == 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Post>(&arg0.posts, arg1).votes) {
            *v0
        } else {
            0x1::option::none<u256>()
        };
        let v2 = v1;
        let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Post>(&mut arg0.posts, arg1);
        let v4 = v3.votes;
        assert!(v4 < 4294967295, 2);
        let v5 = v4 + 1;
        v3.votes = v5;
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, v5)) {
            let v6 = *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u32, u256>(&arg0.last_votes, v5);
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Post>(&arg0.posts, v6)) {
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::insert_after<u256, Post>(&mut arg0.posts, v6, arg1, v3);
                *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, v5) = arg1;
            } else {
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u256, Post>(&mut arg0.posts, arg1, v3);
                *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, v5) = arg1;
            };
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u256, Post>(&mut arg0.posts, arg1, v3);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u32, u256>(&mut arg0.last_votes, v5, arg1);
        };
        if (0x1::option::is_some<u256>(&v2)) {
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, v4)) {
                *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u32, u256>(&mut arg0.last_votes, v4) = 0x1::option::extract<u256>(&mut v2);
            };
        } else if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u32, u256>(&arg0.last_votes, v4)) {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u32, u256>(&mut arg0.last_votes, v4);
        };
    }

    // decompiled from Move bytecode v6
}

