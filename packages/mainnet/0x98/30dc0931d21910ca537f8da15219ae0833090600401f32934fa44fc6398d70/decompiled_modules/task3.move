module 0x9830dc0931d21910ca537f8da15219ae0833090600401f32934fa44fc6398d70::task3 {
    struct NFT_INFO has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        mint_count: u64,
    }

    struct RANMIAN has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct TASK3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: RANMIAN) {
        let RANMIAN {
            id     : v0,
            number : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: TASK3, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/ranmian"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/89071056?v=4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Task3 NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ranmian"));
        let v4 = 0x2::package::claim<TASK3>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RANMIAN>(&v4, v0, v2, arg1);
        0x2::display::update_version<RANMIAN>(&mut v5);
        let v6 = NFT_INFO{
            id           : 0x2::object::new(arg1),
            total_supply : 1000,
            mint_count   : 0,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v7);
        0x2::transfer::public_transfer<NFT_INFO>(v6, v7);
        0x2::transfer::public_transfer<0x2::display::Display<RANMIAN>>(v5, v7);
    }

    public entry fun mint(arg0: &mut NFT_INFO, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.mint_count = arg0.mint_count + 1;
        assert!(arg0.mint_count <= 1000, 0);
        let v0 = RANMIAN{
            id     : 0x2::object::new(arg1),
            number : arg0.mint_count,
        };
        0x2::transfer::public_transfer<RANMIAN>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

