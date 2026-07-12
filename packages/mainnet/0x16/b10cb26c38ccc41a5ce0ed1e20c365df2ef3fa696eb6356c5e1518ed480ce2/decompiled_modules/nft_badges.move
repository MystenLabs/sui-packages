module 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::nft_badges {
    struct BadgeClaimKey has copy, drop, store {
        owner: address,
        badge_type: 0x1::string::String,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        owner: address,
        badge_type: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: u8,
        earned_at: u64,
    }

    struct BadgeTemplate has store {
        badge_type: 0x1::string::String,
        requirement: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: u8,
    }

    struct BadgeRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        badge_templates: 0x2::table::Table<0x1::string::String, BadgeTemplate>,
        claimed: 0x2::table::Table<BadgeClaimKey, bool>,
    }

    struct BadgeMinted has copy, drop {
        owner: address,
        badge_type: 0x1::string::String,
        name: 0x1::string::String,
        rarity: u8,
        timestamp: u64,
    }

    struct BadgeTemplateAdded has copy, drop {
        badge_type: 0x1::string::String,
        name: 0x1::string::String,
        rarity: u8,
    }

    public entry fun add_badge_template(arg0: &mut BadgeRegistry, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 0);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = BadgeTemplate{
            badge_type  : v0,
            requirement : arg2,
            name        : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg4),
            image_url   : 0x1::string::utf8(arg5),
            rarity      : arg6,
        };
        let v2 = BadgeTemplateAdded{
            badge_type : v0,
            name       : 0x1::string::utf8(arg3),
            rarity     : arg6,
        };
        0x2::event::emit<BadgeTemplateAdded>(v2);
        0x2::table::add<0x1::string::String, BadgeTemplate>(&mut arg0.badge_templates, v0, v1);
    }

    public fun check_eligibility(arg0: u64, arg1: u64, arg2: 0x1::string::String) : bool {
        arg2 == 0x1::string::utf8(b"first_purchase") && arg0 >= 1 || arg2 == 0x1::string::utf8(b"10_purchases") && arg0 >= 10 || arg2 == 0x1::string::utf8(b"50_purchases") && arg0 >= 50 || arg2 == 0x1::string::utf8(b"100_purchases") && arg0 >= 100 || arg2 == 0x1::string::utf8(b"referral_master") && arg1 >= 5
    }

    public entry fun claim_badge(arg0: &mut BadgeRegistry, arg1: &0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::CustomerShopAccount, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::get_account_customer(arg1), 0);
        let v1 = 0x1::string::utf8(arg2);
        assert!(0x2::table::contains<0x1::string::String, BadgeTemplate>(&arg0.badge_templates, v1), 1);
        assert!(check_eligibility(0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::get_account_purchases(arg1), 0, v1), 2);
        let v2 = BadgeClaimKey{
            owner      : v0,
            badge_type : v1,
        };
        assert!(!0x2::table::contains<BadgeClaimKey, bool>(&arg0.claimed, v2), 3);
        0x2::table::add<BadgeClaimKey, bool>(&mut arg0.claimed, v2, true);
        issue_badge(arg0, v1, v0, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public fun get_badge_rarity(arg0: &Badge) : u8 {
        arg0.rarity
    }

    public fun get_badge_type(arg0: &Badge) : 0x1::string::String {
        arg0.badge_type
    }

    public fun has_claimed(arg0: &BadgeRegistry, arg1: address, arg2: vector<u8>) : bool {
        let v0 = BadgeClaimKey{
            owner      : arg1,
            badge_type : 0x1::string::utf8(arg2),
        };
        0x2::table::contains<BadgeClaimKey, bool>(&arg0.claimed, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BadgeRegistry{
            id              : 0x2::object::new(arg0),
            admin           : 0x2::tx_context::sender(arg0),
            badge_templates : 0x2::table::new<0x1::string::String, BadgeTemplate>(arg0),
            claimed         : 0x2::table::new<BadgeClaimKey, bool>(arg0),
        };
        0x2::transfer::share_object<BadgeRegistry>(v0);
    }

    fun issue_badge(arg0: &BadgeRegistry, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, BadgeTemplate>(&arg0.badge_templates, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::string::String, BadgeTemplate>(&arg0.badge_templates, arg1);
        let v1 = Badge{
            id          : 0x2::object::new(arg4),
            owner       : arg2,
            badge_type  : v0.badge_type,
            name        : v0.name,
            description : v0.description,
            image_url   : v0.image_url,
            rarity      : v0.rarity,
            earned_at   : arg3,
        };
        let v2 = BadgeMinted{
            owner      : arg2,
            badge_type : v0.badge_type,
            name       : v0.name,
            rarity     : v0.rarity,
            timestamp  : arg3,
        };
        0x2::event::emit<BadgeMinted>(v2);
        0x2::transfer::transfer<Badge>(v1, arg2);
    }

    public entry fun mint_badge(arg0: &BadgeRegistry, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        issue_badge(arg0, 0x1::string::utf8(arg1), arg2, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public entry fun setup_default_badges(arg0: &mut BadgeRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = BadgeTemplate{
            badge_type  : 0x1::string::utf8(b"first_purchase"),
            requirement : 1,
            name        : 0x1::string::utf8(b"First Sip"),
            description : 0x1::string::utf8(b"Welcome to the coffee club!"),
            image_url   : 0x1::string::utf8(b"https://example.com/badges/first_purchase.png"),
            rarity      : 1,
        };
        0x2::table::add<0x1::string::String, BadgeTemplate>(&mut arg0.badge_templates, 0x1::string::utf8(b"first_purchase"), v0);
        let v1 = BadgeTemplate{
            badge_type  : 0x1::string::utf8(b"10_purchases"),
            requirement : 10,
            name        : 0x1::string::utf8(b"Regular"),
            description : 0x1::string::utf8(b"A true coffee regular!"),
            image_url   : 0x1::string::utf8(b"https://example.com/badges/10_purchases.png"),
            rarity      : 2,
        };
        0x2::table::add<0x1::string::String, BadgeTemplate>(&mut arg0.badge_templates, 0x1::string::utf8(b"10_purchases"), v1);
        let v2 = BadgeTemplate{
            badge_type  : 0x1::string::utf8(b"50_purchases"),
            requirement : 50,
            name        : 0x1::string::utf8(b"Caffeine Connoisseur"),
            description : 0x1::string::utf8(b"50 coffees and counting!"),
            image_url   : 0x1::string::utf8(b"https://example.com/badges/50_purchases.png"),
            rarity      : 3,
        };
        0x2::table::add<0x1::string::String, BadgeTemplate>(&mut arg0.badge_templates, 0x1::string::utf8(b"50_purchases"), v2);
        let v3 = BadgeTemplate{
            badge_type  : 0x1::string::utf8(b"100_purchases"),
            requirement : 100,
            name        : 0x1::string::utf8(b"Coffee Legend"),
            description : 0x1::string::utf8(b"100 coffees! Legendary status achieved!"),
            image_url   : 0x1::string::utf8(b"https://example.com/badges/100_purchases.png"),
            rarity      : 4,
        };
        0x2::table::add<0x1::string::String, BadgeTemplate>(&mut arg0.badge_templates, 0x1::string::utf8(b"100_purchases"), v3);
        let v4 = BadgeTemplate{
            badge_type  : 0x1::string::utf8(b"referral_master"),
            requirement : 5,
            name        : 0x1::string::utf8(b"Coffee Ambassador"),
            description : 0x1::string::utf8(b"Brought 5 friends to the coffee club!"),
            image_url   : 0x1::string::utf8(b"https://example.com/badges/referral_master.png"),
            rarity      : 3,
        };
        0x2::table::add<0x1::string::String, BadgeTemplate>(&mut arg0.badge_templates, 0x1::string::utf8(b"referral_master"), v4);
    }

    // decompiled from Move bytecode v6
}

