module 0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck {
    struct RepairTruck has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        armour: u8,
        speed: u8,
        rig: u8,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct REPAIR_TRUCK has drop {
        dummy_field: bool,
    }

    public fun armour(arg0: &RepairTruck) : u8 {
        arg0.armour
    }

    public fun attributes(arg0: &RepairTruck) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun init(arg0: REPAIR_TRUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<REPAIR_TRUCK>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Repair Trucks"));
        let v5 = 0x2::display::new_with_fields<RepairTruck>(&v0, v1, v3, arg1);
        0x2::display::update_version<RepairTruck>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<RepairTruck>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<RepairTruck>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<RepairTruck>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<RepairTruck>>(v7, v8);
    }

    public fun media_url(arg0: &RepairTruck) : 0x1::string::String {
        arg0.media_url
    }

    public(friend) fun mint(arg0: u8, arg1: u8, arg2: u8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) : RepairTruck {
        RepairTruck{
            id          : 0x2::object::new(arg8),
            name        : arg4,
            description : arg5,
            media_url   : arg6,
            armour      : arg0,
            speed       : arg1,
            rig         : arg2,
            serial      : arg3,
            attributes  : arg7,
        }
    }

    public fun name(arg0: &RepairTruck) : 0x1::string::String {
        arg0.name
    }

    public fun rig(arg0: &RepairTruck) : u8 {
        arg0.rig
    }

    public fun serial(arg0: &RepairTruck) : u64 {
        arg0.serial
    }

    public fun speed(arg0: &RepairTruck) : u8 {
        arg0.speed
    }

    // decompiled from Move bytecode v7
}

