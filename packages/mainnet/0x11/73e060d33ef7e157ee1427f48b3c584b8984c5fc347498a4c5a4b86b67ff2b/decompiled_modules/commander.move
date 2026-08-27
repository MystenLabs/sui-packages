module 0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander {
    struct Commander has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        doctrine: u8,
        command: u8,
        cunning: u8,
        logistics: u8,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct COMMANDER has drop {
        dummy_field: bool,
    }

    public fun attributes(arg0: &Commander) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun command(arg0: &Commander) : u8 {
        arg0.command
    }

    public fun cunning(arg0: &Commander) : u8 {
        arg0.cunning
    }

    public fun doctrine(arg0: &Commander) : u8 {
        arg0.doctrine
    }

    fun init(arg0: COMMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COMMANDER>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Commanders"));
        let v5 = 0x2::display::new_with_fields<Commander>(&v0, v1, v3, arg1);
        0x2::display::update_version<Commander>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Commander>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Commander>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Commander>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Commander>>(v7, v8);
    }

    public fun logistics(arg0: &Commander) : u8 {
        arg0.logistics
    }

    public fun media_url(arg0: &Commander) : 0x1::string::String {
        arg0.media_url
    }

    public(friend) fun mint(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : Commander {
        Commander{
            id          : 0x2::object::new(arg9),
            name        : arg5,
            description : arg6,
            media_url   : arg7,
            doctrine    : arg0,
            command     : arg1,
            cunning     : arg2,
            logistics   : arg3,
            serial      : arg4,
            attributes  : arg8,
        }
    }

    public fun name(arg0: &Commander) : 0x1::string::String {
        arg0.name
    }

    public fun serial(arg0: &Commander) : u64 {
        arg0.serial
    }

    // decompiled from Move bytecode v7
}

