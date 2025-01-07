module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character {
    struct Character has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        classe: 0x1::string::String,
        sex: 0x1::string::String,
        position: 0x1::string::String,
        experience: u32,
        health: u16,
        selected: bool,
        soul: u8,
        inventory: 0x2::object_bag::ObjectBag,
    }

    struct KioskIdKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CHARACTER has drop {
        dummy_field: bool,
    }

    public(friend) fun delete(arg0: Character, arg1: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_registry::NameRegistry) {
        let Character {
            id         : v0,
            name       : v1,
            classe     : _,
            sex        : _,
            position   : _,
            experience : _,
            health     : _,
            selected   : _,
            soul       : _,
            inventory  : v9,
        } = arg0;
        let v10 = v9;
        assert!(0x2::object_bag::is_empty(&v10), 4);
        0x2::object_bag::destroy_empty(v10);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_registry::remove_name(arg1, v1);
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_registry::NameRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Character {
        assert!(valid_classe(arg2), 2);
        assert!(valid_sex(arg3), 3);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::string::to_lower_case(arg1);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_registry::add_name(arg0, v0, arg4);
        Character{
            id         : 0x2::object::new(arg4),
            name       : v0,
            classe     : arg2,
            sex        : arg3,
            position   : 0x1::string::utf8(b"{\"x\":0,\"y\":0,\"z\":0}"),
            experience : 0,
            health     : 30,
            selected   : false,
            soul       : 100,
            inventory  : 0x2::object_bag::new(arg4),
        }
    }

    public(friend) fun add_field<T0: copy + drop + store, T1: store>(arg0: &mut Character, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun admin_set_experience(arg0: &mut Character, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg1, arg3);
        assert!(arg2 > arg0.experience, 5);
        arg0.experience = arg2;
    }

    public fun admin_set_health(arg0: &mut Character, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg1, arg3);
        arg0.health = arg2;
    }

    public fun admin_set_position(arg0: &mut Character, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg1, arg3);
        arg0.position = arg2;
    }

    public fun admin_set_soul(arg0: &mut Character, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg1, arg3);
        arg0.soul = arg2;
    }

    public(friend) fun borrow_field_mut<T0: copy + drop + store, T1: store>(arg0: &mut Character, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun borrow_inventory(arg0: &Character) : &0x2::object_bag::ObjectBag {
        &arg0.inventory
    }

    public(friend) fun borrow_inventory_mut(arg0: &mut Character) : &mut 0x2::object_bag::ObjectBag {
        &mut arg0.inventory
    }

    public(friend) fun has_field<T0: copy + drop + store>(arg0: &Character, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    fun init(arg0: CHARACTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.aresrpg.world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.aresrpg.world/classe/{classe}_{sex}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Character part of the AresRPG universe."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aresrpg.world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AresRPG"));
        let v4 = 0x2::package::claim<CHARACTER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Character>(&v4, v0, v2, arg1);
        0x2::display::update_version<Character>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Character>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun remove_kiosk_id(arg0: &mut Character) {
        let v0 = KioskIdKey{dummy_field: false};
        0x2::dynamic_field::remove<KioskIdKey, 0x2::object::ID>(&mut arg0.id, v0);
    }

    public(friend) fun set_kiosk_id(arg0: &mut Character, arg1: 0x2::object::ID) {
        let v0 = KioskIdKey{dummy_field: false};
        0x2::dynamic_field::add<KioskIdKey, 0x2::object::ID>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun set_selected(arg0: &mut Character, arg1: bool) {
        arg0.selected = arg1;
    }

    fun valid_classe(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sram"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"iop"));
        0x1::vector::contains<0x1::string::String>(&v0, &arg0)
    }

    fun valid_sex(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"male"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"female"));
        0x1::vector::contains<0x1::string::String>(&v0, &arg0)
    }

    // decompiled from Move bytecode v6
}

