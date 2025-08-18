module 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events {
    struct PublicationCreated has copy, drop {
        publication: address,
        owner: address,
        name: 0x1::string::String,
        vault_id: address,
    }

    struct ContributorAdded has copy, drop {
        publication: address,
        addr: address,
        added_by: address,
    }

    struct ContributorRemoved has copy, drop {
        publication: address,
        addr: address,
        removed_by: address,
    }

    struct ArticlePosted has copy, drop {
        publication: address,
        article: address,
        author: address,
        title: 0x1::string::String,
        gating: u8,
        asset_count: u64,
    }

    struct RenewIntent has copy, drop {
        publication: address,
        vault: address,
        batch_start: u64,
        batch_len: u64,
    }

    struct SubscriptionMinted has copy, drop {
        user: address,
        subscription_id: address,
        plan: u8,
        expires_ms: u64,
    }

    struct SubscriptionExtended has copy, drop {
        user: address,
        subscription_id: address,
        old_expires_ms: u64,
        new_expires_ms: u64,
    }

    struct ArticleNftMinted has copy, drop {
        article: address,
        nft_id: address,
        to: address,
        price_paid: u64,
    }

    public fun emit_article_nft_minted(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = ArticleNftMinted{
            article    : arg0,
            nft_id     : arg1,
            to         : arg2,
            price_paid : arg3,
        };
        0x2::event::emit<ArticleNftMinted>(v0);
    }

    public fun emit_article_posted(arg0: address, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: u8, arg5: u64) {
        let v0 = ArticlePosted{
            publication : arg0,
            article     : arg1,
            author      : arg2,
            title       : arg3,
            gating      : arg4,
            asset_count : arg5,
        };
        0x2::event::emit<ArticlePosted>(v0);
    }

    public fun emit_contributor_added(arg0: address, arg1: address, arg2: address) {
        let v0 = ContributorAdded{
            publication : arg0,
            addr        : arg1,
            added_by    : arg2,
        };
        0x2::event::emit<ContributorAdded>(v0);
    }

    public fun emit_contributor_removed(arg0: address, arg1: address, arg2: address) {
        let v0 = ContributorRemoved{
            publication : arg0,
            addr        : arg1,
            removed_by  : arg2,
        };
        0x2::event::emit<ContributorRemoved>(v0);
    }

    public fun emit_publication_created(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: address) {
        let v0 = PublicationCreated{
            publication : arg0,
            owner       : arg1,
            name        : arg2,
            vault_id    : arg3,
        };
        0x2::event::emit<PublicationCreated>(v0);
    }

    public fun emit_renew_intent(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RenewIntent{
            publication : arg0,
            vault       : arg1,
            batch_start : arg2,
            batch_len   : arg3,
        };
        0x2::event::emit<RenewIntent>(v0);
    }

    public fun emit_subscription_extended(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SubscriptionExtended{
            user            : arg0,
            subscription_id : arg1,
            old_expires_ms  : arg2,
            new_expires_ms  : arg3,
        };
        0x2::event::emit<SubscriptionExtended>(v0);
    }

    public fun emit_subscription_minted(arg0: address, arg1: address, arg2: u8, arg3: u64) {
        let v0 = SubscriptionMinted{
            user            : arg0,
            subscription_id : arg1,
            plan            : arg2,
            expires_ms      : arg3,
        };
        0x2::event::emit<SubscriptionMinted>(v0);
    }

    // decompiled from Move bytecode v6
}

