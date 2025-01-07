module 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::postLib {
    struct Post has key {
        id: 0x2::object::UID,
        ipfsDoc: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::IpfsHash,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct PostMetaData has key {
        id: 0x2::object::UID,
        postId: 0x2::object::ID,
        postType: u8,
        postTime: u64,
        author: 0x2::object::ID,
        authorMetaData: vector<u8>,
        rating: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        communityId: 0x2::object::ID,
        language: u8,
        officialReplyMetaDataKey: u64,
        bestReplyMetaDataKey: u64,
        deletedRepliesCount: u64,
        isDeleted: bool,
        tags: vector<u64>,
        replies: 0x2::table::Table<u64, ReplyMetaData>,
        comments: 0x2::table::Table<u64, CommentMetaData>,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
        historyVotes: 0x2::vec_map::VecMap<0x2::object::ID, u8>,
    }

    struct Reply has key {
        id: 0x2::object::UID,
        ipfsDoc: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::IpfsHash,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct ReplyMetaData has store, key {
        id: 0x2::object::UID,
        replyId: 0x2::object::ID,
        postTime: u64,
        author: 0x2::object::ID,
        authorMetaData: vector<u8>,
        rating: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        parentReplyMetaDataKey: u64,
        language: u8,
        isFirstReply: bool,
        isQuickReply: bool,
        isDeleted: bool,
        comments: 0x2::table::Table<u64, CommentMetaData>,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
        historyVotes: 0x2::vec_map::VecMap<0x2::object::ID, u8>,
    }

    struct Comment has key {
        id: 0x2::object::UID,
        ipfsDoc: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::IpfsHash,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct CommentMetaData has store, key {
        id: 0x2::object::UID,
        commentId: 0x2::object::ID,
        postTime: u64,
        author: 0x2::object::ID,
        rating: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        language: u8,
        isDeleted: bool,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
        historyVotes: 0x2::vec_map::VecMap<0x2::object::ID, u8>,
    }

    struct CreatePostEvent has copy, drop {
        userId: 0x2::object::ID,
        communityId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
    }

    struct CreateReplyEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        parentReplyKey: u64,
        replyMetaDataKey: u64,
    }

    struct CreateCommentEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        parentReplyKey: u64,
        commentMetaDataKey: u64,
    }

    struct EditPostEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
    }

    struct ModeratorEditPostEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
    }

    struct EditReplyEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        replyMetaDataKey: u64,
    }

    struct ModeratorEditReplyEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        replyMetaDataKey: u64,
    }

    struct EditCommentEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        parentReplyKey: u64,
        commentMetaDataKey: u64,
    }

    struct DeletePostEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
    }

    struct DeleteReplyEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        replyMetaDataKey: u64,
    }

    struct DeleteCommentEvent has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        parentReplyKey: u64,
        commentMetaDataKey: u64,
    }

    struct ChangeStatusBestReply has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        replyMetaDataKey: u64,
    }

    struct VoteItem has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        replyMetaDataKey: u64,
        commentMetaDataKey: u64,
        voteDirection: u8,
    }

    struct PostTypeChanged has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        oldPostType: u8,
    }

    struct PostCommunityChanged has copy, drop {
        userId: 0x2::object::ID,
        postMetaDataId: 0x2::object::ID,
        oldCommunityId: 0x2::object::ID,
    }

    struct StructRating has drop {
        upvotedPost: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        downvotedPost: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        upvotedReply: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        downvotedReply: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        firstReply: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        quickReply: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        acceptReply: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
        acceptedReply: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64,
    }

    public entry fun authorEditPost(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut Post, arg5: &mut PostMetaData, arg6: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg7: vector<u8>, arg8: u8, arg9: vector<u64>, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        checkMatchItemId(0x2::object::id<Post>(arg4), arg5.postId);
        assert!(!0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::isEmptyIpfs(arg7), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getErrorInvalidIpfsHash());
        if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsHash(arg4.ipfsDoc) != arg7) {
            arg4.ipfsDoc = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsDoc(arg7, 0x1::vector::empty<u8>());
        };
        editPost(arg0, arg1, arg2, arg3, arg5, arg6, arg8, arg9, arg10, arg11);
        let v0 = EditPostEvent{
            userId         : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3),
            postMetaDataId : 0x2::object::id<PostMetaData>(arg5),
        };
        0x2::event::emit<EditPostEvent>(v0);
    }

    public entry fun authorEditReply(arg0: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg3: &mut PostMetaData, arg4: &mut Reply, arg5: u64, arg6: vector<u8>, arg7: bool, arg8: u8) {
        let v0 = getMutableReplyMetaDataSafe(arg3, arg5);
        checkMatchItemId(0x2::object::id<Reply>(arg4), v0.replyId);
        assert!(!0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::isEmptyIpfs(arg6), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getErrorInvalidIpfsHash());
        if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsHash(arg4.ipfsDoc) != arg6) {
            arg4.ipfsDoc = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsDoc(arg6, 0x1::vector::empty<u8>());
        };
        editReply(arg0, arg1, arg2, arg3, arg5, arg7, arg8);
        let v1 = EditReplyEvent{
            userId           : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg2),
            postMetaDataId   : 0x2::object::id<PostMetaData>(arg3),
            replyMetaDataKey : arg5,
        };
        0x2::event::emit<EditReplyEvent>(v1);
    }

    fun changePostCommunity(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg2: &mut PostMetaData, arg3: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community>(arg3);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::onlyNotFrozenCommunity(arg3);
        let v1 = arg2.communityId;
        let v2 = getTypesRating(arg2.postType);
        let (v3, v4) = getHistoryInformations(arg2.historyVotes);
        let v5 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v3);
        let v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v2.upvotedPost, &v5);
        let v7 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v4);
        let v8 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v2.downvotedPost, &v7);
        let v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v6, &v8);
        let v10 = 1;
        while (v10 <= 0x2::table::length<u64, ReplyMetaData>(&arg2.replies)) {
            let v11 = getReplyMetaData(arg2, v10);
            if (v11.isDeleted) {
                v10 = v10 + 1;
                continue
            };
            let (v12, v13) = getHistoryInformations(v11.historyVotes);
            let v14 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v12);
            v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v2.upvotedReply, &v14);
            let v15 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v13);
            v8 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v2.downvotedReply, &v15);
            let v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v6, &v8);
            let v17 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            let v18 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11.rating, &v17) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                true
            } else {
                let v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11.rating, &v19) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
            };
            if (v18) {
                if (v11.isFirstReply) {
                    let v20 = &v16;
                    v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v20, &v2.firstReply);
                };
                if (v11.isQuickReply) {
                    let v21 = &v16;
                    v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v21, &v2.quickReply);
                };
            };
            if (arg2.bestReplyMetaDataKey == v10 && arg2.author != v11.author) {
                let v22 = &v16;
                v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v22, &v2.acceptedReply);
                v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v16, &v2.acceptReply);
            };
            let v23 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v11.author, arg1, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v16, &v23), v1, arg4);
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v11.author, arg1, v16, v0, arg4);
            v10 = v10 + 1;
        };
        let v24 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg2.author, arg1, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v9, &v24), v1, arg4);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg2.author, arg1, v9, v0, arg4);
        arg2.communityId = v0;
    }

    fun changePostType(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg2: &mut PostMetaData, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != 2 || getActiveReplyCount(arg2) == 0, 109);
        let v0 = getTypesRating(arg2.postType);
        let v1 = getTypesRating(arg3);
        let (v2, v3) = getHistoryInformations(arg2.historyVotes);
        let v4 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.upvotedPost, &v0.upvotedPost);
        let v5 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v2);
        let v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v4, &v5);
        let v7 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.downvotedPost, &v0.downvotedPost);
        let v8 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v3);
        let v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v7, &v8);
        let v10 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v6, &v9);
        let v11 = 1;
        while (v11 <= 0x2::table::length<u64, ReplyMetaData>(&arg2.replies)) {
            let v12 = getReplyMetaData(arg2, v11);
            if (v12.isDeleted) {
                v11 = v11 + 1;
                continue
            };
            let (v13, v14) = getHistoryInformations(v12.historyVotes);
            let v15 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.upvotedReply, &v0.upvotedReply);
            let v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v13);
            v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v15, &v16);
            let v17 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.downvotedReply, &v0.downvotedReply);
            let v18 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v14);
            v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v17, &v18);
            let v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v6, &v9);
            let v20 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            let v21 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v12.rating, &v20) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                true
            } else {
                let v22 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v12.rating, &v22) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
            };
            if (v21) {
                if (v12.isFirstReply) {
                    let v23 = &v19;
                    let v24 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.firstReply, &v0.firstReply);
                    v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v23, &v24);
                };
                if (v12.isQuickReply) {
                    let v25 = &v19;
                    let v26 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.quickReply, &v0.quickReply);
                    v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v25, &v26);
                };
            };
            if (arg2.bestReplyMetaDataKey == v11 && arg2.author != v12.author) {
                let v27 = &v19;
                let v28 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.acceptedReply, &v0.acceptedReply);
                v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v27, &v28);
                let v29 = &v10;
                let v30 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v1.acceptReply, &v0.acceptReply);
                v10 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v29, &v30);
            };
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v12.author, arg1, v19, arg2.communityId, arg4);
            v11 = v11 + 1;
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg2.author, arg1, v10, arg2.communityId, arg4);
        arg2.postType = arg3;
    }

    public entry fun changeStatusBestReply(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = getReplyMetaDataSafe(arg4, arg5);
        let v1 = arg4.communityId;
        let v2 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        assert!(arg4.author == v2, 120);
        if (arg4.bestReplyMetaDataKey == arg5) {
            updateRatingForBestReply(arg0, arg2, v2, v0.author, arg4.postType, false, v1, arg6);
            arg4.bestReplyMetaDataKey = 0;
        } else {
            if (arg4.bestReplyMetaDataKey != 0) {
                updateRatingForBestReply(arg0, arg2, v2, getReplyMetaDataSafe(arg4, arg4.bestReplyMetaDataKey).author, arg4.postType, false, v1, arg6);
            };
            updateRatingForBestReply(arg0, arg2, v2, v0.author, arg4.postType, true, v1, arg6);
            arg4.bestReplyMetaDataKey = arg5;
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, v2, v1, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_best_reply(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        let v3 = ChangeStatusBestReply{
            userId           : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3),
            postMetaDataId   : 0x2::object::id<PostMetaData>(arg4),
            replyMetaDataKey : arg5,
        };
        0x2::event::emit<ChangeStatusBestReply>(v3);
    }

    fun checkMatchItemId(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 == arg1, 122);
    }

    public entry fun createComment(arg0: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &0x2::clock::Clock, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: u64, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        assert!(!0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::isEmptyIpfs(arg6), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getErrorInvalidIpfsHash());
        assert!(arg7 < 4, 124);
        let v1 = Comment{
            id         : 0x2::object::new(arg8),
            ipfsDoc    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsDoc(arg6, 0x1::vector::empty<u8>()),
            properties : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        let v2 = CommentMetaData{
            id           : 0x2::object::new(arg8),
            commentId    : 0x2::object::id<Comment>(&v1),
            postTime     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getTimestamp(arg2),
            author       : v0,
            rating       : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            language     : arg7,
            isDeleted    : false,
            properties   : 0x2::vec_map::empty<u8, vector<u8>>(),
            historyVotes : 0x2::vec_map::empty<0x2::object::ID, u8>(),
        };
        let v3 = arg4.author;
        let v4 = v3;
        let v5 = if (arg5 == 0) {
            assert!(!arg4.isDeleted, 116);
            let v6 = 0x2::table::length<u64, CommentMetaData>(&arg4.comments) + 1;
            0x2::table::add<u64, CommentMetaData>(&mut arg4.comments, v6, v2);
            v6
        } else {
            let v7 = getMutableReplyMetaDataSafe(arg4, arg5);
            if (v3 != v0) {
                v4 = v7.author;
            };
            let v8 = 0x2::table::length<u64, CommentMetaData>(&v7.comments) + 1;
            0x2::table::add<u64, CommentMetaData>(&mut v7.comments, v8, v2);
            v8
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, v4, arg4.communityId, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_publication_comment(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        0x2::transfer::transfer<Comment>(v1, 0x2::tx_context::sender(arg8));
        let v9 = CreateCommentEvent{
            userId             : v0,
            postMetaDataId     : 0x2::object::id<PostMetaData>(arg4),
            parentReplyKey     : arg5,
            commentMetaDataKey : v5,
        };
        0x2::event::emit<CreateCommentEvent>(v9);
    }

    public entry fun createPost(arg0: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &0x2::clock::Clock, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg5: vector<u8>, arg6: u8, arg7: vector<u64>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, v0, 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community>(arg4), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_publication_post(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        createPostPrivate(arg2, v0, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<u8>(), arg9);
    }

    public entry fun createPostByBot(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg1: &0x2::clock::Clock, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg3: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg4: vector<u8>, arg5: u8, arg6: vector<u64>, arg7: u8, arg8: u8, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg2), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_bot(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getZeroId());
        createPostPrivate(arg1, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::get_bot_id(), arg3, arg4, arg5, arg6, arg7, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::compose_messenger_sender_property(arg8, arg9), arg10);
    }

    fun createPostPrivate(arg0: &0x2::clock::Clock, arg1: 0x2::object::ID, arg2: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg3: vector<u8>, arg4: u8, arg5: vector<u64>, arg6: u8, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::onlyNotFrozenCommunity(arg2);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::checkTags(arg2, arg5);
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community>(arg2);
        assert!(!0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::isEmptyIpfs(arg3), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getErrorInvalidIpfsHash());
        assert!(arg6 < 4, 124);
        assert!(0x1::vector::length<u64>(&mut arg5) > 0, 123);
        let v1 = Post{
            id         : 0x2::object::new(arg8),
            ipfsDoc    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsDoc(arg3, 0x1::vector::empty<u8>()),
            properties : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        let v2 = PostMetaData{
            id                       : 0x2::object::new(arg8),
            postId                   : 0x2::object::id<Post>(&v1),
            postType                 : arg4,
            postTime                 : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getTimestamp(arg0),
            author                   : arg1,
            authorMetaData           : arg7,
            rating                   : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            communityId              : v0,
            language                 : arg6,
            officialReplyMetaDataKey : 0,
            bestReplyMetaDataKey     : 0,
            deletedRepliesCount      : 0,
            isDeleted                : false,
            tags                     : arg5,
            replies                  : 0x2::table::new<u64, ReplyMetaData>(arg8),
            comments                 : 0x2::table::new<u64, CommentMetaData>(arg8),
            properties               : 0x2::vec_map::empty<u8, vector<u8>>(),
            historyVotes             : 0x2::vec_map::empty<0x2::object::ID, u8>(),
        };
        let v3 = CreatePostEvent{
            userId         : arg1,
            communityId    : v0,
            postMetaDataId : 0x2::object::id<PostMetaData>(&v2),
        };
        0x2::event::emit<CreatePostEvent>(v3);
        0x2::transfer::share_object<PostMetaData>(v2);
        0x2::transfer::transfer<Post>(v1, 0x2::tx_context::sender(arg8));
    }

    public entry fun createReply(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &0x2::clock::Clock, arg4: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg5: &mut PostMetaData, arg6: u64, arg7: vector<u8>, arg8: bool, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg8) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_community_admin()
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none()
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg4, arg5.author, arg5.communityId, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_publication_reply(), v0);
        createReplyPrivate(arg0, arg2, arg3, 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg4), arg5, arg6, arg7, arg8, arg9, 0x1::vector::empty<u8>(), arg10);
    }

    public entry fun createReplyByBot(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &0x2::clock::Clock, arg4: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg5: &mut PostMetaData, arg6: u64, arg7: vector<u8>, arg8: u8, arg9: u8, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::checkHasRole(arg1, 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg4), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_bot(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getZeroId());
        createReplyPrivate(arg0, arg2, arg3, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::get_bot_id(), arg5, arg6, arg7, false, arg8, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::compose_messenger_sender_property(arg9, arg10), arg11);
    }

    fun createReplyPrivate(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: &mut PostMetaData, arg5: u64, arg6: vector<u8>, arg7: bool, arg8: u8, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.isDeleted, 116);
        assert!(arg4.postType != 2, 106);
        assert!(arg5 == 0, 107);
        assert!(!0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::isEmptyIpfs(arg6), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getErrorInvalidIpfsHash());
        assert!(arg8 < 4, 124);
        let v0 = 0x2::table::length<u64, ReplyMetaData>(&arg4.replies);
        if (arg4.postType == 0 || arg4.postType == 1) {
            let v1 = 1;
            while (v1 <= v0) {
                let v2 = getReplyMetaData(arg4, v1);
                assert!(arg3 != v2.author && arg3 != 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::get_bot_id() || v2.authorMetaData != arg9 || v2.isDeleted, 103);
                v1 = v1 + 1;
            };
        };
        let v3 = false;
        let v4 = false;
        let v5 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getTimestamp(arg2);
        if (arg7) {
            arg4.officialReplyMetaDataKey = v0 + 1;
        };
        if (arg4.author != arg3) {
            let v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (getActiveReplyCount(arg4) == 0) {
                v3 = true;
                let v7 = &v6;
                let v8 = getUserRatingChangeForReplyAction(arg4.postType, 5);
                v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v7, &v8);
            };
            if (v5 - arg4.postTime < 900000) {
                v4 = true;
                let v9 = &v6;
                let v10 = getUserRatingChangeForReplyAction(arg4.postType, 6);
                v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v9, &v10);
            };
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg3, arg1, v6, arg4.communityId, arg10);
        };
        let v11 = Reply{
            id         : 0x2::object::new(arg10),
            ipfsDoc    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsDoc(arg6, 0x1::vector::empty<u8>()),
            properties : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        let v12 = ReplyMetaData{
            id                     : 0x2::object::new(arg10),
            replyId                : 0x2::object::id<Reply>(&v11),
            postTime               : v5,
            author                 : arg3,
            authorMetaData         : arg9,
            rating                 : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            parentReplyMetaDataKey : arg5,
            language               : arg8,
            isFirstReply           : v3,
            isQuickReply           : v4,
            isDeleted              : false,
            comments               : 0x2::table::new<u64, CommentMetaData>(arg10),
            properties             : 0x2::vec_map::empty<u8, vector<u8>>(),
            historyVotes           : 0x2::vec_map::empty<0x2::object::ID, u8>(),
        };
        let v13 = v0 + 1;
        let v14 = CreateReplyEvent{
            userId           : arg3,
            postMetaDataId   : 0x2::object::id<PostMetaData>(arg4),
            parentReplyKey   : arg5,
            replyMetaDataKey : v13,
        };
        0x2::event::emit<CreateReplyEvent>(v14);
        0x2::table::add<u64, ReplyMetaData>(&mut arg4.replies, v13, v12);
        0x2::transfer::transfer<Reply>(v11, 0x2::tx_context::sender(arg10));
    }

    fun deductReplyRating(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg2: &ReplyMetaData, arg3: u8, arg4: bool, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2.isDeleted) {
            return
        };
        let v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        let v1 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        let v2 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&arg2.rating, &v1) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
            true
        } else {
            let v3 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&arg2.rating, &v3) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
        };
        if (v2) {
            if (arg2.isFirstReply) {
                let v4 = &v0;
                let v5 = getUserRatingChangeForReplyAction(arg3, 5);
                v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v4, &v5);
            };
            if (arg2.isQuickReply) {
                let v6 = &v0;
                let v7 = getUserRatingChangeForReplyAction(arg3, 6);
                v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v6, &v7);
            };
            if (arg4 && arg3 != 2) {
                let v8 = &v0;
                let v9 = getUserRatingChangeForReplyAction(arg3, 4);
                v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v8, &v9);
            };
        };
        let v10 = getTypesRating(arg3);
        let (v11, v12) = getHistoryInformations(arg2.historyVotes);
        let v13 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v11);
        let v14 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v10.upvotedReply, &v13);
        let v15 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v12);
        let v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v10.downvotedReply, &v15);
        let v17 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v14, &v16);
        let v18 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v17, &v18) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
            let v19 = &v0;
            v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v19, &v17);
        };
        let v20 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v0, &v20) != 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg2.author, arg1, v0, arg5, arg6);
        };
    }

    public entry fun deleteComment(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        let v1 = arg4.communityId;
        let v2 = getMutableCommentMetaDataSafe(arg4, arg5, arg6);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, v2.author, v1, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_delete_item(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        if (v0 != v2.author) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v0, arg2, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1), v1, arg7);
        };
        v2.isDeleted = true;
        let v3 = DeleteCommentEvent{
            userId             : v0,
            postMetaDataId     : 0x2::object::id<PostMetaData>(arg4),
            parentReplyKey     : arg5,
            commentMetaDataKey : arg6,
        };
        0x2::event::emit<DeleteCommentEvent>(v3);
    }

    public entry fun deletePost(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &0x2::clock::Clock, arg4: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg5: &mut PostMetaData, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg5.isDeleted, 116);
        let v0 = arg5.communityId;
        let v1 = arg5.author;
        let v2 = arg5.bestReplyMetaDataKey;
        let v3 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg4);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg4, v1, v0, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_delete_item(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        let v4 = arg5.postType;
        let v5 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getTimestamp(arg3);
        let v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        if (v5 - arg5.postTime < 604800000 || v3 == v1) {
            let v7 = getTypesRating(v4);
            let (v8, v9) = getHistoryInformations(arg5.historyVotes);
            let v10 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v8);
            let v11 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v7.upvotedPost, &v10);
            let v12 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(v9);
            let v13 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v7.downvotedPost, &v12);
            let v14 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v11, &v13);
            let v15 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v14, &v15) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                let v16 = &v6;
                v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v16, &v14);
            };
        };
        if (v2 != 0) {
            let v17 = &v6;
            let v18 = getUserRatingChangeForReplyAction(v4, 3);
            v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v17, &v18);
        };
        let v19 = if (v3 == v1) {
            let v20 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1);
            &v20
        } else {
            let v21 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(2);
            &v21
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v3, arg2, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(&v6, v19), v0, arg6);
        if (v5 - arg5.postTime < 604800000) {
            let v22 = 1;
            while (v22 <= 0x2::table::length<u64, ReplyMetaData>(&arg5.replies)) {
                deductReplyRating(arg0, arg2, getReplyMetaData(arg5, v22), v4, v2 == v22, v0, arg6);
                v22 = v22 + 1;
            };
        };
        arg5.isDeleted = true;
        let v23 = DeletePostEvent{
            userId         : v3,
            postMetaDataId : 0x2::object::id<PostMetaData>(arg5),
        };
        0x2::event::emit<DeletePostEvent>(v23);
    }

    public entry fun deleteReply(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &0x2::clock::Clock, arg4: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg5: &mut PostMetaData, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg4);
        let v1 = arg5.communityId;
        arg5.deletedRepliesCount = arg5.deletedRepliesCount + 1;
        let v2 = arg5.bestReplyMetaDataKey == arg6;
        if (v2) {
            arg5.bestReplyMetaDataKey = 0;
        };
        if (arg5.officialReplyMetaDataKey == arg6) {
            arg5.officialReplyMetaDataKey = 0;
        };
        let v3 = arg5.postType;
        let v4 = getMutableReplyMetaDataSafe(arg5, arg6);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg4, v4.author, v1, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_delete_item(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        assert!(v0 != v4.author || !v2, 105);
        let v5 = if (v0 == v4.author) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2)
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v4.author, arg2, v5, v1, arg7);
        if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getTimestamp(arg3) - v4.postTime < 604800000 || v0 == v4.author) {
            deductReplyRating(arg0, arg2, v4, v3, v4.parentReplyMetaDataKey == 0 && v2, v1, arg7);
        };
        v4.isDeleted = true;
        let v6 = DeleteReplyEvent{
            userId           : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg4),
            postMetaDataId   : 0x2::object::id<PostMetaData>(arg5),
            replyMetaDataKey : arg6,
        };
        0x2::event::emit<DeleteReplyEvent>(v6);
    }

    public entry fun editComment(arg0: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg3: &mut PostMetaData, arg4: &mut Comment, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u8) {
        assert!(!0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::isEmptyIpfs(arg7), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getErrorInvalidIpfsHash());
        let v0 = getMutableCommentMetaDataSafe(arg3, arg5, arg6);
        checkMatchItemId(0x2::object::id<Comment>(arg4), v0.commentId);
        assert!(arg8 < 4, 124);
        if (v0.language != arg8) {
            v0.language = arg8;
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg2, v0.author, arg3.communityId, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_edit_item(), 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsHash(arg4.ipfsDoc) != arg7) {
            arg4.ipfsDoc = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::commonLib::getIpfsDoc(arg7, 0x1::vector::empty<u8>());
        };
        let v1 = EditCommentEvent{
            userId             : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg2),
            postMetaDataId     : 0x2::object::id<PostMetaData>(arg3),
            parentReplyKey     : arg5,
            commentMetaDataKey : arg6,
        };
        0x2::event::emit<EditCommentEvent>(v1);
    }

    fun editPost(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg6: u8, arg7: vector<u64>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.isDeleted, 116);
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        let v1 = arg4.author;
        let v2 = if (v0 == v1) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_edit_item()
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_none()
        };
        let v3 = if (v0 == v1) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none()
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_admin_or_community_moderator()
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, v1, arg4.communityId, v2, v3);
        if (arg4.postType != arg6) {
            let v4 = PostTypeChanged{
                userId         : v0,
                postMetaDataId : 0x2::object::id<PostMetaData>(arg4),
                oldPostType    : arg4.postType,
            };
            0x2::event::emit<PostTypeChanged>(v4);
            changePostType(arg0, arg2, arg4, arg6, arg9);
        };
        if (arg4.communityId != 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community>(arg5)) {
            let v5 = PostCommunityChanged{
                userId         : v0,
                postMetaDataId : 0x2::object::id<PostMetaData>(arg4),
                oldCommunityId : arg4.communityId,
            };
            0x2::event::emit<PostCommunityChanged>(v5);
            changePostCommunity(arg0, arg2, arg4, arg5, arg9);
        };
        assert!(arg8 < 4, 124);
        if (arg4.language != arg8) {
            arg4.language = arg8;
        };
        if (0x1::vector::length<u64>(&arg7) > 0) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::checkTags(arg5, arg7);
            arg4.tags = arg7;
        };
        let v6 = EditPostEvent{
            userId         : v0,
            postMetaDataId : 0x2::object::id<PostMetaData>(arg4),
        };
        0x2::event::emit<EditPostEvent>(v6);
    }

    fun editReply(arg0: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg3: &mut PostMetaData, arg4: u64, arg5: bool, arg6: u8) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg2);
        let v1 = getMutableReplyMetaDataSafe(arg3, arg4);
        assert!(arg6 < 4, 124);
        if (v1.language != arg6) {
            v1.language = arg6;
        };
        let v2 = v1.author;
        let v3 = if (v0 == v2) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_edit_item()
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_none()
        };
        let v4 = if (arg5 || v0 != v2) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_admin_or_community_moderator()
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none()
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg2, v2, arg3.communityId, v3, v4);
        if (arg5) {
            arg3.officialReplyMetaDataKey = arg4;
        } else if (arg3.officialReplyMetaDataKey == arg4) {
            arg3.officialReplyMetaDataKey = 0;
        };
    }

    fun getActiveReplyCount(arg0: &PostMetaData) : u64 {
        0x2::table::length<u64, ReplyMetaData>(&arg0.replies) - arg0.deletedRepliesCount
    }

    public fun getCommentMetaData(arg0: &mut PostMetaData, arg1: u64, arg2: u64) : &CommentMetaData {
        getMutableCommentMetaData(arg0, arg1, arg2)
    }

    public fun getCommentMetaDataSafe(arg0: &mut PostMetaData, arg1: u64, arg2: u64) : &CommentMetaData {
        assert!(!arg0.isDeleted, 116);
        let v0 = getCommentMetaData(arg0, arg1, arg2);
        assert!(!v0.isDeleted, 118);
        v0
    }

    fun getCommonRating() : StructRating {
        StructRating{
            upvotedPost    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1),
            downvotedPost  : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1),
            upvotedReply   : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1),
            downvotedReply : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1),
            firstReply     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1),
            quickReply     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1),
            acceptReply    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1),
            acceptedReply  : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(3),
        }
    }

    fun getExpertRating() : StructRating {
        StructRating{
            upvotedPost    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5),
            downvotedPost  : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2),
            upvotedReply   : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(10),
            downvotedReply : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2),
            firstReply     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5),
            quickReply     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5),
            acceptReply    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(2),
            acceptedReply  : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(15),
        }
    }

    public fun getForumItemRatingChange(arg0: 0x2::object::ID, arg1: &mut 0x2::vec_map::VecMap<0x2::object::ID, u8>, arg2: bool) : (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64, bool) {
        let (v0, v1) = getHistoryVote(arg0, *arg1);
        let v2 = false;
        let v3 = if (arg2) {
            if (v0 == 1) {
                *0x2::vec_map::get_mut<0x2::object::ID, u8>(arg1, &arg0) = 3;
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(2)
            } else if (v0 == 2) {
                if (v1) {
                    *0x2::vec_map::get_mut<0x2::object::ID, u8>(arg1, &arg0) = 3;
                } else {
                    0x2::vec_map::insert<0x2::object::ID, u8>(arg1, arg0, 3);
                };
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
            } else {
                *0x2::vec_map::get_mut<0x2::object::ID, u8>(arg1, &arg0) = 2;
                v2 = true;
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            }
        } else if (v0 == 1) {
            *0x2::vec_map::get_mut<0x2::object::ID, u8>(arg1, &arg0) = 2;
            v2 = true;
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
        } else if (v0 == 2) {
            if (v1) {
                *0x2::vec_map::get_mut<0x2::object::ID, u8>(arg1, &arg0) = 1;
            } else {
                0x2::vec_map::insert<0x2::object::ID, u8>(arg1, arg0, 1);
            };
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u8>(arg1, &arg0) = 1;
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2)
        };
        (v3, v2)
    }

    fun getHistoryInformations(arg0: 0x2::vec_map::VecMap<0x2::object::ID, u8>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 0x2::vec_map::size<0x2::object::ID, u8>(&arg0)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u8>(&arg0, v0);
            let v5 = 3;
            if (v4 == &v5) {
                v1 = v1 + 1;
            } else {
                let v6 = 1;
                if (v4 == &v6) {
                    v2 = v2 + 1;
                };
            };
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun getHistoryVote(arg0: 0x2::object::ID, arg1: 0x2::vec_map::VecMap<0x2::object::ID, u8>) : (u8, bool) {
        if (0x2::vec_map::contains<0x2::object::ID, u8>(&arg1, &arg0)) {
            (*0x2::vec_map::get<0x2::object::ID, u8>(&arg1, &arg0), true)
        } else {
            (2, false)
        }
    }

    public fun getMutableCommentMetaData(arg0: &mut PostMetaData, arg1: u64, arg2: u64) : &mut CommentMetaData {
        assert!(arg2 > 0, 102);
        if (arg1 == 0) {
            assert!(0x2::table::length<u64, CommentMetaData>(&arg0.comments) >= arg2, 115);
            0x2::table::borrow_mut<u64, CommentMetaData>(&mut arg0.comments, arg2)
        } else {
            let v1 = getMutableReplyMetaDataSafe(arg0, arg1);
            assert!(0x2::table::length<u64, CommentMetaData>(&v1.comments) >= arg2, 115);
            0x2::table::borrow_mut<u64, CommentMetaData>(&mut v1.comments, arg2)
        }
    }

    public fun getMutableCommentMetaDataSafe(arg0: &mut PostMetaData, arg1: u64, arg2: u64) : &mut CommentMetaData {
        assert!(!arg0.isDeleted, 116);
        let v0 = getMutableCommentMetaData(arg0, arg1, arg2);
        assert!(!v0.isDeleted, 118);
        v0
    }

    public fun getMutableReplyMetaData(arg0: &mut PostMetaData, arg1: u64) : &mut ReplyMetaData {
        assert!(arg1 >= 0, 102);
        assert!(0x2::table::length<u64, ReplyMetaData>(&arg0.replies) >= arg1, 114);
        0x2::table::borrow_mut<u64, ReplyMetaData>(&mut arg0.replies, arg1)
    }

    public fun getMutableReplyMetaDataSafe(arg0: &mut PostMetaData, arg1: u64) : &mut ReplyMetaData {
        assert!(!arg0.isDeleted, 116);
        let v0 = getMutableReplyMetaData(arg0, arg1);
        assert!(!v0.isDeleted, 117);
        v0
    }

    public fun getReplyMetaData(arg0: &PostMetaData, arg1: u64) : &ReplyMetaData {
        assert!(arg1 > 0, 102);
        assert!(0x2::table::length<u64, ReplyMetaData>(&arg0.replies) >= arg1, 114);
        0x2::table::borrow<u64, ReplyMetaData>(&arg0.replies, arg1)
    }

    public fun getReplyMetaDataSafe(arg0: &PostMetaData, arg1: u64) : &ReplyMetaData {
        assert!(!arg0.isDeleted, 116);
        let v0 = getReplyMetaData(arg0, arg1);
        assert!(!v0.isDeleted, 117);
        v0
    }

    fun getTutorialRating() : StructRating {
        StructRating{
            upvotedPost    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5),
            downvotedPost  : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2),
            upvotedReply   : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            downvotedReply : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            firstReply     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            quickReply     : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            acceptReply    : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
            acceptedReply  : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero(),
        }
    }

    fun getTypesRating(arg0: u8) : StructRating {
        if (arg0 == 0) {
            getExpertRating()
        } else if (arg0 == 1) {
            getCommonRating()
        } else {
            assert!(arg0 == 2, 100);
            getTutorialRating()
        }
    }

    public fun getUserRatingChange(arg0: u8, arg1: u8, arg2: u8) : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64 {
        if (arg2 == 0) {
            getUserRatingChangeForPostAction(arg0, arg1)
        } else if (arg2 == 1) {
            getUserRatingChangeForReplyAction(arg0, arg1)
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero()
        }
    }

    fun getUserRatingChangeForPostAction(arg0: u8, arg1: u8) : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64 {
        if (arg0 == 0) {
            if (arg1 == 0) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            } else if (arg1 == 1) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5)
            } else {
                assert!(arg1 == 2, 101);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2)
            }
        } else if (arg0 == 1) {
            if (arg1 == 0) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            } else if (arg1 == 1) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
            } else {
                assert!(arg1 == 2, 101);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            }
        } else {
            assert!(arg0 == 2, 100);
            if (arg1 == 0) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            } else if (arg1 == 1) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5)
            } else {
                assert!(arg1 == 2, 101);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2)
            }
        }
    }

    public fun getUserRatingChangeForReplyAction(arg0: u8, arg1: u8) : 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64 {
        if (arg0 == 0) {
            if (arg1 == 0) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            } else if (arg1 == 1) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(10)
            } else if (arg1 == 2) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2)
            } else if (arg1 == 4) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(15)
            } else if (arg1 == 3) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(2)
            } else if (arg1 == 5) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5)
            } else {
                assert!(arg1 == 6, 101);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(5)
            }
        } else if (arg0 == 1) {
            if (arg1 == 0) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            } else if (arg1 == 1) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
            } else if (arg1 == 2) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1)
            } else if (arg1 == 4) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(3)
            } else if (arg1 == 3) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
            } else if (arg1 == 5) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
            } else {
                assert!(arg1 == 6, 101);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(1)
            }
        } else {
            assert!(arg0 == 2, 101);
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero()
        }
    }

    public entry fun moderatorEditPostMetaData(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::communityLib::Community, arg6: u8, arg7: vector<u64>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        editPost(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v0 = ModeratorEditPostEvent{
            userId         : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3),
            postMetaDataId : 0x2::object::id<PostMetaData>(arg4),
        };
        0x2::event::emit<ModeratorEditPostEvent>(v0);
    }

    public entry fun moderatorEditReply(arg0: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg3: &mut PostMetaData, arg4: u64, arg5: bool, arg6: u8) {
        editReply(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = ModeratorEditReplyEvent{
            userId           : 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg2),
            postMetaDataId   : 0x2::object::id<PostMetaData>(arg3),
            replyMetaDataKey : arg4,
        };
        0x2::event::emit<ModeratorEditReplyEvent>(v0);
    }

    fun updateRatingForBestReply(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: bool, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg2 != arg3) {
            let v0 = if (arg5) {
                getUserRatingChangeForReplyAction(arg4, 3)
            } else {
                let v1 = getUserRatingChangeForReplyAction(arg4, 3);
                let v2 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v1, &v2)
            };
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg2, arg1, v0, arg6, arg7);
            let v3 = if (arg5) {
                getUserRatingChangeForReplyAction(arg4, 4)
            } else {
                let v4 = getUserRatingChangeForReplyAction(arg4, 4);
                let v5 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v4, &v5)
            };
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg3, arg1, v3, arg6, arg7);
        };
    }

    fun vote(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: bool, arg6: 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::I64, arg7: u8, arg8: 0x2::object::ID, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        let v1 = if (arg5) {
            let v1 = getUserRatingChange(arg4, 1, arg7);
            let v2 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::from(2);
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&arg6, &v2) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()) {
                let v3 = &v1;
                let v4 = getUserRatingChange(arg4, 2, arg7);
                let v5 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                let v6 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v4, &v5);
                v1 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v3, &v6);
                let v7 = getUserRatingChange(arg4, 0, arg7);
                let v8 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v7, &v8);
            };
            let v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&arg6, &v9) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getLessThan()) {
                let v10 = &v1;
                let v11 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                v1 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(v10, &v11);
                let v12 = &v0;
                let v13 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(v12, &v13);
            };
            v1
        } else {
            let v1 = getUserRatingChange(arg4, 2, arg7);
            v0 = getUserRatingChange(arg4, 0, arg7);
            let v14 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2);
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&arg6, &v14) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()) {
                let v15 = &v1;
                let v16 = getUserRatingChange(arg4, 1, arg7);
                let v17 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                let v18 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(&v16, &v17);
                v1 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v15, &v18);
            };
            let v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&arg6, &v19) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                let v20 = &v1;
                let v21 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(1);
                v1 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(v20, &v21);
                let v22 = &v0;
                let v23 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::neg_from(2);
                v0 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::mul(v22, &v23);
            };
            v1
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg2, arg1, v0, arg8, arg9);
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, arg3, arg1, v1, arg8, arg9);
    }

    public entry fun voteComment(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg3: &mut PostMetaData, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg2);
        let v1 = arg3.communityId;
        let v2 = getMutableCommentMetaDataSafe(arg3, arg4, arg5);
        assert!(v0 != v2.author, 110);
        let v3 = &mut v2.historyVotes;
        let (v4, v5) = getForumItemRatingChange(v0, v3, arg6);
        let v6 = v4;
        let v7 = if (v5) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_cancel_vote()
        } else {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_vote_comment()
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg2, v2.author, v1, v7, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        v2.rating = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v2.rating, &v6);
        let v8 = if (v5) {
            let v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v6, &v9) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                0
            } else {
                1
            }
        } else {
            let v10 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v6, &v10) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                3
            } else {
                4
            }
        };
        let v11 = VoteItem{
            userId             : v0,
            postMetaDataId     : 0x2::object::id<PostMetaData>(arg3),
            replyMetaDataKey   : arg4,
            commentMetaDataKey : arg5,
            voteDirection      : v8,
        };
        0x2::event::emit<VoteItem>(v11);
    }

    public entry fun votePost(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.isDeleted, 116);
        let v0 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        let v1 = arg4.communityId;
        assert!(v0 != arg4.author, 112);
        let v2 = &mut arg4.historyVotes;
        let (v3, v4) = getForumItemRatingChange(v0, v2, arg5);
        let v5 = v3;
        let v6 = if (v4) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_cancel_vote()
        } else {
            let v7 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v5, &v7) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_upvote_post()
            } else {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_downvote_post()
            }
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, arg4.author, v1, v6, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        vote(arg0, arg2, v0, arg4.author, arg4.postType, arg5, v5, 0, v1, arg6);
        arg4.rating = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&arg4.rating, &v5);
        let v8 = if (v4) {
            let v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v5, &v9) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                0
            } else {
                1
            }
        } else {
            let v10 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v5, &v10) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                3
            } else {
                4
            }
        };
        let v11 = VoteItem{
            userId             : v0,
            postMetaDataId     : 0x2::object::id<PostMetaData>(arg4),
            replyMetaDataKey   : 0,
            commentMetaDataKey : 0,
            voteDirection      : v8,
        };
        0x2::event::emit<VoteItem>(v11);
    }

    public entry fun voteReply(arg0: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::UsersRatingCollection, arg1: &0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::UserRolesCollection, arg2: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::nftLib::AchievementCollection, arg3: &mut 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User, arg4: &mut PostMetaData, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4.postType;
        let v1 = 0x2::object::id<0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::User>(arg3);
        let v2 = arg4.communityId;
        let v3 = getMutableReplyMetaDataSafe(arg4, arg5);
        assert!(v1 != v3.author, 111);
        let v4 = &mut v3.historyVotes;
        let (v5, v6) = getForumItemRatingChange(v1, v4, arg6);
        let v7 = v5;
        let v8 = if (v6) {
            0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_cancel_vote()
        } else {
            let v9 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v7, &v9) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_upvote_reply()
            } else {
                0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::get_action_downvote_reply()
            }
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::checkActionRole(arg0, arg1, arg3, v3.author, v2, v8, 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib::get_action_role_none());
        let v10 = v3.rating;
        v3.rating = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(&v3.rating, &v7);
        let v11 = v3.rating;
        let v12 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
        if (v3.isFirstReply) {
            let v13 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            let v14 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v10, &v13) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getLessThan()) {
                let v15 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11, &v15) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                    true
                } else {
                    let v16 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                    0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11, &v16) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
                }
            } else {
                false
            };
            if (v14) {
                let v17 = &v12;
                let v18 = getUserRatingChangeForReplyAction(v0, 5);
                v12 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v17, &v18);
            } else {
                let v19 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                let v20 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v10, &v19) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                    true
                } else {
                    let v21 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                    0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v10, &v21) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
                };
                let v22 = if (v20) {
                    let v23 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                    0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11, &v23) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getLessThan()
                } else {
                    false
                };
                if (v22) {
                    let v24 = &v12;
                    let v25 = getUserRatingChangeForReplyAction(v0, 5);
                    v12 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v24, &v25);
                };
            };
        };
        if (v3.isQuickReply) {
            let v26 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            let v27 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v10, &v26) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getLessThan()) {
                let v28 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11, &v28) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                    true
                } else {
                    let v29 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                    0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11, &v29) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
                }
            } else {
                false
            };
            if (v27) {
                let v30 = &v12;
                let v31 = getUserRatingChangeForReplyAction(v0, 6);
                v12 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::add(v30, &v31);
            } else {
                let v32 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                let v33 = if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v10, &v32) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                    true
                } else {
                    let v34 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                    0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v10, &v34) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getEual()
                };
                let v35 = if (v33) {
                    let v36 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
                    0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v11, &v36) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getLessThan()
                } else {
                    false
                };
                if (v35) {
                    let v37 = &v12;
                    let v38 = getUserRatingChangeForReplyAction(v0, 6);
                    v12 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::sub(v37, &v38);
                };
            };
        };
        0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::userLib::updateRating(arg0, v3.author, arg2, v12, v2, arg7);
        vote(arg0, arg2, v1, v3.author, v0, arg6, v7, 1, v2, arg7);
        let v39 = if (v6) {
            let v40 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v7, &v40) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                0
            } else {
                1
            }
        } else {
            let v41 = 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::zero();
            if (0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::compare(&v7, &v41) == 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::i64Lib::getGreaterThan()) {
                3
            } else {
                4
            }
        };
        let v42 = VoteItem{
            userId             : v1,
            postMetaDataId     : 0x2::object::id<PostMetaData>(arg4),
            replyMetaDataKey   : arg5,
            commentMetaDataKey : 0,
            voteDirection      : v39,
        };
        0x2::event::emit<VoteItem>(v42);
    }

    // decompiled from Move bytecode v6
}

