module 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item {
    struct Item has store, key {
        id: 0x2::object::UID,
        asset_id: 0x1::string::String,
        asset_type: 0x1::string::String,
        asset_group_id: 0x1::string::String,
        version: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AssetSigner has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    struct ItemArgs has copy, drop {
        dbpk: u64,
        asset_id: 0x1::string::String,
        asset_type: 0x1::string::String,
        asset_group_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ItemMinted has copy, drop {
        id: 0x2::object::ID,
        dbpk: u64,
        asset_id: 0x1::string::String,
        asset_type: 0x1::string::String,
        asset_group_id: 0x1::string::String,
        version: u64,
    }

    struct ItemUpdated has copy, drop {
        id: 0x2::object::ID,
        asset_id: 0x1::string::String,
        asset_type: 0x1::string::String,
        asset_group_id: 0x1::string::String,
        version: u64,
    }

    struct ItemBurned has copy, drop {
        id: 0x2::object::ID,
        asset_id: 0x1::string::String,
        asset_type: 0x1::string::String,
        asset_group_id: 0x1::string::String,
        version: u64,
    }

    struct AssetSignerUpdated has copy, drop {
        id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    public(friend) fun build_item_args(arg0: vector<u8>) : ItemArgs {
        let v0 = 0x2::bcs::new(arg0);
        ItemArgs{
            dbpk           : 0x2::bcs::peel_u64(&mut v0),
            asset_id       : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            asset_type     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            asset_group_id : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            name           : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            description    : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            image_url      : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            attributes     : to_attribute_map(0x2::bcs::peel_vec_vec_u8(&mut v0)),
        }
    }

    public fun burn_item(arg0: Item) {
        let Item {
            id             : v0,
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            version        : v4,
            name           : _,
            description    : _,
            image_url      : _,
            attributes     : _,
        } = arg0;
        let v9 = v0;
        let v10 = ItemBurned{
            id             : 0x2::object::uid_to_inner(&v9),
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            version        : v4,
        };
        0x2::event::emit<ItemBurned>(v10);
        0x2::object::delete(v9);
    }

    public fun get_asset_group_id(arg0: &Item) : 0x1::string::String {
        arg0.asset_group_id
    }

    public fun get_asset_id(arg0: &Item) : 0x1::string::String {
        arg0.asset_id
    }

    public fun get_asset_type(arg0: &Item) : 0x1::string::String {
        arg0.asset_type
    }

    public fun new_asset_signer(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : AssetSigner {
        let v0 = AssetSigner{
            id         : 0x2::object::new(arg1),
            public_key : arg0,
        };
        let v1 = AssetSignerUpdated{
            id         : 0x2::object::id<AssetSigner>(&v0),
            public_key : arg0,
        };
        0x2::event::emit<AssetSignerUpdated>(v1);
        v0
    }

    public fun new_item(arg0: &AssetSigner, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Item {
        new_item_inner(verify_item_args_and_build_item_args(arg1, arg0.public_key, arg2), arg3)
    }

    public(friend) fun new_item_inner(arg0: ItemArgs, arg1: &mut 0x2::tx_context::TxContext) : Item {
        let ItemArgs {
            dbpk           : v0,
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            name           : v4,
            description    : v5,
            image_url      : v6,
            attributes     : v7,
        } = arg0;
        let v8 = Item{
            id             : 0x2::object::new(arg1),
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            version        : 1,
            name           : v4,
            description    : v5,
            image_url      : v6,
            attributes     : v7,
        };
        let v9 = ItemMinted{
            id             : 0x2::object::id<Item>(&v8),
            dbpk           : v0,
            asset_id       : v8.asset_id,
            asset_type     : v8.asset_type,
            asset_group_id : v8.asset_group_id,
            version        : v8.version,
        };
        0x2::event::emit<ItemMinted>(v9);
        v8
    }

    public(friend) fun set_asset_signer(arg0: &mut AssetSigner, arg1: vector<u8>) {
        arg0.public_key = arg1;
        let v0 = AssetSignerUpdated{
            id         : 0x2::object::id<AssetSigner>(arg0),
            public_key : arg1,
        };
        0x2::event::emit<AssetSignerUpdated>(v0);
    }

    fun to_attribute_map(arg0: vector<vector<u8>>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        let v2 = 0x1::vector::length<vector<u8>>(&arg0);
        assert!(v2 % 2 == 0, 101);
        loop {
            if (v1 >= v2) {
                break
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg0, v1)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg0, v1 + 1)));
            v1 = v1 + 2;
        };
        v0
    }

    public fun update_item(arg0: &mut Item, arg1: vector<u8>, arg2: &AssetSigner, arg3: vector<u8>) {
        update_item_inner(arg0, verify_item_args_and_build_item_args(arg1, arg2.public_key, arg3));
    }

    public(friend) fun update_item_inner(arg0: &mut Item, arg1: ItemArgs) {
        let ItemArgs {
            dbpk           : _,
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            name           : v4,
            description    : v5,
            image_url      : _,
            attributes     : v7,
        } = arg1;
        arg0.asset_id = v1;
        arg0.asset_type = v2;
        arg0.asset_group_id = v3;
        arg0.name = v4;
        arg0.description = v5;
        arg0.attributes = v7;
        arg0.version = arg0.version + 1;
        let v8 = ItemUpdated{
            id             : 0x2::object::uid_to_inner(&arg0.id),
            asset_id       : arg0.asset_id,
            asset_type     : arg0.asset_type,
            asset_group_id : arg0.asset_group_id,
            version        : arg0.version,
        };
        0x2::event::emit<ItemUpdated>(v8);
    }

    public(friend) fun verify_item_args(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &arg0), 102);
    }

    fun verify_item_args_and_build_item_args(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : ItemArgs {
        verify_item_args(arg0, arg1, arg2);
        build_item_args(arg0)
    }

    // decompiled from Move bytecode v6
}

