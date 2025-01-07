module 0x7103e989e8fd35d6d713e06ac4cab0f0612848cd9af79a8da129ce7b051c6ddf::my_hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
    }

    struct MY_HERO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Hero) {
        let Hero {
            id          : v0,
            name        : _,
            img_url     : _,
            description : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MY_HERO, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Liquidpool"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmdyZkfnpxnQgmPn1LmPccaDzQ1GVHU11rHrUvEybysMuD"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Best nfts"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"helios.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sui"));
        let v4 = 0x2::package::claim<MY_HERO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            img_url     : arg1,
            description : arg2,
            creator     : arg3,
        };
        0x2::transfer::public_transfer<Hero>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun send(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            img_url     : arg1,
            description : arg2,
            creator     : arg3,
        };
        0x2::transfer::public_transfer<Hero>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

