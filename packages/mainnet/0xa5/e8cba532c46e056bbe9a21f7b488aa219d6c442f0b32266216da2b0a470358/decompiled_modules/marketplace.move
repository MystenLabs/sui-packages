module 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::marketplace {
    struct Marketplace has store, key {
        id: 0x2::object::UID,
        main: Stand<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>,
        vip_fees: 0x2::table::Table<u64, u64>,
        base_trading_fee: u64,
        to_burn_fee: u64,
        team_fee: u64,
        rewards_fee: u64,
        referrer_fee: u64,
        version: u64,
    }

    struct Stand<phantom T0> has store, key {
        id: 0x2::object::UID,
        primary_listings: 0x2::table::Table<u64, Listing_P>,
        secondary_listings: 0x2::table::Table<u64, Listing>,
        primary_list_index: u64,
        secondary_list_index: u64,
    }

    struct Listing_P has store {
        item_id: address,
        price: u64,
    }

    struct Listing has store {
        coin_type: 0x1::type_name::TypeName,
        item_id: address,
        price: u64,
        seller: address,
        expire_at: u64,
    }

    struct WithdrawFeeProfitsRequest has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        to: address,
    }

    struct NewSecondaryListing has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        seller: address,
        item_id: address,
        listing_key: u64,
        expire_at: u64,
    }

    struct NewPrimaryListing has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        item_id: address,
        listing_key: u64,
    }

    struct ItemBought has copy, drop {
        is_primary_listing: bool,
        buyer_vip_level: u64,
        buyer: address,
        seller: address,
        coin_type: 0x1::type_name::TypeName,
        item_id: address,
        listing_key: u64,
    }

    struct ItemTake has copy, drop {
        seller: address,
        item_id: address,
        listing_key: u64,
    }

    struct VipFeeUpdate has copy, drop {
        vip_level: u64,
        fee: u64,
    }

    struct VipFeeRemove has copy, drop {
        vip_level: u64,
    }

    struct TradingFeeUpdate has copy, drop {
        new_base_fee: u64,
        new_to_burn_fee: u64,
        new_team_fee: u64,
        new_rewards_fee: u64,
        new_referrer_fee: u64,
    }

    fun assert_list_expire(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg1 >= arg0, 10);
        };
    }

    public fun buy_primary_arca<T0: store + key>(arg0: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg1: &mut Marketplace, arg2: u64, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(1 == arg1.version, 3);
        let v0 = &mut arg1.main;
        assert!(0x2::table::contains<u64, Listing_P>(&v0.primary_listings, arg2), 1);
        let Listing_P {
            item_id : v1,
            price   : v2,
        } = 0x2::table::remove<u64, Listing_P>(&mut v0.primary_listings, arg2);
        assert!(v2 == 0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg0), 0);
        put_coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(v0, arg0);
        let v3 = ItemBought{
            is_primary_listing : true,
            buyer_vip_level    : 0,
            buyer              : 0x2::tx_context::sender(arg3),
            seller             : @0x0,
            coin_type          : 0x1::type_name::get<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            item_id            : v1,
            listing_key        : arg2,
        };
        0x2::event::emit<ItemBought>(v3);
        0x2::dynamic_object_field::remove<address, T0>(&mut v0.id, v1)
    }

    public fun buy_secondary<T0: store + key, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut Marketplace, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(1 == arg2.version, 3);
        let v0 = &mut arg2.main;
        assert!(0x2::table::contains<u64, Listing>(&v0.secondary_listings, arg1), 1);
        let Listing {
            coin_type : v1,
            item_id   : v2,
            price     : v3,
            seller    : v4,
            expire_at : v5,
        } = 0x2::table::remove<u64, Listing>(&mut v0.secondary_listings, arg1);
        assert_list_expire(0x2::clock::timestamp_ms(arg3) / 1000, v5);
        assert!(v1 == 0x1::type_name::get<T1>(), 4);
        assert!(v3 == 0x2::coin::value<T1>(&arg0), 0);
        let v6 = &mut arg0;
        fee_distribution<T1>(v6, arg2.base_trading_fee, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, v4);
        let v7 = ItemBought{
            is_primary_listing : false,
            buyer_vip_level    : 0,
            buyer              : 0x2::tx_context::sender(arg4),
            seller             : v4,
            coin_type          : v1,
            item_id            : v2,
            listing_key        : arg1,
        };
        0x2::event::emit<ItemBought>(v7);
        0x2::dynamic_object_field::remove<address, T0>(&mut v0.id, v2)
    }

    public fun buy_secondary_vip<T0: store + key, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut Marketplace, arg3: &0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::StakingPool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(1 == arg2.version, 3);
        let v0 = &mut arg2.main;
        assert!(0x2::table::contains<u64, Listing>(&v0.secondary_listings, arg1), 1);
        let Listing {
            coin_type : v1,
            item_id   : v2,
            price     : v3,
            seller    : v4,
            expire_at : v5,
        } = 0x2::table::remove<u64, Listing>(&mut v0.secondary_listings, arg1);
        assert_list_expire(0x2::clock::timestamp_ms(arg4) / 1000, v5);
        assert!(v1 == 0x1::type_name::get<T1>(), 4);
        assert!(v3 == 0x2::coin::value<T1>(&arg0), 0);
        let v6 = 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::calc_vip_level(arg3, v4, arg4);
        let v7 = &mut arg0;
        fee_distribution<T1>(v7, *0x2::table::borrow_mut<u64, u64>(&mut arg2.vip_fees, v6), v0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, v4);
        let v8 = ItemBought{
            is_primary_listing : false,
            buyer_vip_level    : v6,
            buyer              : 0x2::tx_context::sender(arg5),
            seller             : v4,
            coin_type          : v1,
            item_id            : v2,
            listing_key        : arg1,
        };
        0x2::event::emit<ItemBought>(v8);
        0x2::dynamic_object_field::remove<address, T0>(&mut v0.id, v2)
    }

    public fun buy_secondary_vip_arca<T0: store + key>(arg0: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &mut Marketplace, arg4: &mut 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::StakingPool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(1 == arg3.version, 3);
        let v0 = &mut arg3.main;
        assert!(0x2::table::contains<u64, Listing>(&v0.secondary_listings, arg1), 1);
        let Listing {
            coin_type : v1,
            item_id   : v2,
            price     : v3,
            seller    : v4,
            expire_at : v5,
        } = 0x2::table::remove<u64, Listing>(&mut v0.secondary_listings, arg1);
        assert_list_expire(0x2::clock::timestamp_ms(arg5) / 1000, v5);
        assert!(v1 == 0x1::type_name::get<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(), 4);
        assert!(v3 == 0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg0), 0);
        let v6 = 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::calc_vip_level(arg4, v4, arg5);
        let v7 = &mut arg0;
        fee_distribution_arca(v7, arg2, *0x2::table::borrow_mut<u64, u64>(&mut arg3.vip_fees, v6), arg3.to_burn_fee, arg3.team_fee, arg3.rewards_fee, arg3.referrer_fee, v0, arg4, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(arg0, v4);
        let v8 = ItemBought{
            is_primary_listing : false,
            buyer_vip_level    : v6,
            buyer              : 0x2::tx_context::sender(arg6),
            seller             : v4,
            coin_type          : v1,
            item_id            : v2,
            listing_key        : arg1,
        };
        0x2::event::emit<ItemBought>(v8);
        0x2::dynamic_object_field::remove<address, T0>(&mut v0.id, v2)
    }

    fun fee_calculation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = (arg0 as u128) * (arg1 as u128) / 10000;
        (((v0 * (arg2 as u128) / 10000) as u64), ((v0 * (arg3 as u128) / 10000) as u64), ((v0 * (arg4 as u128) / 10000) as u64), ((v0 * (arg5 as u128) / 10000) as u64))
    }

    fun fee_distribution<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Stand<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg3: &mut 0x2::tx_context::TxContext) {
        put_coin<T0>(arg2, 0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64), arg3));
    }

    fun fee_distribution_arca(arg0: &mut 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg1: 0x1::option::Option<address>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut Stand<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg8: &mut 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::StakingPool, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = fee_calculation(0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0), arg2, arg3, arg4, arg5, arg6);
        put_coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg7, 0x2::coin::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0, v1, arg9));
        0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::marketplace_add_rewards(arg8, 0x2::coin::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0, v2, arg9));
        if (0x1::option::is_some<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(0x2::coin::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0, v3, arg9), 0x1::option::extract<address>(&mut arg1));
            0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::marketplace_add_to_burn(arg8, 0x2::coin::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0, v0, arg9));
        } else {
            0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking::marketplace_add_to_burn(arg8, 0x2::coin::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg0, v0 + v3, arg9));
        };
    }

    public fun get_fee_profits<T0>(arg0: &Marketplace) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.main.id, 0x1::type_name::get<T0>()))
    }

    public fun get_vip_fee(arg0: &Marketplace, arg1: u64) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.vip_fees, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stand<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>{
            id                   : 0x2::object::new(arg0),
            primary_listings     : 0x2::table::new<u64, Listing_P>(arg0),
            secondary_listings   : 0x2::table::new<u64, Listing>(arg0),
            primary_list_index   : 0,
            secondary_list_index : 0,
        };
        let v1 = 0x2::table::new<u64, u64>(arg0);
        0x2::table::add<u64, u64>(&mut v1, 0, 300);
        0x2::table::add<u64, u64>(&mut v1, 1, 300);
        0x2::table::add<u64, u64>(&mut v1, 2, 300);
        0x2::table::add<u64, u64>(&mut v1, 3, 300);
        0x2::table::add<u64, u64>(&mut v1, 4, 284);
        0x2::table::add<u64, u64>(&mut v1, 5, 268);
        0x2::table::add<u64, u64>(&mut v1, 6, 252);
        0x2::table::add<u64, u64>(&mut v1, 7, 236);
        0x2::table::add<u64, u64>(&mut v1, 8, 221);
        0x2::table::add<u64, u64>(&mut v1, 9, 205);
        0x2::table::add<u64, u64>(&mut v1, 10, 189);
        0x2::table::add<u64, u64>(&mut v1, 11, 173);
        0x2::table::add<u64, u64>(&mut v1, 12, 157);
        0x2::table::add<u64, u64>(&mut v1, 13, 141);
        0x2::table::add<u64, u64>(&mut v1, 14, 125);
        0x2::table::add<u64, u64>(&mut v1, 15, 109);
        0x2::table::add<u64, u64>(&mut v1, 16, 94);
        0x2::table::add<u64, u64>(&mut v1, 17, 78);
        0x2::table::add<u64, u64>(&mut v1, 18, 62);
        0x2::table::add<u64, u64>(&mut v1, 19, 46);
        0x2::table::add<u64, u64>(&mut v1, 20, 30);
        let v2 = Marketplace{
            id               : 0x2::object::new(arg0),
            main             : v0,
            vip_fees         : v1,
            base_trading_fee : 300,
            to_burn_fee      : 0,
            team_fee         : 10000,
            rewards_fee      : 0,
            referrer_fee     : 0,
            version          : 1,
        };
        0x2::transfer::public_share_object<Marketplace>(v2);
    }

    public entry fun list_primary_arca<T0: store + key>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut Marketplace, arg2: T0, arg3: u64, arg4: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(1 == arg1.version, 3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg4);
        let v0 = &mut arg1.main;
        let v1 = 0x2::object::id_address<T0>(&arg2);
        let v2 = Listing_P{
            item_id : v1,
            price   : arg3,
        };
        v0.primary_list_index = v0.primary_list_index + 1;
        let v3 = v0.primary_list_index;
        0x2::table::add<u64, Listing_P>(&mut v0.primary_listings, v3, v2);
        0x2::dynamic_object_field::add<address, T0>(&mut v0.id, v1, arg2);
        let v4 = NewPrimaryListing{
            coin_type   : 0x1::type_name::get<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            price       : arg3,
            item_id     : v1,
            listing_key : v3,
        };
        0x2::event::emit<NewPrimaryListing>(v4);
    }

    public entry fun list_secondary<T0: store + key, T1>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 3);
        assert_list_expire(0x2::clock::timestamp_ms(arg4) / 1000, arg3);
        let v0 = &mut arg0.main;
        let v1 = 0x2::object::id_address<T0>(&arg1);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = Listing{
            coin_type : v2,
            item_id   : v1,
            price     : arg2,
            seller    : 0x2::tx_context::sender(arg5),
            expire_at : arg3,
        };
        v0.secondary_list_index = v0.secondary_list_index + 1;
        let v4 = v0.secondary_list_index;
        0x2::table::add<u64, Listing>(&mut v0.secondary_listings, v4, v3);
        0x2::dynamic_object_field::add<address, T0>(&mut v0.id, v1, arg1);
        let v5 = NewSecondaryListing{
            coin_type   : v2,
            price       : arg2,
            seller      : 0x2::tx_context::sender(arg5),
            item_id     : v1,
            listing_key : v4,
            expire_at   : arg3,
        };
        0x2::event::emit<NewSecondaryListing>(v5);
    }

    public entry fun list_secondary_arca<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 3);
        assert_list_expire(0x2::clock::timestamp_ms(arg4) / 1000, arg3);
        let v0 = &mut arg0.main;
        let v1 = 0x2::object::id_address<T0>(&arg1);
        let v2 = 0x1::type_name::get<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>();
        let v3 = Listing{
            coin_type : v2,
            item_id   : v1,
            price     : arg2,
            seller    : 0x2::tx_context::sender(arg5),
            expire_at : arg3,
        };
        v0.secondary_list_index = v0.secondary_list_index + 1;
        let v4 = v0.secondary_list_index;
        0x2::table::add<u64, Listing>(&mut v0.secondary_listings, v4, v3);
        0x2::dynamic_object_field::add<address, T0>(&mut v0.id, v1, arg1);
        let v5 = NewSecondaryListing{
            coin_type   : v2,
            price       : arg2,
            seller      : 0x2::tx_context::sender(arg5),
            item_id     : v1,
            listing_key : v4,
            expire_at   : arg3,
        };
        0x2::event::emit<NewSecondaryListing>(v5);
    }

    entry fun migrate(arg0: &mut Marketplace, arg1: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg2: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(arg0.version < 1, 2);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    fun put_coin<T0>(arg0: &mut Stand<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public entry fun remove_vip_fees(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut Marketplace, arg2: u64, arg3: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(1 == arg1.version, 3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg3);
        assert!(0x2::table::contains<u64, u64>(&arg1.vip_fees, arg2), 6);
        0x2::table::remove<u64, u64>(&mut arg1.vip_fees, arg2);
        let v0 = VipFeeRemove{vip_level: arg2};
        0x2::event::emit<VipFeeRemove>(v0);
    }

    public fun take_item<T0: store + key>(arg0: u64, arg1: &mut Marketplace, arg2: &0x2::tx_context::TxContext) : T0 {
        assert!(1 == arg1.version, 3);
        let v0 = &mut arg1.main;
        assert!(0x2::table::contains<u64, Listing>(&v0.secondary_listings, arg0), 1);
        let Listing {
            coin_type : _,
            item_id   : v2,
            price     : _,
            seller    : v4,
            expire_at : _,
        } = 0x2::table::remove<u64, Listing>(&mut v0.secondary_listings, arg0);
        assert!(v4 == 0x2::tx_context::sender(arg2), 5);
        let v6 = ItemTake{
            seller      : v4,
            item_id     : v2,
            listing_key : arg0,
        };
        0x2::event::emit<ItemTake>(v6);
        0x2::dynamic_object_field::remove<address, T0>(&mut v0.id, v2)
    }

    public entry fun update_trading_fee(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut Marketplace, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(1 == arg1.version, 3);
        assert!(arg2 <= 10000, 9);
        assert!(arg3 + arg4 + arg5 + arg6 == 10000, 9);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg7);
        arg1.base_trading_fee = arg2;
        arg1.to_burn_fee = arg3;
        arg1.team_fee = arg4;
        arg1.rewards_fee = arg5;
        arg1.referrer_fee = arg6;
        let v0 = TradingFeeUpdate{
            new_base_fee     : arg2,
            new_to_burn_fee  : arg3,
            new_team_fee     : arg4,
            new_rewards_fee  : arg5,
            new_referrer_fee : arg6,
        };
        0x2::event::emit<TradingFeeUpdate>(v0);
    }

    public entry fun update_vip_fees(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut Marketplace, arg2: u64, arg3: u64, arg4: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(1 == arg1.version, 3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg4);
        if (0x2::table::contains<u64, u64>(&arg1.vip_fees, arg2)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg1.vip_fees, arg2) = arg3;
        } else {
            0x2::table::add<u64, u64>(&mut arg1.vip_fees, arg2, arg3);
        };
        let v0 = VipFeeUpdate{
            vip_level : arg2,
            fee       : arg3,
        };
        0x2::event::emit<VipFeeUpdate>(v0);
    }

    fun withdraw_fee_profits<T0>(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.main.id, 0x1::type_name::get<T0>())), arg2), arg1);
    }

    public entry fun withdraw_fee_profits_execute<T0>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut Marketplace, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(1 == arg4.version, 3);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_multi_sig_scope(arg1, arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<WithdrawFeeProfitsRequest>(arg1, &arg2, arg5);
                assert!(v2.coin_type == 0x1::type_name::get<T0>(), 7);
                withdraw_fee_profits<T0>(arg4, v2.to, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 8
    }

    public entry fun withdraw_fee_profits_request<T0>(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_multi_sig_scope(arg1, arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_participant(arg1, arg3);
        let v0 = WithdrawFeeProfitsRequest{
            id        : 0x2::object::new(arg3),
            coin_type : 0x1::type_name::get<T0>(),
            to        : arg2,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<WithdrawFeeProfitsRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<WithdrawFeeProfitsRequest>(arg1, *0x1::string::bytes(&v1), 7, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

