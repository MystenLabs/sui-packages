module 0xd64075af6f1edb736551d78f37338336f8f690b10825ab76bd6e136049d8116::dendv2 {
    struct Manager has key {
        id: 0x2::object::UID,
        dividends: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<u64, DividendInfo>,
    }

    struct DividendInfo has drop, store {
        register_time: u64,
        settled_num: u64,
        is_settled: bool,
        bonus_types: vector<0x1::type_name::TypeName>,
        bonus: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        redeemed_num: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct DividendDetail has store {
        dividends: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct PhaseDividend has store, key {
        id: 0x2::object::UID,
    }

    struct Name has store {
        i: u64,
    }

    fun add_dividend_v2(arg0: &mut Manager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let v0 = PhaseDividend{id: 0x2::object::new(arg4)};
            0x2::dynamic_object_field::add<0x2::object::ID, PhaseDividend>(&mut arg0.id, arg1, v0);
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, PhaseDividend>(&mut arg0.id, arg1);
        if (!0x2::dynamic_field::exists_<u64>(&v1.id, arg2)) {
            let v2 = DividendDetail{dividends: 0x2::vec_map::empty<0x1::type_name::TypeName, u64>()};
            0x2::dynamic_field::add<u64, DividendDetail>(&mut v1.id, arg2, v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<u64, DividendDetail>(&mut v1.id, arg2);
        if (0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v3.dividends) == 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&arg3)) {
            return false
        };
        v3.dividends = arg3;
        true
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Manager{
            id        : 0x2::object::new(arg0),
            dividends : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<u64, DividendInfo>(arg0),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    public entry fun mint(arg0: &mut Manager, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PhaseDividend{id: 0x2::object::new(arg4)};
        0x2::dynamic_object_field::add<0x2::object::ID, PhaseDividend>(&mut arg0.id, arg1, v0);
        let v1 = Name{i: 19};
        0x2::dynamic_field::add<u64, Name>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, PhaseDividend>(&mut arg0.id, arg1).id, arg2, v1);
    }

    public entry fun register_bonus<T0>(arg0: &mut Manager, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<u64, DividendInfo>(&arg0.dividends, arg1)) {
            let v0 = DividendInfo{
                register_time : 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::now_timestamp(arg3),
                settled_num   : 0,
                is_settled    : false,
                bonus_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
                bonus         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                redeemed_num  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<u64, DividendInfo>(&mut arg0.dividends, arg1, v0);
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg0.dividends, arg1);
        let v2 = 0x1::type_name::get<T0>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1.bonus, v2, arg2);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1.redeemed_num, v2, 0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.bonus_types, 0x1::type_name::get<T0>());
    }

    public entry fun settle(arg0: &mut Manager, arg1: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: u64, arg3: vector<0x2::object::ID>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<u64, DividendInfo>(&arg0.dividends, arg2), 1);
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&arg0.dividends, arg2).is_settled, 2);
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::nfts(arg1);
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg3)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(v0)
        } else {
            0x1::option::some<0x2::object::ID>(0x1::vector::pop_back<0x2::object::ID>(&mut arg3))
        };
        let v2 = v1;
        if (0x1::option::is_none<0x2::object::ID>(&v2)) {
            return
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&arg0.dividends, arg2).bonus_types;
        let v6 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<u64, DividendInfo>(&arg0.dividends, arg2).bonus;
        while (0x1::option::is_some<0x2::object::ID>(&v2) && v3 < arg4) {
            let v7 = *0x1::option::borrow<0x2::object::ID>(&v2);
            let v8 = 0;
            let v9 = false;
            let v10 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
                let v11 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v8);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v10, v11, (((0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::xcetus_amount(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(v0, v7)) as u128) * (*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v6, &v11) as u128) / (0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::totol_amount(arg1) as u128)) as u64));
                v9 = add_dividend_v2(arg0, v7, arg2, v10, arg5);
                v8 = v8 + 1;
            };
            if (v9) {
                v4 = v4 + 1;
            };
            v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(v0, v7));
            v3 = v3 + 1;
        };
        let v12 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<u64, DividendInfo>(&mut arg0.dividends, arg2);
        v12.settled_num = v12.settled_num + v4;
        if (v12.settled_num >= 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::total_holder(arg1)) {
            v12.is_settled = true;
        };
    }

    // decompiled from Move bytecode v6
}

