module 0x83724f616a6a964967a50018812361edb93270b34f9db6d780a10c1b932d9393::lootbox {
    struct AdminGranted has copy, drop {
        admin: address,
    }

    struct HouseCreated has copy, drop {
        house_id: 0x2::object::ID,
        pub_key: vector<u8>,
        init_fund_amount: u64,
    }

    struct TopUp has copy, drop {
        house_id: 0x2::object::ID,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        house_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct LootboxCategoryCreated has copy, drop {
        category_id: 0x2::object::ID,
        name: 0x1::string::String,
        price: u64,
    }

    struct LootboxCategoryDeleted has copy, drop {
        category_id: 0x2::object::ID,
    }

    struct LootboxCategoryPriceChanged has copy, drop {
        category_id: 0x2::object::ID,
        price: u64,
    }

    struct LootboxSettingForSuiRewardAdded has copy, drop {
        category_id: 0x2::object::ID,
        house_id: 0x2::object::ID,
        sui_amount: u64,
        portion: u64,
    }

    struct LootboxSettingForNftRewardAdded has copy, drop {
        category_id: 0x2::object::ID,
        house_id: 0x2::object::ID,
        nft_group: 0x1::string::String,
        portion: u64,
    }

    struct LootboxSettingAtIndexRemoved has copy, drop {
        category_id: 0x2::object::ID,
        house_id: 0x2::object::ID,
        setting_index_to_remove: u64,
    }

    struct NftToGroupAssigned has copy, drop {
        house_id: 0x2::object::ID,
        nft_group: 0x1::string::String,
        id: 0x2::object::ID,
    }

    struct NftGivenBack has copy, drop {
        house_id: 0x2::object::ID,
        nft_group: 0x1::string::String,
        index: u64,
    }

    struct LootboxBought has copy, drop {
        lootbox_id: 0x2::object::ID,
        player: address,
        lootbox_category_id: 0x2::object::ID,
        purchased_at: u64,
    }

    struct LootboxOpenedWithNoReward has copy, drop {
        lootbox_id: 0x2::object::ID,
        opened_at: u64,
    }

    struct LootboxOpenedWithSuiReward has copy, drop {
        lootbox_id: 0x2::object::ID,
        opened_at: u64,
        sui_amount: u64,
    }

    struct LootboxOpenedWithNftReward has copy, drop {
        lootbox_id: 0x2::object::ID,
        opened_at: u64,
        nft_id: 0x2::object::ID,
    }

    struct House has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        lootbox_categories: vector<LootboxCategory>,
        nft_groups: 0x2::table::Table<0x1::string::String, vector<0x2::object::ID>>,
        nft_containers: 0x2::bag::Bag,
    }

    struct LootboxCategory has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        nft_type: 0x1::string::String,
        price: u64,
        lootbox_settings: vector<LootboxSetting>,
    }

    struct LootboxSetting has drop, store {
        type: u8,
        portion: u64,
        sui_amount: 0x1::option::Option<u64>,
        nft_group: 0x1::option::Option<0x1::string::String>,
    }

    struct Lootbox has store, key {
        id: 0x2::object::UID,
        player: address,
        seed: vector<u8>,
        lootbox_category_id: 0x2::object::ID,
        opened: bool,
        purchased_at: u64,
        opened_at: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LOOTBOX has drop {
        dummy_field: bool,
    }

    public entry fun add_lootbox_setting_for_nft_reward(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<LootboxCategory>(&mut arg1.lootbox_categories, arg2);
        assert!(get_all_portions(&v0.lootbox_settings, arg4) <= 10000, 0);
        let v1 = LootboxSetting{
            type       : 1,
            portion    : arg4,
            sui_amount : 0x1::option::none<u64>(),
            nft_group  : 0x1::option::some<0x1::string::String>(arg3),
        };
        0x1::vector::push_back<LootboxSetting>(&mut v0.lootbox_settings, v1);
        let v2 = LootboxSettingForNftRewardAdded{
            category_id : 0x2::object::uid_to_inner(&v0.id),
            house_id    : 0x2::object::uid_to_inner(&arg1.id),
            nft_group   : arg3,
            portion     : arg4,
        };
        0x2::event::emit<LootboxSettingForNftRewardAdded>(v2);
    }

    public entry fun add_lootbox_setting_for_sui_reward(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<LootboxCategory>(&mut arg1.lootbox_categories, arg2);
        assert!(get_all_portions(&v0.lootbox_settings, arg4) <= 10000, 0);
        let v1 = LootboxSetting{
            type       : 0,
            portion    : arg4,
            sui_amount : 0x1::option::some<u64>(arg3),
            nft_group  : 0x1::option::none<0x1::string::String>(),
        };
        0x1::vector::push_back<LootboxSetting>(&mut v0.lootbox_settings, v1);
        let v2 = LootboxSettingForSuiRewardAdded{
            category_id : 0x2::object::uid_to_inner(&v0.id),
            house_id    : 0x2::object::uid_to_inner(&arg1.id),
            sui_amount  : arg3,
            portion     : arg4,
        };
        0x2::event::emit<LootboxSettingForSuiRewardAdded>(v2);
    }

    public entry fun assign_nft_to_group<T0: store + key>(arg0: &AdminCap, arg1: &mut House, arg2: T0, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg2);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg1.nft_containers, v0, arg2);
        let v1 = &mut arg1.nft_groups;
        if (!0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(v1, arg3)) {
            0x2::table::add<0x1::string::String, vector<0x2::object::ID>>(v1, arg3, 0x1::vector::singleton<0x2::object::ID>(v0));
        } else {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(v1, arg3), v0);
        };
        let v2 = NftToGroupAssigned{
            house_id  : 0x2::object::uid_to_inner(&arg1.id),
            nft_group : arg3,
            id        : v0,
        };
        0x2::event::emit<NftToGroupAssigned>(v2);
    }

    public entry fun buy_lootbox(arg0: &mut House, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_category_index_by_id(arg0, arg3);
        assert!(v0, 1);
        let v2 = get_category_by_index(arg0, v1);
        assert!(0x2::object::uid_to_inner(&v2.id) == arg3, 2);
        assert!(v2.price == 0x2::coin::value<0x2::sui::SUI>(&arg2), 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v3 = 0x2::object::new(arg5);
        let v4 = Lootbox{
            id                  : v3,
            player              : 0x2::tx_context::sender(arg5),
            seed                : arg1,
            lootbox_category_id : arg3,
            opened              : false,
            purchased_at        : 0x2::clock::timestamp_ms(arg4),
            opened_at           : 0,
        };
        0x2::transfer::share_object<Lootbox>(v4);
        let v5 = LootboxBought{
            lootbox_id          : 0x2::object::uid_to_inner(&v3),
            player              : 0x2::tx_context::sender(arg5),
            lootbox_category_id : arg3,
            purchased_at        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LootboxBought>(v5);
    }

    public entry fun change_lootbox_category_price(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<LootboxCategory>(&mut arg1.lootbox_categories, arg2);
        v0.price = arg3;
        let v1 = LootboxCategoryPriceChanged{
            category_id : 0x2::object::uid_to_inner(&v0.id),
            price       : arg3,
        };
        0x2::event::emit<LootboxCategoryPriceChanged>(v1);
    }

    public entry fun create_house(arg0: &AdminCap, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = House{
            id                 : v0,
            pub_key            : arg1,
            pool               : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            lootbox_categories : 0x1::vector::empty<LootboxCategory>(),
            nft_groups         : 0x2::table::new<0x1::string::String, vector<0x2::object::ID>>(arg3),
            nft_containers     : 0x2::bag::new(arg3),
        };
        0x2::transfer::share_object<House>(v1);
        let v2 = HouseCreated{
            house_id         : 0x2::object::uid_to_inner(&v0),
            pub_key          : arg1,
            init_fund_amount : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<HouseCreated>(v2);
    }

    public entry fun create_lootbox_category(arg0: &AdminCap, arg1: &mut House, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = LootboxCategory{
            id               : v0,
            name             : arg2,
            nft_type         : arg3,
            price            : arg4,
            lootbox_settings : 0x1::vector::empty<LootboxSetting>(),
        };
        0x1::vector::push_back<LootboxCategory>(&mut arg1.lootbox_categories, v1);
        let v2 = LootboxCategoryCreated{
            category_id : 0x2::object::uid_to_inner(&v0),
            name        : arg2,
            price       : arg4,
        };
        0x2::event::emit<LootboxCategoryCreated>(v2);
    }

    public entry fun delete_lootbox_category(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let LootboxCategory {
            id               : v0,
            name             : _,
            nft_type         : _,
            price            : _,
            lootbox_settings : _,
        } = 0x1::vector::remove<LootboxCategory>(&mut arg1.lootbox_categories, arg2);
        let v5 = v0;
        0x2::object::delete(v5);
        let v6 = LootboxCategoryDeleted{category_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<LootboxCategoryDeleted>(v6);
    }

    fun get_all_portions(arg0: &vector<LootboxSetting>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<LootboxSetting>(arg0)) {
            v1 = 0x1::vector::borrow<LootboxSetting>(arg0, v0).portion + v1;
            v0 = v0 + 1;
        };
        v1 + arg1
    }

    public entry fun get_back_nft<T0: store + key>(arg0: &AdminCap, arg1: &mut House, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<0x2::object::ID, T0>(&mut arg1.nft_containers, nft_id_for_group_at_index(arg1, arg2, arg3)), 0x2::tx_context::sender(arg4));
        0x1::vector::remove<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg1.nft_groups, arg2), arg3);
        let v0 = NftGivenBack{
            house_id  : 0x2::object::uid_to_inner(&arg1.id),
            nft_group : arg2,
            index     : arg3,
        };
        0x2::event::emit<NftGivenBack>(v0);
    }

    public fun get_category_by_index(arg0: &House, arg1: u64) : &LootboxCategory {
        0x1::vector::borrow<LootboxCategory>(&arg0.lootbox_categories, arg1)
    }

    public fun get_category_id_by_index(arg0: &House, arg1: u64) : 0x2::object::ID {
        0x2::object::uid_to_inner(&0x1::vector::borrow<LootboxCategory>(&arg0.lootbox_categories, arg1).id)
    }

    public fun get_category_index_by_id(arg0: &House, arg1: 0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LootboxCategory>(&arg0.lootbox_categories)) {
            if (0x2::object::uid_to_inner(&0x1::vector::borrow<LootboxCategory>(&arg0.lootbox_categories, v0).id) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_lootbox_setting_index_from_remainder(arg0: &vector<LootboxSetting>, arg1: u64) : (bool, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<LootboxSetting>(arg0)) {
            let v2 = 0x1::vector::borrow<LootboxSetting>(arg0, v0);
            if (arg1 >= v1 && arg1 < v2.portion + v1) {
                return (true, v0)
            };
            v1 = v1 + v2.portion;
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public entry fun grant_admin_cap_to(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
        let v1 = AdminGranted{admin: arg1};
        0x2::event::emit<AdminGranted>(v1);
    }

    public fun house_pub_key(arg0: &House) : vector<u8> {
        arg0.pub_key
    }

    fun init(arg0: LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOOTBOX>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = AdminGranted{admin: v0};
        0x2::event::emit<AdminGranted>(v2);
    }

    public fun lootbox_exists(arg0: &House, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lootbox>(&arg0.id, arg1)
    }

    public fun nft_at_id<T0: store + key>(arg0: &House, arg1: 0x2::object::ID) : &T0 {
        0x2::bag::borrow<0x2::object::ID, T0>(&arg0.nft_containers, arg1)
    }

    public fun nft_group(arg0: &House, arg1: 0x1::string::String) : &vector<0x2::object::ID> {
        0x2::table::borrow<0x1::string::String, vector<0x2::object::ID>>(&arg0.nft_groups, arg1)
    }

    public fun nft_id_for_group_at_index(arg0: &House, arg1: 0x1::string::String, arg2: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(nft_group(arg0, arg1), arg2)
    }

    public entry fun open_lootbox<T0: store + key>(arg0: &mut House, arg1: &mut Lootbox, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.opened, 5);
        arg1.opened = true;
        arg1.opened_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = 0x2::object::uid_to_bytes(&arg1.id);
        0x1::vector::append<u8>(&mut v0, arg1.seed);
        let v1 = house_pub_key(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v1, &v0), 6);
        let v2 = 0x2::hash::blake2b256(&arg2);
        let (v3, v4) = get_category_index_by_id(arg0, arg1.lootbox_category_id);
        assert!(v3, 1);
        let v5 = get_category_by_index(arg0, v4);
        assert!(0x2::object::uid_to_inner(&v5.id) == arg1.lootbox_category_id, 2);
        let v6 = &v5.lootbox_settings;
        let (v7, v8) = get_lootbox_setting_index_from_remainder(v6, safe_selection(10000, &v2));
        if (v7) {
            let v9 = 0x1::vector::borrow<LootboxSetting>(v6, v8);
            if (v9.type == 1) {
                let v10 = v9.nft_group;
                assert!(!0x1::option::is_none<0x1::string::String>(&v10), 9);
                let v11 = 0x1::option::borrow<0x1::string::String>(&v10);
                let v12 = nft_id_for_group_at_index(arg0, *v11, 0);
                0x2::transfer::public_transfer<T0>(0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.nft_containers, v12), arg1.player);
                0x1::vector::remove<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.nft_groups, *v11), 0);
                let v13 = LootboxOpenedWithNftReward{
                    lootbox_id : 0x2::object::uid_to_inner(&arg1.id),
                    opened_at  : 0x2::clock::timestamp_ms(arg3),
                    nft_id     : v12,
                };
                0x2::event::emit<LootboxOpenedWithNftReward>(v13);
            } else if (v9.type == 0) {
                let v14 = v9.sui_amount;
                assert!(!0x1::option::is_none<u64>(&v14), 8);
                let v15 = 0x1::option::borrow<u64>(&v14);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, *v15), arg4), arg1.player);
                let v16 = LootboxOpenedWithSuiReward{
                    lootbox_id : 0x2::object::uid_to_inner(&arg1.id),
                    opened_at  : 0x2::clock::timestamp_ms(arg3),
                    sui_amount : *v15,
                };
                0x2::event::emit<LootboxOpenedWithSuiReward>(v16);
            };
        } else {
            let v17 = LootboxOpenedWithNoReward{
                lootbox_id : 0x2::object::uid_to_inner(&arg1.id),
                opened_at  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<LootboxOpenedWithNoReward>(v17);
        };
    }

    public entry fun remove_lootbox_setting_at_index(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<LootboxCategory>(&mut arg1.lootbox_categories, arg2);
        0x1::vector::remove<LootboxSetting>(&mut v0.lootbox_settings, arg3);
        let v1 = LootboxSettingAtIndexRemoved{
            category_id             : 0x2::object::uid_to_inner(&v0.id),
            house_id                : 0x2::object::uid_to_inner(&arg1.id),
            setting_index_to_remove : arg3,
        };
        0x2::event::emit<LootboxSettingAtIndexRemoved>(v1);
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 7);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public entry fun top_up(arg0: &AdminCap, arg1: &mut House, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = TopUp{
            house_id : 0x2::object::uid_to_inner(&arg1.id),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<TopUp>(v0);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.pool), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool, arg2, arg4), arg3);
        let v0 = Withdraw{
            house_id  : 0x2::object::uid_to_inner(&arg1.id),
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

