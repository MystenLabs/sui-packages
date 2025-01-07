module 0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::nft_config {
    struct Avatar has copy, drop, store {
        asset_id: 0x1::string::String,
    }

    struct Space has copy, drop, store {
        scene_id: u8,
    }

    struct Coupon has copy, drop, store {
        symbol: 0x1::string::String,
        amount: u64,
    }

    struct Attributes has copy, drop, store {
        avatar: 0x1::option::Option<Avatar>,
        space: 0x1::option::Option<Space>,
        coupon: 0x1::option::Option<Coupon>,
    }

    struct NFTConfig has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        can_mint: bool,
        attributes: Attributes,
    }

    struct CreateNFTConfigEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        attributes: Attributes,
    }

    public entry fun create_avatar_nft_config(arg0: &0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::Contract, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::assert_admin(arg0, arg6);
        let v0 = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg3));
        let v1 = 0x2::object::new(arg6);
        let v2 = Avatar{asset_id: arg5};
        let v3 = Attributes{
            avatar : 0x1::option::some<Avatar>(v2),
            space  : 0x1::option::none<Space>(),
            coupon : 0x1::option::none<Coupon>(),
        };
        let v4 = CreateNFTConfigEvent{
            id          : 0x2::object::uid_to_inner(&v1),
            name        : arg1,
            description : arg2,
            img_url     : v0,
            attributes  : v3,
        };
        0x2::event::emit<CreateNFTConfigEvent>(v4);
        let v5 = Avatar{asset_id: arg5};
        let v6 = Attributes{
            avatar : 0x1::option::some<Avatar>(v5),
            space  : 0x1::option::none<Space>(),
            coupon : 0x1::option::none<Coupon>(),
        };
        let v7 = NFTConfig{
            id          : v1,
            name        : arg1,
            description : arg2,
            img_url     : v0,
            can_mint    : arg4,
            attributes  : v6,
        };
        0x2::transfer::share_object<NFTConfig>(v7);
    }

    public entry fun create_coupon_nft_config(arg0: &0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::Contract, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::assert_admin(arg0, arg7);
        let v0 = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg3));
        let v1 = 0x2::object::new(arg7);
        let v2 = Coupon{
            symbol : arg5,
            amount : arg6,
        };
        let v3 = Attributes{
            avatar : 0x1::option::none<Avatar>(),
            space  : 0x1::option::none<Space>(),
            coupon : 0x1::option::some<Coupon>(v2),
        };
        let v4 = CreateNFTConfigEvent{
            id          : 0x2::object::uid_to_inner(&v1),
            name        : arg1,
            description : arg2,
            img_url     : v0,
            attributes  : v3,
        };
        0x2::event::emit<CreateNFTConfigEvent>(v4);
        let v5 = Coupon{
            symbol : arg5,
            amount : arg6,
        };
        let v6 = Attributes{
            avatar : 0x1::option::none<Avatar>(),
            space  : 0x1::option::none<Space>(),
            coupon : 0x1::option::some<Coupon>(v5),
        };
        let v7 = NFTConfig{
            id          : v1,
            name        : arg1,
            description : arg2,
            img_url     : v0,
            can_mint    : arg4,
            attributes  : v6,
        };
        0x2::transfer::share_object<NFTConfig>(v7);
    }

    public entry fun create_space_nft_config(arg0: &0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::Contract, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::assert_admin(arg0, arg6);
        let v0 = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg3));
        let v1 = 0x2::object::new(arg6);
        let v2 = Space{scene_id: arg5};
        let v3 = Attributes{
            avatar : 0x1::option::none<Avatar>(),
            space  : 0x1::option::some<Space>(v2),
            coupon : 0x1::option::none<Coupon>(),
        };
        let v4 = CreateNFTConfigEvent{
            id          : 0x2::object::uid_to_inner(&v1),
            name        : arg1,
            description : arg2,
            img_url     : v0,
            attributes  : v3,
        };
        0x2::event::emit<CreateNFTConfigEvent>(v4);
        let v5 = Space{scene_id: arg5};
        let v6 = Attributes{
            avatar : 0x1::option::none<Avatar>(),
            space  : 0x1::option::some<Space>(v5),
            coupon : 0x1::option::none<Coupon>(),
        };
        let v7 = NFTConfig{
            id          : v1,
            name        : arg1,
            description : arg2,
            img_url     : v0,
            can_mint    : arg4,
            attributes  : v6,
        };
        0x2::transfer::share_object<NFTConfig>(v7);
    }

    public fun get_nft_avatar_attributes(arg0: &NFTConfig) : &0x1::option::Option<Avatar> {
        &arg0.attributes.avatar
    }

    public fun get_nft_can_mint(arg0: &NFTConfig) : bool {
        arg0.can_mint
    }

    public fun get_nft_coupon_amount(arg0: &Coupon) : u64 {
        arg0.amount
    }

    public fun get_nft_coupon_attributes(arg0: &NFTConfig) : &0x1::option::Option<Coupon> {
        &arg0.attributes.coupon
    }

    public fun get_nft_description(arg0: &NFTConfig) : 0x1::string::String {
        arg0.description
    }

    public fun get_nft_id(arg0: &NFTConfig) : &0x2::object::ID {
        0x2::object::uid_as_inner(&arg0.id)
    }

    public fun get_nft_img_url(arg0: &NFTConfig) : 0x2::url::Url {
        arg0.img_url
    }

    public fun get_nft_name(arg0: &NFTConfig) : 0x1::string::String {
        arg0.name
    }

    public fun get_nft_space_attributes(arg0: &NFTConfig) : &0x1::option::Option<Space> {
        &arg0.attributes.space
    }

    // decompiled from Move bytecode v6
}

