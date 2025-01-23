module 0x6ba83aa67ba2d7169d34d021729a797a61644f6c2061f06aa8f519d0e9bfbf0d::artizm {
    struct DigitalTwin has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: 0x1::string::String,
        project_url: 0x1::string::String,
        artist_note: 0x1::string::String,
        price: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ARTIZM has drop {
        dummy_field: bool,
    }

    public fun new(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : DigitalTwin {
        DigitalTwin{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            creator     : 0x1::string::utf8(arg3),
            project_url : 0x1::string::utf8(arg4),
            artist_note : 0x1::string::utf8(arg5),
            price       : 0x1::string::utf8(arg6),
        }
    }

    public fun artist_note(arg0: &DigitalTwin) : 0x1::string::String {
        arg0.artist_note
    }

    public fun creator(arg0: &DigitalTwin) : 0x1::string::String {
        arg0.creator
    }

    public fun destroy(arg0: DigitalTwin) {
        let DigitalTwin {
            id          : v0,
            name        : _,
            image_url   : _,
            creator     : _,
            project_url : _,
            artist_note : _,
            price       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun image_url(arg0: &DigitalTwin) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: ARTIZM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ARTIZM>(arg0, arg1);
        let v1 = 0x2::display::new<DigitalTwin>(&v0, arg1);
        0x2::display::add<DigitalTwin>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DigitalTwin>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://ipfs.io/ipfs/{image_url}"));
        0x2::display::add<DigitalTwin>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<DigitalTwin>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An official DIGITAL TWIN: a commemorative NFT from Artizm, powered by Anima Labs"));
        0x2::display::add<DigitalTwin>(&mut v1, 0x1::string::utf8(b"project_name"), 0x1::string::utf8(b"Artizm, powered by Anima Labs"));
        0x2::display::add<DigitalTwin>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::update_version<DigitalTwin>(&mut v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DigitalTwin>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &DigitalTwin) : 0x1::string::String {
        arg0.name
    }

    public fun new_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun price(arg0: &DigitalTwin) : 0x1::string::String {
        arg0.price
    }

    public fun project_url(arg0: &DigitalTwin) : 0x1::string::String {
        arg0.project_url
    }

    // decompiled from Move bytecode v6
}

