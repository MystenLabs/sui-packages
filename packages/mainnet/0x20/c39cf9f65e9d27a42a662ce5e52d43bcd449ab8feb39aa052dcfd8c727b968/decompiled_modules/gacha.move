module 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::gacha {
    struct GACHA has drop {
        dummy_field: bool,
    }

    struct GachaBall has store, key {
        id: 0x2::object::UID,
        token_type: u64,
        collection: 0x1::string::String,
        name: 0x1::string::String,
        type: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct GachaBallMinted has copy, drop {
        id: 0x2::object::ID,
        token_type: u64,
    }

    struct GachaBallBurned has copy, drop {
        id: 0x2::object::ID,
        token_type: u64,
    }

    public(friend) fun burn(arg0: GachaBall) {
        let GachaBall {
            id          : v0,
            token_type  : v1,
            collection  : _,
            name        : _,
            type        : _,
            description : _,
        } = arg0;
        let v6 = v0;
        let v7 = GachaBallBurned{
            id         : 0x2::object::uid_to_inner(&v6),
            token_type : v1,
        };
        0x2::event::emit<GachaBallBurned>(v7);
        0x2::object::delete(v6);
    }

    public fun collection(arg0: &GachaBall) : &0x1::string::String {
        &arg0.collection
    }

    public(friend) fun id(arg0: &GachaBall) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: GACHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GACHA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://display.legendofarcadia.io/gacha/{type}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://legendofarcadia.io"));
        let v5 = 0x2::display::new_with_fields<GachaBall>(&v0, v1, v3, arg1);
        0x2::display::update_version<GachaBall>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GachaBall>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : GachaBall {
        let v0 = GachaBall{
            id          : 0x2::object::new(arg5),
            token_type  : arg0,
            collection  : arg1,
            name        : arg2,
            type        : arg3,
            description : arg4,
        };
        let v1 = GachaBallMinted{
            id         : 0x2::object::uid_to_inner(&v0.id),
            token_type : arg0,
        };
        0x2::event::emit<GachaBallMinted>(v1);
        v0
    }

    public fun name(arg0: &GachaBall) : &0x1::string::String {
        &arg0.name
    }

    public fun tokenType(arg0: &GachaBall) : &u64 {
        &arg0.token_type
    }

    public fun type(arg0: &GachaBall) : &0x1::string::String {
        &arg0.type
    }

    // decompiled from Move bytecode v6
}

