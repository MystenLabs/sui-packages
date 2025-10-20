module 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::article {
    struct PublishArticle has copy, drop {
        article_id: 0x2::object::ID,
        owner: address,
        blob_ids: vector<u256>,
        blob_sizes: vector<u64>,
        blob_storage_sizes: vector<u64>,
        blob_end_epochs: vector<u32>,
        files: 0x2::vec_map::VecMap<0x1::ascii::String, File>,
        timestamp_ms: u64,
    }

    struct DeleteArticle has copy, drop {
        article_id: 0x2::object::ID,
        owner: address,
        current_epoch: u32,
        blob_end_epochs: vector<u32>,
        timestamp_ms: u64,
    }

    struct BurnArticle has copy, drop {
        article_id: 0x2::object::ID,
        owner: address,
        current_epoch: u32,
        blob_end_epochs: vector<u32>,
        timestamp_ms: u64,
    }

    struct RenewArticle has copy, drop {
        article_id: 0x2::object::ID,
        owner: address,
        current_epoch: u32,
        prev_blob_end_epochs: vector<u32>,
        new_blob_end_epochs: vector<u32>,
    }

    struct ARTICLE has drop {
        dummy_field: bool,
    }

    struct Article has store, key {
        id: 0x2::object::UID,
        created_at: u64,
        blobs: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
        files: 0x2::vec_map::VecMap<0x1::ascii::String, File>,
    }

    struct File has copy, drop, store {
        is_public: bool,
        blob_index: u64,
        mime_type: 0x1::ascii::String,
        size: u64,
    }

    public fun blob_index(arg0: &File) : u64 {
        arg0.blob_index
    }

    public fun blobs(arg0: &Article) : &vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob> {
        &arg0.blobs
    }

    public(friend) fun burn_article(arg0: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::Studio, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::remove_asset<Article>(arg0, arg2);
        assert!(is_expired(&v0, arg1), 113);
        let Article {
            id         : v1,
            created_at : _,
            blobs      : v3,
            files      : _,
        } = v0;
        let v5 = v3;
        let v6 = v1;
        0x2::object::delete(v6);
        let v7 = &v5;
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v7)) {
            0x1::vector::push_back<u32>(&mut v8, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v7, v9))));
            v9 = v9 + 1;
        };
        let v10 = BurnArticle{
            article_id      : 0x2::object::uid_to_inner(&v6),
            owner           : 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::owner(arg0),
            current_epoch   : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1),
            blob_end_epochs : v8,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BurnArticle>(v10);
        0x1::vector::reverse<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v5);
        let v11 = 0;
        while (v11 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v5)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v5));
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v5);
    }

    fun check_blobs_integrity(arg0: &vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>) {
        let v0 = 0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0, 0);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::registered_epoch(v0);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(v0);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::encoding_type(v0);
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v0));
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v0));
        assert!(v2 == true, 104);
        let v6 = 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0);
        if (v6 > 1) {
            let v7 = 1;
            while (v7 < v6) {
                let v8 = 0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0, v7);
                assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::registered_epoch(v8) == v1, 103);
                assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(v8) == v2, 104);
                assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::encoding_type(v8) == v3, 107);
                assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v8)) == v4, 105);
                assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v8)) == v5, 106);
                v7 = v7 + 1;
            };
        };
    }

    fun check_blobs_time_validity(arg0: &vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : 0x2::vec_map::VecMap<u64, u32> {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v1 = v0 + 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::config::blob_extended_duration();
        let v2 = 0x2::vec_map::empty<u64, u32>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0)) {
            let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0, v3));
            assert!(v4 > v0, 111);
            if (v4 < v1) {
                0x2::vec_map::insert<u64, u32>(&mut v2, v3, v1 - v4);
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun created_at(arg0: &Article) : u64 {
        arg0.created_at
    }

    public(friend) fun delete_article(arg0: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::Studio, arg1: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::storage::StorageSpace, arg2: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::storage::StorageTreasury, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let Article {
            id         : v0,
            created_at : _,
            blobs      : v2,
            files      : _,
        } = 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::remove_asset<Article>(arg0, arg4);
        let v4 = v2;
        let v5 = v0;
        0x2::object::delete(v5);
        let v6 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg3, 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v4));
        let v7 = &v4;
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v7)) {
            0x1::vector::push_back<u32>(&mut v8, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v7, v9))));
            v9 = v9 + 1;
        };
        let v10 = DeleteArticle{
            article_id      : 0x2::object::uid_to_inner(&v5),
            owner           : 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::owner(arg0),
            current_epoch   : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3),
            blob_end_epochs : v8,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DeleteArticle>(v10);
        if (0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v4)) {
            0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4);
        } else {
            0x1::vector::reverse<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v4);
            let v11 = 0;
            while (v11 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v4)) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::fuse_amount(&mut v6, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg3, 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v4)));
                v11 = v11 + 1;
            };
            0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4);
        };
        0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::storage::deallocate_storage_from_treasury(arg1, arg2, arg3, v6, arg6);
    }

    public fun end_epoch(arg0: &Article) : u32 {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, 0));
        let v1 = &arg0.blobs;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v1)) {
            v0 = 0x1::u32::min(v0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun file_size(arg0: &File) : u64 {
        arg0.size
    }

    public fun files(arg0: &Article) : &0x2::vec_map::VecMap<0x1::ascii::String, File> {
        &arg0.files
    }

    fun init(arg0: ARTICLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ARTICLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_expired(arg0: &Article, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : bool {
        end_epoch(arg0) <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1)
    }

    public fun is_public(arg0: &File) : bool {
        arg0.is_public
    }

    public fun mime_type(arg0: &File) : 0x1::ascii::String {
        arg0.mime_type
    }

    public(friend) fun publish_article(arg0: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::Studio, arg1: &0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::config::Config, arg2: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<bool>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::assert_owner(arg0, arg9);
        0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::assert_studio_time_validity(arg0, arg8);
        assert!(!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2), 101);
        check_blobs_integrity(&arg2);
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg3);
        let v1 = if (v0 == 0x1::vector::length<u64>(&arg4)) {
            if (v0 == 0x1::vector::length<0x1::ascii::String>(&arg5)) {
                if (v0 == 0x1::vector::length<u64>(&arg6)) {
                    v0 == 0x1::vector::length<bool>(&arg7)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 102);
        0x1::vector::reverse<u64>(&mut arg4);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg4)) {
            assert!(0x1::vector::pop_back<u64>(&mut arg4) < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2), 103);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg4);
        0x1::vector::reverse<u64>(&mut arg4);
        0x1::vector::reverse<0x1::ascii::String>(&mut arg5);
        0x1::vector::reverse<u64>(&mut arg6);
        0x1::vector::reverse<bool>(&mut arg7);
        let v3 = 0x1::vector::empty<File>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::ascii::String>(&arg3)) {
            let v5 = File{
                is_public  : 0x1::vector::pop_back<bool>(&mut arg7),
                blob_index : 0x1::vector::pop_back<u64>(&mut arg4),
                mime_type  : 0x1::vector::pop_back<0x1::ascii::String>(&mut arg5),
                size       : 0x1::vector::pop_back<u64>(&mut arg6),
            };
            0x1::vector::push_back<File>(&mut v3, v5);
            v4 = v4 + 1;
        };
        let v6 = Article{
            id         : 0x2::object::new(arg9),
            created_at : 0x2::clock::timestamp_ms(arg8),
            blobs      : arg2,
            files      : 0x2::vec_map::from_keys_values<0x1::ascii::String, File>(arg3, v3),
        };
        let v7 = 0x2::object::id<Article>(&v6);
        let v8 = &v6.blobs;
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v8)) {
            0x1::vector::push_back<u256>(&mut v9, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v8, v10)));
            v10 = v10 + 1;
        };
        let v11 = &v6.blobs;
        let v12 = vector[];
        let v13 = 0;
        while (v13 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v11)) {
            0x1::vector::push_back<u64>(&mut v12, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v11, v13)));
            v13 = v13 + 1;
        };
        let v14 = &v6.blobs;
        let v15 = vector[];
        let v16 = 0;
        while (v16 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v14)) {
            0x1::vector::push_back<u64>(&mut v15, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v14, v16))));
            v16 = v16 + 1;
        };
        let v17 = &v6.blobs;
        let v18 = vector[];
        let v19 = 0;
        while (v19 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v17)) {
            0x1::vector::push_back<u32>(&mut v18, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v17, v19))));
            v19 = v19 + 1;
        };
        let v20 = PublishArticle{
            article_id         : v7,
            owner              : 0x2::tx_context::sender(arg9),
            blob_ids           : v9,
            blob_sizes         : v12,
            blob_storage_sizes : v15,
            blob_end_epochs    : v18,
            files              : v6.files,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<PublishArticle>(v20);
        0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::add_asset<Article>(arg0, arg1, v6, arg9);
        v7
    }

    public(friend) fun renew_article_with_storage_treasury(arg0: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::Studio, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::storage::StorageSpace, arg3: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::storage::StorageTreasury, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::contains_with_type<0x2::object::ID, Article>(0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::works(arg0), arg4), 112);
        let (v0, v1) = 0x2::vec_map::into_keys_values<u64, u32>(check_blobs_time_validity(&0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of<Article>(arg0, arg4).blobs, arg1));
        let v2 = v1;
        let v3 = v0;
        let v4 = &0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of<Article>(arg0, arg4).blobs;
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4)) {
            0x1::vector::push_back<u32>(&mut v5, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4, v6))));
            v6 = v6 + 1;
        };
        if (0x1::vector::length<u64>(&v3) > 0) {
            let v7 = 0;
            while (v7 < 0x1::vector::length<u64>(&v3)) {
                let v8 = 0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of_mut<Article>(arg0, arg4).blobs, v7);
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob_with_resource(arg1, v8, 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::storage::allocate_storage_from_treasury(arg3, arg2, arg1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v8), *0x1::vector::borrow<u32>(&v2, v7), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v8)), arg5));
                v7 = v7 + 1;
            };
        };
        let v9 = &0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of<Article>(arg0, arg4).blobs;
        let v10 = vector[];
        let v11 = 0;
        while (v11 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v9)) {
            0x1::vector::push_back<u32>(&mut v10, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v9, v11))));
            v11 = v11 + 1;
        };
        let v12 = RenewArticle{
            article_id           : arg4,
            owner                : 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::owner(arg0),
            current_epoch        : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1),
            prev_blob_end_epochs : v5,
            new_blob_end_epochs  : v10,
        };
        0x2::event::emit<RenewArticle>(v12);
    }

    public(friend) fun renew_article_with_wal_payment(arg0: &mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::Studio, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        assert!(0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::contains_with_type<0x2::object::ID, Article>(0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::works(arg0), arg2), 112);
        let (v0, v1) = 0x2::vec_map::into_keys_values<u64, u32>(check_blobs_time_validity(&0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of<Article>(arg0, arg2).blobs, arg1));
        let v2 = v1;
        let v3 = v0;
        let v4 = &0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of<Article>(arg0, arg2).blobs;
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4)) {
            0x1::vector::push_back<u32>(&mut v5, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4, v6))));
            v6 = v6 + 1;
        };
        if (0x1::vector::length<u64>(&v3) > 0) {
            let v7 = 0;
            while (v7 < 0x1::vector::length<u64>(&v3)) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, 0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of_mut<Article>(arg0, arg2).blobs, v7), *0x1::vector::borrow<u32>(&v2, v7), arg3);
                v7 = v7 + 1;
            };
        };
        let v8 = &0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::asset_of<Article>(arg0, arg2).blobs;
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v8)) {
            0x1::vector::push_back<u32>(&mut v9, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v8, v10))));
            v10 = v10 + 1;
        };
        let v11 = RenewArticle{
            article_id           : arg2,
            owner                : 0x1036ec4cc59171bee0effb404d6a7b7d8fb16a521f47bbe91fbc80d4278a2536::studio::owner(arg0),
            current_epoch        : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1),
            prev_blob_end_epochs : v5,
            new_blob_end_epochs  : v9,
        };
        0x2::event::emit<RenewArticle>(v11);
    }

    public fun total_blob_size(arg0: &Article) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs)) {
            v0 = v0 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

