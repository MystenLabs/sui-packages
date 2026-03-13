module 0xc1e6325088dd28f56b192e79c16e12f337cee45df43ddbf5ea10b168eee9d116::forum {
    struct ForumAdminCap has store, key {
        id: 0x2::object::UID,
        forum_id: address,
    }

    struct Forum has key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        slug: vector<u8>,
        description: vector<u8>,
        thread_fee: u64,
        reply_fee: u64,
        creator_share_bps: u64,
        platform_fee_bps: u64,
        platform_wallet: address,
        arweave_fund: 0x2::balance::Balance<0x2::sui::SUI>,
        total_threads: u64,
        total_posts: u64,
        total_tips: u64,
        active: bool,
        created_at: u64,
    }

    struct ForumCreated has copy, drop {
        forum_id: address,
        creator: address,
        name: vector<u8>,
        slug: vector<u8>,
        thread_fee: u64,
        reply_fee: u64,
    }

    struct ThreadPosted has copy, drop {
        forum_id: address,
        author: address,
        title_hash: vector<u8>,
        arweave_tx_id: vector<u8>,
        fee_paid: u64,
        thread_index: u64,
    }

    struct ReplyPosted has copy, drop {
        forum_id: address,
        thread_index: u64,
        author: address,
        arweave_tx_id: vector<u8>,
        reply_to_index: u64,
        fee_paid: u64,
        post_index: u64,
    }

    struct Upvoted has copy, drop {
        forum_id: address,
        post_index: u64,
        voter: address,
    }

    struct Downvoted has copy, drop {
        forum_id: address,
        post_index: u64,
        voter: address,
    }

    struct Tipped has copy, drop {
        forum_id: address,
        post_index: u64,
        tipper: address,
        amount: u64,
        author_share: u64,
        creator_share: u64,
    }

    entry fun create_forum(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) > 0, 0);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 1);
        assert!(arg3 <= 10000000000, 2);
        assert!(arg4 <= 10000000000, 3);
        assert!(arg5 <= 9000, 4);
        assert!(arg6 <= 1000, 5);
        assert!(arg5 + arg6 <= 10000, 4);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = Forum{
            id                : 0x2::object::new(arg8),
            creator           : v0,
            name              : arg0,
            slug              : arg1,
            description       : arg2,
            thread_fee        : arg3,
            reply_fee         : arg4,
            creator_share_bps : arg5,
            platform_fee_bps  : arg6,
            platform_wallet   : arg7,
            arweave_fund      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_threads     : 0,
            total_posts       : 0,
            total_tips        : 0,
            active            : true,
            created_at        : 0x2::tx_context::epoch(arg8),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        let v3 = ForumAdminCap{
            id       : 0x2::object::new(arg8),
            forum_id : v2,
        };
        let v4 = ForumCreated{
            forum_id   : v2,
            creator    : v0,
            name       : v1.name,
            slug       : v1.slug,
            thread_fee : arg3,
            reply_fee  : arg4,
        };
        0x2::event::emit<ForumCreated>(v4);
        0x2::transfer::share_object<Forum>(v1);
        0x2::transfer::transfer<ForumAdminCap>(v3, v0);
    }

    entry fun downvote(arg0: &Forum, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = Downvoted{
            forum_id   : 0x2::object::uid_to_address(&arg0.id),
            post_index : arg1,
            voter      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Downvoted>(v0);
    }

    public fun get_arweave_fund_balance(arg0: &Forum) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.arweave_fund)
    }

    public fun get_forum_creator(arg0: &Forum) : address {
        arg0.creator
    }

    public fun get_forum_name(arg0: &Forum) : vector<u8> {
        arg0.name
    }

    public fun get_reply_fee(arg0: &Forum) : u64 {
        arg0.reply_fee
    }

    public fun get_thread_fee(arg0: &Forum) : u64 {
        arg0.thread_fee
    }

    public fun get_total_posts(arg0: &Forum) : u64 {
        arg0.total_posts
    }

    public fun get_total_threads(arg0: &Forum) : u64 {
        arg0.total_threads
    }

    public fun is_active(arg0: &Forum) : bool {
        arg0.active
    }

    entry fun post_reply(arg0: &mut Forum, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 7);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg0.reply_fee, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v2 = arg0.reply_fee;
        if (v2 > 0) {
            let v3 = &mut v1;
            split_fee(arg0, v3, v2, arg5);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg0.total_posts = arg0.total_posts + 1;
        let v4 = ReplyPosted{
            forum_id       : 0x2::object::uid_to_address(&arg0.id),
            thread_index   : arg1,
            author         : v0,
            arweave_tx_id  : arg3,
            reply_to_index : arg2,
            fee_paid       : v2,
            post_index     : arg0.total_posts,
        };
        0x2::event::emit<ReplyPosted>(v4);
    }

    entry fun post_thread(arg0: &mut Forum, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 7);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.thread_fee, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v2 = arg0.thread_fee;
        if (v2 > 0) {
            let v3 = &mut v1;
            split_fee(arg0, v3, v2, arg4);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg0.total_threads = arg0.total_threads + 1;
        arg0.total_posts = arg0.total_posts + 1;
        let v4 = ThreadPosted{
            forum_id      : 0x2::object::uid_to_address(&arg0.id),
            author        : v0,
            title_hash    : arg1,
            arweave_tx_id : arg2,
            fee_paid      : v2,
            thread_index  : arg0.total_threads,
        };
        0x2::event::emit<ThreadPosted>(v4);
    }

    fun split_fee(arg0: &mut Forum, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * arg0.creator_share_bps / 10000;
        let v1 = arg2 * arg0.platform_fee_bps / 10000;
        let v2 = arg2 - v0 - v1;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, v0), arg3), arg0.creator);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, v1), arg3), arg0.platform_wallet);
        };
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.arweave_fund, 0x2::balance::split<0x2::sui::SUI>(arg1, v2));
        };
    }

    entry fun tip(arg0: &mut Forum, arg1: u64, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 6);
        let v1 = v0 * 8500 / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), arg4), arg2);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), arg0.creator);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        arg0.total_tips = arg0.total_tips + 1;
        let v4 = Tipped{
            forum_id      : 0x2::object::uid_to_address(&arg0.id),
            post_index    : arg1,
            tipper        : 0x2::tx_context::sender(arg4),
            amount        : v0,
            author_share  : v1,
            creator_share : v2,
        };
        0x2::event::emit<Tipped>(v4);
    }

    entry fun update_forum(arg0: &ForumAdminCap, arg1: &mut Forum, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        assert!(arg0.forum_id == 0x2::object::uid_to_address(&arg1.id), 8);
        assert!(arg2 <= 10000000000, 2);
        assert!(arg3 <= 10000000000, 3);
        assert!(arg4 <= 9000, 4);
        assert!(arg5 <= 1000, 5);
        assert!(arg4 + arg5 <= 10000, 4);
        arg1.thread_fee = arg2;
        arg1.reply_fee = arg3;
        arg1.creator_share_bps = arg4;
        arg1.platform_fee_bps = arg5;
        arg1.active = arg6;
    }

    entry fun upvote(arg0: &Forum, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = Upvoted{
            forum_id   : 0x2::object::uid_to_address(&arg0.id),
            post_index : arg1,
            voter      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Upvoted>(v0);
    }

    entry fun withdraw_arweave_fund(arg0: &ForumAdminCap, arg1: &mut Forum, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.forum_id == 0x2::object::uid_to_address(&arg1.id), 8);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.arweave_fund);
        assert!(v0 > 0, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.arweave_fund, v0), arg2), arg1.creator);
    }

    // decompiled from Move bytecode v6
}

