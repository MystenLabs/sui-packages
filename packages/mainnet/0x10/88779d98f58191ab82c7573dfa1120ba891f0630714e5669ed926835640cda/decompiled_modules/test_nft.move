module 0x1088779d98f58191ab82c7573dfa1120ba891f0630714e5669ed926835640cda::test_nft {
    struct TEST_NFT has drop {
        dummy_field: bool,
    }

    struct Test has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        website: 0x2::url::Url,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct TestRegistryPolicy has store, key {
        id: 0x2::object::UID,
        version: u8,
        empty_policy: 0x2::transfer_policy::TransferPolicy<Test>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Test>,
    }

    struct TestMinted has copy, drop {
        test_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct TestTransferred has copy, drop {
        test_id: 0x2::object::ID,
        new_owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct TestBurned has copy, drop {
        test_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    public fun transfer(arg0: &mut TestRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<Test>, arg4: 0x2::object::ID, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        validate_test_registry_policy_version(arg0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<Test>(arg1, 0x2::kiosk::list_with_purchase_cap<Test>(arg1, arg2, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Test>(&arg0.empty_policy, v1);
        let (v6, v7) = 0x2::kiosk::new(arg6);
        let v8 = v7;
        let v9 = v6;
        0x2::kiosk::lock<Test>(&mut v9, &v8, arg3, v2);
        let v10 = TestTransferred{
            test_id   : 0x2::object::uid_to_inner(&v2.id),
            new_owner : arg5,
            kiosk_id  : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v9)),
        };
        0x2::event::emit<TestTransferred>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v9, arg5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v8, arg5);
    }

    public fun attributes(arg0: &Test) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    fun build_attributes_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        let v2 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v2 == 0x1::vector::length<0x1::string::String>(&arg1), 2);
        while (v1 < v2) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun burn(arg0: &mut TestRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        validate_test_registry_policy_version(arg0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<Test>(arg1, 0x2::kiosk::list_with_purchase_cap<Test>(arg1, arg2, arg3, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Test>(&arg0.empty_policy, v1);
        let Test {
            id          : v5,
            name        : _,
            website     : _,
            image_url   : _,
            video_url   : _,
            description : _,
            creator     : _,
            key         : v12,
            attributes  : _,
        } = v0;
        let v14 = v5;
        let v15 = TestBurned{
            test_id : 0x2::object::uid_to_inner(&v14),
            key     : v12,
        };
        0x2::event::emit<TestBurned>(v15);
        0x2::object::delete(v14);
    }

    public fun creator(arg0: &Test) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Test) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Test) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &Test) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TEST_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Test>(&v0, arg1);
        let v3 = TestRegistryPolicy{
            id           : 0x2::object::new(arg1),
            version      : 1,
            empty_policy : v1,
            policy_cap   : v2,
        };
        0x2::transfer::share_object<TestRegistryPolicy>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun key(arg0: &Test) : 0x1::string::String {
        arg0.key
    }

    public fun mint(arg0: &0x1088779d98f58191ab82c7573dfa1120ba891f0630714e5669ed926835640cda::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x2::url::Url, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : Test {
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public entry fun mint_entry(arg0: &0x1088779d98f58191ab82c7573dfa1120ba891f0630714e5669ed926835640cda::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_internal(arg0, arg1, 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg2)), arg3, arg4, arg5, arg6, arg7, build_attributes_map(arg8, arg9), arg10);
        0x2::transfer::public_transfer<Test>(v0, 0x2::tx_context::sender(arg10));
    }

    fun mint_internal(arg0: &0x1088779d98f58191ab82c7573dfa1120ba891f0630714e5669ed926835640cda::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x2::url::Url, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : Test {
        assert!(0x1088779d98f58191ab82c7573dfa1120ba891f0630714e5669ed926835640cda::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg9)), 0);
        let v0 = 0x2::object::new(arg9);
        let v1 = TestMinted{
            test_id : 0x2::object::uid_to_inner(&v0),
            key     : arg7,
        };
        0x2::event::emit<TestMinted>(v1);
        Test{
            id          : v0,
            name        : arg1,
            website     : arg2,
            image_url   : arg3,
            video_url   : arg4,
            description : arg5,
            creator     : arg6,
            key         : arg7,
            attributes  : arg8,
        }
    }

    public fun mint_with_website_string(arg0: &0x1088779d98f58191ab82c7573dfa1120ba891f0630714e5669ed926835640cda::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : Test {
        mint_internal(arg0, arg1, 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg2)), arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun name(arg0: &Test) : 0x1::string::String {
        arg0.name
    }

    public fun validate_test_registry_policy_version(arg0: &TestRegistryPolicy) {
        assert!(arg0.version == 1, 1);
    }

    public fun video_url(arg0: &Test) : 0x1::string::String {
        arg0.video_url
    }

    public fun website(arg0: &Test) : 0x2::url::Url {
        arg0.website
    }

    // decompiled from Move bytecode v6
}

