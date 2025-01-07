module 0x2b8bdb183a381c8010eeb020dbbbc6e1fa1203e00d4550b49048ceb722794af4::ART20 {
    struct NFT has store, key {
        id: 0x2::object::UID,
        artinals_id: u64,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x2::url::Url,
        logo_uri: 0x2::url::Url,
        asset_id: u64,
        max_supply: u64,
        collection_id: 0x2::object::ID,
        category: 0x1::string::String,
    }

    struct ART20 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct DenyListStatusEvent has copy, drop {
        collection_id: 0x2::object::ID,
        address: address,
        is_denied: bool,
    }

    struct DenyListAuthorityRevokedEvent has copy, drop {
        collection_id: 0x2::object::ID,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        id: 0x2::object::ID,
        royalty: u64,
        asset_id: u64,
    }

    struct CollectionCap has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        current_supply: u64,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x2::url::Url,
        logo_uri: 0x2::url::Url,
        is_mutable: bool,
        is_mintable: bool,
        has_deny_list_authority: bool,
        value_source: 0x1::option::Option<0x1::string::String>,
        is_api_source: bool,
    }

    struct UserBalance has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        balance: u64,
    }

    struct TokenIdCounter has key {
        id: 0x2::object::UID,
        last_id: u64,
    }

    struct DenyListKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DenyListStatusChanged has copy, drop {
        collection_id: 0x2::object::ID,
        address: address,
        is_denied: bool,
        changed_by: address,
    }

    struct NFTMintedEvent has copy, drop {
        id: 0x2::object::ID,
        artinals_id: u64,
        creator: address,
        name: 0x1::string::String,
        asset_id: u64,
    }

    struct CollectionCreatedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        initial_supply: u64,
        max_supply: u64,
        is_mutable: bool,
        has_deny_list_authority: bool,
        timestamp: u64,
    }

    struct BurnEvent has copy, drop {
        owner: address,
        id: 0x2::object::ID,
    }

    struct MetadataUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        new_name: 0x1::string::String,
        new_description: 0x1::string::String,
    }

    struct CollectionValueSourceUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        is_api: bool,
        source: 0x1::string::String,
        timestamp: u64,
    }

    struct LogoURIUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        artinals_id: u64,
        new_logo_uri: 0x2::url::Url,
    }

    struct BatchTransferEvent has copy, drop {
        from: address,
        recipients: vector<address>,
        token_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
        collection_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct CollectionMintEvent has copy, drop {
        collection_id: 0x2::object::ID,
        amount: u64,
        current_supply: u64,
        max_supply: u64,
        creator: address,
        timestamp: u64,
    }

    struct AdditionalMintEvent has copy, drop {
        collection_id: 0x2::object::ID,
        amount: u64,
        new_supply: u64,
        max_supply: u64,
        creator: address,
        timestamp: u64,
    }

    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        fee_amount: u64,
        fee_coin_type: 0x1::type_name::TypeName,
        fee_collector: address,
        deployer: address,
    }

    struct CategoryRegistry has key {
        id: 0x2::object::UID,
        categories: 0x2::table::Table<0x1::string::String, Category>,
        admin: address,
    }

    struct Category has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        is_active: bool,
        created_at: u64,
    }

    struct CategoryCreated has copy, drop {
        name: 0x1::string::String,
        description: 0x1::string::String,
        timestamp: u64,
    }

    struct CategoryKey has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_to_deny_list(arg0: &mut CollectionCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::length<address>(&arg1);
        assert!(v1 > 0 && v1 <= 200, 16);
        assert!(v0 == arg0.creator, 2);
        assert!(arg0.has_deny_list_authority, 13);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            let v4 = DenyListKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow_mut<DenyListKey, 0x2::table::Table<address, bool>>(&mut arg0.id, v4);
            if (!0x2::table::contains<address, bool>(v5, v3)) {
                0x2::table::add<address, bool>(v5, v3, true);
                let v6 = DenyListStatusChanged{
                    collection_id : 0x2::object::uid_to_inner(&arg0.id),
                    address       : v3,
                    is_denied     : true,
                    changed_by    : v0,
                };
                0x2::event::emit<DenyListStatusChanged>(v6);
            };
            v2 = v2 + 1;
        };
    }

    public entry fun batch_burn_art20(arg0: vector<NFT>, arg1: &mut CollectionCap, arg2: vector<UserBalance>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<NFT>(&arg0);
        assert!(v0 <= 200, 20);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<UserBalance>(&arg2)) {
            v1 = safe_add(v1, 0x1::vector::borrow<UserBalance>(&arg2, v2).balance);
            v2 = v2 + 1;
        };
        assert!(v1 >= v0, 9);
        assert!(arg1.current_supply >= v0, 6);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::pop_back<NFT>(&mut arg0);
            assert!(v4.collection_id == 0x2::object::uid_to_inner(&arg1.id), 8);
            let v5 = false;
            let v6 = 0;
            while (v6 < 0x1::vector::length<UserBalance>(&arg2)) {
                let v7 = 0x1::vector::borrow_mut<UserBalance>(&mut arg2, v6);
                if (v7.balance > 0 && v7.collection_id == v4.collection_id) {
                    v7.balance = safe_sub(v7.balance, 1);
                    v5 = true;
                    break
                };
                v6 = v6 + 1;
            };
            assert!(v5, 9);
            burn_single_art20(v4, arg1, arg3);
            v3 = v3 + 1;
        };
        while (0 < 0x1::vector::length<UserBalance>(&arg2)) {
            let v8 = 0x1::vector::remove<UserBalance>(&mut arg2, 0);
            if (v8.balance > 0) {
                0x2::transfer::transfer<UserBalance>(v8, 0x2::tx_context::sender(arg3));
                continue
            };
            let UserBalance {
                id            : v9,
                collection_id : _,
                balance       : _,
            } = v8;
            0x2::object::delete(v9);
        };
        0x1::vector::destroy_empty<NFT>(arg0);
        0x1::vector::destroy_empty<UserBalance>(arg2);
    }

    public entry fun batch_burn_art20_by_asset_ids(arg0: &mut CollectionCap, arg1: vector<NFT>, arg2: vector<UserBalance>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_collection_cap_id(arg0);
        let v2 = 0x1::vector::length<u64>(&arg3);
        assert!(v2 > 0 && v2 <= 200, 16);
        assert!(arg0.current_supply >= v2, 6);
        let v3 = 0x2::table::new<u64, bool>(arg4);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<UserBalance>(&arg2)) {
            v4 = safe_add(v4, 0x1::vector::borrow<UserBalance>(&arg2, v5).balance);
            v5 = v5 + 1;
        };
        assert!(v4 >= v2, 9);
        let v6 = 0;
        while (v6 < v2) {
            let v7 = *0x1::vector::borrow<u64>(&arg3, v6);
            assert!(!0x2::table::contains<u64, bool>(&v3, v7), 26);
            0x2::table::add<u64, bool>(&mut v3, v7, true);
            let v8 = false;
            let v9 = 0x1::vector::empty<NFT>();
            while (!0x1::vector::is_empty<NFT>(&arg1)) {
                let v10 = 0x1::vector::pop_back<NFT>(&mut arg1);
                let v11 = if (!v8) {
                    if (v10.collection_id == v1) {
                        v10.asset_id == v7
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v11) {
                    assert!(v0 == v10.creator, 5);
                    let v12 = false;
                    let v13 = 0;
                    while (v13 < 0x1::vector::length<UserBalance>(&arg2)) {
                        let v14 = 0x1::vector::borrow_mut<UserBalance>(&mut arg2, v13);
                        if (v14.balance > 0 && v14.collection_id == v1) {
                            v14.balance = safe_sub(v14.balance, 1);
                            v12 = true;
                            break
                        };
                        v13 = v13 + 1;
                    };
                    assert!(v12, 9);
                    arg0.current_supply = safe_sub(arg0.current_supply, 1);
                    let v15 = BurnEvent{
                        owner : v0,
                        id    : 0x2::object::uid_to_inner(&v10.id),
                    };
                    0x2::event::emit<BurnEvent>(v15);
                    let NFT {
                        id            : v16,
                        artinals_id   : _,
                        creator       : _,
                        name          : _,
                        description   : _,
                        uri           : _,
                        logo_uri      : _,
                        asset_id      : _,
                        max_supply    : _,
                        collection_id : _,
                        category      : _,
                    } = v10;
                    0x2::object::delete(v16);
                    v8 = true;
                    continue
                };
                0x1::vector::push_back<NFT>(&mut v9, v10);
            };
            while (!0x1::vector::is_empty<NFT>(&v9)) {
                0x1::vector::push_back<NFT>(&mut arg1, 0x1::vector::pop_back<NFT>(&mut v9));
            };
            0x1::vector::destroy_empty<NFT>(v9);
            assert!(v8, 21);
            v6 = v6 + 1;
        };
        0x2::table::drop<u64, bool>(v3);
        let v27 = 0;
        while (v27 < 0x1::vector::length<UserBalance>(&arg2)) {
            if (get_user_balance_amount(0x1::vector::borrow<UserBalance>(&arg2, v27)) == 0) {
                cleanup_empty_balance(0x1::vector::remove<UserBalance>(&mut arg2, v27));
                continue
            };
            v27 = v27 + 1;
        };
        while (!0x1::vector::is_empty<NFT>(&arg1)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg1), v0);
        };
        while (!0x1::vector::is_empty<UserBalance>(&arg2)) {
            0x2::transfer::transfer<UserBalance>(0x1::vector::pop_back<UserBalance>(&mut arg2), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
        0x1::vector::destroy_empty<UserBalance>(arg2);
    }

    public entry fun batch_update_art20_image_uri_by_asset_ids(arg0: &CollectionCap, arg1: vector<NFT>, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.is_mutable, 3);
        check_deny_list_restrictions(arg0, v0);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg3), 1);
        assert!(v1 > 0 && v1 <= 200, 16);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg3, v2);
            assert!(0x1::vector::length<u8>(v3) <= 256, 15);
            assert!(0x1::vector::length<u8>(v3) > 0, 15);
            0x2::url::new_unsafe_from_bytes(*v3);
            v2 = v2 + 1;
        };
        let v4 = 0x2::table::new<u64, bool>(arg4);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<u64>(&arg2, v5);
            let v7 = 0x1::vector::borrow<vector<u8>>(&arg3, v5);
            assert!(!0x2::table::contains<u64, bool>(&v4, v6), 26);
            0x2::table::add<u64, bool>(&mut v4, v6, true);
            let v8 = false;
            let v9 = 0x1::vector::empty<NFT>();
            while (!0x1::vector::is_empty<NFT>(&arg1)) {
                let v10 = 0x1::vector::pop_back<NFT>(&mut arg1);
                let v11 = if (!v8) {
                    if (v10.collection_id == get_collection_cap_id(arg0)) {
                        v10.asset_id == v6
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v11) {
                    assert!(v0 == v10.creator, 2);
                    v10.logo_uri = 0x2::url::new_unsafe_from_bytes(*v7);
                    let v12 = LogoURIUpdateEvent{
                        id           : 0x2::object::uid_to_inner(&v10.id),
                        artinals_id  : v10.artinals_id,
                        new_logo_uri : v10.logo_uri,
                    };
                    0x2::event::emit<LogoURIUpdateEvent>(v12);
                    v8 = true;
                };
                0x1::vector::push_back<NFT>(&mut v9, v10);
            };
            while (!0x1::vector::is_empty<NFT>(&v9)) {
                0x1::vector::push_back<NFT>(&mut arg1, 0x1::vector::pop_back<NFT>(&mut v9));
            };
            0x1::vector::destroy_empty<NFT>(v9);
            assert!(v8, 21);
            v5 = v5 + 1;
        };
        0x2::table::drop<u64, bool>(v4);
        while (!0x1::vector::is_empty<NFT>(&arg1)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg1), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
    }

    public entry fun batch_update_metadata(arg0: &CollectionCap, arg1: vector<NFT>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg2)) <= 128, 15);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg3)) <= 1000, 15);
        };
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg4)) <= 256, 15);
        };
        if (0x1::option::is_some<vector<u8>>(&arg5)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg5)) <= 256, 15);
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<NFT>(&arg1)) {
            let v2 = 0x1::vector::borrow_mut<NFT>(&mut arg1, v1);
            assert!(v2.collection_id == get_collection_cap_id(arg0), 8);
            assert!(arg0.is_mutable, 3);
            assert!(v0 == v2.creator, 2);
            if (0x1::option::is_some<0x1::string::String>(&arg2)) {
                v2.name = *0x1::option::borrow<0x1::string::String>(&arg2);
            };
            if (0x1::option::is_some<0x1::string::String>(&arg3)) {
                v2.description = *0x1::option::borrow<0x1::string::String>(&arg3);
            };
            if (0x1::option::is_some<vector<u8>>(&arg4)) {
                v2.uri = 0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg4));
            };
            if (0x1::option::is_some<vector<u8>>(&arg5)) {
                v2.logo_uri = 0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg5));
            };
            let v3 = MetadataUpdateEvent{
                id              : 0x2::object::uid_to_inner(&v2.id),
                new_name        : v2.name,
                new_description : v2.description,
            };
            0x2::event::emit<MetadataUpdateEvent>(v3);
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<NFT>(&arg1)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg1), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
    }

    public entry fun batch_update_metadata_by_asset_ids(arg0: &CollectionCap, arg1: vector<NFT>, arg2: vector<u64>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 > 0 && v1 <= 200, 16);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v2 = 0x1::option::borrow<0x1::string::String>(&arg3);
            assert!(0x1::string::length(v2) <= 128, 15);
            let v3 = 0x1::string::as_bytes(v2);
            assert!(0x1::vector::length<u8>(v3) <= 512, 15);
            assert!(0x1::vector::length<u8>(v3) > 0, 15);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v4 = 0x1::option::borrow<0x1::string::String>(&arg4);
            assert!(0x1::string::length(v4) <= 1000, 15);
            let v5 = 0x1::string::as_bytes(v4);
            assert!(0x1::vector::length<u8>(v5) <= 4000, 15);
            assert!(0x1::vector::length<u8>(v5) > 0, 15);
        };
        if (0x1::option::is_some<vector<u8>>(&arg5)) {
            let v6 = 0x1::option::borrow<vector<u8>>(&arg5);
            assert!(0x1::vector::length<u8>(v6) <= 256, 15);
            assert!(0x1::vector::length<u8>(v6) > 0, 15);
        };
        if (0x1::option::is_some<vector<u8>>(&arg6)) {
            let v7 = 0x1::option::borrow<vector<u8>>(&arg6);
            assert!(0x1::vector::length<u8>(v7) <= 256, 15);
            assert!(0x1::vector::length<u8>(v7) > 0, 15);
        };
        let v8 = 0x2::table::new<u64, bool>(arg7);
        let v9 = 0;
        while (v9 < v1) {
            let v10 = *0x1::vector::borrow<u64>(&arg2, v9);
            assert!(!0x2::table::contains<u64, bool>(&v8, v10), 26);
            0x2::table::add<u64, bool>(&mut v8, v10, true);
            let v11 = false;
            let v12 = 0x1::vector::empty<NFT>();
            while (!0x1::vector::is_empty<NFT>(&arg1)) {
                let v13 = 0x1::vector::pop_back<NFT>(&mut arg1);
                let v14 = if (!v11) {
                    if (v13.collection_id == get_collection_cap_id(arg0)) {
                        v13.asset_id == v10
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v14) {
                    assert!(arg0.is_mutable, 3);
                    assert!(v0 == v13.creator, 2);
                    if (0x1::option::is_some<0x1::string::String>(&arg3)) {
                        v13.name = *0x1::option::borrow<0x1::string::String>(&arg3);
                    };
                    if (0x1::option::is_some<0x1::string::String>(&arg4)) {
                        v13.description = *0x1::option::borrow<0x1::string::String>(&arg4);
                    };
                    if (0x1::option::is_some<vector<u8>>(&arg5)) {
                        v13.uri = 0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg5));
                    };
                    if (0x1::option::is_some<vector<u8>>(&arg6)) {
                        v13.logo_uri = 0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg6));
                    };
                    let v15 = MetadataUpdateEvent{
                        id              : 0x2::object::uid_to_inner(&v13.id),
                        new_name        : v13.name,
                        new_description : v13.description,
                    };
                    0x2::event::emit<MetadataUpdateEvent>(v15);
                    v11 = true;
                };
                0x1::vector::push_back<NFT>(&mut v12, v13);
            };
            while (!0x1::vector::is_empty<NFT>(&v12)) {
                0x1::vector::push_back<NFT>(&mut arg1, 0x1::vector::pop_back<NFT>(&mut v12));
            };
            0x1::vector::destroy_empty<NFT>(v12);
            assert!(v11, 21);
            v9 = v9 + 1;
        };
        0x2::table::drop<u64, bool>(v8);
        while (!0x1::vector::is_empty<NFT>(&arg1)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg1), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
    }

    public entry fun batch_update_token_logo_uri(arg0: vector<NFT>, arg1: vector<vector<u8>>, arg2: &CollectionCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::vector::length<NFT>(&arg0);
        assert!(arg2.is_mutable, 3);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg1), 1);
        assert!(v1 > 0 && v1 <= 200, 16);
        check_deny_list_restrictions(arg2, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg1, v2);
            assert!(0x1::vector::length<u8>(v3) <= 256, 15);
            assert!(0x1::vector::length<u8>(v3) > 0, 15);
            0x2::url::new_unsafe_from_bytes(*v3);
            v2 = v2 + 1;
        };
        let v4 = 0x1::vector::empty<NFT>();
        let v5 = 0;
        while (v5 < v1) {
            let v6 = 0x1::vector::pop_back<NFT>(&mut arg0);
            assert!(v6.collection_id == get_collection_cap_id(arg2), 8);
            assert!(v0 == v6.creator, 2);
            v6.logo_uri = 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg1, v5));
            let v7 = LogoURIUpdateEvent{
                id           : 0x2::object::uid_to_inner(&v6.id),
                artinals_id  : v6.artinals_id,
                new_logo_uri : v6.logo_uri,
            };
            0x2::event::emit<LogoURIUpdateEvent>(v7);
            0x1::vector::push_back<NFT>(&mut v4, v6);
            v5 = v5 + 1;
        };
        while (!0x1::vector::is_empty<NFT>(&arg0)) {
            0x1::vector::push_back<NFT>(&mut v4, 0x1::vector::pop_back<NFT>(&mut arg0));
        };
        while (!0x1::vector::is_empty<NFT>(&v4)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut v4), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg0);
        0x1::vector::destroy_empty<NFT>(v4);
    }

    public entry fun burn_art20(arg0: NFT, arg1: &mut CollectionCap, arg2: vector<UserBalance>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator, 5);
        assert!(arg1.current_supply > 0, 6);
        assert!(arg0.collection_id == 0x2::object::uid_to_inner(&arg1.id), 8);
        let v1 = false;
        let v2 = 0x1::vector::empty<UserBalance>();
        while (!0x1::vector::is_empty<UserBalance>(&arg2)) {
            let v3 = 0x1::vector::pop_back<UserBalance>(&mut arg2);
            assert!(v3.collection_id == 0x2::object::uid_to_inner(&arg1.id), 8);
            if (!v1 && v3.balance > 0) {
                if (v3.balance == 1) {
                    let UserBalance {
                        id            : v4,
                        collection_id : _,
                        balance       : _,
                    } = v3;
                    0x2::object::delete(v4);
                } else {
                    v3.balance = v3.balance - 1;
                    0x1::vector::push_back<UserBalance>(&mut v2, v3);
                };
                v1 = true;
                continue
            };
            0x1::vector::push_back<UserBalance>(&mut v2, v3);
        };
        assert!(v1, 9);
        while (!0x1::vector::is_empty<UserBalance>(&v2)) {
            let v7 = 0x1::vector::pop_back<UserBalance>(&mut v2);
            if (v7.balance > 0) {
                0x2::transfer::transfer<UserBalance>(v7, v0);
                continue
            };
            let UserBalance {
                id            : v8,
                collection_id : _,
                balance       : _,
            } = v7;
            0x2::object::delete(v8);
        };
        0x1::vector::destroy_empty<UserBalance>(arg2);
        0x1::vector::destroy_empty<UserBalance>(v2);
        arg1.current_supply = safe_sub(arg1.current_supply, 1);
        let v11 = BurnEvent{
            owner : v0,
            id    : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<BurnEvent>(v11);
        let NFT {
            id            : v12,
            artinals_id   : _,
            creator       : _,
            name          : _,
            description   : _,
            uri           : _,
            logo_uri      : _,
            asset_id      : _,
            max_supply    : _,
            collection_id : _,
            category      : _,
        } = arg0;
        0x2::object::delete(v12);
    }

    fun burn_single_art20(arg0: NFT, arg1: &mut CollectionCap, arg2: &0x2::tx_context::TxContext) {
        arg1.current_supply = safe_sub(arg1.current_supply, 1);
        let v0 = BurnEvent{
            owner : 0x2::tx_context::sender(arg2),
            id    : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<BurnEvent>(v0);
        let NFT {
            id            : v1,
            artinals_id   : _,
            creator       : _,
            name          : _,
            description   : _,
            uri           : _,
            logo_uri      : _,
            asset_id      : _,
            max_supply    : _,
            collection_id : _,
            category      : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun can_receive_art20(arg0: &CollectionCap, arg1: address) : bool {
        !is_denied(arg0, arg1)
    }

    public fun check_deny_list_restrictions(arg0: &CollectionCap, arg1: address) {
        assert!(!is_denied(arg0, arg1), 12);
    }

    public fun cleanup_empty_balance(arg0: UserBalance) {
        assert!(get_user_balance_amount(&arg0) == 0, 9);
        let UserBalance {
            id            : v0,
            collection_id : _,
            balance       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun collection_exists(arg0: &vector<CollectionCap>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CollectionCap>(arg0)) {
            if (get_collection_cap_id(0x1::vector::borrow<CollectionCap>(arg0, v0)) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun create_category(arg0: &mut CategoryRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2);
        assert!(!0x2::table::contains<0x1::string::String, Category>(&arg0.categories, arg1), 31);
        let v0 = Category{
            name        : arg1,
            description : arg2,
            is_active   : true,
            created_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<0x1::string::String, Category>(&mut arg0.categories, arg1, v0);
        let v1 = CategoryCreated{
            name        : arg1,
            description : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CategoryCreated>(v1);
    }

    public fun create_deny_list(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<address, bool> {
        0x2::table::new<address, bool>(arg0)
    }

    public(friend) fun create_user_balance(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserBalance {
        UserBalance{
            id            : 0x2::object::new(arg2),
            collection_id : arg0,
            balance       : arg1,
        }
    }

    public fun deny_list_size(arg0: &CollectionCap) : u64 {
        let v0 = DenyListKey{dummy_field: false};
        0x2::table::length<address, bool>(0x2::dynamic_field::borrow<DenyListKey, 0x2::table::Table<address, bool>>(&arg0.id, v0))
    }

    public fun drop_collection_cap(arg0: CollectionCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 2);
        assert!(arg0.current_supply == 0, 32);
        let CollectionCap {
            id                      : v0,
            max_supply              : _,
            current_supply          : _,
            creator                 : _,
            name                    : _,
            description             : _,
            uri                     : _,
            logo_uri                : _,
            is_mutable              : _,
            is_mintable             : _,
            has_deny_list_authority : _,
            value_source            : _,
            is_api_source           : _,
        } = arg0;
        let v13 = v0;
        let v14 = DenyListKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<DenyListKey>(&v13, v14)) {
            let v15 = DenyListKey{dummy_field: false};
            0x2::table::drop<address, bool>(0x2::dynamic_field::remove<DenyListKey, 0x2::table::Table<address, bool>>(&mut v13, v15));
        };
        0x2::object::delete(v13);
    }

    public fun emit_deny_list_status(arg0: &CollectionCap, arg1: address) {
        let v0 = DenyListStatusEvent{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            address       : arg1,
            is_denied     : is_denied(arg0, arg1),
        };
        0x2::event::emit<DenyListStatusEvent>(v0);
    }

    public entry fun freeze_collection_metadata(arg0: &mut CollectionCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 2);
        assert!(arg0.is_mutable, 24);
        arg0.is_mutable = false;
    }

    public entry fun freeze_minting(arg0: &mut CollectionCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 2);
        assert!(arg0.is_mintable, 27);
        arg0.is_mintable = false;
    }

    public fun get_all_categories(arg0: &CategoryRegistry) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x2::table::borrow<0x1::string::String, Category>(&arg0.categories, 0x1::string::utf8(b"")).name);
        v0
    }

    public fun get_all_collection_ids(arg0: &vector<CollectionCap>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<CollectionCap>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, get_collection_cap_id(0x1::vector::borrow<CollectionCap>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_category_info(arg0: &CategoryRegistry, arg1: 0x1::string::String) : (0x1::string::String, 0x1::string::String, bool, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, Category>(&arg0.categories, arg1);
        (v0.name, v0.description, v0.is_active, v0.created_at)
    }

    public fun get_collection_cap_id(arg0: &CollectionCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_collection_current_supply(arg0: &CollectionCap) : u64 {
        arg0.current_supply
    }

    public fun get_collection_details(arg0: &CollectionCap) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, 0x2::url::Url, 0x2::url::Url, u64, u64, bool, bool, u64) {
        let v0 = if (has_deny_list(arg0)) {
            deny_list_size(arg0)
        } else {
            0
        };
        (get_collection_cap_id(arg0), arg0.creator, arg0.name, arg0.description, arg0.uri, arg0.logo_uri, arg0.current_supply, arg0.max_supply, arg0.is_mutable, arg0.has_deny_list_authority, v0)
    }

    public fun get_collection_id(arg0: &NFT) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_collection_max_supply(arg0: &CollectionCap) : u64 {
        arg0.max_supply
    }

    public fun get_collection_value_source(arg0: &CollectionCap) : (0x1::option::Option<0x1::string::String>, bool) {
        (arg0.value_source, arg0.is_api_source)
    }

    public fun get_collections_info(arg0: &vector<CollectionCap>) : (vector<0x2::object::ID>, vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x2::url::Url>, vector<0x2::url::Url>, vector<u64>, vector<u64>, vector<bool>, vector<bool>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<0x2::url::Url>();
        let v5 = 0x1::vector::empty<0x2::url::Url>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<bool>();
        let v9 = 0x1::vector::empty<bool>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<CollectionCap>(arg0)) {
            let v11 = 0x1::vector::borrow<CollectionCap>(arg0, v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, get_collection_cap_id(v11));
            0x1::vector::push_back<address>(&mut v1, v11.creator);
            0x1::vector::push_back<0x1::string::String>(&mut v2, v11.name);
            0x1::vector::push_back<0x1::string::String>(&mut v3, v11.description);
            0x1::vector::push_back<0x2::url::Url>(&mut v4, v11.uri);
            0x1::vector::push_back<0x2::url::Url>(&mut v5, v11.logo_uri);
            0x1::vector::push_back<u64>(&mut v6, v11.current_supply);
            0x1::vector::push_back<u64>(&mut v7, v11.max_supply);
            0x1::vector::push_back<bool>(&mut v8, v11.is_mutable);
            0x1::vector::push_back<bool>(&mut v9, v11.has_deny_list_authority);
            v10 = v10 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun get_current_supply(arg0: &CollectionCap) : u64 {
        arg0.current_supply
    }

    public fun get_deny_list_size_safe(arg0: &CollectionCap) : u64 {
        if (!has_deny_list(arg0)) {
            return 0
        };
        deny_list_size(arg0)
    }

    public fun get_deny_list_status(arg0: &CollectionCap, arg1: address) : bool {
        if (!has_deny_list(arg0)) {
            return false
        };
        is_denied(arg0, arg1)
    }

    public fun get_fee_amount(arg0: &FeeConfig) : u64 {
        arg0.fee_amount
    }

    public fun get_fee_coin_type(arg0: &FeeConfig) : 0x1::type_name::TypeName {
        arg0.fee_coin_type
    }

    public fun get_fee_info(arg0: &FeeConfig) : (u64, 0x1::type_name::TypeName, address) {
        (arg0.fee_amount, arg0.fee_coin_type, arg0.fee_collector)
    }

    public fun get_holder_info(arg0: &vector<NFT>, arg1: &CollectionCap, arg2: &vector<UserBalance>, arg3: address) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, u64, u64, bool, u64, bool, bool, bool, u64, vector<0x2::object::ID>, vector<u64>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x2::url::Url>, vector<0x2::url::Url>) {
        let v0 = get_collection_cap_id(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<UserBalance>(arg2)) {
            let v3 = 0x1::vector::borrow<UserBalance>(arg2, v2);
            if (get_user_balance_collection_id(v3) == v0) {
                v1 = v1 + get_user_balance_amount(v3);
            };
            v2 = v2 + 1;
        };
        let v4 = has_deny_list(arg1);
        let v5 = if (v4) {
            deny_list_size(arg1)
        } else {
            0
        };
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = 0x1::vector::empty<0x2::url::Url>();
        let v11 = 0x1::vector::empty<0x2::url::Url>();
        let v12 = 0;
        while (v12 < 0x1::vector::length<NFT>(arg0)) {
            let v13 = 0x1::vector::borrow<NFT>(arg0, v12);
            if (v13.collection_id == v0) {
                0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::uid_to_inner(&v13.id));
                0x1::vector::push_back<u64>(&mut v7, v13.asset_id);
                0x1::vector::push_back<0x1::string::String>(&mut v8, v13.name);
                0x1::vector::push_back<0x1::string::String>(&mut v9, v13.description);
                0x1::vector::push_back<0x2::url::Url>(&mut v10, v13.uri);
                0x1::vector::push_back<0x2::url::Url>(&mut v11, v13.logo_uri);
            };
            v12 = v12 + 1;
        };
        (v0, arg1.creator, arg1.name, arg1.description, arg1.current_supply, arg1.max_supply, arg1.is_mutable, v1, is_denied(arg1, arg3), v4, has_deny_list_authority(arg1), v5, v6, v7, v8, v9, v10, v11)
    }

    public fun get_max_supply(arg0: &NFT) : u64 {
        arg0.max_supply
    }

    public fun get_nft_asset_id(arg0: &NFT) : u64 {
        arg0.asset_id
    }

    public fun get_nft_by_asset_id(arg0: &CollectionCap, arg1: &vector<NFT>, arg2: u64) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<NFT>(arg1)) {
            let v1 = 0x1::vector::borrow<NFT>(arg1, v0);
            if (v1.collection_id == get_collection_cap_id(arg0) && v1.asset_id == arg2) {
                return (0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v1.id)), 0x1::option::some<address>(v1.creator))
            };
            v0 = v0 + 1;
        };
        (0x1::option::none<0x2::object::ID>(), 0x1::option::none<address>())
    }

    public fun get_nft_collection_id(arg0: &NFT) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_nft_creator(arg0: &NFT) : address {
        arg0.creator
    }

    public fun get_nft_id(arg0: &NFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_nfts_by_asset_ids(arg0: &CollectionCap, arg1: &vector<NFT>, arg2: vector<u64>) : (vector<0x2::object::ID>, vector<address>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg2)) {
            let v5 = *0x1::vector::borrow<u64>(&arg2, v4);
            let v6 = false;
            let v7 = 0;
            while (v7 < 0x1::vector::length<NFT>(arg1)) {
                let v8 = 0x1::vector::borrow<NFT>(arg1, v7);
                if (v8.collection_id == get_collection_cap_id(arg0) && v8.asset_id == v5) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::uid_to_inner(&v8.id));
                    0x1::vector::push_back<address>(&mut v1, v8.creator);
                    0x1::vector::push_back<u64>(&mut v2, v5);
                    v6 = true;
                    break
                };
                v7 = v7 + 1;
            };
            if (!v6) {
                0x1::vector::push_back<u64>(&mut v3, v5);
            };
            v4 = v4 + 1;
        };
        (v0, v1, v2, v3)
    }

    public fun get_user_balance(arg0: &UserBalance) : u64 {
        arg0.balance
    }

    public fun get_user_balance_amount(arg0: &UserBalance) : u64 {
        arg0.balance
    }

    public fun get_user_balance_collection_id(arg0: &UserBalance) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_user_balance_id(arg0: &UserBalance) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun has_deny_list(arg0: &CollectionCap) : bool {
        let v0 = DenyListKey{dummy_field: false};
        0x2::dynamic_field::exists_<DenyListKey>(&arg0.id, v0)
    }

    public fun has_deny_list_authority(arg0: &CollectionCap) : bool {
        arg0.has_deny_list_authority
    }

    fun init(arg0: ART20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ART20>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{logo_uri}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{uri}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = TokenIdCounter{
            id      : 0x2::object::new(arg1),
            last_id : 0,
        };
        0x2::transfer::share_object<TokenIdCounter>(v6);
        let v7 = CategoryRegistry{
            id         : 0x2::object::new(arg1),
            categories : 0x2::table::new<0x1::string::String, Category>(arg1),
            admin      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<CategoryRegistry>(v7);
        let v8 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = FeeConfig{
            id            : 0x2::object::new(arg1),
            fee_amount    : 0,
            fee_coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
            fee_collector : 0x2::tx_context::sender(arg1),
            deployer      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<FeeConfig>(v9);
    }

    public fun initialize_deny_list(arg0: &mut CollectionCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 2);
        assert!(arg0.has_deny_list_authority, 13);
        assert!(!has_deny_list(arg0), 14);
        let v0 = DenyListKey{dummy_field: false};
        0x2::dynamic_field::add<DenyListKey, 0x2::table::Table<address, bool>>(&mut arg0.id, v0, 0x2::table::new<address, bool>(arg1));
    }

    public fun is_denied(arg0: &CollectionCap, arg1: address) : bool {
        if (!has_deny_list(arg0)) {
            return false
        };
        let v0 = DenyListKey{dummy_field: false};
        0x2::table::contains<address, bool>(0x2::dynamic_field::borrow<DenyListKey, 0x2::table::Table<address, bool>>(&arg0.id, v0), arg1)
    }

    public entry fun mint_additional_art20(arg0: &mut CollectionCap, arg1: u64, arg2: &mut TokenIdCounter, arg3: &mut UserBalance, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_mintable, 0);
        assert!(0x2::tx_context::sender(arg5) == arg0.creator, 2);
        assert!(arg0.max_supply == 0 || arg0.current_supply + arg1 <= arg0.max_supply, 2);
        assert!(arg3.collection_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        arg3.balance = arg3.balance + arg1;
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0;
        while (v1 < arg1) {
            arg2.last_id = arg2.last_id + 1;
            let v2 = NFT{
                id            : 0x2::object::new(arg5),
                artinals_id   : arg2.last_id,
                creator       : arg0.creator,
                name          : arg0.name,
                description   : arg0.description,
                uri           : arg0.uri,
                logo_uri      : arg0.logo_uri,
                asset_id      : arg0.current_supply + v1 + 1,
                max_supply    : arg0.max_supply,
                collection_id : v0,
                category      : 0x1::string::utf8(b""),
            };
            let v3 = TransferEvent{
                from     : 0x2::tx_context::sender(arg5),
                to       : 0x2::tx_context::sender(arg5),
                id       : 0x2::object::uid_to_inner(&v2.id),
                royalty  : 0,
                asset_id : v2.asset_id,
            };
            0x2::event::emit<TransferEvent>(v3);
            let v4 = NFTMintedEvent{
                id          : 0x2::object::uid_to_inner(&v2.id),
                artinals_id : v2.artinals_id,
                creator     : v2.creator,
                name        : v2.name,
                asset_id    : v2.asset_id,
            };
            0x2::event::emit<NFTMintedEvent>(v4);
            0x2::transfer::transfer<NFT>(v2, 0x2::tx_context::sender(arg5));
            v1 = v1 + 1;
        };
        arg0.current_supply = arg0.current_supply + arg1;
        let v5 = AdditionalMintEvent{
            collection_id : v0,
            amount        : arg1,
            new_supply    : arg0.current_supply,
            max_supply    : arg0.max_supply,
            creator       : arg0.creator,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdditionalMintEvent>(v5);
    }

    public entry fun mint_art20<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: &CategoryRegistry, arg8: bool, arg9: bool, arg10: &mut TokenIdCounter, arg11: &FeeConfig, arg12: 0x2::coin::Coin<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Category>(&arg7.categories, arg6), 30);
        assert!(0x2::table::borrow<0x1::string::String, Category>(&arg7.categories, arg6).is_active, 29);
        assert!(arg2 >= 0, 16);
        assert!(arg2 <= 1000, 20);
        let v0 = 0x2::coin::value<T0>(&arg12);
        if (arg11.fee_amount > 0) {
            assert!(v0 >= arg11.fee_amount, 26);
            assert!(0x1::type_name::get<T0>() == arg11.fee_coin_type, 26);
            if (v0 > arg11.fee_amount) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg12, v0 - arg11.fee_amount, arg14), 0x2::tx_context::sender(arg14));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg12, arg11.fee_collector);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg12, 0x2::tx_context::sender(arg14));
        };
        assert!(arg3 <= 1000000000, 19);
        assert!(arg2 <= 1000000000, 19);
        assert!(arg3 == 0 || arg2 <= arg3, 25);
        assert!(arg10.last_id <= 18446744073709551615 - arg2, 18);
        let v1 = CollectionCap{
            id                      : 0x2::object::new(arg14),
            max_supply              : arg3,
            current_supply          : arg2,
            creator                 : 0x2::tx_context::sender(arg14),
            name                    : 0x1::string::utf8(arg0),
            description             : 0x1::string::utf8(arg1),
            uri                     : 0x2::url::new_unsafe_from_bytes(arg4),
            logo_uri                : 0x2::url::new_unsafe_from_bytes(arg5),
            is_mutable              : arg8,
            is_mintable             : true,
            has_deny_list_authority : arg9,
            value_source            : 0x1::option::none<0x1::string::String>(),
            is_api_source           : false,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = CollectionCreatedEvent{
            collection_id           : v2,
            creator                 : 0x2::tx_context::sender(arg14),
            name                    : 0x1::string::utf8(arg0),
            description             : 0x1::string::utf8(arg1),
            initial_supply          : arg2,
            max_supply              : arg3,
            is_mutable              : arg8,
            has_deny_list_authority : arg9,
            timestamp               : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<CollectionCreatedEvent>(v3);
        let v4 = CollectionMintEvent{
            collection_id  : v2,
            amount         : arg2,
            current_supply : arg2,
            max_supply     : arg3,
            creator        : 0x2::tx_context::sender(arg14),
            timestamp      : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<CollectionMintEvent>(v4);
        let v5 = DenyListKey{dummy_field: false};
        let v6 = create_deny_list(arg14);
        0x2::dynamic_field::add<DenyListKey, 0x2::table::Table<address, bool>>(&mut v1.id, v5, v6);
        let v7 = UserBalance{
            id            : 0x2::object::new(arg14),
            collection_id : v2,
            balance       : arg2,
        };
        let v8 = 0x1::vector::empty<NFT>();
        let v9 = 0;
        while (v9 < arg2) {
            arg10.last_id = arg10.last_id + 1;
            let v10 = NFT{
                id            : 0x2::object::new(arg14),
                artinals_id   : arg10.last_id,
                creator       : 0x2::tx_context::sender(arg14),
                name          : 0x1::string::utf8(arg0),
                description   : 0x1::string::utf8(arg1),
                uri           : 0x2::url::new_unsafe_from_bytes(arg4),
                logo_uri      : 0x2::url::new_unsafe_from_bytes(arg5),
                asset_id      : v9 + 1,
                max_supply    : arg3,
                collection_id : v2,
                category      : arg6,
            };
            let v11 = NFTMintedEvent{
                id          : 0x2::object::uid_to_inner(&v10.id),
                artinals_id : v10.artinals_id,
                creator     : v10.creator,
                name        : v10.name,
                asset_id    : v10.asset_id,
            };
            0x2::event::emit<NFTMintedEvent>(v11);
            let v12 = TransferEvent{
                from     : 0x2::tx_context::sender(arg14),
                to       : 0x2::tx_context::sender(arg14),
                id       : 0x2::object::uid_to_inner(&v10.id),
                royalty  : 0,
                asset_id : v10.asset_id,
            };
            0x2::event::emit<TransferEvent>(v12);
            0x1::vector::push_back<NFT>(&mut v8, v10);
            v9 = v9 + 1;
        };
        while (!0x1::vector::is_empty<NFT>(&v8)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut v8), 0x2::tx_context::sender(arg14));
        };
        0x1::vector::destroy_empty<NFT>(v8);
        0x2::transfer::share_object<CollectionCap>(v1);
        0x2::transfer::transfer<UserBalance>(v7, 0x2::tx_context::sender(arg14));
    }

    public entry fun remove_from_deny_list(arg0: &mut CollectionCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::length<address>(&arg1);
        assert!(v1 > 0 && v1 <= 200, 16);
        assert!(v0 == arg0.creator, 2);
        assert!(arg0.has_deny_list_authority, 13);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            let v4 = DenyListKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow_mut<DenyListKey, 0x2::table::Table<address, bool>>(&mut arg0.id, v4);
            if (0x2::table::contains<address, bool>(v5, v3)) {
                0x2::table::remove<address, bool>(v5, v3);
                let v6 = DenyListStatusChanged{
                    collection_id : 0x2::object::uid_to_inner(&arg0.id),
                    address       : v3,
                    is_denied     : false,
                    changed_by    : v0,
                };
                0x2::event::emit<DenyListStatusChanged>(v6);
            };
            v2 = v2 + 1;
        };
    }

    public fun revoke_deny_list_authority(arg0: &mut CollectionCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.has_deny_list_authority, 2);
        arg0.has_deny_list_authority = false;
        let v0 = DenyListAuthorityRevokedEvent{collection_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<DenyListAuthorityRevokedEvent>(v0);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 18);
        arg0 + arg1
    }

    fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 9);
        arg0 - arg1
    }

    public entry fun set_collection_value_source(arg0: &mut CollectionCap, arg1: vector<u8>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 2);
        let v0 = 0x1::string::utf8(arg1);
        if (arg2) {
            let v1 = 0x1::string::as_bytes(&v0);
            assert!(0x1::vector::length<u8>(v1) <= 256, 15);
            let v2 = b"https://";
            let v3 = 0x1::vector::length<u8>(&v2);
            assert!(0x1::vector::length<u8>(v1) >= v3, 22);
            let v4 = 0;
            let v5 = true;
            while (v4 < v3) {
                if (*0x1::vector::borrow<u8>(v1, v4) != *0x1::vector::borrow<u8>(&v2, v4)) {
                    v5 = false;
                    break
                };
                v4 = v4 + 1;
            };
            assert!(v5, 22);
        } else {
            assert!(0x1::string::length(&v0) == 64, 23);
        };
        if (0x1::option::is_none<0x1::string::String>(&arg0.value_source)) {
            arg0.value_source = 0x1::option::some<0x1::string::String>(v0);
        } else {
            *0x1::option::borrow_mut<0x1::string::String>(&mut arg0.value_source) = v0;
        };
        arg0.is_api_source = arg2;
        let v6 = CollectionValueSourceUpdated{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            is_api        : arg2,
            source        : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CollectionValueSourceUpdated>(v6);
    }

    public entry fun set_fee<T0>(arg0: &mut FeeConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 25);
        arg0.fee_amount = arg1;
        arg0.fee_coin_type = 0x1::type_name::get<T0>();
    }

    public fun set_user_balance_amount(arg0: &mut UserBalance, arg1: u64) {
        arg0.balance = arg1;
    }

    public entry fun transfer_admin_cap(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 25);
        arg0.owner = arg1;
    }

    public entry fun transfer_art20(arg0: vector<NFT>, arg1: vector<address>, arg2: &CollectionCap, arg3: vector<UserBalance>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::length<NFT>(&arg0);
        let v2 = 0x1::vector::length<address>(&arg1);
        assert!(v1 == v2, 15);
        assert!(v1 <= 200, 20);
        assert!(v1 > 0, 16);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<UserBalance>(&arg3)) {
            v3 = safe_add(v3, 0x1::vector::borrow<UserBalance>(&arg3, v4).balance);
            v4 = v4 + 1;
        };
        assert!(v3 >= v1, 9);
        check_deny_list_restrictions(arg2, v0);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x2::object::uid_to_inner(&arg2.id);
        let v8 = 0;
        while (v8 < v2) {
            let v9 = *0x1::vector::borrow<address>(&arg1, v8);
            check_deny_list_restrictions(arg2, v9);
            let v10 = UserBalance{
                id            : 0x2::object::new(arg5),
                collection_id : v7,
                balance       : 1,
            };
            let v11 = 0x1::vector::pop_back<NFT>(&mut arg0);
            assert!(v11.collection_id == v7, 8);
            let v12 = false;
            let v13 = 0;
            while (v13 < 0x1::vector::length<UserBalance>(&arg3)) {
                let v14 = 0x1::vector::borrow_mut<UserBalance>(&mut arg3, v13);
                if (v14.balance > 0 && v14.collection_id == v7) {
                    v14.balance = safe_sub(v14.balance, 1);
                    v12 = true;
                    break
                };
                v13 = v13 + 1;
            };
            assert!(v12, 9);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::uid_to_inner(&v11.id));
            0x1::vector::push_back<u64>(&mut v6, 1);
            let v15 = TransferEvent{
                from     : v0,
                to       : v9,
                id       : 0x2::object::uid_to_inner(&v11.id),
                royalty  : 0,
                asset_id : v11.asset_id,
            };
            0x2::event::emit<TransferEvent>(v15);
            0x2::transfer::transfer<NFT>(v11, v9);
            0x2::transfer::transfer<UserBalance>(v10, v9);
            v8 = v8 + 1;
        };
        while (0 < 0x1::vector::length<UserBalance>(&arg3)) {
            let v16 = 0x1::vector::remove<UserBalance>(&mut arg3, 0);
            if (v16.balance > 0) {
                0x2::transfer::transfer<UserBalance>(v16, v0);
                continue
            };
            let UserBalance {
                id            : v17,
                collection_id : _,
                balance       : _,
            } = v16;
            0x2::object::delete(v17);
        };
        0x1::vector::destroy_empty<NFT>(arg0);
        0x1::vector::destroy_empty<UserBalance>(arg3);
        let v20 = BatchTransferEvent{
            from          : v0,
            recipients    : arg1,
            token_ids     : v5,
            amounts       : v6,
            collection_id : v7,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BatchTransferEvent>(v20);
    }

    public entry fun transfer_art20_by_asset_ids(arg0: &CollectionCap, arg1: vector<NFT>, arg2: vector<UserBalance>, arg3: vector<u64>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = get_collection_cap_id(arg0);
        validate_transfer(arg0, v0, arg4);
        check_deny_list_restrictions(arg0, arg4);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg3)) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v4);
            let (v6, v7) = get_nft_by_asset_id(arg0, &arg1, v5);
            let v8 = v7;
            let v9 = v6;
            assert!(0x1::option::is_some<0x2::object::ID>(&v9), 21);
            assert!(0x1::option::is_some<address>(&v8), 5);
            assert!(0x1::option::extract<address>(&mut v8) == v0, 5);
            let v10 = 0;
            let v11 = false;
            let v12 = v11;
            while (v10 < 0x1::vector::length<NFT>(&arg1)) {
                let v13 = 0x1::vector::borrow_mut<NFT>(&mut arg1, v10);
                let v14 = if (v13.collection_id == v1) {
                    if (v13.asset_id == v5) {
                        !v11
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v14) {
                    let v15 = false;
                    let v16 = 0;
                    while (v16 < 0x1::vector::length<UserBalance>(&arg2)) {
                        let v17 = 0x1::vector::borrow_mut<UserBalance>(&mut arg2, v16);
                        if (v17.collection_id == v1 && v17.balance > 0) {
                            v17.balance = safe_sub(v17.balance, 1);
                            v15 = true;
                            break
                        };
                        v16 = v16 + 1;
                    };
                    assert!(v15, 9);
                    0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x1::option::extract<0x2::object::ID>(&mut v9));
                    0x1::vector::push_back<u64>(&mut v3, 1);
                    0x2::transfer::transfer<NFT>(0x1::vector::remove<NFT>(&mut arg1, v10), arg4);
                    v12 = true;
                    break
                };
                v10 = v10 + 1;
            };
            assert!(v12, 21);
            v4 = v4 + 1;
        };
        let v18 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v18, arg4);
        let v19 = BatchTransferEvent{
            from          : v0,
            recipients    : v18,
            token_ids     : v2,
            amounts       : v3,
            collection_id : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BatchTransferEvent>(v19);
        let v20 = 0;
        while (v20 < 0x1::vector::length<UserBalance>(&arg2)) {
            if (0x1::vector::borrow_mut<UserBalance>(&mut arg2, v20).balance == 0) {
                cleanup_empty_balance(0x1::vector::remove<UserBalance>(&mut arg2, v20));
                continue
            };
            v20 = v20 + 1;
        };
        while (!0x1::vector::is_empty<UserBalance>(&arg2)) {
            0x2::transfer::transfer<UserBalance>(0x1::vector::pop_back<UserBalance>(&mut arg2), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
        0x1::vector::destroy_empty<UserBalance>(arg2);
        0x1::vector::destroy_empty<0x2::object::ID>(v2);
        0x1::vector::destroy_empty<u64>(v3);
    }

    public entry fun transfer_art20_in_quantity(arg0: vector<NFT>, arg1: address, arg2: u64, arg3: &CollectionCap, arg4: vector<UserBalance>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 16);
        let v0 = 0x2::tx_context::sender(arg6);
        validate_transfer(arg3, v0, arg1);
        let v1 = 0x2::object::uid_to_inner(&arg3.id);
        assert!(0x1::vector::length<NFT>(&arg0) >= arg2, 28);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<UserBalance>(&arg4)) {
            v2 = safe_add(v2, 0x1::vector::borrow<UserBalance>(&arg4, v3).balance);
            v3 = v3 + 1;
        };
        assert!(v2 >= arg2, 9);
        let v4 = UserBalance{
            id            : 0x2::object::new(arg6),
            collection_id : 0x2::object::uid_to_inner(&arg3.id),
            balance       : arg2,
        };
        let v5 = arg2;
        let v6 = 0x1::vector::empty<UserBalance>();
        while (v5 > 0) {
            let v7 = 0x1::vector::pop_back<UserBalance>(&mut arg4);
            assert!(v7.collection_id == v1, 8);
            if (v7.balance <= v5) {
                v5 = v5 - v7.balance;
                let UserBalance {
                    id            : v8,
                    collection_id : _,
                    balance       : _,
                } = v7;
                0x2::object::delete(v8);
                continue
            };
            v7.balance = v7.balance - v5;
            v5 = 0;
            0x1::vector::push_back<UserBalance>(&mut v6, v7);
        };
        while (!0x1::vector::is_empty<UserBalance>(&arg4)) {
            let v11 = 0x1::vector::pop_back<UserBalance>(&mut arg4);
            assert!(v11.collection_id == v1, 8);
            0x1::vector::push_back<UserBalance>(&mut v6, v11);
        };
        while (!0x1::vector::is_empty<UserBalance>(&v6)) {
            let v12 = 0x1::vector::pop_back<UserBalance>(&mut v6);
            if (v12.balance > 0) {
                0x2::transfer::transfer<UserBalance>(v12, v0);
                continue
            };
            let UserBalance {
                id            : v13,
                collection_id : _,
                balance       : _,
            } = v12;
            0x2::object::delete(v13);
        };
        0x2::transfer::transfer<UserBalance>(v4, arg1);
        let v16 = 0x1::vector::empty<0x2::object::ID>();
        let v17 = 0x1::vector::empty<u64>();
        let v18 = 0x2::object::uid_to_inner(&arg3.id);
        let v19 = 0;
        while (v19 < arg2) {
            let v20 = 0x1::vector::pop_back<NFT>(&mut arg0);
            assert!(v18 == v20.collection_id, 8);
            0x1::vector::push_back<0x2::object::ID>(&mut v16, 0x2::object::uid_to_inner(&v20.id));
            0x1::vector::push_back<u64>(&mut v17, 1);
            let v21 = TransferEvent{
                from     : v0,
                to       : arg1,
                id       : 0x2::object::uid_to_inner(&v20.id),
                royalty  : 0,
                asset_id : v20.asset_id,
            };
            0x2::event::emit<TransferEvent>(v21);
            0x2::transfer::transfer<NFT>(v20, arg1);
            v19 = v19 + 1;
        };
        while (!0x1::vector::is_empty<NFT>(&arg0)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg0), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg0);
        0x1::vector::destroy_empty<UserBalance>(arg4);
        0x1::vector::destroy_empty<UserBalance>(v6);
        let v22 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v22, arg1);
        let v23 = BatchTransferEvent{
            from          : v0,
            recipients    : v22,
            token_ids     : v16,
            amounts       : v17,
            collection_id : v18,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BatchTransferEvent>(v23);
    }

    public fun update_art20_image_uri(arg0: &mut NFT, arg1: &CollectionCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == get_collection_cap_id(arg1), 8);
        assert!(arg1.is_mutable, 3);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 2);
        arg0.logo_uri = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = LogoURIUpdateEvent{
            id           : 0x2::object::uid_to_inner(&arg0.id),
            artinals_id  : arg0.artinals_id,
            new_logo_uri : arg0.logo_uri,
        };
        0x2::event::emit<LogoURIUpdateEvent>(v0);
    }

    public entry fun update_art20_image_uri_by_asset_id(arg0: &CollectionCap, arg1: vector<NFT>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.is_mutable, 3);
        check_deny_list_restrictions(arg0, v0);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 15);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 15);
        0x2::url::new_unsafe_from_bytes(arg3);
        let v1 = 0x1::vector::empty<NFT>();
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<NFT>(&arg1)) {
            let v4 = 0x1::vector::pop_back<NFT>(&mut arg1);
            let v5 = if (v4.collection_id == get_collection_cap_id(arg0)) {
                if (v4.asset_id == arg2) {
                    !v3
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                assert!(v0 == v4.creator, 2);
                v4.logo_uri = 0x2::url::new_unsafe_from_bytes(arg3);
                let v6 = LogoURIUpdateEvent{
                    id           : 0x2::object::uid_to_inner(&v4.id),
                    artinals_id  : v4.artinals_id,
                    new_logo_uri : v4.logo_uri,
                };
                0x2::event::emit<LogoURIUpdateEvent>(v6);
                v3 = true;
            };
            0x1::vector::push_back<NFT>(&mut v1, v4);
            v2 = v2 + 1;
        };
        assert!(v3, 21);
        while (!0x1::vector::is_empty<NFT>(&v1)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut v1), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
        0x1::vector::destroy_empty<NFT>(v1);
    }

    public fun update_collection_supply(arg0: &mut CollectionCap, arg1: u64) {
        arg0.current_supply = arg1;
    }

    public entry fun update_metadata_by_asset_id(arg0: &CollectionCap, arg1: vector<NFT>, arg2: u64, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v1 = 0x1::option::borrow<0x1::string::String>(&arg3);
            assert!(0x1::string::length(v1) <= 128, 15);
            let v2 = 0x1::string::as_bytes(v1);
            assert!(0x1::vector::length<u8>(v2) <= 512, 15);
            assert!(0x1::vector::length<u8>(v2) > 0, 15);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v3 = 0x1::option::borrow<0x1::string::String>(&arg4);
            assert!(0x1::string::length(v3) <= 1000, 15);
            let v4 = 0x1::string::as_bytes(v3);
            assert!(0x1::vector::length<u8>(v4) <= 4000, 15);
            assert!(0x1::vector::length<u8>(v4) > 0, 15);
        };
        if (0x1::option::is_some<vector<u8>>(&arg5)) {
            let v5 = 0x1::option::borrow<vector<u8>>(&arg5);
            assert!(0x1::vector::length<u8>(v5) <= 256, 15);
            assert!(0x1::vector::length<u8>(v5) > 0, 15);
        };
        if (0x1::option::is_some<vector<u8>>(&arg6)) {
            let v6 = 0x1::option::borrow<vector<u8>>(&arg6);
            assert!(0x1::vector::length<u8>(v6) <= 256, 15);
            assert!(0x1::vector::length<u8>(v6) > 0, 15);
        };
        let v7 = 0x1::vector::empty<NFT>();
        let v8 = false;
        while (!0x1::vector::is_empty<NFT>(&arg1) && !v8) {
            let v9 = 0x1::vector::pop_back<NFT>(&mut arg1);
            if (v9.collection_id == get_collection_cap_id(arg0) && v9.asset_id == arg2) {
                assert!(arg0.is_mutable, 3);
                assert!(v0 == v9.creator, 2);
                if (0x1::option::is_some<0x1::string::String>(&arg3)) {
                    v9.name = 0x1::option::extract<0x1::string::String>(&mut arg3);
                };
                if (0x1::option::is_some<0x1::string::String>(&arg4)) {
                    v9.description = 0x1::option::extract<0x1::string::String>(&mut arg4);
                };
                if (0x1::option::is_some<vector<u8>>(&arg5)) {
                    v9.uri = 0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg5));
                };
                if (0x1::option::is_some<vector<u8>>(&arg6)) {
                    v9.logo_uri = 0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg6));
                };
                let v10 = MetadataUpdateEvent{
                    id              : 0x2::object::uid_to_inner(&v9.id),
                    new_name        : v9.name,
                    new_description : v9.description,
                };
                0x2::event::emit<MetadataUpdateEvent>(v10);
                v8 = true;
            };
            0x1::vector::push_back<NFT>(&mut v7, v9);
        };
        while (!0x1::vector::is_empty<NFT>(&arg1)) {
            0x1::vector::push_back<NFT>(&mut v7, 0x1::vector::pop_back<NFT>(&mut arg1));
        };
        assert!(v8, 21);
        while (!0x1::vector::is_empty<NFT>(&v7)) {
            0x2::transfer::transfer<NFT>(0x1::vector::pop_back<NFT>(&mut v7), v0);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
        0x1::vector::destroy_empty<NFT>(v7);
    }

    public entry fun update_metadata_by_object(arg0: &mut NFT, arg1: &CollectionCap, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == get_collection_cap_id(arg1), 8);
        assert!(arg1.is_mutable, 3);
        assert!(0x2::tx_context::sender(arg6) == arg0.creator, 2);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v0 = 0x1::option::extract<0x1::string::String>(&mut arg2);
            assert!(0x1::string::length(&v0) <= 128, 15);
            arg0.name = v0;
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v1 = 0x1::option::extract<0x1::string::String>(&mut arg3);
            assert!(0x1::string::length(&v1) <= 1000, 15);
            arg0.description = v1;
        };
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            let v2 = 0x1::option::extract<vector<u8>>(&mut arg4);
            assert!(0x1::vector::length<u8>(&v2) <= 256, 15);
            arg0.uri = 0x2::url::new_unsafe_from_bytes(v2);
        };
        if (0x1::option::is_some<vector<u8>>(&arg5)) {
            let v3 = 0x1::option::extract<vector<u8>>(&mut arg5);
            assert!(0x1::vector::length<u8>(&v3) <= 256, 15);
            arg0.logo_uri = 0x2::url::new_unsafe_from_bytes(v3);
        };
        let v4 = MetadataUpdateEvent{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            new_name        : arg0.name,
            new_description : arg0.description,
        };
        0x2::event::emit<MetadataUpdateEvent>(v4);
    }

    public fun validate_transfer(arg0: &CollectionCap, arg1: address, arg2: address) {
        assert!(can_receive_art20(arg0, arg1), 12);
        assert!(can_receive_art20(arg0, arg2), 12);
    }

    public fun verify_admin(arg0: &AdminCap, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun verify_collection_match(arg0: &CollectionCap, arg1: &UserBalance) : bool {
        get_collection_cap_id(arg0) == get_user_balance_collection_id(arg1)
    }

    // decompiled from Move bytecode v6
}

