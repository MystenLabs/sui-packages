module 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::articles {
    struct Article has store, key {
        id: 0x2::object::UID,
        gating: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::Access,
        body_id: u256,
        asset_ids: vector<u256>,
        title: 0x1::string::String,
        slug: 0x1::string::String,
        publication_id: address,
        author: address,
        created_at: u64,
    }

    fun access_to_u8(arg0: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::Access) : u8 {
        if (0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::is_free(arg0)) {
            0
        } else {
            1
        }
    }

    public fun get_article_address(arg0: &Article) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_article_info(arg0: &Article) : (0x1::string::String, 0x1::string::String, address, address, u64, u8, u64) {
        (arg0.title, arg0.slug, arg0.publication_id, arg0.author, arg0.created_at, access_to_u8(&arg0.gating), 0x1::vector::length<u256>(&arg0.asset_ids) + 1)
    }

    fun get_asset_id(arg0: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset) : u256 {
        let (_, v1, _, _) = 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::get_stored_asset_info(arg0);
        let v4 = 0x2::bcs::new(0x2::hash::keccak256(v1));
        0x2::bcs::peel_u256(&mut v4)
    }

    public fun get_asset_ids(arg0: &Article) : &vector<u256> {
        &arg0.asset_ids
    }

    public fun get_author(arg0: &Article) : address {
        arg0.author
    }

    public fun get_body_id(arg0: &Article) : u256 {
        arg0.body_id
    }

    public fun get_gating(arg0: &Article) : &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::Access {
        &arg0.gating
    }

    public fun get_publication_id(arg0: &Article) : address {
        arg0.publication_id
    }

    public fun is_free_content(arg0: &Article) : bool {
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::is_free(&arg0.gating)
    }

    public fun is_gated_content(arg0: &Article) : bool {
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::is_gated(&arg0.gating)
    }

    public fun post(arg0: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::Publication, arg1: &mut 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::PublicationVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::Access, arg5: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset, arg6: vector<0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset>, arg7: &mut 0x2::tx_context::TxContext) : Article {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::is_owner(arg0, v0) || 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::is_contributor(arg0, v0), 0);
        post_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7)
    }

    public fun post_as_owner(arg0: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::PublicationOwnerCap, arg1: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::Publication, arg2: &mut 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::PublicationVault, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::Access, arg6: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset, arg7: vector<0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset>, arg8: &mut 0x2::tx_context::TxContext) : Article {
        assert!(0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::verify_owner_cap(arg0, arg1), 0);
        let v0 = 0x2::tx_context::sender(arg8);
        post_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8)
    }

    fun post_internal(arg0: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::Publication, arg1: &mut 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::PublicationVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::Access, arg5: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset, arg6: vector<0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : Article {
        let v0 = 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::get_publication_address(arg0);
        assert!(0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::get_vault_id(arg0) == 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::get_vault_address(arg1), 2);
        let v1 = 0x2::object::new(arg8);
        let v2 = get_asset_id(&arg5);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::store_asset_in_vault(arg0, arg1, v2, arg5, arg8);
        let v3 = 0x1::vector::empty<u256>();
        while (!0x1::vector::is_empty<0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset>(&arg6)) {
            let v4 = 0x1::vector::pop_back<0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset>(&mut arg6);
            let v5 = get_asset_id(&v4);
            0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::store_asset_in_vault(arg0, arg1, v5, v4, arg8);
            0x1::vector::push_back<u256>(&mut v3, v5);
        };
        0x1::vector::destroy_empty<0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset>(arg6);
        let v6 = Article{
            id             : v1,
            gating         : arg4,
            body_id        : v2,
            asset_ids      : v3,
            title          : arg2,
            slug           : arg3,
            publication_id : v0,
            author         : arg7,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_article_posted(v0, 0x2::object::uid_to_address(&v1), arg7, arg2, access_to_u8(&arg4), 0x1::vector::length<u256>(&v3) + 1);
        v6
    }

    public fun update_article(arg0: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::PublicationOwnerCap, arg1: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::Publication, arg2: &mut Article, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::verify_owner_cap(arg0, arg1), 0);
        assert!(arg2.publication_id == 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication::get_publication_address(arg1), 1);
        arg2.title = arg3;
        arg2.slug = arg4;
    }

    // decompiled from Move bytecode v6
}

