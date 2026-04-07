module 0xae404257f0c7d57429b55a526bc96f054585092da4276c668f9f0befecf46279::curator {
    struct CurationHub has key {
        id: 0x2::object::UID,
        contents: 0x2::table::Table<0x1::ascii::String, CollectionConfig>,
        version: u8,
    }

    struct CollectionConfig has store {
        owner: address,
        moderator: address,
        status: u8,
        approved_vault: address,
        review_vault: address,
        approval_rate: u8,
        contents: 0x2::table::Table<0x2::object::ID, ContentMeta>,
    }

    struct ContentMeta has copy, drop, store {
        content_type: 0x1::ascii::String,
        rating: u64,
        curated: bool,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x1::ascii::String,
        owner: address,
    }

    struct ContentSubmitted has copy, drop {
        collection_id: 0x1::ascii::String,
        content_id: 0x2::object::ID,
        content_type: 0x1::ascii::String,
        rating: u64,
    }

    struct CurationCompleted has copy, drop {
        collection_id: 0x1::ascii::String,
        content_id: 0x2::object::ID,
        result_rating: u64,
    }

    public fun approve_content<T0: store + key>(arg0: &mut CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectionConfig>(&mut arg0.contents, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.moderator, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, ContentMeta>(&v0.contents, arg2);
            !v3.curated && v3.rating > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, ContentMeta>(&mut v0.contents, arg2).curated = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.approved_vault);
        let v4 = CurationCompleted{
            collection_id : arg1,
            content_id    : arg2,
            result_rating : 1,
        };
        0x2::event::emit<CurationCompleted>(v4);
    }

    public fun archive_content(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut CurationHub, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg1.contents, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectionConfig>(&mut arg1.contents, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.moderator, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, ContentMeta>(&v0.contents, arg3);
            !v3.curated && v3.rating > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, ContentMeta>(&mut v0.contents, arg3).curated = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.approval_rate as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.review_vault);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.approved_vault);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.approved_vault);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.review_vault);
        };
        let v7 = CurationCompleted{
            collection_id : arg2,
            content_id    : arg3,
            result_rating : v5,
        };
        0x2::event::emit<CurationCompleted>(v7);
    }

    public entry fun create_collection(arg0: &mut CurationHub, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = CollectionConfig{
            owner          : 0x2::tx_context::sender(arg6),
            moderator      : arg2,
            status         : 0,
            approved_vault : arg3,
            review_vault   : arg4,
            approval_rate  : arg5,
            contents       : 0x2::table::new<0x2::object::ID, ContentMeta>(arg6),
        };
        0x2::table::add<0x1::ascii::String, CollectionConfig>(&mut arg0.contents, arg1, v0);
        let v1 = CollectionCreated{
            collection_id : arg1,
            owner         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<CollectionCreated>(v1);
    }

    public fun curate_batch<T0>(arg0: &mut CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectionConfig>(&mut arg0.contents, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.moderator, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, ContentMeta>(&mut v0.contents, arg2).curated = true;
        };
        let v3 = v2 * (v0.approval_rate as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.review_vault);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.approved_vault);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.approved_vault);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.review_vault);
        };
        let v4 = CurationCompleted{
            collection_id : arg1,
            content_id    : arg2,
            result_rating : v2,
        };
        0x2::event::emit<CurationCompleted>(v4);
    }

    public fun get_collection_info(arg0: &CurationHub, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1);
        (v0.owner, v0.moderator, v0.status & 1 != 0, v0.approved_vault, v0.review_vault, v0.approval_rate)
    }

    public fun get_content_info(arg0: &CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1);
        assert!(0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, ContentMeta>(&v0.contents, arg2);
        (v1.content_type, v1.rating, v1.curated)
    }

    public fun get_content_rating(arg0: &CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, ContentMeta>(&v0.contents, arg2);
        if (v1.curated) {
            return 0
        };
        v1.rating
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CurationHub{
            id       : 0x2::object::new(arg0),
            contents : 0x2::table::new<0x1::ascii::String, CollectionConfig>(arg0),
            version  : 1,
        };
        0x2::transfer::share_object<CurationHub>(v0);
    }

    public entry fun publish_collection(arg0: &mut CurationHub, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectionConfig>(&mut arg0.contents, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun should_curate(arg0: &CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_content_rating(arg0, arg1, arg2) > 0
    }

    public entry fun submit_content(arg0: &mut CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectionConfig>(&mut arg0.contents, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.moderator, 100);
        let v2 = ContentMeta{
            content_type : arg3,
            rating       : arg4,
            curated      : false,
        };
        if (0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, ContentMeta>(&mut v0.contents, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, ContentMeta>(&mut v0.contents, arg2, v2);
        };
        let v3 = ContentSubmitted{
            collection_id : arg1,
            content_id    : arg2,
            content_type  : arg3,
            rating        : arg4,
        };
        0x2::event::emit<ContentSubmitted>(v3);
    }

    public entry fun update_rating(arg0: &mut CurationHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectionConfig>(&arg0.contents, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectionConfig>(&mut arg0.contents, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.moderator, 100);
        assert!(0x2::table::contains<0x2::object::ID, ContentMeta>(&v0.contents, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, ContentMeta>(&mut v0.contents, arg2).rating = arg3;
    }

    // decompiled from Move bytecode v6
}

