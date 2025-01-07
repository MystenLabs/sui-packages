module 0x125557ddfd99cfde15cb47a371b707115e86fb596370022dee4cb0801e28b15b::chenerge_nft {
    struct CHENERGE_NFT has drop {
        dummy_field: bool,
    }

    struct CHENERGE_NB has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: CHENERGE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHENERGE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"CHENERGE #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"CHENERGE collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"CHENERGE nb"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/82131587?s=400&u=cf16292bd0fd209531d7dc43f4daed55f39f1714&v=4"));
        let v5 = 0x2::display::new_with_fields<CHENERGE_NB>(&v0, v1, v3, arg1);
        0x2::display::update_version<CHENERGE_NB>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<CHENERGE_NB>>(v5, v6);
        let v7 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v7);
    }

    public entry fun mint(arg0: &mut State, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = CHENERGE_NB{
            id      : 0x2::object::new(arg2),
            tokenId : arg0.count,
        };
        0x2::transfer::public_transfer<CHENERGE_NB>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

