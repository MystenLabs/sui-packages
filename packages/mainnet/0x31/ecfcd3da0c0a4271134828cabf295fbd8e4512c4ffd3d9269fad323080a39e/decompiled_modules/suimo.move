module 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::suimo {
    struct SuimoHub has key {
        id: 0x2::object::UID,
        suimo_burned: u64,
    }

    struct Suimo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        url: 0x2::url::Url,
        link: 0x2::url::Url,
        lvl: u64,
        health: u64,
        strength: u64,
        dexterity: u64,
        intellect: u64,
        stamina: u64,
        protection: u64,
        hat: 0x1::option::Option<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>,
        weapon: 0x1::option::Option<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>,
        armor: 0x1::option::Option<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>,
        accessory: 0x1::option::Option<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>,
        boots: 0x1::option::Option<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>,
        mystery: 0x1::option::Option<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>,
    }

    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun delete(arg0: Suimo) {
        let Suimo {
            id         : v0,
            name       : _,
            rarity     : _,
            url        : _,
            link       : _,
            lvl        : _,
            health     : _,
            strength   : _,
            dexterity  : _,
            intellect  : _,
            stamina    : _,
            protection : _,
            hat        : v12,
            weapon     : v13,
            armor      : v14,
            accessory  : v15,
            boots      : v16,
            mystery    : v17,
        } = arg0;
        0x1::option::destroy_none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v13);
        0x1::option::destroy_none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v14);
        0x1::option::destroy_none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v15);
        0x1::option::destroy_none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v16);
        0x1::option::destroy_none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v12);
        0x1::option::destroy_none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v17);
        0x2::object::delete(v0);
    }

    fun based_on_rariry_get_image(arg0: 0x1::string::String) : 0x2::url::Url {
        0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::check_rarity(arg0);
        if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::common_rarity_key()) {
            0x2::url::new_unsafe_from_bytes(b"ipfs://Qmb5zBNnWxFRw7Y133fZ4YSMiEB56kwtfxsYsTA8zcfkF3/common.png")
        } else if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rare_rarity_key()) {
            0x2::url::new_unsafe_from_bytes(b"ipfs://Qmb5zBNnWxFRw7Y133fZ4YSMiEB56kwtfxsYsTA8zcfkF3/rare.png")
        } else if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::epic_rarity_key()) {
            0x2::url::new_unsafe_from_bytes(b"ipfs://Qmb5zBNnWxFRw7Y133fZ4YSMiEB56kwtfxsYsTA8zcfkF3/epic.png")
        } else if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::legendary_rarity_key()) {
            0x2::url::new_unsafe_from_bytes(b"ipfs://Qmb5zBNnWxFRw7Y133fZ4YSMiEB56kwtfxsYsTA8zcfkF3/legendary.png")
        } else {
            0x2::url::new_unsafe_from_bytes(b"ipfs://Qmb5zBNnWxFRw7Y133fZ4YSMiEB56kwtfxsYsTA8zcfkF3/common.png")
        }
    }

    fun based_on_rariry_get_stats(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::common_rarity_key()) {
            0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rand_u64_in_range(1, 3, arg1)
        } else if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rare_rarity_key()) {
            0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rand_u64_in_range(2, 4, arg1)
        } else if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::epic_rarity_key()) {
            0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rand_u64_in_range(3, 5, arg1)
        } else if (arg0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::legendary_rarity_key()) {
            0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rand_u64_in_range(4, 6, arg1)
        } else {
            0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::rand_u64_in_range(1, 3, arg1)
        }
    }

    public(friend) fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Suimo {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::calclulate_rarity(arg1);
        let v2 = based_on_rariry_get_stats(v1, arg1);
        let v3 = based_on_rariry_get_stats(v1, arg1);
        let v4 = based_on_rariry_get_stats(v1, arg1);
        let v5 = based_on_rariry_get_stats(v1, arg1);
        let v6 = based_on_rariry_get_stats(v1, arg1);
        Suimo{
            id         : v0,
            name       : name_count(arg0),
            rarity     : v1,
            url        : based_on_rariry_get_image(v1),
            link       : image_url(arg0),
            lvl        : 1,
            health     : v2,
            strength   : v3,
            dexterity  : v4,
            intellect  : v5,
            stamina    : v6,
            protection : based_on_rariry_get_stats(v1, arg1),
            hat        : 0x1::option::none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(),
            weapon     : 0x1::option::none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(),
            armor      : 0x1::option::none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(),
            accessory  : 0x1::option::none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(),
            boots      : 0x1::option::none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(),
            mystery    : 0x1::option::none<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(),
        }
    }

    public entry fun equip_item(arg0: &mut Suimo, arg1: 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::type(&arg1);
        0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::check_type(v0);
        if (v0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::weapon_type_key()) {
            0x1::option::fill<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.weapon, arg1);
            arg0.health = arg0.health + 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&arg1);
        } else if (v0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::armor_type_key()) {
            0x1::option::fill<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.armor, arg1);
            arg0.strength = arg0.strength + 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&arg1);
        } else if (v0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::accessory_type_key()) {
            0x1::option::fill<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.accessory, arg1);
            arg0.dexterity = arg0.dexterity + 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&arg1);
        } else if (v0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::boots_type_key()) {
            0x1::option::fill<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.boots, arg1);
            arg0.intellect = arg0.intellect + 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&arg1);
        } else if (v0 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::hat_type_key()) {
            0x1::option::fill<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.hat, arg1);
            arg0.stamina = arg0.stamina + 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&arg1);
        } else {
            0x1::option::fill<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.mystery, arg1);
            arg0.protection = arg0.protection + 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&arg1);
        };
    }

    fun image_url(arg0: u64) : 0x2::url::Url {
        let v0 = 0x1::string::utf8(b"ipfs://QmaoxQVVxUPjN6rGwjn7cBmmV4F9PvNdh7GSXVAZfmtGkC/");
        0x1::string::append(&mut v0, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::u64_to_string(arg0));
        0x2::url::new_unsafe(0x1::string::to_ascii(v0))
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIMO>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suimo.xyz/"));
        let v5 = 0x2::display::new_with_fields<Suimo>(&v0, v1, v3, arg1);
        0x2::display::update_version<Suimo>(&mut v5);
        let v6 = SuimoHub{
            id           : 0x2::object::new(arg1),
            suimo_burned : 0,
        };
        0x2::transfer::public_transfer<0x2::display::Display<Suimo>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<SuimoHub>(v6);
    }

    fun link_url(arg0: u64) : 0x2::url::Url {
        let v0 = 0x1::string::utf8(b"https://app.suimo.xyz/metadata");
        0x1::string::append(&mut v0, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::u64_to_string(arg0));
        0x2::url::new_unsafe(0x1::string::to_ascii(v0))
    }

    public entry fun merge(arg0: &mut Suimo, arg1: Suimo, arg2: &mut SuimoHub) {
        assert!(&arg0.id != &arg1.id, 2);
        assert!(arg0.lvl + 1 <= 30, 3);
        arg0.health = arg0.health + arg1.health;
        arg0.strength = arg0.strength + arg1.strength;
        arg0.dexterity = arg0.dexterity + arg1.dexterity;
        arg0.intellect = arg0.intellect + arg1.intellect;
        arg0.stamina = arg0.stamina + arg1.stamina;
        arg0.protection = arg0.protection + arg1.protection;
        arg0.lvl = arg0.lvl + arg1.lvl;
        arg2.suimo_burned = arg2.suimo_burned + 1;
        delete(arg1);
    }

    fun name_count(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"SuiMO #");
        0x1::string::append(&mut v0, 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::u64_to_string(arg0));
        v0
    }

    public entry fun remove_item(arg0: &mut Suimo, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::check_type(arg1);
        let v0 = if (arg1 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::weapon_type_key()) {
            let v0 = 0x1::option::extract<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.weapon);
            arg0.health = arg0.health - 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&v0);
            v0
        } else if (arg1 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::armor_type_key()) {
            let v0 = 0x1::option::extract<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.armor);
            arg0.strength = arg0.strength - 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&v0);
            v0
        } else if (arg1 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::accessory_type_key()) {
            let v0 = 0x1::option::extract<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.accessory);
            arg0.dexterity = arg0.dexterity - 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&v0);
            v0
        } else if (arg1 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::boots_type_key()) {
            let v0 = 0x1::option::extract<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.boots);
            arg0.intellect = arg0.intellect - 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&v0);
            v0
        } else if (arg1 == 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::hat_type_key()) {
            let v0 = 0x1::option::extract<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.hat);
            arg0.stamina = arg0.stamina - 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&v0);
            v0
        } else {
            let v0 = 0x1::option::extract<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(&mut arg0.mystery);
            arg0.protection = arg0.protection - 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::xp(&v0);
            v0
        };
        0x2::transfer::public_transfer<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

