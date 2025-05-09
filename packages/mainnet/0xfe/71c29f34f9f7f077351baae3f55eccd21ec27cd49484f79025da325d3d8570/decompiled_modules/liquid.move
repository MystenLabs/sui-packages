module 0xfe71c29f34f9f7f077351baae3f55eccd21ec27cd49484f79025da325d3d8570::liquid {
    struct Liquidpool has store, key {
        id: 0x2::object::UID,
        creator: 0x1::string::String,
        balance: 0x1::string::String,
    }

    struct LIQUID has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Liquidpool) {
        let Liquidpool {
            id      : v0,
            creator : _,
            balance : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: LIQUID, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<LIQUID>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Liquidpool>(&v4, v0, v2, arg1);
        0x2::display::update_version<Liquidpool>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Liquidpool>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Liquidpool{
            id      : 0x2::object::new(arg2),
            creator : arg0,
            balance : arg1,
        };
        0x2::transfer::public_transfer<Liquidpool>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Liquidpool{
            id      : 0x2::object::new(arg1),
            creator : 0x1::string::utf8(b"Mysten labs"),
            balance : 0x1::string::utf8(b"300 SUI"),
        };
        0x2::transfer::public_transfer<Liquidpool>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

