module 0xac00a71b3fd7635f1fe6b321c0e7d1a82737901c8457e022a1980d3b745f478a::my_zpet {
    struct Zpet has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct ZPETMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MY_ZPET has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Zpet>(create_nft(arg0, arg1, arg2, arg4), arg3);
    }

    public entry fun burn(arg0: Zpet, arg1: &mut 0x2::tx_context::TxContext) {
        let Zpet {
            id          : v0,
            name        : _,
            image_url   : _,
            description : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun create_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Zpet {
        let v0 = Zpet{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            image_url   : arg1,
            description : arg2,
        };
        let v1 = ZPETMinted{
            object_id   : 0x2::object::id<Zpet>(&v0),
            creator     : 0x2::tx_context::sender(arg3),
            name        : v0.name,
            image_url   : v0.image_url,
            description : v0.description,
        };
        0x2::event::emit<ZPETMinted>(v1);
        v0
    }

    public fun description(arg0: &Zpet) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &Zpet) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: MY_ZPET, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"zcdc"));
        let v4 = 0x2::package::claim<MY_ZPET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Zpet>(&v4, v0, v2, arg1);
        0x2::display::update_version<Zpet>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Zpet>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &Zpet) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Zpet, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

