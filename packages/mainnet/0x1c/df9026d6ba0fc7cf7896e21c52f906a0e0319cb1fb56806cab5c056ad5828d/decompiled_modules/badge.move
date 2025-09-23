module 0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::badge {
    struct BADGE has drop {
        dummy_field: bool,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        minted_supply: u64,
        event_id: 0x2::object::ID,
        creator: address,
    }

    struct BadgeNFT has store, key {
        id: 0x2::object::UID,
        template_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        recipient: address,
        awarded_at: u64,
    }

    public entry fun award_badge_to_user(arg0: &mut Badge, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted_supply < arg0.total_supply, 0);
        arg0.minted_supply = arg0.minted_supply + 1;
        let v0 = BadgeNFT{
            id          : 0x2::object::new(arg5),
            template_id : 0x2::object::id<Badge>(arg0),
            name        : arg0.name,
            image_url   : arg0.image,
            recipient   : arg3,
            awarded_at  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::kiosk::place<BadgeNFT>(arg1, arg2, v0);
    }

    public fun badges_available(arg0: &Badge) : u64 {
        arg0.total_supply - arg0.minted_supply
    }

    public entry fun create_badge_template(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Badge{
            id            : 0x2::object::new(arg5),
            name          : arg0,
            image         : arg1,
            description   : arg2,
            total_supply  : arg3,
            minted_supply : 0,
            event_id      : arg4,
            creator       : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_share_object<Badge>(v0);
    }

    public fun get_badge_info(arg0: &Badge) : (0x1::string::String, 0x1::string::String, u64, u64) {
        (arg0.name, arg0.description, arg0.minted_supply, arg0.total_supply)
    }

    public fun get_badge_nft_info(arg0: &BadgeNFT) : (0x1::string::String, address, u64) {
        (arg0.name, arg0.recipient, arg0.awarded_at)
    }

    fun init(arg0: BADGE, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_creator(arg0: &Badge, arg1: address) : bool {
        arg0.creator == arg1
    }

    // decompiled from Move bytecode v6
}

