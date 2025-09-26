module 0x512a8012b842a30864da5aba206ac569360dc533f4fdd29c518912ba02522c61::honeybug {
    struct HONEYBUG has drop {
        dummy_field: bool,
    }

    struct HoneyBugMinted has copy, drop {
        bug_id: 0x2::object::ID,
        recipient: address,
        mint_number: u64,
    }

    struct HoneyBugBurned has copy, drop {
        bug_id: 0x2::object::ID,
        burner: address,
    }

    struct HoneyBug has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        mint_number: u64,
        rarity: u8,
    }

    struct HoneyBugCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        total_supply: u64,
        minted_count: u64,
        max_supply: u64,
    }

    public fun add_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<HoneyBug>, arg1: &0x2::transfer_policy::TransferPolicyCap<HoneyBug>, arg2: &mut 0x2::tx_context::TxContext) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<HoneyBug>(arg0, arg1);
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<HoneyBug>, arg1: &0x2::transfer_policy::TransferPolicyCap<HoneyBug>, arg2: &mut 0x2::tx_context::TxContext) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<HoneyBug>(arg0, arg1, (500 as u16), 0);
    }

    public fun get_collection_info(arg0: &HoneyBugCollection) : (0x1::string::String, 0x1::string::String, u64, u64, u64) {
        (arg0.name, arg0.description, arg0.total_supply, arg0.minted_count, arg0.max_supply)
    }

    public fun get_honeybug_info(arg0: &HoneyBug) : (0x1::string::String, 0x1::string::String, u64, u8) {
        (arg0.name, arg0.description, arg0.mint_number, arg0.rarity)
    }

    fun init(arg0: HONEYBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HONEYBUG>(arg0, arg1);
        let v1 = 0x2::display::new<HoneyBug>(&v0, arg1);
        0x2::display::add<HoneyBug>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<HoneyBug>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<HoneyBug>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<HoneyBug>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<HoneyBug>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<HoneyBug>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_collection(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HoneyBugCollection{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"HoneyBugs"),
            description  : 0x1::string::utf8(b"A collection of magical HoneyBugs that live in the Sui ecosystem"),
            image_url    : 0x1::string::utf8(b"https://assets.honeyplay.fun/honeybugs/collection.png"),
            total_supply : 0,
            minted_count : 0,
            max_supply   : 10000,
        };
        let (v1, v2) = 0x2::transfer_policy::new<HoneyBug>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<HoneyBug>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<HoneyBug>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<HoneyBugCollection>(v0);
    }

    public fun mint(arg0: &mut HoneyBugCollection, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted_count < arg0.max_supply, 0);
        let v0 = arg0.minted_count + 1;
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg1);
        let v3 = if (v0 % 5 == 0) {
            0x1::string::utf8(b"Golden")
        } else if (v0 % 4 == 0) {
            0x1::string::utf8(b"Silver")
        } else if (v0 % 3 == 0) {
            0x1::string::utf8(b"Blue")
        } else if (v0 % 2 == 0) {
            0x1::string::utf8(b"Green")
        } else {
            0x1::string::utf8(b"Red")
        };
        let v4 = if (v0 % 3 == 0) {
            0x1::string::utf8(b"Transparent")
        } else if (v0 % 2 == 0) {
            0x1::string::utf8(b"Iridescent")
        } else {
            0x1::string::utf8(b"Solid")
        };
        let v5 = if (v0 % 4 == 0) {
            0x1::string::utf8(b"Large")
        } else if (v0 % 3 == 0) {
            0x1::string::utf8(b"Medium")
        } else {
            0x1::string::utf8(b"Small")
        };
        let v6 = if (v0 % 5 == 0) {
            0x1::string::utf8(b"Legendary")
        } else if (v0 % 4 == 0) {
            0x1::string::utf8(b"Friendly")
        } else if (v0 % 3 == 0) {
            0x1::string::utf8(b"Playful")
        } else if (v0 % 2 == 0) {
            0x1::string::utf8(b"Calm")
        } else {
            0x1::string::utf8(b"Energetic")
        };
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Color"), v3);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Wings"), v4);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Size"), v5);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Personality"), v6);
        let v7 = if (v0 % 100 == 0) {
            5
        } else if (v0 % 20 == 0) {
            4
        } else if (v0 % 10 == 0) {
            3
        } else if (v0 % 5 == 0) {
            2
        } else {
            1
        };
        let v8 = if (v0 % 100 == 0) {
            0x1::string::utf8(b"Legendary HoneyBug")
        } else if (v0 % 20 == 0) {
            0x1::string::utf8(b"Epic HoneyBug")
        } else if (v0 % 10 == 0) {
            0x1::string::utf8(b"Rare HoneyBug")
        } else if (v0 % 5 == 0) {
            0x1::string::utf8(b"Uncommon HoneyBug")
        } else {
            0x1::string::utf8(b"HoneyBug")
        };
        let v9 = HoneyBug{
            id          : 0x2::object::new(arg1),
            name        : v8,
            description : 0x1::string::utf8(b"A magical HoneyBug from the Sui ecosystem"),
            image_url   : 0x1::string::utf8(b"https://assets.honeyplay.fun/honeybugs/bug.png"),
            attributes  : v2,
            mint_number : v0,
            rarity      : v7,
        };
        arg0.minted_count = arg0.minted_count + 1;
        arg0.total_supply = arg0.total_supply + 1;
        let v10 = HoneyBugMinted{
            bug_id      : 0x2::object::uid_to_inner(&v9.id),
            recipient   : v1,
            mint_number : v0,
        };
        0x2::event::emit<HoneyBugMinted>(v10);
        0x2::transfer::public_transfer<HoneyBug>(v9, v1);
    }

    // decompiled from Move bytecode v6
}

