module 0x2b0ff39ca9dc1dfd37daf3370872e60d0bb6aad87121cddb488a0aa9042ac002::task3 {
    struct My_Avatar_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct TASK3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASK3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"a NFT of github avatar"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v4 = 0x2::package::claim<TASK3>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<My_Avatar_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<My_Avatar_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<My_Avatar_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = My_Avatar_NFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<My_Avatar_NFT>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

