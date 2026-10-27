module 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy {
    struct TROPHY has drop {
        dummy_field: bool,
    }

    struct Trophy has key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
        game_name: 0x1::string::String,
        trophy_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        tier: u8,
        tier_name: 0x1::string::String,
        points: u64,
        source: u8,
        source_name: 0x1::string::String,
        number: u64,
        unlocked_at_ms: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Trophy {
        Trophy{
            id             : 0x2::object::new(arg10),
            game           : arg0,
            game_name      : arg1,
            trophy_id      : arg2,
            name           : arg3,
            description    : arg4,
            image_url      : arg5,
            tier           : arg6,
            tier_name      : tier_name(arg6),
            points         : points_for(arg6),
            source         : arg7,
            source_name    : source_name(arg7),
            number         : arg8,
            unlocked_at_ms : arg9,
        }
    }

    public fun assert_tier(arg0: u8) {
        assert!(arg0 <= 3, 401);
    }

    public fun bronze() : u8 {
        0
    }

    public fun description(arg0: &Trophy) : 0x1::string::String {
        arg0.description
    }

    public fun game(arg0: &Trophy) : 0x2::object::ID {
        arg0.game
    }

    public fun game_name(arg0: &Trophy) : 0x1::string::String {
        arg0.game_name
    }

    public(friend) fun give(arg0: Trophy, arg1: address) {
        0x2::transfer::transfer<Trophy>(arg0, arg1);
    }

    public fun gold() : u8 {
        2
    }

    public fun image_url(arg0: &Trophy) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: TROPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TROPHY>(arg0, arg1);
        let v1 = 0x2::display::new<Trophy>(&v0, arg1);
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://rare.market"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Rare Trophies"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"game"), 0x1::string::utf8(b"{game_name}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier_name}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"points"), 0x1::string::utf8(b"{points}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"source"), 0x1::string::utf8(b"{source_name}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<Trophy>(&mut v1, 0x1::string::utf8(b"unlocked_at_ms"), 0x1::string::utf8(b"{unlocked_at_ms}"));
        0x2::display::update_version<Trophy>(&mut v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Trophy>>(v1, v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::AdminCap>(0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::create(arg1), v2);
    }

    public fun name(arg0: &Trophy) : 0x1::string::String {
        arg0.name
    }

    public fun number(arg0: &Trophy) : u64 {
        arg0.number
    }

    public fun platinum() : u8 {
        3
    }

    public fun points(arg0: &Trophy) : u64 {
        arg0.points
    }

    public fun points_for(arg0: u8) : u64 {
        assert_tier(arg0);
        if (arg0 == 0) {
            15
        } else if (arg0 == 1) {
            30
        } else if (arg0 == 2) {
            90
        } else {
            300
        }
    }

    public fun silver() : u8 {
        1
    }

    public fun source(arg0: &Trophy) : u8 {
        arg0.source
    }

    public fun source_attested() : u8 {
        1
    }

    public fun source_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Studio issued")
        } else {
            0x1::string::utf8(b"Self-reported")
        }
    }

    public fun source_studio() : u8 {
        0
    }

    public fun tier(arg0: &Trophy) : u8 {
        arg0.tier
    }

    public fun tier_name(arg0: u8) : 0x1::string::String {
        assert_tier(arg0);
        if (arg0 == 0) {
            0x1::string::utf8(b"Bronze")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Silver")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Gold")
        } else {
            0x1::string::utf8(b"Platinum")
        }
    }

    public fun trophy_id(arg0: &Trophy) : u64 {
        arg0.trophy_id
    }

    public fun unlocked_at_ms(arg0: &Trophy) : u64 {
        arg0.unlocked_at_ms
    }

    // decompiled from Move bytecode v7
}

