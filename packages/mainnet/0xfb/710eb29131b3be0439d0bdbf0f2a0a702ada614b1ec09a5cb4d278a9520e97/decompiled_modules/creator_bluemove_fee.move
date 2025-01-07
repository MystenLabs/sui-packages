module 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::creator_bluemove_fee {
    struct RoyaltyCollection has store, key {
        id: 0x2::object::UID,
        total: u64,
    }

    struct RoyaltyCollectionItem has store, key {
        id: 0x2::object::UID,
        collection_type: 0x1::string::String,
        creator: address,
        bps: u64,
    }

    struct Test_upgrade_new_struct has copy, drop {
        message: 0x1::string::String,
        sender: address,
    }

    public entry fun add_royalty_collection<T0>(arg0: &mut RoyaltyCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        let v0 = 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::utils::get_token_name<T0>();
        let v1 = RoyaltyCollectionItem{
            id              : 0x2::object::new(arg3),
            collection_type : v0,
            creator         : arg1,
            bps             : arg2,
        };
        0x2::dynamic_object_field::add<0x1::string::String, RoyaltyCollectionItem>(&mut arg0.id, v0, v1);
        arg0.total = arg0.total + 1;
    }

    public fun caculate_royalty_collection<T0>(arg0: &mut RoyaltyCollection, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (address, 0x2::coin::Coin<0x2::sui::SUI>, u64, 0x1::string::String) {
        let v0 = 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::utils::get_token_name<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyCollectionItem>(&mut arg0.id, v0);
        let v2 = arg1 * v1.bps / 10000;
        (v1.creator, 0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), v2, v0)
    }

    public fun check_exists_royalty_collection<T0>(arg0: &mut RoyaltyCollection, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::string::String, RoyaltyCollectionItem>(&mut arg0.id, 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::utils::get_token_name<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyCollection{
            id    : 0x2::object::new(arg0),
            total : 0,
        };
        0x2::transfer::public_share_object<RoyaltyCollection>(v0);
    }

    public entry fun update_royalty_collection<T0>(arg0: &mut RoyaltyCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyCollectionItem>(&mut arg0.id, 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::utils::get_token_name<T0>());
        assert!(v0.creator == arg1, 1);
        v0.bps = arg2;
    }

    // decompiled from Move bytecode v6
}

