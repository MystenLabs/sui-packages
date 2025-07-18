module 0x5b7185964577dc1ceb254a40a5a7afbde85442dfb8afa06f7b4c04069839b982::mystemons {
    struct Stats has store {
        atk: u64,
        def: u64,
        spd: u64,
        intelligence: u64,
        stm: u64,
        chr: u64,
    }

    struct Trait has store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
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
        stats: Stats,
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
        let v0 = 0x2::package::claim<MYSTEMONS>(arg0, arg1);
        let v1 = Collection{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Collection>(v1);
        let v2 = 0x2::display::new<Collection>(&v0, arg1);
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"MystenDex Mystemons"));
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"4120636f6c6c656374696f6e206f6620756e69717565204d797374c3a96d6f6e732067656e6572617465642066726f6d20757365722070726f66696c65732e20446973636f7665722c20636f6c6c6563742c20616e6420626174746c6520696e20746865204d797374656e44657820756e69766572736521"));
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.mainnet.walrus.mirai.cloud/v1/blobs/ScREaq6fZq71Rbw0ncMYcq-dBoSNhXcAP8I9vkh6zY4"));
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://teammysten.com"));
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Team Mysten"));
        0x2::display::add<Collection>(&mut v2, 0x1::string::utf8(b"symbol"), 0x1::string::utf8(b"MYSTM"));
        0x2::display::update_version<Collection>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = 0x2::display::new<Mystemon>(&v0, arg1);
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"lore"), 0x1::string::utf8(b"{lore}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{lore}"));
        0x2::display::update_version<Mystemon>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<Mystemon>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_kiosk(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::kiosk::Kiosk, arg15: &0x2::kiosk::KioskOwnerCap, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{
            atk          : arg8,
            def          : arg9,
            spd          : arg10,
            intelligence : arg11,
            stm          : arg12,
            chr          : arg13,
        };
        let v1 = Mystemon{
            id         : 0x2::object::new(arg16),
            name       : arg1,
            lore       : arg2,
            image_url  : 0x2::url::new_unsafe_from_bytes(arg3),
            generation : arg4,
            rarity     : arg5,
            elements   : arg6,
            species    : arg7,
            stats      : v0,
        };
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, 0x2::object::uid_to_address(&v1.id), true);
        let v2 = 0x1::vector::empty<Trait>();
        let v3 = Trait{
            trait_type : 0x1::string::utf8(b"Rarity"),
            value      : arg5,
        };
        0x1::vector::push_back<Trait>(&mut v2, v3);
        let v4 = Trait{
            trait_type : 0x1::string::utf8(b"Species"),
            value      : arg7,
        };
        0x1::vector::push_back<Trait>(&mut v2, v4);
        let v5 = Trait{
            trait_type : 0x1::string::utf8(b"Generation"),
            value      : u64_to_string(arg4),
        };
        0x1::vector::push_back<Trait>(&mut v2, v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            let v7 = Trait{
                trait_type : 0x1::string::utf8(b"Element"),
                value      : *0x1::vector::borrow<0x1::string::String>(&arg6, v6),
            };
            0x1::vector::push_back<Trait>(&mut v2, v7);
            v6 = v6 + 1;
        };
        let v8 = Trait{
            trait_type : 0x1::string::utf8(b"Attack"),
            value      : u64_to_string(arg8),
        };
        0x1::vector::push_back<Trait>(&mut v2, v8);
        let v9 = Trait{
            trait_type : 0x1::string::utf8(b"Defense"),
            value      : u64_to_string(arg9),
        };
        0x1::vector::push_back<Trait>(&mut v2, v9);
        let v10 = Trait{
            trait_type : 0x1::string::utf8(b"Speed"),
            value      : u64_to_string(arg10),
        };
        0x1::vector::push_back<Trait>(&mut v2, v10);
        let v11 = Trait{
            trait_type : 0x1::string::utf8(b"Intelligence"),
            value      : u64_to_string(arg11),
        };
        0x1::vector::push_back<Trait>(&mut v2, v11);
        let v12 = Trait{
            trait_type : 0x1::string::utf8(b"Stamina"),
            value      : u64_to_string(arg12),
        };
        0x1::vector::push_back<Trait>(&mut v2, v12);
        let v13 = Trait{
            trait_type : 0x1::string::utf8(b"Charisma"),
            value      : u64_to_string(arg13),
        };
        0x1::vector::push_back<Trait>(&mut v2, v13);
        0x2::dynamic_field::add<0x1::string::String, vector<Trait>>(&mut v1.id, 0x1::string::utf8(b"attributes"), v2);
        0x2::kiosk::place<Mystemon>(arg14, arg15, v1);
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

