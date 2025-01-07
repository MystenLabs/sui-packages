module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle {
    struct COLLECTION_BUNDLE has drop {
        dummy_field: bool,
    }

    struct CollectionBundle has store, key {
        id: 0x2::object::UID,
        valid_purchases: vector<u64>,
        count: u64,
    }

    struct CollectionBundlePurchased has copy, drop {
        object_id: 0x2::object::ID,
        purchaser: address,
        count: u64,
        maintainer_balance_change: u64,
    }

    struct CollectionBundleValueAdded has copy, drop {
        object_id: 0x2::object::ID,
        purchaser: address,
        count: u64,
        maintainer_balance_change: u64,
    }

    public entry fun add_value(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: &mut CollectionBundle, arg2: u64, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::pay_for_bundle(arg2, arg3, arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::increment_bundle_count(arg2, arg0);
        arg1.count = arg1.count + arg2;
        let v3 = CollectionBundleValueAdded{
            object_id                 : 0x2::object::id<CollectionBundle>(arg1),
            purchaser                 : v0,
            count                     : arg2,
            maintainer_balance_change : v1,
        };
        0x2::event::emit<CollectionBundleValueAdded>(v3);
    }

    public entry fun admin_create(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: u64, arg2: vector<u64>, arg3: address, arg4: &0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            assert!(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::is_valid_bundle_purchase(arg0, 0x1::vector::borrow<u64>(&arg2, v0)), 3);
            v0 = v0 + 1;
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::increment_bundle_count(arg1, arg0);
        let v1 = CollectionBundle{
            id              : 0x2::object::new(arg5),
            valid_purchases : arg2,
            count           : arg1,
        };
        0x2::transfer::public_transfer<CollectionBundle>(v1, arg3);
    }

    public fun assert_valid_purchase(arg0: &CollectionBundle, arg1: u64) {
        assert!(0x1::vector::contains<u64>(&arg0.valid_purchases, &arg1), 3);
    }

    public fun count(arg0: &CollectionBundle) : u64 {
        arg0.count
    }

    public(friend) fun decrement(arg0: &mut CollectionBundle, arg1: u64) {
        assert!(arg0.count >= arg1, 0);
        arg0.count = arg0.count - arg1;
    }

    public entry fun destroy(arg0: CollectionBundle) {
        assert!(arg0.count == 0, 2);
        let CollectionBundle {
            id              : v0,
            valid_purchases : _,
            count           : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: COLLECTION_BUNDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x2::package::claim<COLLECTION_BUNDLE>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Collection Bundle"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://arweave.net/4wuv64FYFUH2T3l6Fo0F1FeBu3_6qJ705KVzEtUaR-E"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A bundle for use in The Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thecollection.ai"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://arweave.net/K_N97SKiJU-jv-O4_7MwEwRnuGt5z7rJJp3GKJcRqBs"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A collection of AI art as selected by the community in a unique voting process."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Ethos"));
        let v5 = 0x2::display::new_with_fields<CollectionBundle>(&v2, v0, v3, arg1);
        0x2::display::update_version<CollectionBundle>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CollectionBundle>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun purchase(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: u64, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            assert!(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::is_valid_bundle_purchase(arg0, 0x1::vector::borrow<u64>(&arg2, v0)), 3);
            v0 = v0 + 1;
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let (v2, v3) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::pay_for_bundle(arg1, arg3, arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::increment_bundle_count(arg1, arg0);
        let v4 = CollectionBundle{
            id              : 0x2::object::new(arg4),
            valid_purchases : arg2,
            count           : arg1,
        };
        let v5 = CollectionBundlePurchased{
            object_id                 : 0x2::object::id<CollectionBundle>(&v4),
            purchaser                 : v1,
            count                     : arg1,
            maintainer_balance_change : v2,
        };
        0x2::event::emit<CollectionBundlePurchased>(v5);
        0x2::transfer::public_transfer<CollectionBundle>(v4, v1);
    }

    // decompiled from Move bytecode v6
}

