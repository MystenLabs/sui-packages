module 0x5638332744ff566bb40225318b348fd65e65747d56c724f7312d0e858d319ac1::mystemons {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Trait has store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct MystemonV2 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lore: 0x1::string::String,
        image_url: 0x1::string::String,
        elements: vector<0x1::string::String>,
        rarity: 0x1::string::String,
        species: 0x1::string::String,
        mutated: bool,
        attributes: vector<Trait>,
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
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<MYSTEMONS>(arg0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        let v3 = 0x2::display::new<MystemonV2>(&v1, arg1);
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Mystendex Test 1"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4120636f6c6c656374696f6e206f6620756e69717565204d797374c3a96d6f6e732067656e6572617465642066726f6d20757365722070726f66696c65732e"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"icon_url"), 0x1::string::utf8(b"https://aggregator.mainnet.walrus.mirai.cloud/v1/blobs/ScREaq6fZq71Rbw0ncMYcq-dBoSNhXcAP8I9vkh6zY4"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://teammysten.com"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Team Mysten"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{lore}"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"species"), 0x1::string::utf8(b"{species}"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"mutated"), 0x1::string::utf8(b"{mutated}"));
        0x2::display::add<MystemonV2>(&mut v3, 0x1::string::utf8(b"elements"), 0x1::string::utf8(b"{elements}"));
        0x2::display::update_version<MystemonV2>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<MystemonV2>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public entry fun mint_to_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: bool, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Trait>();
        let v1 = Trait{
            key   : 0x1::string::utf8(b"Rarity"),
            value : arg4,
        };
        0x1::vector::push_back<Trait>(&mut v0, v1);
        let v2 = Trait{
            key   : 0x1::string::utf8(b"Species"),
            value : arg5,
        };
        0x1::vector::push_back<Trait>(&mut v0, v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v4 = Trait{
                key   : 0x1::string::utf8(b"Element"),
                value : *0x1::vector::borrow<0x1::string::String>(&arg3, v3),
            };
            0x1::vector::push_back<Trait>(&mut v0, v4);
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg7)) {
            let v5 = Trait{
                key   : *0x1::vector::borrow<0x1::string::String>(&arg7, v3),
                value : *0x1::vector::borrow<0x1::string::String>(&arg8, v3),
            };
            0x1::vector::push_back<Trait>(&mut v0, v5);
            v3 = v3 + 1;
        };
        let v6 = MystemonV2{
            id         : 0x2::object::new(arg11),
            name       : arg0,
            lore       : arg1,
            image_url  : arg2,
            elements   : arg3,
            rarity     : arg4,
            species    : arg5,
            mutated    : arg6,
            attributes : v0,
        };
        0x2::kiosk::place<MystemonV2>(arg9, arg10, v6);
    }

    // decompiled from Move bytecode v6
}

