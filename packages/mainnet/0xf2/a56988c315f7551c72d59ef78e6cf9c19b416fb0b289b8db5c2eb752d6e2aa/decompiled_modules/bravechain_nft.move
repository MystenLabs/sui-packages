module 0xf2a56988c315f7551c72d59ef78e6cf9c19b416fb0b289b8db5c2eb752d6e2aa::bravechain_nft {
    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        is_locked: bool,
    }

    struct ItemCreated has copy, drop {
        object_id: 0x2::object::ID,
        minted_by: address,
    }

    struct NftControlCap has store, key {
        id: 0x2::object::UID,
    }

    struct BRAVECHAIN_NFT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &NftControlCap, arg1: Item) {
        let Item {
            id          : v0,
            name        : _,
            image_url   : _,
            link        : _,
            description : _,
            is_locked   : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: BRAVECHAIN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BRAVECHAIN_NFT>(arg0, arg1);
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
        let v6 = NftControlCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<NftControlCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &NftControlCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            image_url   : arg2,
            link        : arg3,
            description : arg4,
            is_locked   : false,
        };
        let v1 = ItemCreated{
            object_id : 0x2::object::id<Item>(&v0),
            minted_by : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ItemCreated>(v1);
        0x2::transfer::public_transfer<Item>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

