module 0x553f973242660dcd4b20171b4ec51f404e6db9a67cae71f692e7e378e83a69e2::display {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct DISPLAY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
    }

    public fun batch_mint(arg0: &Minter, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 0);
        assert!(v0 == 0x1::vector::length<address>(&arg4), 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = NFT{
                id          : 0x2::object::new(arg5),
                name        : *0x1::vector::borrow<0x1::string::String>(&arg1, v1),
                image_url   : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                description : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
            };
            0x2::transfer::public_transfer<NFT>(v2, *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    public fun create_minter(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Minter{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<Minter>(v0, arg1);
    }

    fun init(arg0: DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://oceansgallerie.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://oceansgallerie.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"OCEAN"));
        let v4 = 0x2::package::claim<DISPLAY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &Minter, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            image_url   : arg3,
            description : arg2,
        };
        0x2::transfer::public_transfer<NFT>(v0, arg4);
    }

    public fun mint_and_distribute_multiple(arg0: &Minter, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = NFT{
                id          : 0x2::object::new(arg5),
                name        : arg1,
                image_url   : arg3,
                description : arg2,
            };
            0x2::transfer::public_transfer<NFT>(v2, *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

