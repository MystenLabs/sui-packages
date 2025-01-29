module 0x3366ebcba1b91c328bdffcbcdd6b30b61ca7e5ae74459141230c00f4b6ed2cab::bravechain {
    struct Item has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        seller: address,
    }

    struct ItemCreated has copy, drop {
        object_id: 0x2::object::ID,
        minted_by: address,
    }

    struct ItemTrash has store, key {
        id: 0x2::object::UID,
        items: vector<Item>,
    }

    struct NFTManageCap has store, key {
        id: 0x2::object::UID,
    }

    struct BRAVECHAIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: Item, arg1: &NFTManageCap) {
        let Item {
            id        : v0,
            name      : _,
            image_url : _,
            seller    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun clear_trash(arg0: &NFTManageCap, arg1: &mut ItemTrash) {
        while (!0x1::vector::is_empty<Item>(&arg1.items)) {
            burn(0x1::vector::pop_back<Item>(&mut arg1.items), arg0);
        };
    }

    fun init(arg0: BRAVECHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BRAVECHAIN>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.bravefrontier.jp/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"BraveFrontierVersus of the Sui ecosystem"));
        let v5 = 0x2::display::new_with_fields<Item>(&v0, v1, v3, arg1);
        0x2::display::update_version<Item>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = NFTManageCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<NFTManageCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = ItemTrash{
            id    : 0x2::object::new(arg1),
            items : 0x1::vector::empty<Item>(),
        };
        0x2::transfer::share_object<ItemTrash>(v7);
    }

    public fun mint(arg0: &NFTManageCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{
            id        : 0x2::object::new(arg3),
            name      : b"BraveFrontierVersus Item NFT",
            image_url : b"https://www.bravefrontier.jp/",
            seller    : arg1,
        };
        let v1 = ItemCreated{
            object_id : 0x2::object::id<Item>(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemCreated>(v1);
        0x2::transfer::public_transfer<Item>(v0, arg2);
    }

    public fun remove(arg0: &NFTManageCap, arg1: &mut ItemTrash, arg2: Item) {
        0x1::vector::push_back<Item>(&mut arg1.items, arg2);
    }

    // decompiled from Move bytecode v6
}

