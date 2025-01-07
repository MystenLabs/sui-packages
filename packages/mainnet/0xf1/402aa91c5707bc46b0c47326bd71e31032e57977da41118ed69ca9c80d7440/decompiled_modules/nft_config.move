module 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config {
    struct Attributes has copy, drop, store {
        reward_index: 0x1::string::String,
        campaign_id: 0x1::string::String,
        campaign_name: 0x1::string::String,
    }

    struct NFTConfig has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        max_supply: u64,
        attributes: Attributes,
        creators: vector<address>,
    }

    struct CreateNFTConfigEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        attributes: Attributes,
    }

    public fun add_creator(arg0: &mut NFTConfig, arg1: address) {
        assert!(!0x1::vector::contains<address>(&arg0.creators, &arg1), 0);
        if (arg0.max_supply > 0) {
            assert!(arg0.max_supply > 0x1::vector::length<address>(&arg0.creators), 1);
        };
        0x1::vector::push_back<address>(&mut arg0.creators, arg1);
    }

    public entry fun create_nft_config(arg0: &0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::Contract, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::assert_admin(arg0, arg8);
        let v0 = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg3));
        let v1 = 0x2::object::new(arg8);
        let v2 = Attributes{
            reward_index  : arg4,
            campaign_id   : arg5,
            campaign_name : arg6,
        };
        let v3 = CreateNFTConfigEvent{
            id          : 0x2::object::uid_to_inner(&v1),
            name        : arg1,
            description : arg2,
            img_url     : v0,
            attributes  : v2,
        };
        0x2::event::emit<CreateNFTConfigEvent>(v3);
        let v4 = Attributes{
            reward_index  : arg4,
            campaign_id   : arg5,
            campaign_name : arg6,
        };
        let v5 = NFTConfig{
            id          : v1,
            name        : arg1,
            description : arg2,
            img_url     : v0,
            max_supply  : arg7,
            attributes  : v4,
            creators    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<NFTConfig>(v5);
    }

    public fun get_nft_campaign_id(arg0: &NFTConfig) : 0x1::string::String {
        arg0.attributes.campaign_id
    }

    public fun get_nft_campaign_name(arg0: &NFTConfig) : 0x1::string::String {
        arg0.attributes.campaign_name
    }

    public fun get_nft_description(arg0: &NFTConfig) : 0x1::string::String {
        arg0.description
    }

    public fun get_nft_id(arg0: &NFTConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_nft_img_url(arg0: &NFTConfig) : 0x2::url::Url {
        arg0.img_url
    }

    public fun get_nft_name(arg0: &NFTConfig) : 0x1::string::String {
        arg0.name
    }

    public fun get_nft_reward_index(arg0: &NFTConfig) : 0x1::string::String {
        arg0.attributes.reward_index
    }

    // decompiled from Move bytecode v6
}

