module 0xdf025543fda7452de9d1c21005496b80c3a5e7a4e97bb9ab667063742a475229::my_hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        creator: 0x1::string::String,
        balance: 0x1::string::String,
    }

    struct MY_HERO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Hero) {
        let Hero {
            id      : v0,
            creator : _,
            balance : _,
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://helios.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmdyZkfnpxnQgmPn1LmPccaDzQ1GVHU11rHrUvEybysMuD"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Best nfts"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://helios.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sui"));
        let v4 = 0x2::package::claim<MY_HERO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{
            id      : 0x2::object::new(arg2),
            creator : arg0,
            balance : arg1,
        };
        0x2::transfer::public_transfer<Hero>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{
            id      : 0x2::object::new(arg1),
            creator : 0x1::string::utf8(b"Mysten labs"),
            balance : 0x1::string::utf8(b"300 SUI"),
        };
        0x2::transfer::public_transfer<Hero>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

