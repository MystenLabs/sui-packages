module 0x28bae0217055fe470efd268101fca41466f201caa696e6dfdfb27867d32f2f9a::item {
    struct Damage has store {
        from: u16,
        to: u16,
        type: 0x1::string::String,
        element: 0x1::string::String,
    }

    struct Statistics has store {
        vitality: u16,
        wisdom: u16,
        strength: u16,
        intelligence: u16,
        chance: u16,
        agility: u16,
        range: u8,
        movement: u8,
        action: u8,
        critical: u8,
        critical_chance: u8,
        critical_outcomes: u8,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: 0x1::string::String,
        level: u8,
        damage: vector<Damage>,
        stats: 0x1::option::Option<Statistics>,
    }

    struct ItemMintCap has key {
        id: 0x2::object::UID,
    }

    struct ITEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aresrpg.world/item/{type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aresrpg.world/item/{type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Item part of the AresRPG universe."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aresrpg.world"));
        let v4 = 0x2::package::claim<ITEM>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Item>(&v4, v0, v2, arg1);
        0x2::display::update_version<Item>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ItemMintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ItemMintCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &ItemMintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: vector<Damage>, arg5: 0x1::option::Option<Statistics>, arg6: &mut 0x2::tx_context::TxContext) : Item {
        Item{
            id     : 0x2::object::new(arg6),
            name   : arg1,
            type   : arg2,
            level  : arg3,
            damage : arg4,
            stats  : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

