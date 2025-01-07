module 0xef47cce7190abc66cedc7fe6e1903512498dd866edeedd9bef62c9a397f55f4f::dgu_mad_lads {
    struct DGU_MAD_LADS has drop {
        dummy_field: bool,
    }

    struct MAD_LADS has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: DGU_MAD_LADS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DGU_MAD_LADS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"dgu mad lads #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"dgu mad lads collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"dgu mad lads"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/47034800?v=4"));
        let v5 = 0x2::display::new_with_fields<MAD_LADS>(&v0, v1, v3, arg1);
        0x2::display::update_version<MAD_LADS>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<MAD_LADS>>(v5, v6);
        let v7 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v7);
    }

    public entry fun mint(arg0: &mut State, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = MAD_LADS{
            id      : 0x2::object::new(arg2),
            tokenId : arg0.count,
        };
        0x2::transfer::public_transfer<MAD_LADS>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

