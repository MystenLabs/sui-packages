module 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
    }

    struct ListingMeta has drop, store {
        seller: address,
        price: u64,
        is_primary: bool,
        kind: u8,
    }

    struct CountryKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct LandmarkKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct MetaKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct Listed has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        is_primary: bool,
        kind: u8,
    }

    struct Purchased has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        fee: u64,
        is_primary: bool,
        kind: u8,
    }

    struct Delisted has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
        kind: u8,
    }

    public fun buy_country(arg0: &mut Marketplace, arg1: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        let v0 = MetaKey{nft_id: arg2};
        assert!(0x2::dynamic_field::exists<MetaKey>(&arg0.id, v0), 32);
        let v1 = MetaKey{nft_id: arg2};
        let v2 = 0x2::dynamic_field::remove<MetaKey, ListingMeta>(&mut arg0.id, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v2.price, 30);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = CountryKey{nft_id: arg2};
        let v5 = Purchased{
            nft_id     : arg2,
            buyer      : v3,
            seller     : v2.seller,
            price      : v2.price,
            fee        : settle_payment(arg1, arg3, v2.seller, v2.price, v2.is_primary, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::ops_wallet(arg1), arg4),
            is_primary : v2.is_primary,
            kind       : 0,
        };
        0x2::event::emit<Purchased>(v5);
        0x2::transfer::public_transfer<0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country>(0x2::dynamic_object_field::remove<CountryKey, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country>(&mut arg0.id, v4), v3);
    }

    public fun buy_landmark(arg0: &mut Marketplace, arg1: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        let v0 = MetaKey{nft_id: arg2};
        assert!(0x2::dynamic_field::exists<MetaKey>(&arg0.id, v0), 32);
        let v1 = MetaKey{nft_id: arg2};
        let v2 = 0x2::dynamic_field::remove<MetaKey, ListingMeta>(&mut arg0.id, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v2.price, 30);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = LandmarkKey{nft_id: arg2};
        let v5 = Purchased{
            nft_id     : arg2,
            buyer      : v3,
            seller     : v2.seller,
            price      : v2.price,
            fee        : settle_payment(arg1, arg3, v2.seller, v2.price, v2.is_primary, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::ops_wallet(arg1), arg4),
            is_primary : v2.is_primary,
            kind       : 1,
        };
        0x2::event::emit<Purchased>(v5);
        0x2::transfer::public_transfer<0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark>(0x2::dynamic_object_field::remove<LandmarkKey, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark>(&mut arg0.id, v4), v3);
    }

    public fun delist_country(arg0: &mut Marketplace, arg1: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        let v0 = MetaKey{nft_id: arg2};
        assert!(0x2::dynamic_field::exists<MetaKey>(&arg0.id, v0), 32);
        let v1 = MetaKey{nft_id: arg2};
        let v2 = 0x2::dynamic_field::remove<MetaKey, ListingMeta>(&mut arg0.id, v1);
        assert!(0x2::tx_context::sender(arg3) == v2.seller, 31);
        let v3 = CountryKey{nft_id: arg2};
        let v4 = Delisted{
            nft_id : arg2,
            seller : v2.seller,
            kind   : 0,
        };
        0x2::event::emit<Delisted>(v4);
        0x2::transfer::public_transfer<0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country>(0x2::dynamic_object_field::remove<CountryKey, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country>(&mut arg0.id, v3), v2.seller);
    }

    public fun delist_landmark(arg0: &mut Marketplace, arg1: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        let v0 = MetaKey{nft_id: arg2};
        assert!(0x2::dynamic_field::exists<MetaKey>(&arg0.id, v0), 32);
        let v1 = MetaKey{nft_id: arg2};
        let v2 = 0x2::dynamic_field::remove<MetaKey, ListingMeta>(&mut arg0.id, v1);
        assert!(0x2::tx_context::sender(arg3) == v2.seller, 31);
        let v3 = LandmarkKey{nft_id: arg2};
        let v4 = Delisted{
            nft_id : arg2,
            seller : v2.seller,
            kind   : 1,
        };
        0x2::event::emit<Delisted>(v4);
        0x2::transfer::public_transfer<0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark>(0x2::dynamic_object_field::remove<LandmarkKey, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark>(&mut arg0.id, v3), v2.seller);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun list_country(arg0: &mut Marketplace, arg1: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country>(&arg2);
        let v2 = CountryKey{nft_id: v1};
        0x2::dynamic_object_field::add<CountryKey, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country::Country>(&mut arg0.id, v2, arg2);
        let v3 = MetaKey{nft_id: v1};
        let v4 = ListingMeta{
            seller     : v0,
            price      : arg3,
            is_primary : arg4,
            kind       : 0,
        };
        0x2::dynamic_field::add<MetaKey, ListingMeta>(&mut arg0.id, v3, v4);
        let v5 = Listed{
            nft_id     : v1,
            seller     : v0,
            price      : arg3,
            is_primary : arg4,
            kind       : 0,
        };
        0x2::event::emit<Listed>(v5);
    }

    public fun list_landmark(arg0: &mut Marketplace, arg1: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark>(&arg2);
        let v2 = LandmarkKey{nft_id: v1};
        0x2::dynamic_object_field::add<LandmarkKey, 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark::Landmark>(&mut arg0.id, v2, arg2);
        let v3 = MetaKey{nft_id: v1};
        let v4 = ListingMeta{
            seller     : v0,
            price      : arg3,
            is_primary : arg4,
            kind       : 1,
        };
        0x2::dynamic_field::add<MetaKey, ListingMeta>(&mut arg0.id, v3, v4);
        let v5 = Listed{
            nft_id     : v1,
            seller     : v0,
            price      : arg3,
            is_primary : arg4,
            kind       : 1,
        };
        0x2::event::emit<Listed>(v5);
    }

    fun settle_payment(arg0: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: bool, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg5);
            arg3
        } else {
            let (v1, v2) = 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::split_fee<0x2::sui::SUI>(arg0, arg1, arg6);
            let v3 = v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg5);
            0x2::coin::value<0x2::sui::SUI>(&v3)
        }
    }

    // decompiled from Move bytecode v7
}

