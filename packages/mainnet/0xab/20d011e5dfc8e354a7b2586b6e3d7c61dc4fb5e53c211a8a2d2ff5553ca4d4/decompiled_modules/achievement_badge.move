module 0xab20d011e5dfc8e354a7b2586b6e3d7c61dc4fb5e53c211a8a2d2ff5553ca4d4::achievement_badge {
    struct AchievementBadge has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AwardCap has store, key {
        id: 0x2::object::UID,
    }

    struct ACHIEVEMENT_BADGE has drop {
        dummy_field: bool,
    }

    public fun award(arg0: &AwardCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AchievementBadge{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
        };
        0x2::transfer::transfer<AchievementBadge>(v0, arg4);
    }

    public fun get_description(arg0: &AchievementBadge) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &AchievementBadge) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_image_url(arg0: &AchievementBadge) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &AchievementBadge) : &0x1::string::String {
        &arg0.name
    }

    fun init(arg0: ACHIEVEMENT_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<ACHIEVEMENT_BADGE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AchievementBadge>(&v4, v0, v2, arg1);
        0x2::display::update_version<AchievementBadge>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AchievementBadge>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AwardCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AwardCap>(v6, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

