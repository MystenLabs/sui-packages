module 0x766a8c60513958ad32535cc90258221a7508ef1467b239e253d924eae1904258::pigasus {
    struct BrowseStore has key {
        id: 0x2::object::UID,
        owner: address,
        category_data: 0x2::table::Table<0x1::string::String, vector<BrowseData>>,
        interest_data: 0x2::table::Table<0x1::string::String, vector<BrowseData>>,
    }

    struct BrowseData has copy, drop, store {
        encrypted_content: vector<u8>,
    }

    public entry fun create_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BrowseStore{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            category_data : 0x2::table::new<0x1::string::String, vector<BrowseData>>(arg0),
            interest_data : 0x2::table::new<0x1::string::String, vector<BrowseData>>(arg0),
        };
        0x2::transfer::share_object<BrowseStore>(v0);
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

    public entry fun upload_data(arg0: &mut BrowseStore, arg1: vector<u8>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        let v0 = BrowseData{encrypted_content: arg1};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            if (!0x2::table::contains<0x1::string::String, vector<BrowseData>>(&arg0.category_data, v2)) {
                0x2::table::add<0x1::string::String, vector<BrowseData>>(&mut arg0.category_data, v2, 0x1::vector::empty<BrowseData>());
            };
            0x1::vector::push_back<BrowseData>(0x2::table::borrow_mut<0x1::string::String, vector<BrowseData>>(&mut arg0.category_data, v2), v0);
            v1 = v1 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg3, v3);
            if (!0x2::table::contains<0x1::string::String, vector<BrowseData>>(&arg0.interest_data, v4)) {
                0x2::table::add<0x1::string::String, vector<BrowseData>>(&mut arg0.interest_data, v4, 0x1::vector::empty<BrowseData>());
            };
            0x1::vector::push_back<BrowseData>(0x2::table::borrow_mut<0x1::string::String, vector<BrowseData>>(&mut arg0.interest_data, v4), v0);
            v3 = v3 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

