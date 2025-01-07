module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::stamp_rally {
    struct StampRally has key {
        id: 0x2::object::UID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        stamps_needed: u64,
        nft_stamp_collections: 0x2::vec_set::VecSet<0x2::object::ID>,
        participants: 0x2::vec_set::VecSet<address>,
        total_participants: u64,
        metrics: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        reward: Reward,
        tracked_minter: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::table::Table<address, bool>>,
        status: 0x1::string::String,
        creator: address,
    }

    struct Reward has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        reward_nft_collection: 0x2::object::ID,
        total_reward_minted: u64,
    }

    struct StampRallyManagement has key {
        id: 0x2::object::UID,
        merchant_id: vector<u8>,
        tracked_created_stamp_rally: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_stamp_rally_event: u64,
    }

    struct StampRallyCreatedEvent has copy, drop {
        stamp_rally_id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        stamps_needed: u64,
        nft_stamp_collections: 0x2::vec_set::VecSet<0x2::object::ID>,
        reward_name: 0x1::string::String,
        reward_description: 0x1::string::String,
        reward_nft_collection: 0x2::object::ID,
        creator: address,
    }

    struct StampRallyUpdatedEvent has copy, drop {
        stamp_rally_id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        stamps_needed: u64,
        nft_stamp_collections: vector<0x2::object::ID>,
        reward_name: 0x1::string::String,
        reward_description: 0x1::string::String,
        reward_nft_collection: 0x2::object::ID,
        updated_by: address,
    }

    struct NftStampMintedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        stamp_rally_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        is_transferable: bool,
        image_url: 0x1::string::String,
        minted_at: u64,
        minter: address,
    }

    struct DynamicNftStampMintedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        stamp_rally_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        is_transferable: bool,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        minted_at: u64,
        status: 0x1::string::String,
        minter: address,
    }

    struct ClaimRewardEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        stamp_rally_id: 0x2::object::ID,
        reward_nft_id: 0x2::object::ID,
        reward_collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        is_transferable: bool,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        minted_at: u64,
        status: 0x1::string::String,
        minter: address,
    }

    struct StampRallyPublishedEvent has copy, drop {
        stamp_rally_id: 0x2::object::ID,
        status: 0x1::string::String,
        sender: address,
    }

    struct StampRallyUnpublishedEvent has copy, drop {
        stamp_rally_id: 0x2::object::ID,
        status: 0x1::string::String,
        sender: address,
    }

    struct StampRallyDeleteEvent has copy, drop {
        stamp_rally_id: 0x2::object::ID,
        status: 0x1::string::String,
        sender: address,
    }

    public entry fun delete(arg0: StampRally, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_delete();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg3);
        assert!(arg0.status == 0x1::string::utf8(b"draft"), 4005);
        let v1 = StampRallyDeleteEvent{
            stamp_rally_id : 0x2::object::id<StampRally>(&arg0),
            status         : 0x1::string::utf8(b"deleted"),
            sender         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StampRallyDeleteEvent>(v1);
        let StampRally {
            id                    : v2,
            merchant_id           : _,
            name                  : _,
            description           : _,
            thumbnail_url         : _,
            location              : _,
            start_at              : _,
            end_at                : _,
            stamps_needed         : _,
            nft_stamp_collections : _,
            participants          : _,
            total_participants    : _,
            metrics               : _,
            reward                : v15,
            tracked_minter        : v16,
            status                : _,
            creator               : _,
        } = arg0;
        let Reward {
            name                  : _,
            description           : _,
            reward_nft_collection : _,
            total_reward_minted   : _,
        } = v15;
        let (_, v24) = 0x2::vec_map::into_keys_values<0x2::object::ID, 0x2::table::Table<address, bool>>(v16);
        let v25 = v24;
        let v26 = 0x1::vector::length<0x2::table::Table<address, bool>>(&v25);
        while (v26 > 0) {
            v26 = v26 - 1;
            0x2::table::drop<address, bool>(0x1::vector::pop_back<0x2::table::Table<address, bool>>(&mut v25));
        };
        0x1::vector::destroy_empty<0x2::table::Table<address, bool>>(v25);
        0x2::object::delete(v2);
    }

    public fun claim_dynamic_reward(arg0: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection, arg1: &mut StampRally, arg2: vector<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>, arg3: vector<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg0);
        validate_reward_collection(arg1, &v0, arg5);
        use_stamp(arg1, arg2, arg3, arg4, arg5);
        let v1 = &mut arg1.reward;
        increase_total_reward_minted(v1);
        let v2 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::mint(arg0, 0x2::object::id<StampRally>(arg1), 0x1::string::utf8(b"claim_reward"), arg4, arg5);
        let v3 = ClaimRewardEvent{
            merchant_id          : arg1.merchant_id,
            stamp_rally_id       : 0x2::object::uid_to_inner(&arg1.id),
            reward_nft_id        : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>(&v2),
            reward_collection_id : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg0),
            name                 : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_name(&v2),
            description          : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_description(&v2),
            type                 : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_type(&v2),
            is_transferable      : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_transferable(&v2),
            image_url            : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_image_url(&v2),
            update_image_url     : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_update_image_url(&v2),
            minted_at            : 0x2::clock::timestamp_ms(arg4),
            status               : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_status(&v2),
            minter               : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ClaimRewardEvent>(v3);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::transfer(v2, 0x2::tx_context::sender(arg5), arg5);
    }

    public fun claim_normal_reward(arg0: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::NftCollection, arg1: &mut StampRally, arg2: vector<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>, arg3: vector<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::NftCollection>(arg0);
        validate_reward_collection(arg1, &v0, arg5);
        use_stamp(arg1, arg2, arg3, arg4, arg5);
        let v1 = &mut arg1.reward;
        increase_total_reward_minted(v1);
        let v2 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::mint(arg0, 0x2::object::id<StampRally>(arg1), 0x1::string::utf8(b"claim_reward"), arg4, arg5);
        let v3 = ClaimRewardEvent{
            merchant_id          : arg1.merchant_id,
            stamp_rally_id       : 0x2::object::uid_to_inner(&arg1.id),
            reward_nft_id        : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>(&v2),
            reward_collection_id : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::NftCollection>(arg0),
            name                 : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_name(&v2),
            description          : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_description(&v2),
            type                 : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_type(&v2),
            is_transferable      : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_transferable(&v2),
            image_url            : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_image_url(&v2),
            update_image_url     : 0x1::string::utf8(b""),
            minted_at            : 0x2::clock::timestamp_ms(arg4),
            status               : 0x1::string::utf8(b""),
            minter               : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ClaimRewardEvent>(v3);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::transfer(v2, 0x2::tx_context::sender(arg5), arg5);
    }

    public fun create_stamp_rally(arg0: &mut StampRallyManagement, arg1: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: vector<0x2::object::ID>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x2::object::ID, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_create();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg13);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg9);
        let v2 = v1;
        assert!(v1 > 0, 4006);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg9, &arg12), 4007);
        let v3 = 0x2::vec_map::empty<0x2::object::ID, 0x2::table::Table<address, bool>>();
        let v4 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v2 > 0) {
            v2 = v2 - 1;
            0x2::vec_map::insert<0x2::object::ID, 0x2::table::Table<address, bool>>(&mut v3, *0x1::vector::borrow<0x2::object::ID>(&arg9, v2), 0x2::table::new<address, bool>(arg14));
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v4, *0x1::vector::borrow<0x2::object::ID>(&arg9, v2), 0);
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::table::Table<address, bool>>(&mut v3, arg12, 0x2::table::new<address, bool>(arg14));
        let v5 = 0x2::vec_set::from_keys<0x2::object::ID>(arg9);
        let v6 = Reward{
            name                  : arg10,
            description           : arg11,
            reward_nft_collection : arg12,
            total_reward_minted   : 0,
        };
        let v7 = StampRally{
            id                    : 0x2::object::new(arg14),
            merchant_id           : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::get_merchant_id(arg1),
            name                  : arg3,
            description           : arg4,
            thumbnail_url         : arg5,
            location              : arg6,
            start_at              : arg7,
            end_at                : arg8,
            stamps_needed         : 0x2::vec_set::size<0x2::object::ID>(&v5),
            nft_stamp_collections : v5,
            participants          : 0x2::vec_set::empty<address>(),
            total_participants    : 0,
            metrics               : v4,
            reward                : v6,
            tracked_minter        : v3,
            status                : 0x1::string::utf8(b"draft"),
            creator               : 0x2::tx_context::sender(arg14),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tracked_created_stamp_rally, 0x2::object::uid_to_inner(&v7.id));
        arg0.total_stamp_rally_event = arg0.total_stamp_rally_event + 1;
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::increase_stamp_rally_quantity(arg1);
        let v8 = StampRallyCreatedEvent{
            stamp_rally_id        : 0x2::object::uid_to_inner(&v7.id),
            merchant_id           : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant>(arg1),
            name                  : arg3,
            description           : arg4,
            thumbnail_url         : arg5,
            location              : arg6,
            start_at              : arg7,
            end_at                : arg8,
            stamps_needed         : 0x2::vec_set::size<0x2::object::ID>(&v5),
            nft_stamp_collections : v5,
            reward_name           : arg10,
            reward_description    : arg11,
            reward_nft_collection : arg12,
            creator               : 0x2::tx_context::sender(arg14),
        };
        0x2::event::emit<StampRallyCreatedEvent>(v8);
        0x2::transfer::share_object<StampRally>(v7);
    }

    fun increase_total_reward_minted(arg0: &mut Reward) {
        arg0.total_reward_minted = arg0.total_reward_minted + 1;
    }

    public(friend) fun init_stamp_rally_management(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = StampRallyManagement{
            id                          : 0x2::object::new(arg1),
            merchant_id                 : arg0,
            tracked_created_stamp_rally : 0x2::vec_set::empty<0x2::object::ID>(),
            total_stamp_rally_event     : 0,
        };
        0x2::transfer::share_object<StampRallyManagement>(v0);
        0x2::object::id<StampRallyManagement>(&v0)
    }

    public entry fun mint_dynamic_nft(arg0: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection, arg1: &mut StampRally, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_status_event(arg1);
        track_minter_and_collection<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg1, arg0, arg2, arg3);
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::mint(arg0, 0x2::object::id<StampRally>(arg1), 0x1::string::utf8(b"collect_stamp"), arg2, arg3);
        let v1 = DynamicNftStampMintedEvent{
            merchant_id      : arg1.merchant_id,
            stamp_rally_id   : 0x2::object::uid_to_inner(&arg1.id),
            nft_id           : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>(&v0),
            collection_id    : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg0),
            name             : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_name(&v0),
            description      : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_description(&v0),
            type             : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_type(&v0),
            is_transferable  : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_transferable(&v0),
            image_url        : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_image_url(&v0),
            update_image_url : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_update_image_url(&v0),
            minted_at        : 0x2::clock::timestamp_ms(arg2),
            status           : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_status(&v0),
            minter           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DynamicNftStampMintedEvent>(v1);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::transfer(v0, 0x2::tx_context::sender(arg3), arg3);
        update_participants(arg1, arg3);
    }

    public entry fun mint_normal_nft(arg0: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::NftCollection, arg1: &mut StampRally, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_status_event(arg1);
        track_minter_and_collection<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::NftCollection>(arg1, arg0, arg2, arg3);
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::mint(arg0, 0x2::object::id<StampRally>(arg1), 0x1::string::utf8(b"collect_stamp"), arg2, arg3);
        let v1 = NftStampMintedEvent{
            merchant_id     : arg1.merchant_id,
            stamp_rally_id  : 0x2::object::uid_to_inner(&arg1.id),
            nft_id          : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>(&v0),
            collection_id   : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::NftCollection>(arg0),
            name            : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_name(&v0),
            description     : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_description(&v0),
            type            : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_type(&v0),
            is_transferable : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_transferable(&v0),
            image_url       : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_nft_image_url(&v0),
            minted_at       : 0x2::clock::timestamp_ms(arg2),
            minter          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NftStampMintedEvent>(v1);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::transfer(v0, 0x2::tx_context::sender(arg3), arg3);
        update_participants(arg1, arg3);
    }

    public entry fun publish(arg0: &mut StampRally, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_publish();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg3);
        assert!(arg0.status == 0x1::string::utf8(b"draft") || arg0.status == 0x1::string::utf8(b"unpublished"), 4008);
        arg0.status = 0x1::string::utf8(b"published");
        let v1 = StampRallyPublishedEvent{
            stamp_rally_id : 0x2::object::id<StampRally>(arg0),
            status         : 0x1::string::utf8(b"published"),
            sender         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StampRallyPublishedEvent>(v1);
    }

    fun track_minter_and_collection<T0: key>(arg0: &mut StampRally, arg1: &T0, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start_at && 0x2::clock::timestamp_ms(arg2) <= arg0.end_at, 4004);
        let v0 = 0x2::object::id<T0>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.nft_stamp_collections, &v0), 4002);
        let v1 = 0x2::object::id<T0>(arg1);
        let v2 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::table::Table<address, bool>>(&mut arg0.tracked_minter, &v1);
        assert!(!0x2::table::contains<address, bool>(v2, 0x2::tx_context::sender(arg3)), 4003);
        0x2::table::add<address, bool>(v2, 0x2::tx_context::sender(arg3), true);
        let v3 = 0x2::object::id<T0>(arg1);
        let v4 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.metrics, &v3);
        *v4 = *v4 + 1;
    }

    public entry fun unpublish(arg0: &mut StampRally, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_unpublish();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg3);
        assert!(arg0.status == 0x1::string::utf8(b"published"), 4009);
        arg0.status = 0x1::string::utf8(b"unpublished");
        let v1 = StampRallyUnpublishedEvent{
            stamp_rally_id : 0x2::object::id<StampRally>(arg0),
            status         : 0x1::string::utf8(b"unpublished"),
            sender         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StampRallyUnpublishedEvent>(v1);
    }

    fun update_participants(arg0: &mut StampRally, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.participants, &v0)) {
            0x2::vec_set::insert<address>(&mut arg0.participants, 0x2::tx_context::sender(arg1));
            arg0.total_participants = arg0.total_participants + 1;
        };
    }

    public fun update_stamp_rally(arg0: &mut StampRally, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: vector<0x2::object::ID>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x2::object::ID, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_update();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg13);
        if (arg0.status == 0x1::string::utf8(b"draft")) {
            assert!(!0x1::vector::contains<0x2::object::ID>(&arg9, &arg12), 4007);
            assert!(0x1::vector::length<0x2::object::ID>(&arg9) > 0, 4006);
            let v1 = 0x2::vec_set::from_keys<0x2::object::ID>(arg9);
            arg0.nft_stamp_collections = v1;
            arg0.stamps_needed = 0x2::vec_set::size<0x2::object::ID>(&v1);
            arg0.reward.name = arg10;
            arg0.reward.description = arg11;
            arg0.reward.reward_nft_collection = arg12;
            let v2 = 0x1::vector::length<0x2::object::ID>(&arg9);
            let v3 = 0x2::vec_map::empty<0x2::object::ID, u64>();
            while (v2 > 0) {
                v2 = v2 - 1;
                0x2::vec_map::insert<0x2::object::ID, u64>(&mut v3, *0x1::vector::borrow<0x2::object::ID>(&arg9, v2), 0);
                if (!0x2::vec_map::contains<0x2::object::ID, 0x2::table::Table<address, bool>>(&arg0.tracked_minter, 0x1::vector::borrow<0x2::object::ID>(&arg9, v2))) {
                    0x2::vec_map::insert<0x2::object::ID, 0x2::table::Table<address, bool>>(&mut arg0.tracked_minter, *0x1::vector::borrow<0x2::object::ID>(&arg9, v2), 0x2::table::new<address, bool>(arg14));
                };
            };
            if (!0x2::vec_map::contains<0x2::object::ID, 0x2::table::Table<address, bool>>(&arg0.tracked_minter, &arg12)) {
                0x2::vec_map::insert<0x2::object::ID, 0x2::table::Table<address, bool>>(&mut arg0.tracked_minter, arg12, 0x2::table::new<address, bool>(arg14));
            };
            arg0.metrics = v3;
        };
        arg0.name = arg3;
        arg0.description = arg4;
        arg0.thumbnail_url = arg5;
        arg0.location = arg6;
        arg0.start_at = arg7;
        arg0.end_at = arg8;
        let v4 = StampRallyUpdatedEvent{
            stamp_rally_id        : 0x2::object::uid_to_inner(&arg0.id),
            merchant_id           : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant>(arg1),
            name                  : arg3,
            description           : arg4,
            thumbnail_url         : arg5,
            location              : arg6,
            start_at              : arg7,
            end_at                : arg8,
            stamps_needed         : 0x1::vector::length<0x2::object::ID>(&arg9),
            nft_stamp_collections : arg9,
            reward_name           : arg10,
            reward_description    : arg11,
            reward_nft_collection : arg12,
            updated_by            : 0x2::tx_context::sender(arg14),
        };
        0x2::event::emit<StampRallyUpdatedEvent>(v4);
    }

    fun use_stamp(arg0: &StampRally, arg1: vector<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>, arg2: vector<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg0.start_at && 0x2::clock::timestamp_ms(arg3) < arg0.end_at, 4004);
        let v0 = 0x1::vector::length<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>(&arg1);
        let v1 = 0x1::vector::length<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>(&arg2);
        assert!(v0 + v1 == arg0.stamps_needed, 4001);
        let v2 = arg0.nft_stamp_collections;
        let v3 = 0x2::vec_set::empty<0x2::object::ID>();
        let v4 = v0;
        while (v4 > 0) {
            v4 = v4 - 1;
            let v5 = 0x1::vector::pop_back<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>(&mut arg1);
            assert!(!0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::check_nft_is_used(&v5), 4010);
            let v6 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::get_collection_id(&v5);
            if (0x2::vec_set::contains<0x2::object::ID>(&v2, v6)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v3, *v6);
                0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::use_nft_in_claim_reward(&mut v5, arg3, arg4);
            };
            0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::transfer(v5, 0x2::tx_context::sender(arg4), arg4);
        };
        v4 = v1;
        while (v4 > 0) {
            v4 = v4 - 1;
            let v7 = 0x1::vector::pop_back<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>(&mut arg2);
            assert!(!0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::check_nft_is_used(&v7), 4010);
            let v8 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_collection_id(&v7);
            if (0x2::vec_set::contains<0x2::object::ID>(&v2, v8)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v3, *v8);
                0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::use_nft_in_claim_reward(&mut v7, arg3, arg4);
            };
            0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::transfer(v7, 0x2::tx_context::sender(arg4), arg4);
        };
        0x1::vector::destroy_empty<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft::Nft>(arg1);
        0x1::vector::destroy_empty<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>(arg2);
        assert!(0x2::vec_set::size<0x2::object::ID>(&v3) == arg0.stamps_needed, 4002);
    }

    fun validate_reward_collection(arg0: &mut StampRally, arg1: &0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.reward.reward_nft_collection;
        assert!(arg1 == &v0, 4002);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::table::Table<address, bool>>(&mut arg0.tracked_minter, arg1);
        assert!(!0x2::table::contains<address, bool>(v1, 0x2::tx_context::sender(arg2)), 4003);
        0x2::table::add<address, bool>(v1, 0x2::tx_context::sender(arg2), true);
    }

    fun validate_status_event(arg0: &StampRally) {
        assert!(arg0.status == 0x1::string::utf8(b"published"), 4009);
    }

    // decompiled from Move bytecode v6
}

