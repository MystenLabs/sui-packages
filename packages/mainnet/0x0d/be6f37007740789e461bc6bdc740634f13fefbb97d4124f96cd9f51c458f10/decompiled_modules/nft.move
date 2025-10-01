module 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft {
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
        assert!(!arg0.is_locked, 13906834706919325697);
        0x2::transfer::transfer<Item>(arg0, arg1);
    }

    public fun admin_transfer(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: Item, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834732689260547);
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

    public fun create_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Item>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Item>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Item>>(v1, 0x2::tx_context::sender(arg1));
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

    public fun lock(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: &mut Item, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834758459064323);
        arg1.is_locked = true;
    }

    public fun mint(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834535120764931);
        let v1 = 0x1::string::utf8(0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::nft_image_url());
        if (!0x1::string::is_empty(&arg2)) {
            v1 = arg2;
        };
        let v2 = 0x1::string::utf8(0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::nft_link_url());
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

    public fun unlock(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: &mut Item, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834784228868099);
        arg1.is_locked = false;
    }

    // decompiled from Move bytecode v6
}

