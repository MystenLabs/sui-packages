module 0x1c9c1bdc050a6dec2dcc5a20ee044f87f09e98981f424bb4faf2a4ed3b3fd6a1::nft {
    struct CoCoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        count: u64,
        date: vector<0x1::string::String>,
    }

    struct VisitorList has store, key {
        id: 0x2::object::UID,
        visitors: vector<address>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun add_object(arg0: &mut VisitorList, arg1: &mut CoCoNFT, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        arg1.count = arg1.count + 1;
        0x1::vector::push_back<0x1::string::String>(&mut arg1.date, arg2);
        0x2::dynamic_object_field::add<0x1::string::String, 0x1c9c1bdc050a6dec2dcc5a20ee044f87f09e98981f424bb4faf2a4ed3b3fd6a1::item::CoCoItem>(&mut arg1.id, item_key(), 0x1c9c1bdc050a6dec2dcc5a20ee044f87f09e98981f424bb4faf2a4ed3b3fd6a1::item::new_item(arg3, arg4, arg5, arg2, arg6));
    }

    public entry fun first_mint(arg0: &mut VisitorList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg5);
        0x1::vector::push_back<0x1::string::String>(&mut v0.date, arg4);
        0x2::transfer::public_transfer<CoCoNFT>(v0, 0x2::tx_context::sender(arg5));
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true CoCoNFT of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CoCoNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<CoCoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CoCoNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = VisitorList{
            id       : 0x2::object::new(arg1),
            visitors : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<VisitorList>(v6);
    }

    fun item_key() : 0x1::string::String {
        0x1::string::utf8(b"item")
    }

    public fun mint(arg0: &mut VisitorList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : CoCoNFT {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.visitors)) {
            assert!(*0x1::vector::borrow<address>(&arg0.visitors, v0) != 0x2::tx_context::sender(arg4), 1001);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.visitors, 0x2::tx_context::sender(arg4));
        CoCoNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            img_url     : arg3,
            count       : 1,
            date        : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    // decompiled from Move bytecode v6
}

