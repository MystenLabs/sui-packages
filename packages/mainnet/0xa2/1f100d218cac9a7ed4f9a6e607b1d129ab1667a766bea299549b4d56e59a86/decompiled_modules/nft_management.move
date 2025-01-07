module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management {
    struct NftCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        type: u64,
        merchant_id: 0x2::object::ID,
        nft_minted_counter: u64,
        is_transferable: bool,
        deleted_at: 0x1::option::Option<u64>,
    }

    struct DynamicNftCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        creator: address,
        type: u64,
        merchant_id: 0x2::object::ID,
        nft_minted_counter: u64,
        is_transferable: bool,
        deleted_at: 0x1::option::Option<u64>,
    }

    struct NftManagement has key {
        id: 0x2::object::UID,
        merchant_id: vector<u8>,
        tracked_created_collection: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct CollectionCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        creator: address,
        type: u64,
        merchant_id: 0x2::object::ID,
        nft_minted_counter: u64,
        is_transferable: bool,
    }

    struct CollectionUpdatedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        is_transferable: bool,
        sender: address,
        type: u64,
    }

    struct CollectionDeletedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        deleted_at: u64,
        sender: address,
        type: u64,
    }

    struct NftManagementCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        merchant_id: vector<u8>,
        sender: address,
    }

    public(friend) fun count_dynamic_nft_minted(arg0: &DynamicNftCollection) : u64 {
        arg0.nft_minted_counter
    }

    public(friend) fun count_normal_nft_minted(arg0: &NftCollection) : u64 {
        arg0.nft_minted_counter
    }

    entry fun create_collection(arg0: &mut NftManagement, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_create();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg7);
        let v1 = NftCollection{
            id                 : 0x2::object::new(arg8),
            name               : arg3,
            description        : arg4,
            image_url          : arg5,
            creator            : 0x2::tx_context::sender(arg8),
            type               : 1,
            merchant_id        : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::get_merchant_id(arg1),
            nft_minted_counter : 0,
            is_transferable    : arg6,
            deleted_at         : 0x1::option::none<u64>(),
        };
        let v2 = CollectionCreatedEvent{
            id                 : 0x2::object::uid_to_inner(&v1.id),
            name               : v1.name,
            description        : v1.description,
            image_url          : v1.image_url,
            update_image_url   : 0x1::string::utf8(b""),
            creator            : v1.creator,
            type               : v1.type,
            merchant_id        : v1.merchant_id,
            nft_minted_counter : v1.nft_minted_counter,
            is_transferable    : v1.is_transferable,
        };
        0x2::event::emit<CollectionCreatedEvent>(v2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tracked_created_collection, 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::share_object<NftCollection>(v1);
    }

    entry fun create_dynamic_collection(arg0: &mut NftManagement, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_create();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg8);
        let v1 = DynamicNftCollection{
            id                 : 0x2::object::new(arg9),
            name               : arg3,
            description        : arg4,
            image_url          : arg5,
            update_image_url   : arg6,
            creator            : 0x2::tx_context::sender(arg9),
            type               : 2,
            merchant_id        : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::get_merchant_id(arg1),
            nft_minted_counter : 0,
            is_transferable    : arg7,
            deleted_at         : 0x1::option::none<u64>(),
        };
        let v2 = CollectionCreatedEvent{
            id                 : 0x2::object::uid_to_inner(&v1.id),
            name               : v1.name,
            description        : v1.description,
            image_url          : v1.image_url,
            update_image_url   : v1.update_image_url,
            creator            : v1.creator,
            type               : v1.type,
            merchant_id        : v1.merchant_id,
            nft_minted_counter : v1.nft_minted_counter,
            is_transferable    : v1.is_transferable,
        };
        0x2::event::emit<CollectionCreatedEvent>(v2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tracked_created_collection, 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::share_object<DynamicNftCollection>(v1);
    }

    public entry fun delete_collection(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg2: &mut NftCollection, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_delete();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg0, arg1, &v0, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg2.deleted_at = 0x1::option::some<u64>(v1);
        let v2 = CollectionDeletedEvent{
            collection_id : 0x2::object::uid_to_inner(&arg2.id),
            deleted_at    : v1,
            sender        : 0x2::tx_context::sender(arg4),
            type          : 1,
        };
        0x2::event::emit<CollectionDeletedEvent>(v2);
    }

    public entry fun delete_dynamic_collection(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg2: &mut DynamicNftCollection, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_delete();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg0, arg1, &v0, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg2.deleted_at = 0x1::option::some<u64>(v1);
        let v2 = CollectionDeletedEvent{
            collection_id : 0x2::object::uid_to_inner(&arg2.id),
            deleted_at    : v1,
            sender        : 0x2::tx_context::sender(arg4),
            type          : 2,
        };
        0x2::event::emit<CollectionDeletedEvent>(v2);
    }

    public(friend) fun get_collection_description(arg0: &NftCollection) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_collection_image_url(arg0: &NftCollection) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun get_collection_is_deleted(arg0: &NftCollection) : bool {
        0x1::option::is_some<u64>(&arg0.deleted_at)
    }

    public(friend) fun get_collection_is_transferable(arg0: &NftCollection) : bool {
        arg0.is_transferable
    }

    public(friend) fun get_collection_name(arg0: &NftCollection) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun get_collection_type(arg0: &NftCollection) : u64 {
        arg0.type
    }

    public(friend) fun get_dynamic_collection_description(arg0: &DynamicNftCollection) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_dynamic_collection_image_url(arg0: &DynamicNftCollection) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun get_dynamic_collection_is_deleted(arg0: &DynamicNftCollection) : bool {
        0x1::option::is_some<u64>(&arg0.deleted_at)
    }

    public(friend) fun get_dynamic_collection_is_transferable(arg0: &DynamicNftCollection) : bool {
        arg0.is_transferable
    }

    public(friend) fun get_dynamic_collection_name(arg0: &DynamicNftCollection) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun get_dynamic_collection_type(arg0: &DynamicNftCollection) : u64 {
        arg0.type
    }

    public(friend) fun get_dynamic_collection_update_image_url(arg0: &DynamicNftCollection) : 0x1::string::String {
        arg0.update_image_url
    }

    public(friend) fun increment_dynamic_nft_minted(arg0: &mut DynamicNftCollection) {
        arg0.nft_minted_counter = arg0.nft_minted_counter + 1;
    }

    public(friend) fun increment_normal_nft_minted(arg0: &mut NftCollection) {
        arg0.nft_minted_counter = arg0.nft_minted_counter + 1;
    }

    public(friend) fun init_nft_management(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = NftManagement{
            id                         : 0x2::object::new(arg1),
            merchant_id                : arg0,
            tracked_created_collection : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v1 = NftManagementCreatedEvent{
            id          : 0x2::object::uid_to_inner(&v0.id),
            merchant_id : v0.merchant_id,
            sender      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NftManagementCreatedEvent>(v1);
        0x2::transfer::share_object<NftManagement>(v0);
        0x2::object::id<NftManagement>(&v0)
    }

    public entry fun update_collection(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg2: &mut NftCollection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_update();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg0, arg1, &v0, arg6);
        arg2.name = arg3;
        arg2.description = arg4;
        arg2.is_transferable = arg5;
        let v1 = CollectionUpdatedEvent{
            collection_id   : 0x2::object::uid_to_inner(&arg2.id),
            name            : arg3,
            description     : arg4,
            is_transferable : arg5,
            sender          : 0x2::tx_context::sender(arg7),
            type            : 1,
        };
        0x2::event::emit<CollectionUpdatedEvent>(v1);
    }

    public entry fun update_dynamic_collection(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg2: &mut DynamicNftCollection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_update();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg0, arg1, &v0, arg6);
        arg2.name = arg3;
        arg2.description = arg4;
        arg2.is_transferable = arg5;
        let v1 = CollectionUpdatedEvent{
            collection_id   : 0x2::object::uid_to_inner(&arg2.id),
            name            : arg3,
            description     : arg4,
            is_transferable : arg5,
            sender          : 0x2::tx_context::sender(arg7),
            type            : 2,
        };
        0x2::event::emit<CollectionUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

