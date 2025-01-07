module 0xf868a86ac645b752d37000e825c3a2821dac5924a8c1727ee68b479e861a2c9c::guinjgidanft {
    struct MYGUINJGIDANFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        owner: address,
    }

    struct GUINJGIDANFT has drop {
        dummy_field: bool,
    }

    struct MintNFT has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    fun init(arg0: GUINJGIDANFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/61534762?v=4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"I am seen,My github avator!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"guinjgida"));
        let v4 = 0x2::package::claim<GUINJGIDANFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MYGUINJGIDANFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MYGUINJGIDANFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MYGUINJGIDANFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MYGUINJGIDANFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : arg2,
            owner       : v0,
        };
        let v2 = MintNFT{
            object_id : 0x2::object::id<MYGUINJGIDANFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<MintNFT>(v2);
        0x2::transfer::public_transfer<MYGUINJGIDANFT>(v1, v0);
    }

    public entry fun transfernft(arg0: MYGUINJGIDANFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<MYGUINJGIDANFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

