module 0xb64766fecf7ba01aa09c6c84fa400905b97081f42f8eb65185a62d1e9ac3a68f::futuwxq_nft {
    struct FUTUWXQ_NFT has drop {
        dummy_field: bool,
    }

    struct FUTUWXQ has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: FUTUWXQ_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"FUTUWXQ_NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A NFT for futuwxq"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/49089070"));
        let v4 = 0x2::package::claim<FUTUWXQ_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<FUTUWXQ>(&v4, v0, v2, arg1);
        0x2::display::update_version<FUTUWXQ>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<FUTUWXQ>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FUTUWXQ{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<FUTUWXQ>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

