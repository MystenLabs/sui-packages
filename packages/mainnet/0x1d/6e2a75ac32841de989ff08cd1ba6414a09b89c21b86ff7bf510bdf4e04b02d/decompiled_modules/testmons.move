module 0x1d6e2a75ac32841de989ff08cd1ba6414a09b89c21b86ff7bf510bdf4e04b02d::testmons {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TestmonV2 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lore: 0x1::string::String,
        image_url: 0x1::string::String,
        elements: vector<0x1::string::String>,
        species: 0x1::string::String,
        rarity: 0x1::string::String,
        mutated: bool,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct TESTMONS has drop {
        dummy_field: bool,
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: TESTMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<TESTMONS>(arg0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        let v3 = 0x2::display::new<TestmonV2>(&v1, arg1);
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Test Dex1"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"A collection of unique Testmons generated from user profiles."));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"icon_url"), 0x1::string::utf8(b"https://aggregator.mainnet.walrus.mirai.cloud/v1/blobs/ScREaq6fZq71Rbw0ncMYcq-dBoSNhXcAP8I9vkh6zY4"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://teammysten.com"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Team Mysten"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{lore}"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"species"), 0x1::string::utf8(b"{species}"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"mutated"), 0x1::string::utf8(b"{mutated}"));
        0x2::display::add<TestmonV2>(&mut v3, 0x1::string::utf8(b"elements"), 0x1::string::utf8(b"{elements}"));
        0x2::display::update_version<TestmonV2>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<TestmonV2>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public entry fun mint_and_transfer(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = if (!0x1::vector::is_empty<0x1::string::String>(&arg4)) {
            *0x1::vector::borrow<0x1::string::String>(&arg4, 0)
        } else {
            0x1::string::utf8(b"Unknown")
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), arg6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Species"), arg5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Element"), v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg8)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg8, v2), *0x1::vector::borrow<0x1::string::String>(&arg9, v2));
            v2 = v2 + 1;
        };
        let v3 = TestmonV2{
            id         : 0x2::object::new(arg11),
            name       : arg1,
            lore       : arg2,
            image_url  : arg3,
            elements   : arg4,
            species    : arg5,
            rarity     : arg6,
            mutated    : arg7,
            attributes : v0,
        };
        0x2::transfer::public_transfer<TestmonV2>(v3, arg10);
    }

    public entry fun mint_to_kiosk(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = if (!0x1::vector::is_empty<0x1::string::String>(&arg4)) {
            *0x1::vector::borrow<0x1::string::String>(&arg4, 0)
        } else {
            0x1::string::utf8(b"Unknown")
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), arg6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Species"), arg5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Element"), v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg8)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg8, v2), *0x1::vector::borrow<0x1::string::String>(&arg9, v2));
            v2 = v2 + 1;
        };
        let v3 = TestmonV2{
            id         : 0x2::object::new(arg12),
            name       : arg1,
            lore       : arg2,
            image_url  : arg3,
            elements   : arg4,
            species    : arg5,
            rarity     : arg6,
            mutated    : arg7,
            attributes : v0,
        };
        0x2::kiosk::place<TestmonV2>(arg10, arg11, v3);
    }

    public fun update_attribute(arg0: &AdminCap, arg1: &mut TestmonV2, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, arg2, arg3);
    }

    public entry fun update_attribute_in_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow_mut<TestmonV2>(arg1, arg2, arg3);
        update_attribute(arg0, v0, arg4, arg5);
    }

    public fun update_image_url(arg0: &AdminCap, arg1: &mut TestmonV2, arg2: 0x1::string::String) {
        arg1.image_url = arg2;
    }

    public entry fun update_image_url_in_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow_mut<TestmonV2>(arg1, arg2, arg3);
        update_image_url(arg0, v0, arg4);
    }

    public fun update_lore(arg0: &AdminCap, arg1: &mut TestmonV2, arg2: 0x1::string::String) {
        arg1.lore = arg2;
    }

    public entry fun update_lore_in_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow_mut<TestmonV2>(arg1, arg2, arg3);
        update_lore(arg0, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

