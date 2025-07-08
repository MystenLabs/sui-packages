module 0xff65f29e1868c3c8be9ff2f6c444476c027383a5493ca526dfba6bdfa3894712::nft_distributor {
    struct NFT_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        recipient: address,
        reward_type: 0x1::string::String,
        minted_at: u64,
        distributor_id: address,
    }

    struct NFTRewardDistributed has copy, drop {
        user: address,
        nft_id: address,
        reward_type: 0x1::string::String,
        timestamp: u64,
    }

    struct NFTTemplateUpdated has copy, drop {
        admin: address,
        reward_type: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct DistributorStatusChanged has copy, drop {
        admin: address,
        active: bool,
    }

    struct DistributorCreated has copy, drop {
        admin: address,
        distributor_id: address,
    }

    struct NFTDistributor has key {
        id: 0x2::object::UID,
        admin: address,
        total_distributed: u64,
        active: bool,
        created_at: u64,
        default_name: 0x1::string::String,
        default_description: 0x1::string::String,
        default_image_url: 0x1::string::String,
        swap_name: 0x1::string::String,
        swap_description: 0x1::string::String,
        swap_image_url: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        distributor_id: address,
    }

    public entry fun create_distributor(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = NFTDistributor{
            id                  : v1,
            admin               : v0,
            total_distributed   : 0,
            active              : true,
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg0),
            default_name        : 0x1::string::utf8(b"GBC Mobile Reward NFT"),
            default_description : 0x1::string::utf8(b"A reward NFT from GBC Mobile platform"),
            default_image_url   : 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreiflxiutm55wmdyvxd64dv7lsei6uectn62hcwee5f2fqqpkpa54vi"),
            swap_name           : 0x1::string::utf8(b"GBC Mobile Swap Reward"),
            swap_description    : 0x1::string::utf8(b"NFT reward for completing a swap on GBC Mobile"),
            swap_image_url      : 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreiflxiutm55wmdyvxd64dv7lsei6uectn62hcwee5f2fqqpkpa54vi"),
        };
        let v4 = AdminCap{
            id             : 0x2::object::new(arg0),
            distributor_id : v2,
        };
        0x2::transfer::transfer<AdminCap>(v4, v0);
        0x2::transfer::share_object<NFTDistributor>(v3);
        let v5 = DistributorCreated{
            admin          : v0,
            distributor_id : v2,
        };
        0x2::event::emit<DistributorCreated>(v5);
    }

    public entry fun distribute_custom_reward(arg0: &mut NFTDistributor, arg1: &AdminCap, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg0.active, 2);
        assert!(arg2 != @0x0, 4);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        let (v2, v3, v4) = if (!0x1::string::is_empty(&arg4)) {
            (arg4, arg5, arg6)
        } else if (arg3 == 0x1::string::utf8(b"swap")) {
            (arg0.swap_name, arg0.swap_description, arg0.swap_image_url)
        } else {
            (arg0.default_name, arg0.default_description, arg0.default_image_url)
        };
        let v5 = RewardNFT{
            id             : v0,
            name           : v2,
            description    : v3,
            image_url      : v4,
            recipient      : arg2,
            reward_type    : arg3,
            minted_at      : v1,
            distributor_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::transfer::public_transfer<RewardNFT>(v5, arg2);
        arg0.total_distributed = arg0.total_distributed + 1;
        let v6 = NFTRewardDistributed{
            user        : arg2,
            nft_id      : 0x2::object::uid_to_address(&v0),
            reward_type : arg3,
            timestamp   : v1,
        };
        0x2::event::emit<NFTRewardDistributed>(v6);
    }

    public entry fun distribute_swap_reward(arg0: &mut NFTDistributor, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.active, 2);
        assert!(arg1 != @0x0, 4);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = 0x1::string::utf8(b"swap");
        let v3 = RewardNFT{
            id             : v0,
            name           : arg0.swap_name,
            description    : arg0.swap_description,
            image_url      : arg0.swap_image_url,
            recipient      : arg1,
            reward_type    : v2,
            minted_at      : v1,
            distributor_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::transfer::public_transfer<RewardNFT>(v3, arg1);
        arg0.total_distributed = arg0.total_distributed + 1;
        let v4 = NFTRewardDistributed{
            user        : arg1,
            nft_id      : 0x2::object::uid_to_address(&v0),
            reward_type : v2,
            timestamp   : v1,
        };
        0x2::event::emit<NFTRewardDistributed>(v4);
    }

    public fun get_admin(arg0: &NFTDistributor) : address {
        arg0.admin
    }

    public fun get_created_at(arg0: &NFTDistributor) : u64 {
        arg0.created_at
    }

    public fun get_distributor_stats(arg0: &NFTDistributor) : (u64, bool) {
        (arg0.total_distributed, arg0.active)
    }

    public fun get_max_batch_size() : u64 {
        50
    }

    public fun get_nft_distributor_id(arg0: &RewardNFT) : address {
        arg0.distributor_id
    }

    public fun get_nft_metadata(arg0: &RewardNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, 0x1::string::String, u64) {
        (arg0.name, arg0.description, arg0.image_url, arg0.recipient, arg0.reward_type, arg0.minted_at)
    }

    public fun get_nft_template(arg0: &NFTDistributor, arg1: 0x1::string::String) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        if (arg1 == 0x1::string::utf8(b"swap")) {
            (arg0.swap_name, arg0.swap_description, arg0.swap_image_url)
        } else {
            (arg0.default_name, arg0.default_description, arg0.default_image_url)
        }
    }

    public fun get_total_distributed(arg0: &NFTDistributor) : u64 {
        arg0.total_distributed
    }

    fun init(arg0: NFT_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<NFT_DISTRIBUTOR>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"reward_type"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"minted_at"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://gbcmobile.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"GBC Mobile"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{reward_type}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{minted_at}"));
        let v6 = 0x2::display::new_with_fields<RewardNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<RewardNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<RewardNFT>>(v6, v0);
    }

    public fun is_active(arg0: &NFTDistributor) : bool {
        arg0.active
    }

    public entry fun set_active(arg0: &mut NFTDistributor, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        arg0.active = arg2;
        let v0 = DistributorStatusChanged{
            admin  : arg0.admin,
            active : arg2,
        };
        0x2::event::emit<DistributorStatusChanged>(v0);
    }

    public entry fun transfer_admin(arg0: &mut NFTDistributor, arg1: AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg2 != @0x0, 4);
        assert!(arg2 != arg0.admin, 5);
        arg0.admin = arg2;
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
        let v0 = AdminChanged{
            old_admin : arg0.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun update_nft_template(arg0: &mut NFTDistributor, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg6), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(!0x1::string::is_empty(&arg3), 7);
        assert!(!0x1::string::is_empty(&arg4), 7);
        assert!(!0x1::string::is_empty(&arg5), 7);
        if (arg2 == 0x1::string::utf8(b"swap")) {
            arg0.swap_name = arg3;
            arg0.swap_description = arg4;
            arg0.swap_image_url = arg5;
        } else {
            arg0.default_name = arg3;
            arg0.default_description = arg4;
            arg0.default_image_url = arg5;
        };
        let v0 = NFTTemplateUpdated{
            admin       : arg0.admin,
            reward_type : arg2,
            name        : arg3,
            description : arg4,
            image_url   : arg5,
        };
        0x2::event::emit<NFTTemplateUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

