module 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::publication {
    struct Publication has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        contributors: vector<address>,
        vault_id: address,
    }

    struct PublicationOwnerCap has store, key {
        id: 0x2::object::UID,
        publication_id: address,
    }

    public fun add_contributor(arg0: &PublicationOwnerCap, arg1: &mut Publication, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.publication_id == 0x2::object::uid_to_address(&arg1.id), 0);
        assert!(!0x1::vector::contains<address>(&arg1.contributors, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg1.contributors, arg2);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_contributor_added(0x2::object::uid_to_address(&arg1.id), arg2, 0x2::tx_context::sender(arg3));
    }

    public entry fun add_contributor_entry(arg0: &PublicationOwnerCap, arg1: &mut Publication, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        add_contributor(arg0, arg1, arg2, arg3);
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (PublicationOwnerCap, address) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::create_and_share_vault(v2, arg1);
        let v4 = Publication{
            id           : v1,
            name         : arg0,
            owner        : v0,
            contributors : 0x1::vector::empty<address>(),
            vault_id     : v3,
        };
        let v5 = PublicationOwnerCap{
            id             : 0x2::object::new(arg1),
            publication_id : v2,
        };
        0x2::transfer::share_object<Publication>(v4);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_publication_created(v2, v0, arg0, v3);
        (v5, v2)
    }

    public entry fun create_publication(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = create(arg0, arg1);
        0x2::transfer::transfer<PublicationOwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun get_contributors(arg0: &Publication) : &vector<address> {
        &arg0.contributors
    }

    public fun get_name(arg0: &Publication) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner(arg0: &Publication) : address {
        arg0.owner
    }

    public fun get_publication_address(arg0: &Publication) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_publication_id(arg0: &PublicationOwnerCap) : address {
        arg0.publication_id
    }

    public fun get_vault_id(arg0: &Publication) : address {
        arg0.vault_id
    }

    public fun is_contributor(arg0: &Publication, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.contributors, &arg1)
    }

    public fun is_owner(arg0: &Publication, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun remove_asset_from_vault(arg0: &Publication, arg1: &mut 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::PublicationVault, arg2: u256, arg3: &0x2::tx_context::TxContext) : 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset {
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::remove_asset_authorized(arg1, arg2, get_publication_address(arg0), arg0.owner, &arg0.contributors, 0x2::tx_context::sender(arg3))
    }

    public fun remove_contributor(arg0: &PublicationOwnerCap, arg1: &mut Publication, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.publication_id == 0x2::object::uid_to_address(&arg1.id), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.contributors, &arg2);
        assert!(v0, 1);
        0x1::vector::remove<address>(&mut arg1.contributors, v1);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_contributor_removed(0x2::object::uid_to_address(&arg1.id), arg2, 0x2::tx_context::sender(arg3));
    }

    public entry fun remove_contributor_entry(arg0: &PublicationOwnerCap, arg1: &mut Publication, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        remove_contributor(arg0, arg1, arg2, arg3);
    }

    public fun store_asset_in_vault(arg0: &Publication, arg1: &mut 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::PublicationVault, arg2: u256, arg3: 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::StoredAsset, arg4: &0x2::tx_context::TxContext) {
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::vault::store_asset_authorized(arg1, arg2, arg3, get_publication_address(arg0), arg0.owner, &arg0.contributors, 0x2::tx_context::sender(arg4));
    }

    public fun verify_owner_cap(arg0: &PublicationOwnerCap, arg1: &Publication) : bool {
        arg0.publication_id == get_publication_address(arg1)
    }

    // decompiled from Move bytecode v6
}

