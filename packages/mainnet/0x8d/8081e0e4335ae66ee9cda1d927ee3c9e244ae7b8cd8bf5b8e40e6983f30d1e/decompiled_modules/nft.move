module 0x8d8081e0e4335ae66ee9cda1d927ee3c9e244ae7b8cd8bf5b8e40e6983f30d1e::nft {
    struct Created<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    struct Delete<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ScaleProtocol has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut AdminCap, arg1: ScaleProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Delete<ScaleProtocol>{id: 0x2::object::id<ScaleProtocol>(&arg1)};
        0x2::event::emit<Delete<ScaleProtocol>>(v0);
        let ScaleProtocol {
            id          : v1,
            name        : _,
            description : _,
            img_url     : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://clutchy.io/marketplace/item/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://scale.exchange"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"scale protocol team"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ScaleProtocol>(&v4, v0, v2, arg1);
        0x2::display::update_version<ScaleProtocol>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ScaleProtocol>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_(arg1, arg2, arg3, arg4);
        let v1 = Created<ScaleProtocol>{id: 0x2::object::id<ScaleProtocol>(&v0)};
        0x2::event::emit<Created<ScaleProtocol>>(v1);
        0x2::transfer::transfer<ScaleProtocol>(v0, 0x2::tx_context::sender(arg4));
    }

    fun mint_(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : ScaleProtocol {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 1);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 3);
        assert!(0x1::vector::length<u8>(&arg0) < 50, 6);
        assert!(0x1::vector::length<u8>(&arg1) < 240, 4);
        assert!(0x1::vector::length<u8>(&arg2) < 280, 5);
        ScaleProtocol{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            img_url     : 0x1::string::utf8(arg2),
        }
    }

    public entry fun mint_multiple(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = mint_(arg1, arg2, arg3, arg5);
        let ScaleProtocol {
            id          : v2,
            name        : v3,
            description : v4,
            img_url     : v5,
        } = v1;
        while (v0 < arg4) {
            let v6 = 0x2::object::new(arg5);
            let v7 = Created<ScaleProtocol>{id: 0x2::object::uid_to_inner(&v6)};
            0x2::event::emit<Created<ScaleProtocol>>(v7);
            let v8 = ScaleProtocol{
                id          : v6,
                name        : v3,
                description : v4,
                img_url     : v5,
            };
            0x2::transfer::transfer<ScaleProtocol>(v8, 0x2::tx_context::sender(arg5));
            v0 = v0 + 1;
        };
        0x2::object::delete(v2);
    }

    public entry fun mint_multiple_recipient(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = mint_(arg1, arg2, arg3, arg6);
        let ScaleProtocol {
            id          : v2,
            name        : v3,
            description : v4,
            img_url     : v5,
        } = v1;
        while (v0 < arg4) {
            let v6 = 0x2::object::new(arg6);
            let v7 = Created<ScaleProtocol>{id: 0x2::object::uid_to_inner(&v6)};
            0x2::event::emit<Created<ScaleProtocol>>(v7);
            let v8 = ScaleProtocol{
                id          : v6,
                name        : v3,
                description : v4,
                img_url     : v5,
            };
            0x2::transfer::transfer<ScaleProtocol>(v8, arg5);
            v0 = v0 + 1;
        };
        0x2::object::delete(v2);
    }

    public entry fun mint_recipient(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_(arg1, arg2, arg3, arg5);
        let v1 = Created<ScaleProtocol>{id: 0x2::object::id<ScaleProtocol>(&v0)};
        0x2::event::emit<Created<ScaleProtocol>>(v1);
        0x2::transfer::transfer<ScaleProtocol>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

