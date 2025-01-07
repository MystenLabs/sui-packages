module 0x4e3c80b0ad08dd303e7a0854edaec46c8c3884c3e0c6c5673a53c5ceb2674b38::firstmodule {
    struct HeadIconNFT has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
    }

    struct FIRSTMODULE has drop {
        dummy_field: bool,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: FIRSTMODULE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"summertoo #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://wonder365.etbood.com/heads/newhead.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"summertoo's headicon"));
        let v4 = 0x2::package::claim<FIRSTMODULE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<HeadIconNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<HeadIconNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HeadIconNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v6);
    }

    public entry fun mint(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = HeadIconNFT{
            id      : 0x2::object::new(arg1),
            tokenId : arg0.count,
        };
        0x2::transfer::public_transfer<HeadIconNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

