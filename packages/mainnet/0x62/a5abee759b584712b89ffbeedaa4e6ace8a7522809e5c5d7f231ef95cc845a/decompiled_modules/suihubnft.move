module 0x62a5abee759b584712b89ffbeedaa4e6ace8a7522809e5c5d7f231ef95cc845a::suihubnft {
    struct SuihubNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct Global has key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUIHUBNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUBNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiHub - Master IB"));
        let v4 = 0x2::package::claim<SUIHUBNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuihubNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuihubNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuihubNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Global{
            id         : 0x2::object::new(arg1),
            current_id : 1,
        };
        0x2::transfer::share_object<Global>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut Global, arg1: &AdminCap, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SuihubNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(b"SuiHub - Master IB"),
            img_url     : 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/QmQtswV3RoMJ7GQsaUxruLwGnzD1sn58gwQ2suNs2n3bYN"),
        };
        arg0.current_id = arg0.current_id + 1;
        0x2::transfer::public_transfer<SuihubNFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

