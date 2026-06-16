module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events {
    struct PublicationCreated has copy, drop {
        publication: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        vault_id: 0x2::object::ID,
    }

    struct ContributorAdded has copy, drop {
        publication: 0x2::object::ID,
        addr: address,
        added_by: address,
    }

    struct ContributorRemoved has copy, drop {
        publication: 0x2::object::ID,
        addr: address,
        removed_by: address,
    }

    struct ArticlePosted has copy, drop {
        publication: 0x2::object::ID,
        vault: 0x2::object::ID,
        article: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
        slug: 0x1::string::String,
        gating: u8,
        quilt_id: u256,
        quilt_object_id: 0x2::object::ID,
    }

    struct ArticleDeleted has copy, drop {
        publication: 0x2::object::ID,
        vault: 0x2::object::ID,
        article: 0x2::object::ID,
        deleted_by: address,
        title: 0x1::string::String,
        slug: 0x1::string::String,
        body_blob_id: 0x2::object::ID,
    }

    struct ArticleUpdated has copy, drop {
        publication: 0x2::object::ID,
        article: 0x2::object::ID,
        old_title: 0x1::string::String,
        new_title: 0x1::string::String,
        old_slug: 0x1::string::String,
        new_slug: 0x1::string::String,
        updated_by: address,
    }

    struct BlobStored has copy, drop {
        vault_id: 0x2::object::ID,
        publication_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        blob_content_id: u256,
        size: u64,
        end_epoch: u64,
        stored_by: address,
    }

    struct BlobRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        publication_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        blob_content_id: u256,
        removed_by: address,
    }

    struct BlobRenewed has copy, drop {
        publication: 0x2::object::ID,
        vault: 0x2::object::ID,
        blob_id: 0x2::object::ID,
        blob_content_id: u256,
        extended_epochs: u32,
        new_expiration_epoch: u64,
        renewed_by: address,
    }

    struct PublicationSubscriptionCreated has copy, drop {
        subscription_id: 0x2::object::ID,
        publication_id: 0x2::object::ID,
        subscriber: address,
        amount_paid: u64,
        expires_at: u64,
    }

    struct PublicationSubscriptionExtended has copy, drop {
        subscription_id: 0x2::object::ID,
        publication_id: 0x2::object::ID,
        subscriber: address,
        amount_paid: u64,
        new_expires_at: u64,
    }

    struct PublicationSubscriptionPriceUpdated has copy, drop {
        publication_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct PublicationNameUpdated has copy, drop {
        publication_id: 0x2::object::ID,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        updated_by: address,
    }

    struct SubscriptionBalanceWithdrawn has copy, drop {
        publication_id: 0x2::object::ID,
        amount: u64,
        withdrawn_by: address,
    }

    struct ArticleNftMinted has copy, drop {
        article_id: 0x2::object::ID,
        nft_id: address,
        to: address,
    }

    struct PublicationTipped has copy, drop {
        publication_id: 0x2::object::ID,
        tipper: address,
        amount: u64,
    }

    public(friend) fun emit_article_deleted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::object::ID) {
        let v0 = ArticleDeleted{
            publication  : arg0,
            vault        : arg1,
            article      : arg2,
            deleted_by   : arg3,
            title        : arg4,
            slug         : arg5,
            body_blob_id : arg6,
        };
        0x2::event::emit<ArticleDeleted>(v0);
    }

    public(friend) fun emit_article_nft_minted(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = ArticleNftMinted{
            article_id : arg0,
            nft_id     : arg1,
            to         : arg2,
        };
        0x2::event::emit<ArticleNftMinted>(v0);
    }

    public(friend) fun emit_article_posted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u256, arg8: 0x2::object::ID) {
        let v0 = ArticlePosted{
            publication     : arg0,
            vault           : arg1,
            article         : arg2,
            author          : arg3,
            title           : arg4,
            slug            : arg5,
            gating          : arg6,
            quilt_id        : arg7,
            quilt_object_id : arg8,
        };
        0x2::event::emit<ArticlePosted>(v0);
    }

    public(friend) fun emit_article_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address) {
        let v0 = ArticleUpdated{
            publication : arg0,
            article     : arg1,
            old_title   : arg2,
            new_title   : arg3,
            old_slug    : arg4,
            new_slug    : arg5,
            updated_by  : arg6,
        };
        0x2::event::emit<ArticleUpdated>(v0);
    }

    public(friend) fun emit_blob_removed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u256, arg4: address) {
        let v0 = BlobRemoved{
            vault_id        : arg0,
            publication_id  : arg1,
            blob_object_id  : arg2,
            blob_content_id : arg3,
            removed_by      : arg4,
        };
        0x2::event::emit<BlobRemoved>(v0);
    }

    public(friend) fun emit_blob_renewed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u256, arg4: u32, arg5: u64, arg6: address) {
        let v0 = BlobRenewed{
            publication          : arg0,
            vault                : arg1,
            blob_id              : arg2,
            blob_content_id      : arg3,
            extended_epochs      : arg4,
            new_expiration_epoch : arg5,
            renewed_by           : arg6,
        };
        0x2::event::emit<BlobRenewed>(v0);
    }

    public(friend) fun emit_blob_stored(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u256, arg4: u64, arg5: u64, arg6: address) {
        let v0 = BlobStored{
            vault_id        : arg0,
            publication_id  : arg1,
            blob_object_id  : arg2,
            blob_content_id : arg3,
            size            : arg4,
            end_epoch       : arg5,
            stored_by       : arg6,
        };
        0x2::event::emit<BlobStored>(v0);
    }

    public(friend) fun emit_contributor_added(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = ContributorAdded{
            publication : arg0,
            addr        : arg1,
            added_by    : arg2,
        };
        0x2::event::emit<ContributorAdded>(v0);
    }

    public(friend) fun emit_contributor_removed(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = ContributorRemoved{
            publication : arg0,
            addr        : arg1,
            removed_by  : arg2,
        };
        0x2::event::emit<ContributorRemoved>(v0);
    }

    public(friend) fun emit_publication_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        let v0 = PublicationCreated{
            publication : arg0,
            owner       : arg1,
            name        : arg2,
            vault_id    : arg3,
        };
        0x2::event::emit<PublicationCreated>(v0);
    }

    public(friend) fun emit_publication_name_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address) {
        let v0 = PublicationNameUpdated{
            publication_id : arg0,
            old_name       : arg1,
            new_name       : arg2,
            updated_by     : arg3,
        };
        0x2::event::emit<PublicationNameUpdated>(v0);
    }

    public(friend) fun emit_publication_subscription_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = PublicationSubscriptionCreated{
            subscription_id : arg0,
            publication_id  : arg1,
            subscriber      : arg2,
            amount_paid     : arg3,
            expires_at      : arg4,
        };
        0x2::event::emit<PublicationSubscriptionCreated>(v0);
    }

    public(friend) fun emit_publication_subscription_extended(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = PublicationSubscriptionExtended{
            subscription_id : arg0,
            publication_id  : arg1,
            subscriber      : arg2,
            amount_paid     : arg3,
            new_expires_at  : arg4,
        };
        0x2::event::emit<PublicationSubscriptionExtended>(v0);
    }

    public(friend) fun emit_publication_subscription_price_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = PublicationSubscriptionPriceUpdated{
            publication_id : arg0,
            old_price      : arg1,
            new_price      : arg2,
            updated_by     : arg3,
        };
        0x2::event::emit<PublicationSubscriptionPriceUpdated>(v0);
    }

    public(friend) fun emit_publication_tipped(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PublicationTipped{
            publication_id : arg0,
            tipper         : arg1,
            amount         : arg2,
        };
        0x2::event::emit<PublicationTipped>(v0);
    }

    public(friend) fun emit_subscription_balance_withdrawn(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = SubscriptionBalanceWithdrawn{
            publication_id : arg0,
            amount         : arg1,
            withdrawn_by   : arg2,
        };
        0x2::event::emit<SubscriptionBalanceWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

