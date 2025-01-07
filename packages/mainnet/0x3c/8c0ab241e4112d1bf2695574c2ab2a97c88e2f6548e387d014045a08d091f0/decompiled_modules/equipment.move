module 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment {
    struct EQUIPMENT has drop {
        dummy_field: bool,
    }

    struct Sword has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        attack: u64,
        creater: address,
    }

    struct EquipmentList has store, key {
        id: 0x2::object::UID,
        equipment: 0x2::table::Table<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>,
    }

    public fun create_ep(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Sword {
        Sword{
            id      : 0x2::object::new(arg2),
            name    : arg0,
            attack  : 3,
            creater : arg1,
        }
    }

    fun init(arg0: EQUIPMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://oss-of-ch1hiro.oss-cn-beijing.aliyuncs.com/imgs/202412082132939.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creater}"));
        let v4 = 0x2::package::claim<EQUIPMENT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Sword>(&v4, v0, v2, arg1);
        0x2::display::update_version<Sword>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Sword>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun return_name(arg0: &mut Sword) : 0x1::string::String {
        arg0.name
    }

    public fun return_property(arg0: &mut Sword) : u64 {
        arg0.attack
    }

    // decompiled from Move bytecode v6
}

