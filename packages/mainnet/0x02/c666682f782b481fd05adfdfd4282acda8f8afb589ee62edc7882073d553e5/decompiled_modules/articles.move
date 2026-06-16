module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::articles {
    struct Article has store, key {
        id: 0x2::object::UID,
        gating: 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::Access,
        body_blob_id: 0x2::object::ID,
        title: 0x1::string::String,
        slug: 0x1::string::String,
        publication_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        author: address,
    }

    struct PostArticleCap has key {
        id: 0x2::object::UID,
    }

    fun access_to_u8(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::Access) : u8 {
        if (0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::is_free(arg0)) {
            0
        } else {
            1
        }
    }

    public fun delete_article(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::PublicationOwnerCap, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg3: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::PublicationVault, arg4: Article, arg5: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg6: &mut 0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::verify_owner_cap(arg1, arg2), 201);
        assert!(arg4.publication_id == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg2), 204);
        assert!(arg4.vault_id == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_vault_id(arg2), 205);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::get_vault_id(arg3) == arg4.vault_id, 205);
        let Article {
            id             : v0,
            gating         : _,
            body_blob_id   : v2,
            title          : v3,
            slug           : v4,
            publication_id : v5,
            vault_id       : v6,
            author         : _,
        } = arg4;
        let v8 = v0;
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::destroy(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg5, 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::remove_blob_from_vault(arg2, arg3, v2, arg6)));
        0x2::object::delete(v8);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_article_deleted(v5, v6, 0x2::object::uid_to_inner(&v8), 0x2::tx_context::sender(arg6), v3, v4, v2);
    }

    public fun destroy_post_article_cap(arg0: PostArticleCap) {
        let PostArticleCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun generate_slug_from_title(arg0: 0x1::string::String, arg1: &0x2::object::UID) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 65 && v3 <= 90) {
                v3 + 32
            } else if (v3 == 32) {
                45
            } else {
                let v5 = if (v3 >= 97 && v3 <= 122) {
                    true
                } else if (v3 >= 48 && v3 <= 57) {
                    true
                } else {
                    v3 == 45
                };
                if (v5) {
                    v3
                } else {
                    0
                }
            };
            if (v4 != 0) {
                if (!(v4 == 45) || !false) {
                    0x1::vector::push_back<u8>(&mut v1, v4);
                };
            };
            v2 = v2 + 1;
        };
        if (!0x1::vector::is_empty<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(&v1, 0x1::vector::length<u8>(&v1) - 1) == 45) {
                0x1::vector::pop_back<u8>(&mut v1);
            };
        };
        if (!0x1::vector::is_empty<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(&v1, 0) == 45) {
                0x1::vector::remove<u8>(&mut v1, 0);
            };
        };
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::vector::push_back<u8>(&mut v1, 45);
        };
        let v6 = 0x2::object::uid_to_bytes(arg1);
        let v7 = 0;
        while (v7 < 8 && v7 < 0x1::vector::length<u8>(&v6)) {
            let v8 = *0x1::vector::borrow<u8>(&v6, v7);
            let v9 = if (v8 / 16 < 10) {
                48 + v8 / 16
            } else {
                87 + v8 / 16
            };
            0x1::vector::push_back<u8>(&mut v1, v9);
            let v10 = if (v8 % 16 < 10) {
                48 + v8 % 16
            } else {
                87 + v8 % 16
            };
            0x1::vector::push_back<u8>(&mut v1, v10);
            v7 = v7 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun get_article_id(arg0: &Article) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_article_info(arg0: &Article) : (0x1::string::String, 0x1::string::String, 0x2::object::ID, 0x2::object::ID, address, u8) {
        (arg0.title, arg0.slug, arg0.publication_id, arg0.vault_id, arg0.author, access_to_u8(&arg0.gating))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PostArticleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PostArticleCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_free_content(arg0: &Article) : bool {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::is_free(&arg0.gating)
    }

    public fun issue_additional_post_article_cap(arg0: &PostArticleCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PostArticleCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<PostArticleCap>(v0, arg1);
    }

    fun post_internal(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg1: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::PublicationVault, arg2: 0x1::string::String, arg3: 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::Access, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Article {
        let v0 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg0);
        let v1 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::get_vault_id(arg1);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_vault_id(arg0) == v1, 203);
        let v2 = 0x2::object::new(arg6);
        let v3 = generate_slug_from_title(arg2, &v2);
        let v4 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::get_blob_object_id(&arg4);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::store_blob_in_vault(arg0, arg1, arg4, arg6);
        let v5 = Article{
            id             : v2,
            gating         : arg3,
            body_blob_id   : v4,
            title          : arg2,
            slug           : v3,
            publication_id : v0,
            vault_id       : v1,
            author         : arg5,
        };
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_article_posted(v0, v1, 0x2::object::uid_to_inner(&v2), arg5, arg2, v3, access_to_u8(&arg3), 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::get_blob_content_id(&arg4), v4);
        v5
    }

    public fun post_with_cap(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &PostArticleCap, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg3: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::PublicationVault, arg4: 0x1::string::String, arg5: 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::Access, arg6: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : Article {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        post_internal(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun publication_id(arg0: &Article) : 0x2::object::ID {
        arg0.publication_id
    }

    public fun transfer_post_article_cap(arg0: PostArticleCap, arg1: address) {
        0x2::transfer::transfer<PostArticleCap>(arg0, arg1);
    }

    public fun update_article(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::PublicationOwnerCap, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg3: &mut Article, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::verify_owner_cap(arg1, arg2), 201);
        assert!(arg3.publication_id == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg2), 202);
        assert!(arg3.vault_id == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_vault_id(arg2), 203);
        let v0 = generate_slug_from_title(arg4, &arg3.id);
        arg3.title = arg4;
        arg3.slug = v0;
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_article_updated(arg3.publication_id, 0x2::object::uid_to_inner(&arg3.id), arg3.title, arg4, arg3.slug, v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

