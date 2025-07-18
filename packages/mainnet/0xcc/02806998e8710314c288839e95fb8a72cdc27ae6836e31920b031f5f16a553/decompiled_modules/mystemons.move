module 0xcc02806998e8710314c288839e95fb8a72cdc27ae6836e31920b031f5f16a553::mystemons {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
    }

    struct Mystemon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lore: 0x1::string::String,
        image_url: 0x2::url::Url,
        generation: u64,
        rarity: 0x1::string::String,
        elements: vector<0x1::string::String>,
        species: 0x1::string::String,
        atk: 0x1::string::String,
        def: 0x1::string::String,
        spd: 0x1::string::String,
        intelligence: 0x1::string::String,
        stm: 0x1::string::String,
        chr: 0x1::string::String,
    }

    struct MYSTEMONS has drop {
        dummy_field: bool,
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: MYSTEMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Collection>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<AdminCap>(v1);
        let v2 = 0x2::package::claim<MYSTEMONS>(arg0, arg1);
        let v3 = 0x2::display::new<Mystemon>(&v2, arg1);
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://teammysten.com/mystemon/{id}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{lore}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://teammysten.com"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Team Mysten"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Rarity"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Species"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Generation"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Attack"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Defense"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Speed"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Intelligence"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Stamina"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Charisma"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{species}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{generation}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{atk}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{def}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{spd}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{intelligence}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{stm}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{chr}"));
        0x2::display::add_multiple<Mystemon>(&mut v3, v4, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::display::update_version<Mystemon>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<Mystemon>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_kiosk(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::kiosk::Kiosk, arg16: &0x2::kiosk::KioskOwnerCap, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = Mystemon{
            id           : 0x2::object::new(arg17),
            name         : arg2,
            lore         : arg3,
            image_url    : 0x2::url::new_unsafe_from_bytes(arg4),
            generation   : arg5,
            rarity       : arg6,
            elements     : arg7,
            species      : arg8,
            atk          : u64_to_string(arg9),
            def          : u64_to_string(arg10),
            spd          : u64_to_string(arg11),
            intelligence : u64_to_string(arg12),
            stm          : u64_to_string(arg13),
            chr          : u64_to_string(arg14),
        };
        0x2::dynamic_field::add<address, bool>(&mut arg1.id, 0x2::object::uid_to_address(&v0.id), true);
        0x2::kiosk::place<Mystemon>(arg15, arg16, v0);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = b"";
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
                arg0 = arg0 / 10;
            };
            0x1::vector::reverse<u8>(&mut v0);
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

