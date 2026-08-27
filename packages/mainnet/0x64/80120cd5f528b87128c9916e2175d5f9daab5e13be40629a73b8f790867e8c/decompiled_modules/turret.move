module 0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret {
    struct Turret has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        power: u8,
        range: u8,
        armour: u8,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct WeaponSlot has copy, drop, store {
        dummy_field: bool,
    }

    struct WeaponEquipped has copy, drop {
        turret_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
    }

    struct WeaponUnequipped has copy, drop {
        turret_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
    }

    struct TURRET has drop {
        dummy_field: bool,
    }

    public fun armour(arg0: &Turret) : u8 {
        arg0.armour
    }

    public fun attributes(arg0: &Turret) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun equip_weapon<T0: store + key>(arg0: &mut Turret, arg1: T0) {
        let v0 = WeaponSlot{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<WeaponSlot>(&arg0.id, v0), 1);
        let v1 = WeaponEquipped{
            turret_id : 0x2::object::id<Turret>(arg0),
            item_id   : 0x2::object::id<T0>(&arg1),
            item_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WeaponEquipped>(v1);
        let v2 = WeaponSlot{dummy_field: false};
        0x2::dynamic_object_field::add<WeaponSlot, T0>(&mut arg0.id, v2, arg1);
    }

    public fun has_weapon(arg0: &Turret) : bool {
        let v0 = WeaponSlot{dummy_field: false};
        0x2::dynamic_object_field::exists<WeaponSlot>(&arg0.id, v0)
    }

    fun init(arg0: TURRET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TURRET>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Turrets"));
        let v5 = 0x2::display::new_with_fields<Turret>(&v0, v1, v3, arg1);
        0x2::display::update_version<Turret>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Turret>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Turret>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Turret>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Turret>>(v7, v8);
    }

    public fun media_url(arg0: &Turret) : 0x1::string::String {
        arg0.media_url
    }

    public(friend) fun mint(arg0: u8, arg1: u8, arg2: u8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) : Turret {
        Turret{
            id          : 0x2::object::new(arg8),
            name        : arg4,
            description : arg5,
            media_url   : arg6,
            power       : arg0,
            range       : arg1,
            armour      : arg2,
            serial      : arg3,
            attributes  : arg7,
        }
    }

    public fun name(arg0: &Turret) : 0x1::string::String {
        arg0.name
    }

    public fun power(arg0: &Turret) : u8 {
        arg0.power
    }

    public fun range(arg0: &Turret) : u8 {
        arg0.range
    }

    public fun serial(arg0: &Turret) : u64 {
        arg0.serial
    }

    public fun unequip_weapon<T0: store + key>(arg0: &mut Turret) : T0 {
        let v0 = WeaponSlot{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<WeaponSlot>(&arg0.id, v0), 2);
        let v1 = WeaponSlot{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<WeaponSlot, T0>(&mut arg0.id, v1);
        let v3 = WeaponUnequipped{
            turret_id : 0x2::object::id<Turret>(arg0),
            item_id   : 0x2::object::id<T0>(&v2),
            item_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WeaponUnequipped>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

