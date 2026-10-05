module 0x77616994e0607170c16c505ddc2ffdc407ef6bcace7befdf4aea411231b38071::yoyo_cyclone {
    struct YOYO_CYCLONE has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        result: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        minter: address,
        win_image_url: 0x1::string::String,
        lose_image_url: 0x1::string::String,
        wins: u64,
        losses: u64,
        players: 0x2::table::Table<address, bool>,
        used_codes: 0x2::table::Table<u64, bool>,
    }

    struct DuelRecorded has copy, drop {
        nft_id: 0x2::object::ID,
        player: address,
        won: bool,
        number: u64,
        code: u64,
    }

    public fun attributes(arg0: &Nft) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun description(arg0: &Nft) : 0x1::string::String {
        arg0.description
    }

    public fun has_played(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.players, arg1)
    }

    public fun image_url(arg0: &Nft) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: YOYO_CYCLONE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<YOYO_CYCLONE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"result"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"number"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"luchador"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://wrestling.expo.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://effisend.xyz"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Effisend"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{result}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"537569204261736563616d7020c2b72053696e6761706f7265"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"El Rey Gallo"));
        let v5 = 0x2::display::new_with_fields<Nft>(&v0, v1, v3, arg1);
        0x2::display::update_version<Nft>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v5, v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v6);
        let v8 = Registry{
            id             : 0x2::object::new(arg1),
            minter         : v6,
            win_image_url  : 0x1::string::utf8(b""),
            lose_image_url : 0x1::string::utf8(b""),
            wins           : 0,
            losses         : 0,
            players        : 0x2::table::new<address, bool>(arg1),
            used_codes     : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::share_object<Registry>(v8);
    }

    public fun is_code_used(arg0: &Registry, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.used_codes, arg1)
    }

    public fun losses(arg0: &Registry) : u64 {
        arg0.losses
    }

    public fun minter(arg0: &Registry) : address {
        arg0.minter
    }

    public fun name(arg0: &Nft) : 0x1::string::String {
        arg0.name
    }

    public fun number(arg0: &Nft) : u64 {
        arg0.number
    }

    public fun record_duel(arg0: &mut Registry, arg1: address, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.minter, 2);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_codes, arg3), 3);
        assert!(!0x2::table::contains<address, bool>(&arg0.players, arg1), 0);
        assert!(!0x1::string::is_empty(&arg0.win_image_url) && !0x1::string::is_empty(&arg0.lose_image_url), 1);
        0x2::table::add<u64, bool>(&mut arg0.used_codes, arg3, true);
        0x2::table::add<address, bool>(&mut arg0.players, arg1, arg2);
        let (v0, v1, v2, v3, v4) = if (arg2) {
            arg0.wins = arg0.wins + 1;
            (0x1::string::utf8(x"c2a147616e61737465212028596f752057696e292023"), 0x1::string::utf8(x"c2a147616e617374652c2063616d7065c3b36e212028596f7520776f6e2c206368616d70212920596f75206265617420456c205265792047616c6c6f20617420686973206f776e2067616d6520696e2061206c75636861206c6962726520796f2d796f206475656c20617420537569204261736563616d702c2053696e6761706f72652e204576657279206368616c6c656e6765722074616b657320686f6d652061207072656d696f20287072697a65293b206f6e6c79206368616d70696f6e732074616b6520686f6d652074686520676f6c64656e20636172642e20c2a156697661206c61206c75636861206c696272652120284c6f6e67206c697665206c75636861206c69627265212920c2b7206279204566666973656e64"), arg0.win_image_url, 0x1::string::utf8(b"win"), arg0.wins)
        } else {
            arg0.losses = arg0.losses + 1;
            (0x1::string::utf8(x"c2a14275656e20696e74656e746f212028596f75204c6f7365292023"), 0x1::string::utf8(x"c2a1546520656e726564c3b320456c205265792047616c6c6f212028456c205265792047616c6c6f2074616e676c656420796f75207570212920596f75207374657070656420696e746f207468652072696e6720616e64206368616c6c656e67656420456c205265792047616c6c6f20746f2061206c75636861206c6962726520796f2d796f206475656c20617420537569204261736563616d702c2053696e6761706f72652e20596f752077616c6b6564206177617920776974682061207072656d696f20287072697a652920616e64207468697320636f7070657220636172642e20c2a14275656e20696e74656e746f2120284e69636520747279212920c2b7206279204566666973656e64"), arg0.lose_image_url, 0x1::string::utf8(b"lose"), arg0.losses)
        };
        let v5 = v0;
        0x1::string::append(&mut v5, 0x1::u64::to_string(v4));
        0x1::string::append(&mut v5, 0x1::string::utf8(x"20c2b720456c205265792047616c6c6f"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Result"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Card"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Event"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Luchador"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Duel"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Creator"));
        let v8 = if (arg2) {
            x"c2a147616e61737465212028596f752057696e29"
        } else {
            x"c2a14275656e20696e74656e746f212028596f75204c6f736529"
        };
        let v9 = if (arg2) {
            b"Gold"
        } else {
            b"Copper"
        };
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(v8));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(v9));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(x"537569204261736563616d7020c2b72053696e6761706f7265"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"El Rey Gallo"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Yo-yo"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Effisend"));
        let v12 = Nft{
            id          : 0x2::object::new(arg4),
            name        : v5,
            description : v1,
            image_url   : v2,
            result      : v3,
            number      : v4,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v6, v10),
        };
        let v13 = DuelRecorded{
            nft_id : 0x2::object::id<Nft>(&v12),
            player : arg1,
            won    : arg2,
            number : v4,
            code   : arg3,
        };
        0x2::event::emit<DuelRecorded>(v13);
        0x2::transfer::public_transfer<Nft>(v12, arg1);
    }

    public fun result(arg0: &Nft) : 0x1::string::String {
        arg0.result
    }

    public fun set_images(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg1.win_image_url = arg2;
        arg1.lose_image_url = arg3;
    }

    public fun set_minter(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        arg1.minter = arg2;
    }

    public fun wins(arg0: &Registry) : u64 {
        arg0.wins
    }

    // decompiled from Move bytecode v7
}

