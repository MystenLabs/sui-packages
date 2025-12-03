module 0xd078bd7e37ae449a4f7e2cfadb5a5b592dd2bb3ba6cceba1c9dada2bc6da8c43::trace_minting {
    struct CollectionCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
        current_supply: u64,
        burned_count: u64,
        creator: address,
        created_at: u64,
        admins: vector<address>,
        metadata_table: 0x2::table::Table<u64, 0x1::string::String>,
        type_counts: 0x2::table::Table<0x1::string::String, u64>,
        type_max_supplies: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct TraceNFT has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        token_id: u64,
        collectible_type: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        minted_at: u64,
        minted_by: address,
        metadata_url: 0x1::string::String,
    }

    struct TRACE_MINTING has drop {
        dummy_field: bool,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        collection_id: 0x2::object::ID,
        token_id: u64,
        collectible_type: 0x1::string::String,
        recipient: address,
        minted_at: u64,
    }

    struct NFTBurned has copy, drop {
        collection_id: 0x2::object::ID,
        token_id: u64,
        burned_by: address,
        burned_at: u64,
    }

    struct MaxSupplyUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        old_max_supply: u64,
        new_max_supply: u64,
        updated_by: address,
        updated_at: u64,
    }

    struct TypeMaxSupplySet has copy, drop {
        collection_id: 0x2::object::ID,
        collectible_type: 0x1::string::String,
        max_supply: u64,
        set_by: address,
        set_at: u64,
    }

    struct AdminAdded has copy, drop {
        collection_id: 0x2::object::ID,
        admin: address,
        added_by: address,
        added_at: u64,
    }

    struct AdminRemoved has copy, drop {
        collection_id: 0x2::object::ID,
        admin: address,
        removed_by: address,
        removed_at: u64,
    }

    struct CollectionInfoUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        updated_by: address,
        updated_at: u64,
    }

    public fun add_admin(arg0: &mut CollectionCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg3);
        if (!contains_address(&arg0.admins, arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v0 = AdminAdded{
                collection_id : 0x2::object::uid_to_inner(&arg0.id),
                admin         : arg1,
                added_by      : 0x2::tx_context::sender(arg3),
                added_at      : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<AdminAdded>(v0);
        };
    }

    public fun add_collection_metadata(arg0: &mut CollectionCap, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg3);
        0x2::table::add<u64, 0x1::string::String>(&mut arg0.metadata_table, arg1, arg2);
    }

    fun assert_is_admin(arg0: &CollectionCap, arg1: &0x2::tx_context::TxContext) {
        assert!(contains_address(&arg0.admins, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun batch_mint_nfts(arg0: &mut CollectionCap, arg1: vector<address>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg8);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 7);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 7);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 7);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg5), 7);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg6), 7);
        assert!(arg0.current_supply + v0 <= arg0.max_supply, 5);
        let v1 = 0;
        while (v1 < v0) {
            mint(arg0, *0x1::vector::borrow<address>(&arg1, v1), *0x1::vector::borrow<0x1::string::String>(&arg2, v1), *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1), *0x1::vector::borrow<0x1::string::String>(&arg5, v1), *0x1::vector::borrow<0x1::string::String>(&arg6, v1), arg7, arg8);
            v1 = v1 + 1;
        };
    }

    public fun burn_nft(arg0: TraceNFT, arg1: &mut CollectionCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg1, arg3);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(arg0.collection_id == v0, 10);
        let v1 = arg0.collectible_type;
        arg1.burned_count = arg1.burned_count + 1;
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.type_counts, v1)) {
            let v2 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.type_counts, v1);
            if (*v2 > 0) {
                *v2 = *v2 - 1;
            };
        };
        let v3 = NFTBurned{
            collection_id : v0,
            token_id      : arg0.token_id,
            burned_by     : 0x2::tx_context::sender(arg3),
            burned_at     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NFTBurned>(v3);
        let TraceNFT {
            id               : v4,
            collection_id    : _,
            token_id         : _,
            collectible_type : _,
            name             : _,
            description      : _,
            image_url        : _,
            attributes       : v11,
            minted_at        : _,
            minted_by        : _,
            metadata_url     : _,
        } = arg0;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v11);
        0x2::object::delete(v4);
    }

    fun contains_address(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = CollectionCap{
            id                : 0x2::object::new(arg4),
            name              : arg0,
            description       : arg1,
            image_url         : arg2,
            max_supply        : 18446744073709551615,
            current_supply    : 0,
            burned_count      : 0,
            creator           : v0,
            created_at        : 0x2::clock::timestamp_ms(arg3),
            admins            : v1,
            metadata_table    : 0x2::table::new<u64, 0x1::string::String>(arg4),
            type_counts       : 0x2::table::new<0x1::string::String, u64>(arg4),
            type_max_supplies : 0x2::table::new<0x1::string::String, u64>(arg4),
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = CollectionCreated{
            collection_id : v3,
            name          : v2.name,
            creator       : v2.creator,
        };
        0x2::event::emit<CollectionCreated>(v4);
        0x2::transfer::share_object<CollectionCap>(v2);
        v3
    }

    public fun get_collection_info(arg0: &CollectionCap) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, address) {
        (arg0.name, arg0.description, arg0.image_url, arg0.max_supply, arg0.current_supply, arg0.creator)
    }

    public fun get_nft_info(arg0: &TraceNFT) : (0x2::object::ID, u64, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, address, 0x1::string::String) {
        (arg0.collection_id, arg0.token_id, arg0.collectible_type, arg0.name, arg0.description, arg0.image_url, arg0.minted_at, arg0.minted_by, arg0.metadata_url)
    }

    public fun get_type_count(arg0: &CollectionCap, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_counts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.type_counts, arg1)
        } else {
            0
        }
    }

    public fun get_type_max_supply(arg0: &CollectionCap, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_max_supplies, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.type_max_supplies, arg1)
        } else {
            18446744073709551615
        }
    }

    fun init(arg0: TRACE_MINTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TRACE_MINTING>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.trace.fan/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.trace.fan"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Trace Platform"));
        let v5 = 0x2::display::new_with_fields<TraceNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<TraceNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TraceNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_admin(arg0: &CollectionCap, arg1: address) : bool {
        contains_address(&arg0.admins, arg1)
    }

    public fun mint(arg0: &mut CollectionCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg8);
        assert!(arg0.current_supply < arg0.max_supply, 5);
        assert!(0x1::string::length(&arg3) > 0, 2);
        assert!(0x1::string::length(&arg4) > 0, 2);
        assert!(0x1::string::length(&arg2) > 0, 2);
        let v0 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_counts, arg2)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.type_counts, arg2)
        } else {
            0
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_max_supplies, arg2)) {
            assert!(v0 < *0x2::table::borrow<0x1::string::String, u64>(&arg0.type_max_supplies, arg2), 9);
        };
        let v1 = arg0.current_supply + 1;
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = 0x1::string::utf8(*0x1::string::bytes(&arg2));
        let v4 = TraceNFT{
            id               : 0x2::object::new(arg8),
            collection_id    : 0x2::object::uid_to_inner(&arg0.id),
            token_id         : v1,
            collectible_type : arg2,
            name             : arg3,
            description      : arg4,
            image_url        : arg5,
            attributes       : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg8),
            minted_at        : v2,
            minted_by        : 0x2::tx_context::sender(arg8),
            metadata_url     : arg6,
        };
        0x2::transfer::transfer<TraceNFT>(v4, arg1);
        arg0.current_supply = arg0.current_supply + 1;
        let v5 = 0x1::string::utf8(*0x1::string::bytes(&v3));
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_counts, v5)) {
            let v6 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.type_counts, v5);
            *v6 = *v6 + 1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.type_counts, v5, 1);
        };
        let v7 = NFTMinted{
            collection_id    : 0x2::object::uid_to_inner(&arg0.id),
            token_id         : v1,
            collectible_type : v3,
            recipient        : arg1,
            minted_at        : v2,
        };
        0x2::event::emit<NFTMinted>(v7);
    }

    public fun remove_admin(arg0: &mut CollectionCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg3);
        assert!(contains_address(&arg0.admins, arg1), 1);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 11);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.admins, v0);
                break
            };
            v0 = v0 + 1;
        };
        let v1 = AdminRemoved{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            admin         : arg1,
            removed_by    : 0x2::tx_context::sender(arg3),
            removed_at    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminRemoved>(v1);
    }

    public fun set_type_max_supply(arg0: &mut CollectionCap, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg4);
        let v0 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_counts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.type_counts, arg1)
        } else {
            0
        };
        assert!(arg2 >= v0, 8);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.type_max_supplies, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.type_max_supplies, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.type_max_supplies, arg1, arg2);
        };
        let v1 = TypeMaxSupplySet{
            collection_id    : 0x2::object::uid_to_inner(&arg0.id),
            collectible_type : arg1,
            max_supply       : arg2,
            set_by           : 0x2::tx_context::sender(arg4),
            set_at           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TypeMaxSupplySet>(v1);
    }

    public fun update_collection_info(arg0: &mut CollectionCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg5);
        if (0x1::string::length(&arg1) > 0) {
            arg0.name = arg1;
        };
        if (0x1::string::length(&arg2) > 0) {
            arg0.description = arg2;
        };
        if (0x1::string::length(&arg3) > 0) {
            arg0.image_url = arg3;
        };
        let v0 = CollectionInfoUpdated{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            updated_by    : 0x2::tx_context::sender(arg5),
            updated_at    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CollectionInfoUpdated>(v0);
    }

    public fun update_max_supply(arg0: &mut CollectionCap, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg3);
        assert!(arg1 >= arg0.current_supply, 8);
        arg0.max_supply = arg1;
        let v0 = MaxSupplyUpdated{
            collection_id  : 0x2::object::uid_to_inner(&arg0.id),
            old_max_supply : arg0.max_supply,
            new_max_supply : arg1,
            updated_by     : 0x2::tx_context::sender(arg3),
            updated_at     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MaxSupplyUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

