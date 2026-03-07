module 0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::suibot {
    struct Factory has key {
        id: 0x2::object::UID,
        indexes: 0x2::vec_map::VecMap<0x1::string::String, u16>,
    }

    struct PartKey has copy, drop, store {
        pos0: 0x1::string::String,
        pos1: u16,
    }

    struct FactoryManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Suibot has store, key {
        id: 0x2::object::UID,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct FactoryPart has store, key {
        id: 0x2::object::UID,
        data: 0x1::string::String,
    }

    public fun add_part(arg0: &mut Factory, arg1: &FactoryManagerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x1::string::String, u16>(&arg0.indexes, &arg2), 13835621567876562949);
        let v0 = *0x2::vec_map::get<0x1::string::String, u16>(&arg0.indexes, &arg2);
        *0x2::vec_map::get_mut<0x1::string::String, u16>(&mut arg0.indexes, &arg2) = v0 + 1;
        let v1 = PartKey{
            pos0 : arg2,
            pos1 : v0,
        };
        0x2::dynamic_field::add<PartKey, 0x1::string::String>(&mut arg0.id, v1, arg3);
    }

    public fun create(arg0: &Factory, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u16, arg8: u16, arg9: u16, arg10: u16, arg11: &mut 0x2::tx_context::TxContext) : Suibot {
        let v0 = 0x1::string::utf8(b"head");
        let v1 = 0x1::string::utf8(b"body");
        let v2 = 0x1::string::utf8(b"legs");
        let v3 = 0x1::string::utf8(b"hands");
        assert!(*0x2::vec_map::get<0x1::string::String, u16>(&arg0.indexes, &v2) > arg7, 13835058377404710913);
        assert!(*0x2::vec_map::get<0x1::string::String, u16>(&arg0.indexes, &v3) > arg8, 13835058381699678209);
        assert!(*0x2::vec_map::get<0x1::string::String, u16>(&arg0.indexes, &v1) > arg9, 13835058385994645505);
        assert!(*0x2::vec_map::get<0x1::string::String, u16>(&arg0.indexes, &v0) > arg10, 13835058390289612801);
        assert!(0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette::is_valid_color(arg1), 13835339873856389123);
        assert!(0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette::is_valid_color(arg2), 13835339878151356419);
        assert!(0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette::is_valid_color(arg3), 13835339882446323715);
        assert!(0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette::is_valid_color(arg4), 13835339886741291011);
        assert!(0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette::is_valid_color(arg5), 13835339891036258307);
        assert!(0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette::is_valid_color(arg6), 13835339895331225603);
        let v4 = 0x2::object::new(arg11);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"main_color"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"secondary_color"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"accent_color"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"background_color"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"joint_color"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"eyes_color"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, arg1);
        0x1::vector::push_back<0x1::string::String>(v8, arg2);
        0x1::vector::push_back<0x1::string::String>(v8, arg3);
        0x1::vector::push_back<0x1::string::String>(v8, arg4);
        0x1::vector::push_back<0x1::string::String>(v8, arg5);
        0x1::vector::push_back<0x1::string::String>(v8, arg6);
        let v9 = PartKey{
            pos0 : v0,
            pos1 : arg10,
        };
        let v10 = PartKey{
            pos0 : v1,
            pos1 : arg9,
        };
        let v11 = PartKey{
            pos0 : v2,
            pos1 : arg7,
        };
        let v12 = PartKey{
            pos0 : v3,
            pos1 : arg8,
        };
        let v13 = FactoryPart{
            id   : 0x2::object::new(arg11),
            data : *0x2::dynamic_field::borrow<PartKey, 0x1::string::String>(&arg0.id, v9),
        };
        0x2::dynamic_object_field::add<0x1::string::String, FactoryPart>(&mut v4, v0, v13);
        let v14 = FactoryPart{
            id   : 0x2::object::new(arg11),
            data : *0x2::dynamic_field::borrow<PartKey, 0x1::string::String>(&arg0.id, v10),
        };
        0x2::dynamic_object_field::add<0x1::string::String, FactoryPart>(&mut v4, v1, v14);
        let v15 = FactoryPart{
            id   : 0x2::object::new(arg11),
            data : *0x2::dynamic_field::borrow<PartKey, 0x1::string::String>(&arg0.id, v11),
        };
        0x2::dynamic_object_field::add<0x1::string::String, FactoryPart>(&mut v4, v2, v15);
        let v16 = FactoryPart{
            id   : 0x2::object::new(arg11),
            data : *0x2::dynamic_field::borrow<PartKey, 0x1::string::String>(&arg0.id, v12),
        };
        0x2::dynamic_object_field::add<0x1::string::String, FactoryPart>(&mut v4, v3, v16);
        Suibot{
            id       : v4,
            metadata : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v5, v7),
        }
    }

    public fun destroy(arg0: Suibot, arg1: &mut 0x2::tx_context::TxContext) {
        let Suibot {
            id       : v0,
            metadata : _,
        } = arg0;
        let v2 = v0;
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"head"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"body"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"legs"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"hands"));
        0x1::vector::reverse<0x1::string::String>(&mut v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&v3)) {
            let FactoryPart {
                id   : v6,
                data : _,
            } = 0x2::dynamic_object_field::remove<0x1::string::String, FactoryPart>(&mut v2, 0x1::vector::pop_back<0x1::string::String>(&mut v3));
            0x2::object::delete(v6);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v3);
        0x2::object::delete(v2);
    }

    public fun destroy_factory(arg0: Factory, arg1: FactoryManagerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let FactoryManagerCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let Factory {
            id      : v1,
            indexes : v2,
        } = arg0;
        let v3 = v1;
        let (v4, v5) = 0x2::vec_map::into_keys_values<0x1::string::String, u16>(v2);
        let v6 = v4;
        let v7 = v5;
        0x1::vector::reverse<u16>(&mut v7);
        assert!(0x1::vector::length<0x1::string::String>(&v6) == 0x1::vector::length<u16>(&v7), 13906834874423050239);
        0x1::vector::reverse<0x1::string::String>(&mut v6);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::string::String>(&v6)) {
            let v9 = 0;
            while (v9 < 0x1::vector::pop_back<u16>(&mut v7)) {
                let v10 = PartKey{
                    pos0 : 0x1::vector::pop_back<0x1::string::String>(&mut v6),
                    pos1 : v9,
                };
                0x2::dynamic_field::remove<PartKey, 0x1::string::String>(&mut v3, v10);
                v9 = v9 + 1;
            };
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v6);
        0x1::vector::destroy_empty<u16>(v7);
        0x2::object::delete(v3);
    }

    fun display_template() : 0x1::string::String {
        let v0 = b"";
        let v1 = vector[b"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>", b"<svg width=\"100\" height=\"100\" viewBox=\"0 0 100 100\" version=\"1.1\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns=\"http://www.w3.org/2000/svg\">", b"<style>", b"path { fill: none; fill-opacity: 1; stroke: #000; stroke-width: 1; stroke-linejoin: round; }", b".shadow { fill: #ffffff; fill-opacity: 0.5; stroke: none; }", b".shadow-stroke { stroke: #ffffff; stroke-opacity: 0.5; }", b".thin { stroke-width: 0.5; }", b".round { stroke-linecap: round; }", b".mid { stroke-width: 0.7; }", b".main { fill: #MAINCOLOR; }", b".secondary { fill: #SECONDARYCOLOR; }", b".eyes { fill: #EYESCOLOR; }", b".joint { fill: #JOINTCOLOR; }", b".accent { fill: #ACCENTCOLOR; }", b"</style>", b"</style>", b"<rect width=\"100\" height=\"100\" fill=\"#BACKCOLOR\" />", b"<g id=\"back-layer\">BACKINSERT</g>", b"<g id=\"suibot\">", b"HEADINSERT", b"BODYINSERT", b"LEGSINSERT", b"HANDSINSERT", b"</g>", b"<use xlink:href=\"#suibot\" transform=\"matrix(-1,0,0,1,99.8,0)\" />", b"<g id=\"front-layer\">FRONTINSERT</g>", b"</svg>"];
        0x1::vector::reverse<vector<u8>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v1)) {
            let v3 = v0;
            0x1::vector::append<u8>(&mut v3, 0x1::vector::pop_back<vector<u8>>(&mut v1));
            v0 = v3;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        let v4 = 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::urlencode::encode(v0);
        0x1::debug::print<0x1::string::String>(&v4);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"HEADINSERT"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"BODYINSERT"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"LEGSINSERT"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"HANDSINSERT"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{id=>['head'].data:url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{id=>['body'].data:url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{id=>['legs'].data:url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{id=>['hands'].data:url}"));
        let v9 = 0;
        while (v9 < 4) {
            let v10 = 0x1::string::index_of(&v4, 0x1::vector::borrow<0x1::string::String>(&v5, v9));
            assert!(v10 != 0x1::string::length(&v4), 13906835230905335807);
            let v11 = 0x1::string::substring(&v4, 0, v10);
            0x1::string::append(&mut v11, *0x1::vector::borrow<0x1::string::String>(&v7, v9));
            0x1::string::append(&mut v11, 0x1::string::substring(&v4, v10 + 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&v5, v9)), 0x1::string::length(&v4)));
            v4 = v11;
            v9 = v9 + 1;
        };
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"MAINCOLOR"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"SECONDARYCOLOR"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ACCENTCOLOR"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"EYESCOLOR"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"JOINTCOLOR"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"BACKCOLOR"));
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{metadata['main_color']}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{metadata['secondary_color']}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{metadata['accent_color']}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{metadata['eyes_color']}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{metadata['joint_color']}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{metadata['background_color']}"));
        let v16 = 0;
        while (v16 < 6) {
            let v17 = 0x1::string::index_of(&v4, 0x1::vector::borrow<0x1::string::String>(&v12, v16));
            assert!(v17 != 0x1::string::length(&v4), 13906835351164420095);
            let v18 = 0x1::string::substring(&v4, 0, v17);
            0x1::string::append(&mut v18, *0x1::vector::borrow<0x1::string::String>(&v14, v16));
            0x1::string::append(&mut v18, 0x1::string::substring(&v4, v17 + 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&v12, v16)), 0x1::string::length(&v4)));
            v4 = v18;
            v16 = v16 + 1;
        };
        let v19 = 0x1::string::utf8(b"data:image/svg+xml,");
        0x1::string::append(&mut v19, v4);
        v19
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"head"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"body"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"legs"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"hands"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"back"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"front"));
        let v2 = Factory{
            id      : 0x2::object::new(arg0),
            indexes : 0x2::vec_map::from_keys_values<0x1::string::String, u16>(v0, vector[0, 0, 0, 0, 0, 0]),
        };
        0x2::transfer::share_object<Factory>(v2);
        let v3 = FactoryManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::party_transfer<FactoryManagerCap>(v3, 0x2::party::single_owner(0x2::tx_context::sender(arg0)));
    }

    // decompiled from Move bytecode v6
}

