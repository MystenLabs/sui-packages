module 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::publication {
    struct Publication has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        slug: 0x1::string::String,
        collections: 0x2::vec_map::VecMap<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>,
        revoked_publisher_caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct PublicationCreated has copy, drop {
        publication: 0x2::object::ID,
        name: 0x1::string::String,
        slug: 0x1::string::String,
    }

    struct PublicationDeleted has copy, drop {
        publication: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct PublicationRegistry has key {
        id: 0x2::object::UID,
        slugs: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct SlugRegistered has copy, drop {
        slug: 0x1::string::String,
        publication: 0x2::object::ID,
    }

    struct SlugReleased has copy, drop {
        slug: 0x1::string::String,
        publication: 0x2::object::ID,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
    }

    struct PublisherCap has key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
        holder: address,
    }

    struct PublisherCapIssued has copy, drop {
        publication: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct PublisherCapRevoked has copy, drop {
        publication: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct CollectionAdded has copy, drop {
        publication: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct CollectionRemoved has copy, drop {
        publication: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun delete_collection(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active_publisher_cap(arg0, arg1, arg3);
        let (_, v1) = 0x2::vec_map::remove<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, &arg2);
        0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::delete_collection(v1);
        let v2 = CollectionRemoved{
            publication : 0x2::object::id<Publication>(arg0),
            name        : arg2,
        };
        0x2::event::emit<CollectionRemoved>(v2);
    }

    public fun add_entry_to_collection(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::string::String, arg7: bool, arg8: u8, arg9: 0x1::option::Option<vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        assert_active_publisher_cap(arg0, arg1, arg10);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, &arg2);
        0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::add_entry(v0, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::new_entry(arg3, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::make_blob_ref(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::storage_mode(v0), arg4, arg5), arg6, arg7, 0x2::tx_context::sender(arg10), arg8, arg9))
    }

    public fun append_collection_entry_draft_revision(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: u64, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::string::String, arg7: bool, arg8: u8, arg9: 0x1::option::Option<vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        assert_active_publisher_cap(arg0, arg1, arg10);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, &arg2);
        0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::append_draft_revision(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::entry_mut(v0, arg3), 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::make_blob_ref(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::storage_mode(v0), arg4, arg5), arg6, arg7, 0x2::tx_context::sender(arg10), arg8, arg9)
    }

    fun assert_active_publisher_cap(arg0: &Publication, arg1: &PublisherCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.publication_id == 0x2::object::id<Publication>(arg0), 2);
        assert!(arg1.holder == 0x2::tx_context::sender(arg2), 4);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_publisher_caps, 0x2::object::id<PublisherCap>(arg1)), 5);
    }

    fun assert_valid_publisher_seal_id(arg0: &Publication, arg1: &vector<u8>) {
        let v0 = 0x2::object::id<Publication>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(arg1) > v2 + 1, 12);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&v1, v3) == *0x1::vector::borrow<u8>(arg1, v3), 12);
            v3 = v3 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(arg1, v2) == 1, 13);
    }

    public fun contains_slug(arg0: &PublicationRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.slugs, arg1)
    }

    public fun create_collection(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active_publisher_cap(arg0, arg1, arg4);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&arg0.collections, &arg2), 0);
        let v0 = 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::new_collection(arg2, arg3, arg4);
        let v1 = 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::name(&v0);
        0x2::vec_map::insert<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, v1, v0);
        let v2 = CollectionAdded{
            publication : 0x2::object::id<Publication>(arg0),
            name        : v1,
        };
        0x2::event::emit<CollectionAdded>(v2);
    }

    public fun delete_entry_from_collection(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active_publisher_cap(arg0, arg1, arg4);
        0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::delete_entry(0x2::vec_map::get_mut<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, &arg2), arg3);
    }

    public fun delete_publication(arg0: &mut PublicationRegistry, arg1: Publication, arg2: OwnerCap) {
        assert!(arg2.publication_id == 0x2::object::id<Publication>(&arg1), 2);
        let OwnerCap {
            id             : v0,
            publication_id : _,
        } = arg2;
        0x2::object::delete(v0);
        let Publication {
            id                     : v2,
            name                   : v3,
            slug                   : v4,
            collections            : v5,
            revoked_publisher_caps : v6,
        } = arg1;
        let v7 = v2;
        let v8 = 0x2::object::uid_to_inner(&v7);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.slugs, v4);
        let v9 = SlugReleased{
            slug        : v4,
            publication : v8,
        };
        0x2::event::emit<SlugReleased>(v9);
        0x2::vec_map::destroy_empty<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(v5);
        0x2::table::drop<0x2::object::ID, bool>(v6);
        0x2::object::delete(v7);
        let v10 = PublicationDeleted{
            publication : v8,
            name        : v3,
        };
        0x2::event::emit<PublicationDeleted>(v10);
    }

    public fun destroy_publisher_cap(arg0: &mut Publication, arg1: PublisherCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.publication_id == 0x2::object::id<Publication>(arg0), 2);
        assert!(arg1.holder == 0x2::tx_context::sender(arg2), 4);
        let v0 = 0x2::object::id<PublisherCap>(&arg1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_publisher_caps, v0)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg0.revoked_publisher_caps, v0);
        };
        let PublisherCap {
            id             : v1,
            publication_id : _,
            holder         : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicationRegistry{
            id    : 0x2::object::new(arg0),
            slugs : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<PublicationRegistry>(v0);
    }

    public fun issue_publisher_cap(arg0: &mut Publication, arg1: &OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : PublisherCap {
        assert!(arg1.publication_id == 0x2::object::id<Publication>(arg0), 2);
        let v0 = PublisherCap{
            id             : 0x2::object::new(arg3),
            publication_id : 0x2::object::id<Publication>(arg0),
            holder         : arg2,
        };
        let v1 = PublisherCapIssued{
            publication : 0x2::object::id<Publication>(arg0),
            cap         : 0x2::object::id<PublisherCap>(&v0),
        };
        0x2::event::emit<PublisherCapIssued>(v1);
        v0
    }

    public fun new_publication(arg0: &mut PublicationRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : (Publication, OwnerCap, PublisherCap) {
        let v0 = Publication{
            id                     : 0x2::object::new(arg3),
            name                   : arg1,
            slug                   : arg2,
            collections            : 0x2::vec_map::empty<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(),
            revoked_publisher_caps : 0x2::table::new<0x2::object::ID, bool>(arg3),
        };
        let v1 = 0x2::object::id<Publication>(&v0);
        let v2 = OwnerCap{
            id             : 0x2::object::new(arg3),
            publication_id : 0x2::object::id<Publication>(&v0),
        };
        let v3 = PublisherCap{
            id             : 0x2::object::new(arg3),
            publication_id : 0x2::object::id<Publication>(&v0),
            holder         : 0x2::tx_context::sender(arg3),
        };
        register_slug(arg0, arg2, v1);
        let v4 = PublicationCreated{
            publication : v1,
            name        : arg1,
            slug        : arg2,
        };
        0x2::event::emit<PublicationCreated>(v4);
        (v0, v2, v3)
    }

    public fun publication_id_by_slug(arg0: &PublicationRegistry, arg1: 0x1::string::String) : &0x2::object::ID {
        0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.slugs, arg1)
    }

    public fun publish_collection_entry_direct(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: u64, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_active_publisher_cap(arg0, arg1, arg7);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, &arg2);
        0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::publish_direct(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::entry_mut(v0, arg3), 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::make_blob_ref(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::storage_mode(v0), arg4, arg5), arg6, 0x2::tx_context::sender(arg7))
    }

    public fun publish_collection_entry_from_draft(arg0: &mut Publication, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg6: 0x1::option::Option<vector<u8>>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_active_publisher_cap(arg0, arg1, arg8);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::Collection>(&mut arg0.collections, &arg2);
        0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::publish_from_draft(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::entry_mut(v0, arg3), arg4, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::make_blob_ref(0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection::storage_mode(v0), arg5, arg6), arg7, 0x2::tx_context::sender(arg8))
    }

    fun register_slug(arg0: &mut PublicationRegistry, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        validate_slug(&arg1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.slugs, arg1), 6);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.slugs, arg1, arg2);
        let v0 = SlugRegistered{
            slug        : arg1,
            publication : arg2,
        };
        0x2::event::emit<SlugRegistered>(v0);
    }

    public fun revoke_publisher_cap(arg0: &mut Publication, arg1: &OwnerCap, arg2: 0x2::object::ID) {
        assert!(arg1.publication_id == 0x2::object::id<Publication>(arg0), 2);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_publisher_caps, arg2), 5);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_publisher_caps, arg2, true);
        let v0 = PublisherCapRevoked{
            publication : 0x2::object::id<Publication>(arg0),
            cap         : arg2,
        };
        0x2::event::emit<PublisherCapRevoked>(v0);
    }

    entry fun seal_approve_publisher(arg0: vector<u8>, arg1: &Publication, arg2: &PublisherCap, arg3: &0x2::tx_context::TxContext) {
        assert_active_publisher_cap(arg1, arg2, arg3);
        assert_valid_publisher_seal_id(arg1, &arg0);
    }

    public fun share_publication(arg0: Publication) {
        0x2::transfer::share_object<Publication>(arg0);
    }

    public fun transfer_owner_cap(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public fun transfer_publisher_cap(arg0: PublisherCap, arg1: address) {
        0x2::transfer::transfer<PublisherCap>(arg0, arg1);
    }

    fun validate_slug(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 7);
        assert!(0x1::string::length(arg0) <= 64, 8);
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(*0x1::vector::borrow<u8>(v0, 0) != 45, 10);
        assert!(*0x1::vector::borrow<u8>(v0, 0x1::string::length(arg0) - 1) != 45, 10);
        let v1 = 0;
        while (v1 < 0x1::string::length(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            let v3 = v2 >= 97 && v2 <= 122;
            let v4 = v2 >= 48 && v2 <= 57;
            let v5 = if (v3) {
                true
            } else if (v4) {
                true
            } else {
                v2 == 45
            };
            assert!(v5, 9);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

