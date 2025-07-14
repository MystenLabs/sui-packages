module 0xdea3242157ba180e781f668c723a9bb3a83189c03d2d1038af5a140d199e052c::mystemon {
    struct Stats has store {
        atk: u64,
        def: u64,
        spd: u64,
        intelligence: u64,
        stm: u64,
        chr: u64,
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
        stats: Stats,
    }

    struct MYSTEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"lore"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"generation"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"elements"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"species"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"stats.atk"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"stats.def"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"stats.spd"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"stats.intelligence"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"stats.stm"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"stats.chr"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{lore}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{generation}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{elements}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{species}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{stats.atk}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{stats.def}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{stats.spd}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{stats.intelligence}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{stats.stm}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{stats.chr}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{lore}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://mystendex.com"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"MystenDex Team"));
        let v2 = 0x2::package::claim<MYSTEMON>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<Mystemon>(&v2, v0, v1, arg1);
        0x2::display::update_version<Mystemon>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Mystemon>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u64, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{
            atk          : arg7,
            def          : arg8,
            spd          : arg9,
            intelligence : arg10,
            stm          : arg11,
            chr          : arg12,
        };
        let v1 = Mystemon{
            id         : 0x2::object::new(arg13),
            name       : arg0,
            lore       : arg1,
            image_url  : 0x2::url::new_unsafe_from_bytes(arg2),
            generation : arg3,
            rarity     : arg4,
            elements   : arg5,
            species    : arg6,
            stats      : v0,
        };
        0x2::transfer::public_transfer<Mystemon>(v1, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

