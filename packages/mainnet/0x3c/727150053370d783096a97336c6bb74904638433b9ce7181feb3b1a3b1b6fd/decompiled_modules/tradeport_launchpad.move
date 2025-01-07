module 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad {
    struct TRADEPORT_LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        public_key: vector<u8>,
    }

    struct Group has store, key {
        id: 0x2::object::UID,
        index: u64,
        autoreserve_interval: u64,
        minted: u64,
    }

    struct Stage has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        minted: u64,
    }

    struct AddNftMetadataReq has drop {
        sender: vector<u8>,
        group_id: 0x1::string::String,
        type: u64,
        index: u64,
        autoreserve_interval: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
    }

    struct GetNftMetadataReq has drop {
        sender: vector<u8>,
        group_id: 0x1::string::String,
        type: u64,
        order_id: 0x1::string::String,
        expire_at: u64,
        stage_id: 0x1::string::String,
        max_supply: u64,
        price: u64,
        fee: u64,
    }

    struct UpdateNftReq has drop {
        sender: vector<u8>,
        id: vector<u8>,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
    }

    public fun add_nft_metadata(arg0: &mut Store, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = AddNftMetadataReq{
            sender               : 0x2::bcs::to_bytes<address>(&v0),
            group_id             : arg1,
            type                 : arg2,
            index                : arg3,
            autoreserve_interval : arg4,
            name                 : arg5,
            description          : arg6,
            media_url            : arg7,
            attribute_keys       : arg8,
            attribute_values     : arg9,
        };
        verify_signature<AddNftMetadataReq>(&v1, arg10, arg0.public_key);
        let v2 = 0x2::bag::new(arg11);
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"group_id"), arg1);
        0x2::bag::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"type"), arg2);
        0x2::bag::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"index"), arg3);
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"name"), arg5);
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"description"), arg6);
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"media_url"), arg7);
        0x2::bag::add<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v2, 0x1::string::utf8(b"attributes"), format_attributes(arg8, arg9));
        let v3 = false;
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1)) {
            let v4 = Group{
                id                   : 0x2::object::new(arg11),
                index                : 0,
                autoreserve_interval : arg4,
                minted               : 0,
            };
            0x2::dynamic_object_field::add<0x1::string::String, Group>(&mut arg0.id, arg1, v4);
            v3 = true;
        };
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Group>(&mut arg0.id, arg1);
        if (arg2 == 0) {
            add_nft_metadata_0(v5, v3, arg3, v2, arg11);
        } else {
            assert!(arg2 == 1, 4);
            add_nft_metadata_1(v5, v2);
        };
    }

    fun add_nft_metadata_0(arg0: &mut Group, arg1: bool, arg2: u64, arg3: 0x2::bag::Bag, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1) {
            assert!(arg2 == 0, 5);
            let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::new<0x2::bag::Bag>(arg4);
            0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<0x2::bag::Bag>(&mut v0, arg3);
            0x2::dynamic_object_field::add<0x1::string::String, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<0x2::bag::Bag>>(&mut arg0.id, 0x1::string::utf8(b"warehouse"), v0);
        } else {
            assert!(arg2 == arg0.index + 1, 5);
            arg0.index = arg2;
            0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<0x2::bag::Bag>(0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<0x2::bag::Bag>>(&mut arg0.id, 0x1::string::utf8(b"warehouse")), arg3);
        };
    }

    fun add_nft_metadata_1(arg0: &mut Group, arg1: 0x2::bag::Bag) {
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"edition_nft_metadata")), 10);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::bag::Bag>(&mut arg0.id, 0x1::string::utf8(b"edition_nft_metadata"), arg1);
    }

    fun clone_nft_metadata(arg0: &0x2::bag::Bag, arg1: &mut 0x2::tx_context::TxContext) : 0x2::bag::Bag {
        let v0 = 0x2::bag::new(arg1);
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"group_id"), *0x2::bag::borrow<0x1::string::String, 0x1::string::String>(arg0, 0x1::string::utf8(b"group_id")));
        0x2::bag::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"type"), *0x2::bag::borrow<0x1::string::String, u64>(arg0, 0x1::string::utf8(b"type")));
        0x2::bag::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"index"), *0x2::bag::borrow<0x1::string::String, u64>(arg0, 0x1::string::utf8(b"index")));
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"), *0x2::bag::borrow<0x1::string::String, 0x1::string::String>(arg0, 0x1::string::utf8(b"name")));
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"), *0x2::bag::borrow<0x1::string::String, 0x1::string::String>(arg0, 0x1::string::utf8(b"description")));
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"media_url"), *0x2::bag::borrow<0x1::string::String, 0x1::string::String>(arg0, 0x1::string::utf8(b"media_url")));
        let v1 = 0x2::bag::borrow<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, 0x1::string::utf8(b"attributes"));
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(v1)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(v1, v3);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, *v4, *v5);
            v3 = v3 + 1;
        };
        0x2::bag::add<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v0, 0x1::string::utf8(b"attributes"), v2);
        v0
    }

    public fun format_attributes(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg1), 6);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg0, v2), *0x1::vector::borrow<0x1::string::String>(&arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_nft_metadata(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) : (0x2::bag::Bag, 0x1::option::Option<0x2::bag::Bag>) {
        verify_version(arg1);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = GetNftMetadataReq{
            sender     : 0x2::bcs::to_bytes<address>(&v0),
            group_id   : arg2,
            type       : arg3,
            order_id   : arg4,
            expire_at  : arg5,
            stage_id   : arg6,
            max_supply : arg7,
            price      : arg8,
            fee        : arg9,
        };
        verify_signature<GetNftMetadataReq>(&v1, arg10, arg1.public_key);
        assert!(0x2::clock::timestamp_ms(arg0) < arg5 * 1000, 7);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Group>(&mut arg1.id, arg2);
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&v2.id, 0x1::string::utf8(b"orderbook"))) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>(&mut v2.id, 0x1::string::utf8(b"orderbook"), 0x2::table::new<0x1::string::String, u64>(arg12));
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>(&mut v2.id, 0x1::string::utf8(b"orderbook"));
        assert!(!0x2::table::contains<0x1::string::String, u64>(v3, arg4), 8);
        0x2::table::add<0x1::string::String, u64>(v3, arg4, arg5);
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&v2.id, 0x1::string::utf8(b"stagebook"))) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<0x1::string::String, Stage>>(&mut v2.id, 0x1::string::utf8(b"stagebook"), 0x2::table::new<0x1::string::String, Stage>(arg12));
        };
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<0x1::string::String, Stage>>(&mut v2.id, 0x1::string::utf8(b"stagebook"));
        if (!0x2::table::contains<0x1::string::String, Stage>(v4, arg6)) {
            let v5 = Stage{
                id         : 0x2::object::new(arg12),
                max_supply : arg7,
                minted     : 0,
            };
            0x2::table::add<0x1::string::String, Stage>(v4, arg6, v5);
        };
        let v6 = 0x2::table::borrow_mut<0x1::string::String, Stage>(v4, arg6);
        assert!(v6.max_supply == 0 || v6.minted < v6.max_supply, 9);
        v6.minted = v6.minted + 1;
        v2.minted = v2.minted + 1;
        let v7 = if (v2.autoreserve_interval > 0) {
            v2.minted % v2.autoreserve_interval == 0
        } else {
            false
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::split<0x2::sui::SUI>(arg11, arg9, arg12));
        if (arg3 == 0) {
            return get_nft_metadata_0(arg0, v2, v7, arg12)
        };
        assert!(arg3 == 1, 4);
        let v8 = v7 && (v6.max_supply == 0 || v6.minted < v6.max_supply);
        if (v8) {
            v6.minted = v6.minted + 1;
        };
        get_nft_metadata_1(v2, v8, arg12)
    }

    fun get_nft_metadata_0(arg0: &0x2::clock::Clock, arg1: &mut Group, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::bag::Bag, 0x1::option::Option<0x2::bag::Bag>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<0x2::bag::Bag>>(&mut arg1.id, 0x1::string::utf8(b"warehouse"));
        if (arg2 && !0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::is_empty<0x2::bag::Bag>(v0)) {
            return (0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::warehouse_utils::redeem_random_nft<0x2::bag::Bag>(arg0, v0, arg3), 0x1::option::some<0x2::bag::Bag>(0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::warehouse_utils::redeem_random_nft<0x2::bag::Bag>(arg0, v0, arg3)))
        };
        (0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::warehouse_utils::redeem_random_nft<0x2::bag::Bag>(arg0, v0, arg3), 0x1::option::none<0x2::bag::Bag>())
    }

    fun get_nft_metadata_1(arg0: &Group, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : (0x2::bag::Bag, 0x1::option::Option<0x2::bag::Bag>) {
        let v0 = 0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::bag::Bag>(&arg0.id, 0x1::string::utf8(b"edition_nft_metadata"));
        if (arg1) {
            let v1 = clone_nft_metadata(v0, arg2);
            return (v1, 0x1::option::some<0x2::bag::Bag>(clone_nft_metadata(v0, arg2)))
        };
        (clone_nft_metadata(v0, arg2), 0x1::option::none<0x2::bag::Bag>())
    }

    fun init(arg0: TRADEPORT_LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT_LAUNCHPAD>(arg0, arg1);
        let v0 = Store{
            id         : 0x2::object::new(arg1),
            version    : 0,
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            public_key : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public fun set_public_key(arg0: &0x2::package::Publisher, arg1: &mut Store, arg2: vector<u8>) {
        assert!(0x2::package::from_package<Store>(arg0), 1);
        arg1.public_key = arg2;
    }

    fun verify_signature<T0>(arg0: &T0, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2, &v0), 3);
    }

    public fun verify_update_nft_request(arg0: &Store, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = UpdateNftReq{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            id               : arg1,
            description      : arg2,
            media_url        : arg3,
            attribute_keys   : arg4,
            attribute_values : arg5,
        };
        verify_signature<UpdateNftReq>(&v1, arg6, arg0.public_key);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 0, 2);
    }

    public fun withdraw_balance(arg0: &0x2::package::Publisher, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Store>(arg0), 1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

