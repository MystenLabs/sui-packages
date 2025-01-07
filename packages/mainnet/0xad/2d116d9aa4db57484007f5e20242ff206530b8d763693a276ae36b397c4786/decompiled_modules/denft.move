module 0xad2d116d9aa4db57484007f5e20242ff206530b8d763693a276ae36b397c4786::denft {
    struct DetaskNFT has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
        amt: u64,
    }

    struct DENFT has drop {
        dummy_field: bool,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: DENFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DeTask #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://detask.etboodonline.com/logo/detasklogo.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DeTask's Commemorative NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://detask.etboodonline.com"));
        let v4 = 0x2::package::claim<DENFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DetaskNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DetaskNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DetaskNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v6);
    }

    public entry fun mint(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.count < 8888, 4001);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 100000000, 4000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 100000000), arg2), @0xd73a6dc9ff5222aed93d45049767837030c74cba9835d8796c7acd311c12e0e2);
        arg1.count = arg1.count + 1;
        let v0 = DetaskNFT{
            id      : 0x2::object::new(arg2),
            tokenId : arg1.count,
            amt     : 100000000,
        };
        0x2::transfer::public_transfer<DetaskNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

