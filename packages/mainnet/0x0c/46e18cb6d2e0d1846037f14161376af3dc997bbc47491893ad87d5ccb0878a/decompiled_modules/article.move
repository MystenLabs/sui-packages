module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::article {
    struct ArticlePublished has copy, drop {
        article_id: 0x2::object::ID,
        publication_id: 0x2::object::ID,
        nonce: u64,
        price: 0x1::option::Option<u64>,
        walrus_quilt_id: u256,
        paid: bool,
        published_at: u64,
        preview_encrypted_key: vector<u8>,
        content_encrypted_key: vector<u8>,
        preview_key_version: u64,
        content_key_version: u64,
        seal_config_ids: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config::SealConfigID>,
    }

    struct ArticleUpdated has copy, drop {
        article_id: 0x2::object::ID,
        price: 0x1::option::Option<u64>,
        paid: bool,
    }

    struct ArticleArchived has copy, drop {
        article_id: 0x2::object::ID,
    }

    struct ArticleUnarchived has copy, drop {
        article_id: 0x2::object::ID,
    }

    struct ArticleFriendAdded has copy, drop {
        article_id: 0x2::object::ID,
        friend_article_id: 0x2::object::ID,
    }

    struct ArticleFriendRemoved has copy, drop {
        article_id: 0x2::object::ID,
        friend_article_id: 0x2::object::ID,
    }

    struct ArticleKeysRotated has copy, drop {
        article_id: 0x2::object::ID,
        preview_encrypted_key: vector<u8>,
        content_encrypted_key: vector<u8>,
        preview_key_version: u64,
        content_key_version: u64,
        seal_config_ids: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config::SealConfigID>,
    }

    struct Article has store, key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
        nonce: u64,
        price: 0x1::option::Option<u64>,
        walrus_quilt_id: u256,
        paid: bool,
        published_at: u64,
        preview_encrypted_key: vector<u8>,
        content_encrypted_key: vector<u8>,
        preview_key_version: u64,
        content_key_version: u64,
        seal_config_ids: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config::SealConfigID>,
        is_archived: bool,
        friends: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public fun id(arg0: &Article) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun add_article_friend(arg0: &mut Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member, arg3: &Article) {
        verify_member_permissions(arg0, arg1, arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_can_manage_article_friends_permission());
        let v0 = 0x2::object::id<Article>(arg3);
        assert!(v0 != id(arg0), 2);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.friends, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.friends, v0) = true;
        } else {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.friends, v0, true);
        };
        let v1 = ArticleFriendAdded{
            article_id        : 0x2::object::id<Article>(arg0),
            friend_article_id : v0,
        };
        0x2::event::emit<ArticleFriendAdded>(v1);
    }

    public fun archive_article(arg0: &mut Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member) {
        verify_member_permissions(arg0, arg1, arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_archive_article_permission());
        arg0.is_archived = true;
        let v0 = ArticleArchived{article_id: 0x2::object::id<Article>(arg0)};
        0x2::event::emit<ArticleArchived>(v0);
    }

    public fun content_encrypted_key(arg0: &Article) : &vector<u8> {
        &arg0.content_encrypted_key
    }

    public fun content_key_version(arg0: &Article) : u64 {
        arg0.content_key_version
    }

    public fun has_article_friend(arg0: &Article, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.friends, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.friends, arg1)
    }

    public fun is_archived(arg0: &Article) : bool {
        arg0.is_archived
    }

    public fun nonce(arg0: &Article) : u64 {
        arg0.nonce
    }

    public fun paid(arg0: &Article) : bool {
        arg0.paid
    }

    public fun preview_encrypted_key(arg0: &Article) : &vector<u8> {
        &arg0.preview_encrypted_key
    }

    public fun preview_key_version(arg0: &Article) : u64 {
        arg0.preview_key_version
    }

    public fun price(arg0: &Article) : 0x1::option::Option<u64> {
        arg0.price
    }

    public fun publication_id(arg0: &Article) : 0x2::object::ID {
        arg0.publication_id
    }

    public fun publish_article(arg0: &mut 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: bool, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config::SealConfigID>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg3);
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::verify_article_publish_allowance(arg0, v0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::register_nonce(arg0, arg1);
        let v1 = 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg0);
        let v2 = Article{
            id                    : 0x2::object::new(arg9),
            publication_id        : v1,
            nonce                 : arg1,
            price                 : arg2,
            walrus_quilt_id       : v0,
            paid                  : arg4,
            published_at          : arg5,
            preview_encrypted_key : arg6,
            content_encrypted_key : arg7,
            preview_key_version   : 0,
            content_key_version   : 0,
            seal_config_ids       : arg8,
            is_archived           : false,
            friends               : 0x2::table::new<0x2::object::ID, bool>(arg9),
        };
        let v3 = ArticlePublished{
            article_id            : 0x2::object::id<Article>(&v2),
            publication_id        : v1,
            nonce                 : arg1,
            price                 : arg2,
            walrus_quilt_id       : v0,
            paid                  : arg4,
            published_at          : arg5,
            preview_encrypted_key : v2.preview_encrypted_key,
            content_encrypted_key : v2.content_encrypted_key,
            preview_key_version   : v2.preview_key_version,
            content_key_version   : v2.content_key_version,
            seal_config_ids       : arg8,
        };
        0x2::event::emit<ArticlePublished>(v3);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::new(arg3, arg9);
        0x2::transfer::share_object<Article>(v2);
    }

    public fun published_at(arg0: &Article) : u64 {
        arg0.published_at
    }

    public fun remove_article_friend(arg0: &mut Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member, arg3: 0x2::object::ID) {
        verify_member_permissions(arg0, arg1, arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_can_manage_article_friends_permission());
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.friends, arg3)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.friends, arg3) = false;
        };
        let v0 = ArticleFriendRemoved{
            article_id        : 0x2::object::id<Article>(arg0),
            friend_article_id : arg3,
        };
        0x2::event::emit<ArticleFriendRemoved>(v0);
    }

    public fun rotate_article_keys(arg0: &mut Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config::SealConfigID>) {
        verify_member_permissions(arg0, arg1, arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_rotate_article_keys_permission());
        assert!(arg5 == arg0.preview_key_version + 1, 3);
        assert!(arg6 == arg0.content_key_version + 1, 4);
        arg0.preview_encrypted_key = arg3;
        arg0.content_encrypted_key = arg4;
        arg0.preview_key_version = arg5;
        arg0.content_key_version = arg6;
        arg0.seal_config_ids = arg7;
        let v0 = ArticleKeysRotated{
            article_id            : 0x2::object::id<Article>(arg0),
            preview_encrypted_key : arg3,
            content_encrypted_key : arg4,
            preview_key_version   : arg5,
            content_key_version   : arg6,
            seal_config_ids       : arg7,
        };
        0x2::event::emit<ArticleKeysRotated>(v0);
    }

    public fun seal_config_ids(arg0: &Article) : &vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config::SealConfigID> {
        &arg0.seal_config_ids
    }

    public fun unarchive_article(arg0: &mut Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member) {
        verify_member_permissions(arg0, arg1, arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_unarchive_article_permission());
        arg0.is_archived = false;
        let v0 = ArticleUnarchived{article_id: 0x2::object::id<Article>(arg0)};
        0x2::event::emit<ArticleUnarchived>(v0);
    }

    public fun update_article(arg0: &mut Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member, arg3: 0x1::option::Option<u64>, arg4: bool) {
        verify_member_permissions(arg0, arg1, arg2, 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::new_update_article_permission());
        validate_article_price(arg3, arg4);
        arg0.price = arg3;
        arg0.paid = arg4;
        let v0 = ArticleUpdated{
            article_id : 0x2::object::id<Article>(arg0),
            price      : arg3,
            paid       : arg4,
        };
        0x2::event::emit<ArticleUpdated>(v0);
    }

    fun validate_article_price(arg0: 0x1::option::Option<u64>, arg1: bool) {
        if (arg1 && 0x1::option::is_some<u64>(&arg0)) {
            assert!(*0x1::option::borrow<u64>(&arg0) > 0, 5);
        };
    }

    fun verify_member_permissions(arg0: &Article, arg1: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Publication, arg2: &0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::Member, arg3: 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::MemberPermission) {
        assert!(0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::id(arg1) == arg0.publication_id, 1);
        0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::publication::verify_member_permissions(arg1, arg2, arg3);
    }

    public fun walrus_quilt_id(arg0: &Article) : u256 {
        arg0.walrus_quilt_id
    }

    // decompiled from Move bytecode v7
}

