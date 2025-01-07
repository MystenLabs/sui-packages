module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft {
    struct DynamicNft has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        is_transferable: bool,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        nth: u64,
        event_id: 0x2::object::ID,
        created_by_action: 0x1::string::String,
        used_at: 0x1::option::Option<u64>,
        status: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
    }

    struct DynamicNftMintedEvent has copy, drop {
        id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        is_transferable: bool,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        nth: u64,
        status: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        sender: address,
    }

    struct DynamicNftUsedEvent has copy, drop {
        id: 0x2::object::ID,
        status: 0x1::string::String,
        updated_at: u64,
        sender: address,
    }

    struct DynamicNftTransferredEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        receiver: address,
    }

    struct DynamicNftUsedInClaimEvent has copy, drop {
        id: 0x2::object::ID,
        used_at: u64,
        sender: address,
    }

    public(friend) fun transfer(arg0: DynamicNft, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = DynamicNftTransferredEvent{
            id       : 0x2::object::uid_to_inner(&arg0.id),
            sender   : 0x2::tx_context::sender(arg2),
            receiver : arg1,
        };
        0x2::event::emit<DynamicNftTransferredEvent>(v0);
        0x2::transfer::transfer<DynamicNft>(arg0, arg1);
    }

    public(friend) fun check_nft_is_used(arg0: &DynamicNft) : bool {
        0x1::option::is_some<u64>(&arg0.used_at)
    }

    entry fun custom_transfer(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection, arg1: DynamicNft, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg0), 7003);
        assert!(0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_is_transferable(arg0), 7001);
        transfer(arg1, arg2, arg3);
    }

    public(friend) fun dynamic_nft_used() : vector<u8> {
        b"Already used"
    }

    public(friend) fun get_collection_id(arg0: &DynamicNft) : &0x2::object::ID {
        &arg0.collection_id
    }

    public(friend) fun get_dynamic_nft_description(arg0: &DynamicNft) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_dynamic_nft_image_url(arg0: &DynamicNft) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun get_dynamic_nft_name(arg0: &DynamicNft) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun get_dynamic_nft_status(arg0: &DynamicNft) : 0x1::string::String {
        arg0.status
    }

    public(friend) fun get_dynamic_nft_transferable(arg0: &DynamicNft) : bool {
        arg0.is_transferable
    }

    public(friend) fun get_dynamic_nft_type(arg0: &DynamicNft) : u64 {
        arg0.type
    }

    public(friend) fun get_dynamic_nft_update_image_url(arg0: &DynamicNft) : 0x1::string::String {
        arg0.update_image_url
    }

    public(friend) fun mint(arg0: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DynamicNft {
        assert!(!0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_is_deleted(arg0), 7002);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = DynamicNft{
            id                : 0x2::object::new(arg4),
            collection_id     : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg0),
            name              : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_name(arg0),
            description       : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_description(arg0),
            type              : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_type(arg0),
            is_transferable   : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_is_transferable(arg0),
            image_url         : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_image_url(arg0),
            update_image_url  : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::get_dynamic_collection_update_image_url(arg0),
            nth               : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::count_dynamic_nft_minted(arg0) + 1,
            event_id          : arg1,
            created_by_action : arg2,
            used_at           : 0x1::option::none<u64>(),
            status            : 0x1::string::utf8(b"Not used"),
            created_at        : v0,
            updated_at        : v0,
        };
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::increment_dynamic_nft_minted(arg0);
        let v2 = DynamicNftMintedEvent{
            id               : 0x2::object::uid_to_inner(&v1.id),
            collection_id    : v1.collection_id,
            name             : v1.name,
            description      : v1.description,
            type             : v1.type,
            is_transferable  : v1.is_transferable,
            image_url        : v1.image_url,
            update_image_url : v1.update_image_url,
            nth              : v1.nth,
            status           : v1.status,
            created_at       : v1.created_at,
            updated_at       : v1.updated_at,
            sender           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DynamicNftMintedEvent>(v2);
        v1
    }

    public(friend) fun use_dynamic_nft(arg0: &mut DynamicNft, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status != 0x1::string::utf8(b"Already used"), 7004);
        arg0.image_url = arg0.update_image_url;
        arg0.status = 0x1::string::utf8(b"Already used");
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = DynamicNftUsedEvent{
            id         : 0x2::object::uid_to_inner(&arg0.id),
            status     : arg0.status,
            updated_at : arg0.updated_at,
            sender     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DynamicNftUsedEvent>(v0);
    }

    public(friend) fun use_nft_in_claim_reward(arg0: &mut DynamicNft, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.used_at = 0x1::option::some<u64>(v0);
        let v1 = DynamicNftUsedInClaimEvent{
            id      : 0x2::object::uid_to_inner(&arg0.id),
            used_at : v0,
            sender  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DynamicNftUsedInClaimEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

