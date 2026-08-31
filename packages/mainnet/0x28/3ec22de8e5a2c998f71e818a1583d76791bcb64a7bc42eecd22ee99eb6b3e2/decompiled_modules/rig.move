module 0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig {
    struct Rig has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        drill: u8,
        capacity: u8,
        armour: u8,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct RIG has drop {
        dummy_field: bool,
    }

    public fun armour(arg0: &Rig) : u8 {
        arg0.armour
    }

    public fun attributes(arg0: &Rig) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun capacity(arg0: &Rig) : u8 {
        arg0.capacity
    }

    public fun drill(arg0: &Rig) : u8 {
        arg0.drill
    }

    fun init(arg0: RIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RIG>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Mining Rigs"));
        let v5 = 0x2::display::new_with_fields<Rig>(&v0, v1, v3, arg1);
        0x2::display::update_version<Rig>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Rig>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Rig>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Rig>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Rig>>(v7, v8);
    }

    public fun media_url(arg0: &Rig) : 0x1::string::String {
        arg0.media_url
    }

    public(friend) fun mint(arg0: u8, arg1: u8, arg2: u8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) : Rig {
        Rig{
            id          : 0x2::object::new(arg8),
            name        : arg4,
            description : arg5,
            media_url   : arg6,
            drill       : arg0,
            capacity    : arg1,
            armour      : arg2,
            serial      : arg3,
            attributes  : arg7,
        }
    }

    public fun name(arg0: &Rig) : 0x1::string::String {
        arg0.name
    }

    public fun serial(arg0: &Rig) : u64 {
        arg0.serial
    }

    // decompiled from Move bytecode v7
}

