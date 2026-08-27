module 0x371253218a55dcf007386d29b3424b3a3e60ec2ae8ba0e8faa6438e44272777a::charter {
    struct Charter has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        serial: u64,
    }

    struct CommandSlot has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        claimed: 0x2::table::Table<address, bool>,
        media_base: 0x1::string::String,
        claimed_count: u64,
        unit_types: vector<0x1::ascii::String>,
    }

    struct CharterClaimed has copy, drop {
        owner: address,
        charter_id: 0x2::object::ID,
        serial: u64,
    }

    struct CommanderEquipped has copy, drop {
        charter_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
    }

    struct CommanderUnequipped has copy, drop {
        charter_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
    }

    struct CHARTER has drop {
        dummy_field: bool,
    }

    public fun allow_unit_type(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x1::ascii::String) {
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.unit_types, arg2);
    }

    public fun claim_with_kiosk_unit<T0: store + key>(arg0: &mut Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg1, arg2), 5);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg3), 6);
        let v0 = 0x1::type_name::get<T0>();
        assert!(is_unit_type(arg0, &v0), 4);
        do_claim(arg0, arg4);
    }

    entry fun claim_with_unit<T0: key>(arg0: &mut Registry, arg1: &T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(is_unit_type(arg0, &v0), 4);
        do_claim(arg0, arg2);
    }

    public fun claimed_count(arg0: &Registry) : u64 {
        arg0.claimed_count
    }

    public fun disallow_unit_type(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x1::ascii::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg1.unit_types)) {
            if (0x1::vector::borrow<0x1::ascii::String>(&arg1.unit_types, v0) == &arg2) {
                0x1::vector::swap_remove<0x1::ascii::String>(&mut arg1.unit_types, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun do_claim(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 1);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.claimed_count = arg0.claimed_count + 1;
        let v1 = arg0.claimed_count;
        let v2 = 0x1::string::utf8(b"Base #");
        0x1::string::append(&mut v2, 0x1::u64::to_string(v1));
        let v3 = arg0.media_base;
        0x1::string::append(&mut v3, 0x1::string::utf8(b"base.png"));
        let v4 = Charter{
            id          : 0x2::object::new(arg1),
            name        : v2,
            description : 0x1::string::utf8(x"4120736f756c626f756e642042617365204e465420e2809420796f75722067726f756e6420696e20746865205761737465732e20546865206c616e6420697320796f75727320666f726576657220616e642063616e6e6f7420626520736f6c643b207768617420796f75206275696c64206f6e20697420697320616e6f74686572206d61747465722e"),
            media_url   : v3,
            serial      : v1,
        };
        let v5 = CharterClaimed{
            owner      : v0,
            charter_id : 0x2::object::id<Charter>(&v4),
            serial     : v1,
        };
        0x2::event::emit<CharterClaimed>(v5);
        0x2::transfer::transfer<Charter>(v4, v0);
    }

    public fun equip_commander<T0: store + key>(arg0: &mut Charter, arg1: T0) {
        let v0 = CommandSlot{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<CommandSlot>(&arg0.id, v0), 2);
        let v1 = CommanderEquipped{
            charter_id : 0x2::object::id<Charter>(arg0),
            item_id    : 0x2::object::id<T0>(&arg1),
            item_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CommanderEquipped>(v1);
        let v2 = CommandSlot{dummy_field: false};
        0x2::dynamic_object_field::add<CommandSlot, T0>(&mut arg0.id, v2, arg1);
    }

    public fun has_claimed(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun has_commander(arg0: &Charter) : bool {
        let v0 = CommandSlot{dummy_field: false};
        0x2::dynamic_object_field::exists<CommandSlot>(&arg0.id, v0)
    }

    fun init(arg0: CHARTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHARTER>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://boombotsai.wal.app/#wastes"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://boombotsai.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots AI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Bases"));
        let v5 = 0x2::display::new_with_fields<Charter>(&v0, v1, v3, arg1);
        0x2::display::update_version<Charter>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<Charter>>(v5, v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v6);
        let v8 = Registry{
            id            : 0x2::object::new(arg1),
            claimed       : 0x2::table::new<address, bool>(arg1),
            media_base    : 0x1::string::utf8(b""),
            claimed_count : 0,
            unit_types    : 0x1::vector::empty<0x1::ascii::String>(),
        };
        0x2::transfer::share_object<Registry>(v8);
    }

    fun is_unit_type(arg0: &Registry, arg1: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::borrow_string(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0.unit_types)) {
            if (0x1::vector::borrow<0x1::ascii::String>(&arg0.unit_types, v1) == v0) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun name(arg0: &Charter) : 0x1::string::String {
        arg0.name
    }

    public fun serial(arg0: &Charter) : u64 {
        arg0.serial
    }

    public fun set_media_base(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x1::string::String) {
        arg1.media_base = arg2;
    }

    public fun unequip_commander<T0: store + key>(arg0: &mut Charter) : T0 {
        let v0 = CommandSlot{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<CommandSlot>(&arg0.id, v0), 3);
        let v1 = CommandSlot{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<CommandSlot, T0>(&mut arg0.id, v1);
        let v3 = CommanderUnequipped{
            charter_id : 0x2::object::id<Charter>(arg0),
            item_id    : 0x2::object::id<T0>(&v2),
            item_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CommanderUnequipped>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

