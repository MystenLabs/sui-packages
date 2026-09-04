module 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon {
    struct Weapon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        kind: u8,
        rarity: u8,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct WEAPON has drop {
        dummy_field: bool,
    }

    public fun attributes(arg0: &Weapon) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public(friend) fun burn(arg0: Weapon) {
        let Weapon {
            id          : v0,
            name        : _,
            description : _,
            media_url   : _,
            kind        : _,
            rarity      : _,
            serial      : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: WEAPON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WEAPON>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_name"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://boombotsai.wal.app/#armory"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://boombotsai.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots AI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Armory"));
        let v5 = 0x2::display::new_with_fields<Weapon>(&v0, v1, v3, arg1);
        0x2::display::update_version<Weapon>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Weapon>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Weapon>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Weapon>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Weapon>>(v7, v8);
    }

    public fun kind(arg0: &Weapon) : u8 {
        arg0.kind
    }

    public fun level(arg0: &Weapon) : u8 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"lvl")) {
            *0x2::dynamic_field::borrow<vector<u8>, u8>(&arg0.id, b"lvl")
        } else {
            1
        }
    }

    fun level_label(arg0: u8) : vector<u8> {
        if (arg0 == 2) {
            b"2"
        } else if (arg0 == 3) {
            b"3"
        } else if (arg0 == 4) {
            b"4"
        } else if (arg0 == 5) {
            b"5"
        } else {
            b"1"
        }
    }

    public fun media_url(arg0: &Weapon) : 0x1::string::String {
        arg0.media_url
    }

    public(friend) fun mint(arg0: u8, arg1: u8, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : Weapon {
        Weapon{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            description : arg4,
            media_url   : arg5,
            kind        : arg0,
            rarity      : arg1,
            serial      : arg2,
            attributes  : arg6,
        }
    }

    public fun name(arg0: &Weapon) : 0x1::string::String {
        arg0.name
    }

    public fun rarity(arg0: &Weapon) : u8 {
        arg0.rarity
    }

    public fun serial(arg0: &Weapon) : u64 {
        arg0.serial
    }

    public(friend) fun set_level(arg0: &mut Weapon, arg1: u8) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"lvl")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u8>(&mut arg0.id, b"lvl") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u8>(&mut arg0.id, b"lvl", arg1);
        };
        let v0 = 0x1::string::utf8(b"LEVEL");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = 0x1::string::utf8(level_label(arg1));
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, 0x1::string::utf8(level_label(arg1)));
        };
    }

    public(friend) fun set_units(arg0: &mut Weapon, arg1: u64) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"units")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"units") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"units", arg1);
        };
    }

    public fun units(arg0: &Weapon) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"units")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"units")
        } else {
            let v1 = (level(arg0) as u64);
            v1 * (v1 + 1) / 2
        }
    }

    // decompiled from Move bytecode v7
}

