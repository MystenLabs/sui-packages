module 0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester {
    struct Harvester has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        armour: u8,
        speed: u8,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct HARVESTER has drop {
        dummy_field: bool,
    }

    public fun armour(arg0: &Harvester) : u8 {
        arg0.armour
    }

    public fun attributes(arg0: &Harvester) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun init(arg0: HARVESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HARVESTER>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Harvesters"));
        let v5 = 0x2::display::new_with_fields<Harvester>(&v0, v1, v3, arg1);
        0x2::display::update_version<Harvester>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Harvester>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Harvester>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Harvester>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Harvester>>(v7, v8);
    }

    public fun media_url(arg0: &Harvester) : 0x1::string::String {
        arg0.media_url
    }

    public(friend) fun mint(arg0: u8, arg1: u8, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : Harvester {
        Harvester{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            description : arg4,
            media_url   : arg5,
            armour      : arg0,
            speed       : arg1,
            serial      : arg2,
            attributes  : arg6,
        }
    }

    public fun name(arg0: &Harvester) : 0x1::string::String {
        arg0.name
    }

    public fun serial(arg0: &Harvester) : u64 {
        arg0.serial
    }

    public fun speed(arg0: &Harvester) : u8 {
        arg0.speed
    }

    // decompiled from Move bytecode v7
}

