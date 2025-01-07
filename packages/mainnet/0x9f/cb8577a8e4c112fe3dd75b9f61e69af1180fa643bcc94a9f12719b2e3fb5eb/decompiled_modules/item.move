module 0x9fcb8577a8e4c112fe3dd75b9f61e69af1180fa643bcc94a9f12719b2e3fb5eb::item {
    struct ItemsGlobal has key {
        id: 0x2::object::UID,
        items: 0x2::vec_map::VecMap<0x1::string::String, Item>,
    }

    struct Item has copy, drop, store {
        name: 0x1::string::String,
        effect: 0x1::string::String,
        duration: 0x1::string::String,
        range: u8,
        effect_value: u64,
        cost: u8,
    }

    public fun apply_item_group(arg0: &mut vector<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>, arg1: &Item) {
        if (arg1.name == 0x1::string::utf8(b"red_potion")) {
            use_red_potion(arg0, arg1);
        } else if (arg1.name == 0x1::string::utf8(b"purple_potion")) {
            use_purple_potion(arg0, arg1);
        } else if (arg1.name == 0x1::string::utf8(b"whet_stone")) {
            use_whet_stone(arg0, arg1);
        } else if (arg1.name == 0x1::string::utf8(b"chicken_drumstick")) {
            use_chicken_drumstick(arg0, arg1);
        };
    }

    public fun apply_item_single(arg0: &mut 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role, arg1: &Item) {
        if (arg1.name == 0x1::string::utf8(b"rice_ball")) {
            use_rice_ball(arg0, arg1);
        } else if (arg1.name == 0x1::string::utf8(b"dragon_fruit")) {
            use_dragon_fruit(arg0, arg1);
        } else if (arg1.name == 0x1::string::utf8(b"boot")) {
            use_boot(arg0, arg1);
        } else if (arg1.name == 0x1::string::utf8(b"devil_fruit")) {
            use_devil_fruit(arg0);
        } else if (arg1.name == 0x1::string::utf8(b"magic_potion")) {
            use_magic_potion(arg0);
        };
    }

    public fun create_random_item(arg0: &ItemsGlobal, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0xfcb7d5a9a0977ec7baa77058e7984c98eaa1f703ddd0912946b6f7ef01a53ac0::utils::get_random_num(0, 10, arg1, arg2);
        get_random_item(arg0, v0, arg2)
    }

    public fun delete_item_global(arg0: ItemsGlobal) {
        let ItemsGlobal {
            id    : v0,
            items : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun generate_item_global(arg0: &mut 0x2::tx_context::TxContext) : ItemsGlobal {
        let v0 = ItemsGlobal{
            id    : 0x2::object::new(arg0),
            items : 0x2::vec_map::empty<0x1::string::String, Item>(),
        };
        let v1 = &mut v0;
        init_items(v1);
        v0
    }

    public fun generate_random_items(arg0: &ItemsGlobal, arg1: &mut 0x2::tx_context::TxContext) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 9;
        let v2 = 10;
        while (v1 > 0) {
            let v3 = v2 + 1;
            v2 = v3;
            0x1::vector::push_back<0x1::string::String>(&mut v0, create_random_item(arg0, v3, arg1));
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_item_by_name(arg0: &ItemsGlobal, arg1: &0x1::string::String) : Item {
        *0x2::vec_map::get<0x1::string::String, Item>(&arg0.items, arg1)
    }

    public fun get_item_price(arg0: &Item) : u8 {
        arg0.cost
    }

    public fun get_items_keys(arg0: &ItemsGlobal) : vector<0x1::string::String> {
        0x2::vec_map::keys<0x1::string::String, Item>(&arg0.items)
    }

    fun get_random_item(arg0: &ItemsGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let (v0, _) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Item>(&arg0.items, arg1 % 0x2::vec_map::size<0x1::string::String, Item>(&arg0.items));
        *v0
    }

    public fun init_items(arg0: &mut ItemsGlobal) {
        let v0 = Item{
            name         : 0x1::string::utf8(b"rice_ball"),
            effect       : 0x1::string::utf8(b"hp"),
            duration     : 0x1::string::utf8(b"permanent"),
            range        : 1,
            effect_value : 3,
            cost         : 2,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"rice_ball"), v0);
        let v1 = Item{
            name         : 0x1::string::utf8(b"dragon_fruit"),
            effect       : 0x1::string::utf8(b"attack"),
            duration     : 0x1::string::utf8(b"permanent"),
            range        : 1,
            effect_value : 3,
            cost         : 2,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"dragon_fruit"), v1);
        let v2 = Item{
            name         : 0x1::string::utf8(b"boot"),
            effect       : 0x1::string::utf8(b"speed"),
            duration     : 0x1::string::utf8(b"permanent"),
            range        : 1,
            effect_value : 2,
            cost         : 2,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"boot"), v2);
        let v3 = Item{
            name         : 0x1::string::utf8(b"devil_fruit"),
            effect       : 0x1::string::utf8(b"-hp+attack"),
            duration     : 0x1::string::utf8(b"permanent"),
            range        : 1,
            effect_value : 20,
            cost         : 2,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"devil_fruit"), v3);
        let v4 = Item{
            name         : 0x1::string::utf8(b"magic_potion"),
            effect       : 0x1::string::utf8(b"sp"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 1,
            effect_value : 10,
            cost         : 2,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"magic_potion"), v4);
        let v5 = Item{
            name         : 0x1::string::utf8(b"red_potion"),
            effect       : 0x1::string::utf8(b"hp"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 6,
            effect_value : 3,
            cost         : 3,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"red_potion"), v5);
        let v6 = Item{
            name         : 0x1::string::utf8(b"purple_potion"),
            effect       : 0x1::string::utf8(b"sp"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 6,
            effect_value : 1,
            cost         : 3,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"purple_potion"), v6);
        let v7 = Item{
            name         : 0x1::string::utf8(b"whet_stone"),
            effect       : 0x1::string::utf8(b"attack"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 6,
            effect_value : 2,
            cost         : 3,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"whet_stone"), v7);
        let v8 = Item{
            name         : 0x1::string::utf8(b"chicken_drumstick"),
            effect       : 0x1::string::utf8(b"speed"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 6,
            effect_value : 1,
            cost         : 3,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"chicken_drumstick"), v8);
        let v9 = Item{
            name         : 0x1::string::utf8(b"invisibility_cloak"),
            effect       : 0x1::string::utf8(b"other"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 1,
            effect_value : 0,
            cost         : 2,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"invisibility_cloak"), v9);
        let v10 = Item{
            name         : 0x1::string::utf8(b"chess"),
            effect       : 0x1::string::utf8(b"other"),
            duration     : 0x1::string::utf8(b"once"),
            range        : 1,
            effect_value : 0,
            cost         : 3,
        };
        0x2::vec_map::insert<0x1::string::String, Item>(&mut arg0.items, 0x1::string::utf8(b"chess"), v10);
    }

    public fun print_items_vec_map(arg0: &0x2::vec_map::VecMap<0x1::string::String, u8>) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, u8>(arg0);
        let v1 = 0x1::vector::length<0x1::string::String>(&v0);
        while (v1 > 0) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&v0, v1 - 1);
            0x1::debug::print<0x1::string::String>(v2);
            0x1::debug::print<u8>(0x2::vec_map::get<0x1::string::String, u8>(arg0, v2));
            v1 = v1 - 1;
        };
    }

    fun use_boot(arg0: &mut 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role, arg1: &Item) {
        0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_speed(arg0, arg1.effect_value);
    }

    fun use_chicken_drumstick(arg0: &mut vector<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>, arg1: &Item) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0)) {
            0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_speed(0x1::vector::borrow_mut<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0, v0), arg1.effect_value);
            v0 = v0 + 1;
        };
    }

    fun use_devil_fruit(arg0: &mut 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role) {
        0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_attack(arg0, 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::get_attack(arg0) * 20 / 100);
        0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::decrease_hp(arg0, 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::get_hp(arg0) * 20 / 100);
    }

    fun use_dragon_fruit(arg0: &mut 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role, arg1: &Item) {
        0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_attack(arg0, arg1.effect_value);
    }

    fun use_magic_potion(arg0: &mut 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role) {
        0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::set_sp(arg0, 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::get_sp_cap(arg0));
    }

    fun use_purple_potion(arg0: &mut vector<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>, arg1: &Item) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0)) {
            0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::set_sp(0x1::vector::borrow_mut<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0, v0), (arg1.effect_value as u8));
            v0 = v0 + 1;
        };
    }

    fun use_red_potion(arg0: &mut vector<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>, arg1: &Item) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0)) {
            0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_hp(0x1::vector::borrow_mut<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0, v0), arg1.effect_value);
            v0 = v0 + 1;
        };
    }

    fun use_rice_ball(arg0: &mut 0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role, arg1: &Item) {
        0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_hp(arg0, arg1.effect_value);
    }

    fun use_whet_stone(arg0: &mut vector<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>, arg1: &Item) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0)) {
            0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::increase_attack(0x1::vector::borrow_mut<0xaa13e45cddc2f18ca9e966d92b1c78953b3e0a745f383856f0550642c20373e0::role::Role>(arg0, v0), arg1.effect_value);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

