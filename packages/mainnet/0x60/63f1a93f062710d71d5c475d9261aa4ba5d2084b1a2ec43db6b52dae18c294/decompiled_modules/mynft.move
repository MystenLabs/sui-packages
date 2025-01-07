module 0x6063f1a93f062710d71d5c475d9261aa4ba5d2084b1a2ec43db6b52dae18c294::mynft {
    struct MYNFT has drop {
        dummy_field: bool,
    }

    struct CHENERGE has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: MYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CHENERGE #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CHENERGE collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CHENERGE nb"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://james-01-1256894360.cos.ap-beijing.myqcloud.com/2024-02-18-WechatIMG691%20-1-.jpg"));
        let v4 = 0x2::package::claim<MYNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CHENERGE>(&v4, v0, v2, arg1);
        0x2::display::update_version<CHENERGE>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<CHENERGE>>(v5, v6);
        let v7 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v7);
    }

    public entry fun mint(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = CHENERGE{
            id      : 0x2::object::new(arg1),
            tokenId : arg0.count,
        };
        0x2::transfer::public_transfer<CHENERGE>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

