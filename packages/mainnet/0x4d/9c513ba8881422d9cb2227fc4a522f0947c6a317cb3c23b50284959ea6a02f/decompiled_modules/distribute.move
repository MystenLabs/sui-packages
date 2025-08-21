module 0x9889e6e46d0850e8fa820954dbb8a48702677ed02ad4c467c45790d3a062dac0::distribute {
    struct DISTRIBUTE has drop {
        dummy_field: bool,
    }

    struct Distributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        table: 0x2::table::Table<address, u64>,
        addr_set: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun claim_all<T0>(arg0: &mut Distributor<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.table;
        let v1 = 0x2::vec_set::into_keys<address>(arg0.addr_set);
        while (0x1::vector::length<address>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::table::remove<address, u64>(v0, v2)), arg1), v2);
        };
        arg0.addr_set = 0x2::vec_set::empty<address>();
    }

    public fun deposit<T0>(arg0: &mut Distributor<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut vector<address>, arg3: &mut vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(arg2) == 0x1::vector::length<u64>(arg3), 4001);
        assert!(0x2::coin::value<T0>(&arg1) == 0x9889e6e46d0850e8fa820954dbb8a48702677ed02ad4c467c45790d3a062dac0::utils::sum(arg3), 4002);
        assert!(0x1::vector::length<u64>(arg3) > 0, 4003);
        let v0 = &mut arg0.table;
        let v1 = &mut arg0.addr_set;
        while (0x1::vector::length<address>(arg2) > 0) {
            let v2 = 0x1::vector::pop_back<address>(arg2);
            let v3 = 0x1::vector::pop_back<u64>(arg3);
            if (0x2::table::contains<address, u64>(v0, v2)) {
                0x2::table::add<address, u64>(v0, v2, 0x2::table::remove<address, u64>(v0, v2) + v3);
                continue
            };
            0x2::table::add<address, u64>(v0, v2, v3);
            0x2::vec_set::insert<address>(v1, v2);
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: DISTRIBUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_distributor<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor<T0>{
            id       : 0x2::object::new(arg1),
            balance  : 0x2::balance::zero<T0>(),
            table    : 0x2::table::new<address, u64>(arg1),
            addr_set : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Distributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

