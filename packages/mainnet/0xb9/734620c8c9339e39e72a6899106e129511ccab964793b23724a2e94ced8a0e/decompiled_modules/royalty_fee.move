module 0xb9734620c8c9339e39e72a6899106e129511ccab964793b23724a2e94ced8a0e::royalty_fee {
    struct RoyaltyBag has store, key {
        id: 0x2::object::UID,
        admin: address,
        royalties: 0x2::bag::Bag,
    }

    struct RoyaltyNftTypeItem has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        creator: address,
        bps: u16,
    }

    public fun charge_royalty<T0>(arg0: &mut RoyaltyBag, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.royalties, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
            return 0
        };
        let v0 = 0x2::bag::borrow<0x1::ascii::String, RoyaltyNftTypeItem>(&arg0.royalties, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = (((arg1 as u128) * (v0.bps as u128) / 10000) as u64);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3), v0.creator);
        };
        v1
    }

    public fun init_royalty_bag(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyBag{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            royalties : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<RoyaltyBag>(v0);
    }

    public entry fun set_admin(arg0: &mut RoyaltyBag, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    public entry fun set_royalty<T0>(arg0: &mut RoyaltyBag, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = RoyaltyNftTypeItem{
            id       : 0x2::object::new(arg3),
            nft_type : v0,
            creator  : arg1,
            bps      : arg2,
        };
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.royalties, v0)) {
            let RoyaltyNftTypeItem {
                id       : v2,
                nft_type : _,
                creator  : _,
                bps      : _,
            } = 0x2::bag::remove<0x1::ascii::String, RoyaltyNftTypeItem>(&mut arg0.royalties, v0);
            0x2::object::delete(v2);
        };
        0x2::bag::add<0x1::ascii::String, RoyaltyNftTypeItem>(&mut arg0.royalties, v0, v1);
    }

    // decompiled from Move bytecode v6
}

