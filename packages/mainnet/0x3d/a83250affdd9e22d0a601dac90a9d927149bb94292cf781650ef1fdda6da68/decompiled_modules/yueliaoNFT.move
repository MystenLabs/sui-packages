module 0x3da83250affdd9e22d0a601dac90a9d927149bb94292cf781650ef1fdda6da68::yueliaoNFT {
    struct YUELIAONFT has drop {
        dummy_field: bool,
    }

    struct YUELIAO has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: YUELIAONFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"yueliao11"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT for yueliao11"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/187120306?u=1902a0c17e07b76b0bb5ff5a93144d78ed5c1ed8&v=4&size=64"));
        let v4 = 0x2::package::claim<YUELIAONFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<YUELIAO>(&v4, v0, v2, arg1);
        0x2::display::update_version<YUELIAO>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<YUELIAO>>(v5, v6);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = YUELIAO{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<YUELIAO>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

