module 0xccde61c4f860a3bce27359b0ded11c7abd1e914a36295479dcad2283563f9854::pigasus {
    struct StoreRegistry has key {
        id: 0x2::object::UID,
        stores: 0x2::table::Table<0x1::string::String, vector<address>>,
        user_stores: 0x2::table::Table<address, vector<address>>,
    }

    struct BrowseStore has key {
        id: 0x2::object::UID,
        owner: address,
        category_data: 0x2::table::Table<0x1::string::String, vector<BrowseData>>,
        interest_data: 0x2::table::Table<0x1::string::String, vector<BrowseData>>,
    }

    struct BrowseData has copy, drop, store {
        encrypted_content: vector<u8>,
    }

    public entry fun create_store(arg0: &mut StoreRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = BrowseStore{
            id            : 0x2::object::new(arg1),
            owner         : v0,
            category_data : 0x2::table::new<0x1::string::String, vector<BrowseData>>(arg1),
            interest_data : 0x2::table::new<0x1::string::String, vector<BrowseData>>(arg1),
        };
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_stores, v0)) {
            0x2::table::add<address, vector<address>>(&mut arg0.user_stores, v0, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_stores, v0), 0x2::object::uid_to_address(&v1.id));
        0x2::transfer::share_object<BrowseStore>(v1);
    }

    public fun find_by_category(arg0: &BrowseStore, arg1: 0x1::string::String) : vector<BrowseData> {
        if (0x2::table::contains<0x1::string::String, vector<BrowseData>>(&arg0.category_data, arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<BrowseData>>(&arg0.category_data, arg1)
        } else {
            0x1::vector::empty<BrowseData>()
        }
    }

    public fun find_by_interest(arg0: &BrowseStore, arg1: 0x1::string::String) : vector<BrowseData> {
        if (0x2::table::contains<0x1::string::String, vector<BrowseData>>(&arg0.interest_data, arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<BrowseData>>(&arg0.interest_data, arg1)
        } else {
            0x1::vector::empty<BrowseData>()
        }
    }

    public fun find_stores_by_category(arg0: &StoreRegistry, arg1: &0x1::string::String) : vector<address> {
        if (0x2::table::contains<0x1::string::String, vector<address>>(&arg0.stores, *arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<address>>(&arg0.stores, *arg1)
        } else {
            0x1::vector::empty<address>()
        }
    }

    public fun get_user_stores(arg0: &StoreRegistry, arg1: address) : vector<address> {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_stores, arg1)) {
            *0x2::table::borrow<address, vector<address>>(&arg0.user_stores, arg1)
        } else {
            0x1::vector::empty<address>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StoreRegistry{
            id          : 0x2::object::new(arg0),
            stores      : 0x2::table::new<0x1::string::String, vector<address>>(arg0),
            user_stores : 0x2::table::new<address, vector<address>>(arg0),
        };
        0x2::transfer::share_object<StoreRegistry>(v0);
    }

    public entry fun upload_data(arg0: &mut StoreRegistry, arg1: &mut BrowseStore, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 1);
        let v0 = BrowseData{encrypted_content: arg2};
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg3, v2);
            if (!0x2::table::contains<0x1::string::String, vector<address>>(&arg0.stores, v3)) {
                0x2::table::add<0x1::string::String, vector<address>>(&mut arg0.stores, v3, 0x1::vector::empty<address>());
            };
            let v4 = 0x2::table::borrow_mut<0x1::string::String, vector<address>>(&mut arg0.stores, v3);
            if (!0x1::vector::contains<address>(v4, &v1)) {
                0x1::vector::push_back<address>(v4, v1);
            };
            if (!0x2::table::contains<0x1::string::String, vector<BrowseData>>(&arg1.category_data, v3)) {
                0x2::table::add<0x1::string::String, vector<BrowseData>>(&mut arg1.category_data, v3, 0x1::vector::empty<BrowseData>());
            };
            0x1::vector::push_back<BrowseData>(0x2::table::borrow_mut<0x1::string::String, vector<BrowseData>>(&mut arg1.category_data, v3), v0);
            v2 = v2 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let v6 = *0x1::vector::borrow<0x1::string::String>(&arg4, v5);
            if (!0x2::table::contains<0x1::string::String, vector<BrowseData>>(&arg1.interest_data, v6)) {
                0x2::table::add<0x1::string::String, vector<BrowseData>>(&mut arg1.interest_data, v6, 0x1::vector::empty<BrowseData>());
            };
            0x1::vector::push_back<BrowseData>(0x2::table::borrow_mut<0x1::string::String, vector<BrowseData>>(&mut arg1.interest_data, v6), v0);
            v5 = v5 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

