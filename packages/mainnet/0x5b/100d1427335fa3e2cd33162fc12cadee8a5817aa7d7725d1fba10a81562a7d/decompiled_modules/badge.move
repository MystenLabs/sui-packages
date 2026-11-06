module 0x5b100d1427335fa3e2cd33162fc12cadee8a5817aa7d7725d1fba10a81562a7d::badge {
    struct BADGE has drop {
        dummy_field: bool,
    }

    struct SuiTideBadge has key {
        id: 0x2::object::UID,
        tier: u8,
        score: u64,
        cleanups: u64,
        objects_cleaned: u64,
    }

    struct BadgeMinted has copy, drop {
        badge_id: 0x2::object::ID,
        owner: address,
    }

    struct BadgeUpgraded has copy, drop {
        badge_id: 0x2::object::ID,
        tier: u8,
        score: u64,
    }

    fun clamp(arg0: u8) : u8 {
        if (arg0 > 3) {
            3
        } else {
            arg0
        }
    }

    fun init(arg0: BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BADGE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"5375695469646520426164676520c2b7204c6576656c207b746965727d"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Evolving rank badge for storage-rebate recoverers on Sui. Score {score}."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suitide.fun/api/badge?level={tier}&score={score}&c={cleanups}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suitide.fun"));
        let v5 = 0x2::display::new_with_fields<SuiTideBadge>(&v0, v1, v3, arg1);
        0x2::display::update_version<SuiTideBadge>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiTideBadge>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        mint_at(0, 0, arg0);
    }

    entry fun mint_at(arg0: u8, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiTideBadge{
            id              : 0x2::object::new(arg2),
            tier            : clamp(arg0),
            score           : arg1,
            cleanups        : 0,
            objects_cleaned : 0,
        };
        let v1 = BadgeMinted{
            badge_id : 0x2::object::id<SuiTideBadge>(&v0),
            owner    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BadgeMinted>(v1);
        0x2::transfer::transfer<SuiTideBadge>(v0, 0x2::tx_context::sender(arg2));
    }

    entry fun record_cleanup(arg0: &mut SuiTideBadge, arg1: u64) {
        arg0.cleanups = arg0.cleanups + 1;
        arg0.objects_cleaned = arg0.objects_cleaned + arg1;
    }

    entry fun sync(arg0: &mut SuiTideBadge, arg1: u8, arg2: u64) {
        let v0 = clamp(arg1);
        arg0.tier = v0;
        arg0.score = arg2;
        if (v0 > arg0.tier) {
            let v1 = BadgeUpgraded{
                badge_id : 0x2::object::id<SuiTideBadge>(arg0),
                tier     : v0,
                score    : arg2,
            };
            0x2::event::emit<BadgeUpgraded>(v1);
        };
    }

    // decompiled from Move bytecode v7
}

