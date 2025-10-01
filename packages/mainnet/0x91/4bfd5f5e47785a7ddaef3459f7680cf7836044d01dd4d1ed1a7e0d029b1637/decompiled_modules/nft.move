module 0x914bfd5f5e47785a7ddaef3459f7680cf7836044d01dd4d1ed1a7e0d029b1637::nft {
    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: 0x1::string::String,
        is_locked: bool,
    }

    struct ItemCreated has copy, drop {
        object_id: 0x2::object::ID,
        minted_by: address,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: Item, arg1: address) {
        assert!(!arg0.is_locked, 13906834655379718145);
        0x2::transfer::transfer<Item>(arg0, arg1);
    }

    public fun admin_transfer(arg0: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::Admins, arg1: Item, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::is_admin(arg0, &v0), 13906834681149652995);
        0x2::transfer::transfer<Item>(arg1, arg2);
    }

    public fun burn(arg0: Item) {
        let Item {
            id          : v0,
            name        : _,
            image_url   : _,
            link        : _,
            description : _,
            blob_id     : _,
            is_locked   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"blob_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        let v5 = 0x2::display::new_with_fields<Item>(&v0, v1, v3, arg1);
        0x2::display::update_version<Item>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun lock(arg0: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::Admins, arg1: &mut Item, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::is_admin(arg0, &v0), 13906834706919456771);
        arg1.is_locked = true;
    }

    public fun mint(arg0: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::Admins, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::is_admin(arg0, &v0), 13906834483581157379);
        let v1 = 0x1::string::utf8(0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::nft_image_url());
        if (!0x1::string::is_empty(&arg2)) {
            v1 = arg2;
        };
        let v2 = 0x1::string::utf8(0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::nft_link_url());
        if (!0x1::string::is_empty(&arg3)) {
            v2 = arg3;
        };
        let v3 = Item{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            image_url   : v1,
            link        : v2,
            description : arg4,
            blob_id     : arg5,
            is_locked   : true,
        };
        let v4 = ItemCreated{
            object_id : 0x2::object::id<Item>(&v3),
            minted_by : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ItemCreated>(v4);
        v3
    }

    public fun unlock(arg0: &0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::Admins, arg1: &mut Item, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xf13a4d64cb6129357667c1253c7379362da85fa22b63dfa3e974b9c6a288fe2d::admin::is_admin(arg0, &v0), 13906834732689260547);
        arg1.is_locked = false;
    }

    // decompiled from Move bytecode v6
}

