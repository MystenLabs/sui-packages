module 0x60e5668be430c4fc36114291c6bc5e32ef366bbf97da584eb4e04adb49c4aeef::mystemon {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mystemon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lore: 0x1::string::String,
        image_url: 0x1::string::String,
        elements: vector<0x1::string::String>,
        species: 0x1::string::String,
        rarity: 0x1::string::String,
        mutated: bool,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        discoverer: 0x1::string::String,
        attack: u64,
        defense: u64,
        stamina: u64,
        speed: u64,
        intelligence: u64,
        charisma: u64,
    }

    struct MYSTEMON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &AdminCap, arg1: Mystemon) {
        let Mystemon {
            id           : v0,
            name         : _,
            lore         : _,
            image_url    : _,
            elements     : _,
            species      : _,
            rarity       : _,
            mutated      : _,
            attributes   : _,
            discoverer   : _,
            attack       : _,
            defense      : _,
            stamina      : _,
            speed        : _,
            intelligence : _,
            charisma     : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun burn_from_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        burn(arg0, 0x2::kiosk::take<Mystemon>(arg1, arg2, arg3));
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: MYSTEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<MYSTEMON>(arg0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        let v3 = 0x2::display::new<Mystemon>(&v1, arg1);
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Mystemon"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"A collection of unique Mystemons generated from user profiles."));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"icon_url"), 0x1::string::utf8(b"https://aggregator.mainnet.walrus.mirai.cloud/v1/blobs/ScREaq6fZq71Rbw0ncMYcq-dBoSNhXcAP8I9vkh6zY4"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://teammysten.com"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Mystemon"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{lore}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"species"), 0x1::string::utf8(b"{species}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"mutated"), 0x1::string::utf8(b"{mutated}"));
        0x2::display::add<Mystemon>(&mut v3, 0x1::string::utf8(b"elements"), 0x1::string::utf8(b"{elements}"));
        0x2::display::update_version<Mystemon>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<Mystemon>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public entry fun mint_and_transfer(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: address, arg18: &mut 0x2::tx_context::TxContext) {
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
        let v3 = Mystemon{
            id           : 0x2::object::new(arg18),
            name         : arg1,
            lore         : arg2,
            image_url    : arg3,
            elements     : arg4,
            species      : arg5,
            rarity       : arg6,
            mutated      : arg7,
            attributes   : v0,
            discoverer   : arg10,
            attack       : arg11,
            defense      : arg12,
            stamina      : arg13,
            speed        : arg14,
            intelligence : arg15,
            charisma     : arg16,
        };
        0x2::transfer::public_transfer<Mystemon>(v3, arg17);
    }

    public entry fun mint_to_kiosk(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::kiosk::Kiosk, arg18: &0x2::kiosk::KioskOwnerCap, arg19: &mut 0x2::tx_context::TxContext) {
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
        let v3 = Mystemon{
            id           : 0x2::object::new(arg19),
            name         : arg1,
            lore         : arg2,
            image_url    : arg3,
            elements     : arg4,
            species      : arg5,
            rarity       : arg6,
            mutated      : arg7,
            attributes   : v0,
            discoverer   : arg10,
            attack       : arg11,
            defense      : arg12,
            stamina      : arg13,
            speed        : arg14,
            intelligence : arg15,
            charisma     : arg16,
        };
        0x2::kiosk::place<Mystemon>(arg17, arg18, v3);
    }

    public fun update_attribute(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, arg2, arg3);
    }

    public entry fun update_attribute_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        update_attribute(arg0, arg1, arg2, arg3);
    }

    public entry fun update_attribute_in_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow_mut<Mystemon>(arg1, arg2, arg3);
        update_attribute(arg0, v0, arg4, arg5);
    }

    public entry fun update_elements_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: vector<0x1::string::String>) {
        arg1.elements = arg2;
    }

    public fun update_image_url(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        arg1.image_url = arg2;
    }

    public entry fun update_image_url_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        update_image_url(arg0, arg1, arg2);
    }

    public entry fun update_image_url_in_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow_mut<Mystemon>(arg1, arg2, arg3);
        update_image_url(arg0, v0, arg4);
    }

    public fun update_lore(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        arg1.lore = arg2;
    }

    public entry fun update_lore_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        update_lore(arg0, arg1, arg2);
    }

    public entry fun update_lore_in_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow_mut<Mystemon>(arg1, arg2, arg3);
        update_lore(arg0, v0, arg4);
    }

    public entry fun update_metadata_batch(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        arg1.name = arg2;
        arg1.lore = arg3;
        arg1.image_url = arg4;
        arg1.species = arg5;
        arg1.rarity = arg6;
    }

    public entry fun update_name_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public entry fun update_rarity_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        arg1.rarity = arg2;
    }

    public entry fun update_species_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: 0x1::string::String) {
        arg1.species = arg2;
    }

    public entry fun update_stats_entry(arg0: &AdminCap, arg1: &mut Mystemon, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg1.attack = arg2;
        arg1.defense = arg3;
        arg1.stamina = arg4;
        arg1.speed = arg5;
        arg1.intelligence = arg6;
        arg1.charisma = arg7;
    }

    // decompiled from Move bytecode v6
}

