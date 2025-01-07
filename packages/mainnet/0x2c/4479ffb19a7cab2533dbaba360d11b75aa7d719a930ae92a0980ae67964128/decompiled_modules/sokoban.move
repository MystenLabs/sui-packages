module 0x2c4479ffb19a7cab2533dbaba360d11b75aa7d719a930ae92a0980ae67964128::sokoban {
    struct SokobanLevel has store, key {
        id: 0x2::object::UID,
        level: u64,
        map_data: vector<u8>,
        creator: address,
    }

    struct SokobanBadge has store, key {
        id: 0x2::object::UID,
        winner: address,
        level: u64,
        url: 0x2::url::Url,
    }

    struct SOKOBAN has drop {
        dummy_field: bool,
    }

    struct SokobanBadgeMinted has copy, drop {
        object_id: 0x2::object::ID,
        winner: address,
        level: u64,
    }

    struct SokobanLevelMinted has copy, drop {
        object_id: 0x2::object::ID,
        level: u64,
        map_data: vector<u8>,
    }

    public fun url(arg0: &SokobanBadge) : &0x2::url::Url {
        &arg0.url
    }

    public fun badge_level(arg0: &SokobanBadge) : &u64 {
        &arg0.level
    }

    public fun creator(arg0: &SokobanLevel) : &address {
        &arg0.creator
    }

    fun init(arg0: SOKOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SOKOBAN>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"map_data"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{map_data}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<SokobanLevel>(&v0, v1, v3, arg1);
        0x2::display::update_version<SokobanLevel>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<SokobanLevel>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"winner"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"level"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{winner}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{level}"));
        let v10 = 0x2::display::new_with_fields<SokobanBadge>(&v0, v6, v8, arg1);
        0x2::display::update_version<SokobanBadge>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<SokobanBadge>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun level(arg0: &SokobanLevel) : &u64 {
        &arg0.level
    }

    public fun map_data(arg0: &SokobanLevel) : &vector<u8> {
        &arg0.map_data
    }

    public entry fun mint_level(arg0: u64, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SokobanLevel{
            id       : 0x2::object::new(arg2),
            level    : arg0,
            map_data : arg1,
            creator  : v0,
        };
        let v2 = SokobanLevelMinted{
            object_id : 0x2::object::id<SokobanLevel>(&v1),
            level     : arg0,
            map_data  : arg1,
        };
        0x2::event::emit<SokobanLevelMinted>(v2);
        0x2::transfer::public_transfer<SokobanLevel>(v1, v0);
    }

    public entry fun mint_to_winner(arg0: &SokobanLevel, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SokobanBadge{
            id     : 0x2::object::new(arg2),
            winner : v0,
            level  : arg0.level,
            url    : 0x2::url::new_unsafe_from_bytes(b"https://www.sina.com.cn"),
        };
        let v2 = SokobanBadgeMinted{
            object_id : 0x2::object::id<SokobanBadge>(&v1),
            winner    : v0,
            level     : arg0.level,
        };
        0x2::event::emit<SokobanBadgeMinted>(v2);
        0x2::transfer::public_transfer<SokobanBadge>(v1, v0);
    }

    public fun winner(arg0: &SokobanBadge) : &address {
        &arg0.winner
    }

    // decompiled from Move bytecode v6
}

