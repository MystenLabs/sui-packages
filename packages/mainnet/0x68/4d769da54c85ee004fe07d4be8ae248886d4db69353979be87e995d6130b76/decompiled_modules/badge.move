module 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge {
    struct BADGE has drop {
        dummy_field: bool,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        badge_type: 0x1::string::String,
        source_id: 0x1::string::String,
        rarity: u8,
        image_id: 0x1::string::String,
    }

    public fun id(arg0: &Badge) : 0x2::object::ID {
        0x2::object::id<Badge>(arg0)
    }

    public fun badge_type(arg0: &Badge) : &0x1::string::String {
        &arg0.badge_type
    }

    public fun description(arg0: &Badge) : &0x1::string::String {
        &arg0.description
    }

    public fun image_id(arg0: &Badge) : &0x1::string::String {
        &arg0.image_id
    }

    fun init(arg0: BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/{image_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://staging.deepsurge.xyz/badges/{source_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DeepSurge"));
        let v4 = 0x2::package::claim<BADGE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Badge>(&v4, v0, v2, arg1);
        0x2::display::update_version<Badge>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Badge>(&v4, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Badge>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Badge>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Badge>>(v7, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : Badge {
        Badge{
            id          : 0x2::object::new(arg7),
            registry_id : arg0,
            name        : arg1,
            description : arg2,
            badge_type  : arg3,
            source_id   : arg4,
            rarity      : arg5,
            image_id    : arg6,
        }
    }

    public fun name(arg0: &Badge) : &0x1::string::String {
        &arg0.name
    }

    public fun rarity(arg0: &Badge) : u8 {
        arg0.rarity
    }

    public fun registry_id(arg0: &Badge) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun source_id(arg0: &Badge) : &0x1::string::String {
        &arg0.source_id
    }

    // decompiled from Move bytecode v6
}

