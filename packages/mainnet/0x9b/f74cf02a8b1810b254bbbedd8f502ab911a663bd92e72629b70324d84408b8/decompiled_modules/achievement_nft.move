module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::achievement_nft {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AchievementBadge has key {
        id: 0x2::object::UID,
        recipient: address,
        achievement_id: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        awarded_at: u64,
    }

    public fun achievement_id(arg0: &AchievementBadge) : u64 {
        arg0.achievement_id
    }

    public entry fun award(arg0: &AdminCap, arg1: address, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AchievementBadge{
            id             : 0x2::object::new(arg6),
            recipient      : arg1,
            achievement_id : arg2,
            title          : 0x1::string::utf8(arg3),
            description    : 0x1::string::utf8(arg4),
            image_url      : 0x2::url::new_unsafe_from_bytes(arg5),
            awarded_at     : 0x2::tx_context::epoch(arg6),
        };
        0x2::transfer::transfer<AchievementBadge>(v0, arg1);
    }

    public entry fun burn(arg0: &AdminCap, arg1: AchievementBadge) {
        let AchievementBadge {
            id             : v0,
            recipient      : _,
            achievement_id : _,
            title          : _,
            description    : _,
            image_url      : _,
            awarded_at     : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun recipient(arg0: &AchievementBadge) : address {
        arg0.recipient
    }

    public fun treasury() : address {
        @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0
    }

    // decompiled from Move bytecode v7
}

