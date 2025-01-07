module 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SettleCap has store, key {
        id: 0x2::object::UID,
    }

    struct DividendManager has key {
        id: 0x2::object::UID,
        dividends: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<u64, DividendInfo>,
        venft_dividends: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, VeNFTDividendInfo>,
        bonus_types: vector<0x1::type_name::TypeName>,
        start_time: u64,
        interval_day: u8,
        balances: 0x2::bag::Bag,
        is_open: bool,
        package_version: u64,
    }

    struct VeNFTDividendInfo has drop, store {
        dividends: 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>,
    }

    struct DividendInfo has drop, store {
        register_time: u64,
        settled_num: u64,
        is_settled: bool,
        bonus_types: vector<0x1::type_name::TypeName>,
        bonus: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        redeemed_num: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct InitEvent has copy, drop, store {
        admin_id: 0x2::object::ID,
        settle_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
    }

    struct AddBonusEvent has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct RemoveBonusEvent has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct RegisterEvent has copy, drop, store {
        phase: u64,
        amount: u64,
    }

    struct UpdateDividendInfoEvent has copy, drop, store {
        phase: u64,
        amount_before: u64,
        amount: u64,
    }

    struct SettleEvent has copy, drop, store {
        phase: u64,
        start: vector<0x2::object::ID>,
        limit: u64,
        next_id: 0x1::option::Option<0x2::object::ID>,
        count: u64,
    }

    struct RedeemEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        phases: vector<u64>,
        redeemed_nums: 0x2::vec_map::VecMap<u64, u64>,
        amount: u64,
    }

    struct ReceiveEvent has copy, drop, store {
        amount: u64,
    }

    struct RedeemAllEvent has copy, drop, store {
        receiver: address,
        amount: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    fun add_dividend(arg0: &mut DividendManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64) : bool {
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, arg1)) {
            let v0 = VeNFTDividendInfo{dividends: 0x2::vec_map::empty<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>()};
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, arg1, v0);
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, arg1);
        if (!0x2::vec_map::contains<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, &arg2)) {
            0x2::vec_map::insert<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, arg2, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>());
        };
        let v2 = 0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, &arg2);
        let v3 = false;
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v2, &arg3)) {
            v3 = true;
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v2, arg3, arg4);
        };
        v3
    }

    public fun checked_package_version(arg0: &DividendManager) {
        assert!(arg0.package_version <= 1, 7);
    }

    public entry fun close(arg0: &AdminCap, arg1: &mut DividendManager) {
        checked_package_version(arg1);
        arg1.is_open = false;
    }

    public fun deposit<T0>(arg0: &mut DividendManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 4);
        checked_package_version(arg0);
        let v0 = key<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        };
        let v1 = ReceiveEvent{amount: arg2};
        0x2::event::emit<ReceiveEvent>(v1);
    }

    fun increase_redeem(arg0: &mut DividendManager, arg1: 0x2::vec_map::VecMap<u64, u64>, arg2: 0x1::type_name::TypeName) {
        let v0 = 0;
        let (v1, v2) = 0x2::vec_map::into_keys_values<u64, u64>(arg1);
        let v3 = v2;
        let v4 = v1;
        while (v0 < 0x1::vector::length<u64>(&v4)) {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg0.dividends, *0x1::vector::borrow<u64>(&v4, v0)).redeemed_num, &arg2);
            *v5 = *v5 + *0x1::vector::borrow<u64>(&v3, v0);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SettleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SettleCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v2 = DividendManager{
            id              : 0x2::object::new(arg0),
            dividends       : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<u64, DividendInfo>(arg0),
            venft_dividends : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, VeNFTDividendInfo>(arg0),
            bonus_types     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            start_time      : 0,
            interval_day    : 7,
            balances        : 0x2::bag::new(arg0),
            is_open         : true,
            package_version : 1,
        };
        let v3 = InitEvent{
            admin_id   : 0x2::object::id<AdminCap>(&v0),
            settle_id  : 0x2::object::id<SettleCap>(&v1),
            manager_id : 0x2::object::id<DividendManager>(&v2),
        };
        0x2::event::emit<InitEvent>(v3);
        0x2::transfer::share_object<DividendManager>(v2);
    }

    fun key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun push_bonus<T0>(arg0: &AdminCap, arg1: &mut DividendManager) {
        checked_package_version(arg1);
        assert!(arg1.is_open, 4);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.bonus_types, &v0), 11);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.bonus_types, 0x1::type_name::get<T0>());
        let v1 = AddBonusEvent{type: 0x1::type_name::get<T0>()};
        0x2::event::emit<AddBonusEvent>(v1);
    }

    public fun redeem<T0>(arg0: &mut DividendManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(arg1);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, VeNFTDividendInfo>(&arg0.venft_dividends, v0), 8);
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, VeNFTDividendInfo>(&mut arg0.venft_dividends, v0);
        let v2 = 0;
        let v3 = 0x2::vec_map::keys<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&v1.dividends);
        let v4 = 0;
        let v5 = 0x2::vec_map::empty<u64, u64>();
        let v6 = key<T0>();
        while (v2 < 0x2::vec_map::size<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&v1.dividends)) {
            let v7 = 0x1::vector::borrow<u64>(&v3, v2);
            let v8 = 0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, v7);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v8, &v6)) {
                let (_, v10) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(v8, &v6);
                v4 = v4 + v10;
                0x2::vec_map::insert<u64, u64>(&mut v5, *v7, v10);
            };
            if (0x2::vec_map::size<0x1::type_name::TypeName, u64>(v8) == 0) {
                let (_, _) = 0x2::vec_map::remove<u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut v1.dividends, v7);
            };
            v2 = v2 + 1;
        };
        let v13 = take<T0>(arg0, v4);
        increase_redeem(arg0, v5, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg2), 0x2::tx_context::sender(arg2));
        let v14 = RedeemEvent{
            venft_id      : 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(arg1),
            phases        : v3,
            redeemed_nums : v5,
            amount        : v4,
        };
        0x2::event::emit<RedeemEvent>(v14);
    }

    public entry fun redeem_extra<T0>(arg0: &AdminCap, arg1: &mut DividendManager, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<u64, DividendInfo>(&arg1.dividends)) {
            let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, v1);
            if (v2.is_settled) {
                let v3 = key<T0>();
                let v4 = key<T0>();
                let v5 = v0 + *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v2.bonus, &v3);
                v0 = v5 - *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v2.redeemed_num, &v4);
            };
            v1 = v1 + 1;
        };
        assert!(arg3 <= 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, key<T0>())) - v0, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(take<T0>(arg1, arg3), arg4), arg2);
        let v6 = RedeemAllEvent{
            receiver : arg2,
            amount   : arg3,
        };
        0x2::event::emit<RedeemAllEvent>(v6);
    }

    public fun register_bonus<T0>(arg0: &AdminCap, arg1: &mut DividendManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1.is_open, 4);
        if (arg2 > 1) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg2 - 1), 2);
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&mut arg1.dividends, arg2 - 1).is_settled, 2);
        };
        checked_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.bonus_types, &v0), 3);
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg2)) {
            let v1 = DividendInfo{
                register_time : 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::now_timestamp(arg4),
                settled_num   : 0,
                is_settled    : false,
                bonus_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
                bonus         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                redeemed_num  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<u64, DividendInfo>(&mut arg1.dividends, arg2, v1);
        };
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, arg2);
        let v3 = key<T0>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.bonus, v3, arg3);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.redeemed_num, v3, 0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2.bonus_types, 0x1::type_name::get<T0>());
        let v4 = RegisterEvent{
            phase  : arg2,
            amount : arg3,
        };
        0x2::event::emit<RegisterEvent>(v4);
    }

    public fun remove_bonus<T0>(arg0: &AdminCap, arg1: &mut DividendManager) {
        checked_package_version(arg1);
        assert!(arg1.is_open, 4);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&mut arg1.bonus_types, &v0);
        assert!(v1, 0);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.bonus_types, v2);
        let v3 = RemoveBonusEvent{type: 0x1::type_name::get<T0>()};
        0x2::event::emit<RemoveBonusEvent>(v3);
    }

    public fun settle(arg0: &SettleCap, arg1: &mut DividendManager, arg2: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64) : 0x1::option::Option<0x2::object::ID> {
        checked_package_version(arg1);
        assert!(arg1.is_open, 4);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg3), 5);
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg3).is_settled, 1);
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::nfts(arg2);
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg4)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(v0)
        } else {
            assert!(0x1::vector::length<0x2::object::ID>(&arg4) == 1, 6);
            0x1::option::some<0x2::object::ID>(0x1::vector::pop_back<0x2::object::ID>(&mut arg4))
        };
        let v2 = v1;
        if (0x1::option::is_none<0x2::object::ID>(&v2)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&mut arg1.dividends, arg3).bonus_types;
        let v6 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg3).bonus;
        while (0x1::option::is_some<0x2::object::ID>(&v2) && v3 < arg5) {
            let v7 = *0x1::option::borrow<0x2::object::ID>(&v2);
            let v8 = 0;
            let v9 = false;
            while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
                let v10 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v8);
                v9 = add_dividend(arg1, v7, arg3, v10, (((0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::xcetus_amount(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(v0, v7)) as u128) * (*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v6, &v10) as u128) / (0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::totol_amount(arg2) as u128)) as u64));
                v8 = v8 + 1;
            };
            if (v9) {
                v4 = v4 + 1;
            };
            v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(v0, v7));
            v3 = v3 + 1;
        };
        let v11 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, arg3);
        v11.settled_num = v11.settled_num + v4;
        if (v11.settled_num >= 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::total_holder(arg2)) {
            v11.is_settled = true;
        };
        let v12 = SettleEvent{
            phase   : arg3,
            start   : arg4,
            limit   : arg5,
            next_id : v2,
            count   : v4,
        };
        0x2::event::emit<SettleEvent>(v12);
        v2
    }

    fun take<T0>(arg0: &mut DividendManager, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = key<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 9);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
    }

    public entry fun update_bonus<T0>(arg0: &AdminCap, arg1: &mut DividendManager, arg2: u64, arg3: u64) {
        assert!(arg1.is_open, 4);
        checked_package_version(arg1);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<u64, DividendInfo>(&arg1.dividends, arg2), 5);
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&arg1.dividends, arg2).is_settled, 1);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg1.dividends, arg2);
        let v1 = key<T0>();
        let v2 = *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.bonus, &v1);
        assert!(v2 != arg3, 12);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.bonus, &v1) = arg3;
        let v3 = UpdateDividendInfoEvent{
            phase         : arg2,
            amount_before : v2,
            amount        : arg3,
        };
        0x2::event::emit<UpdateDividendInfoEvent>(v3);
    }

    public entry fun update_package_version<T0>(arg0: &AdminCap, arg1: &mut DividendManager, arg2: u64) {
        checked_package_version(arg1);
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public entry fun update_start_time(arg0: &AdminCap, arg1: &mut DividendManager, arg2: u64, arg3: &0x2::clock::Clock) {
        checked_package_version(arg1);
        assert!(arg1.is_open, 4);
        assert!(arg2 > 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::now_timestamp(arg3), 6);
        arg1.start_time = arg2;
    }

    // decompiled from Move bytecode v6
}

