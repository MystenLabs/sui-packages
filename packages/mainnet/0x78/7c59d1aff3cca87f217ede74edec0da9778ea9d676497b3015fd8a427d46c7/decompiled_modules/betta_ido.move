module 0x787c59d1aff3cca87f217ede74edec0da9778ea9d676497b3015fd8a427d46c7::betta_ido {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BoughtRecord has store, key {
        id: 0x2::object::UID,
        who: address,
        bought: u64,
    }

    struct BettaStorage<phantom T0> has store, key {
        id: 0x2::object::UID,
        whitelist: vector<address>,
        bought: 0x2::object_table::ObjectTable<address, BoughtRecord>,
        conv_betta: 0x2::coin::Coin<T0>,
        total_betta_sold: u64,
    }

    public entry fun add_whitelist<T0>(arg0: &AdminCap, arg1: &mut BettaStorage<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::append<address>(&mut arg1.whitelist, arg2);
    }

    public entry fun buy<T0>(arg0: &mut BettaStorage<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_betta_sold < 6000000000000000, 10004);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 10002);
        assert!(v0 <= 200000000000, 10001);
        if (0x2::object_table::contains<address, BoughtRecord>(&arg0.bought, 0x2::tx_context::sender(arg2))) {
            if (0x2::object_table::borrow_mut<address, BoughtRecord>(&mut arg0.bought, 0x2::tx_context::sender(arg2)).bought + v0 > 200000000000) {
                abort 10001
            };
        };
        if (0x2::object_table::contains<address, BoughtRecord>(&arg0.bought, 0x2::tx_context::sender(arg2))) {
            let v1 = 0x2::object_table::borrow_mut<address, BoughtRecord>(&mut arg0.bought, 0x2::tx_context::sender(arg2));
            v1.bought = v1.bought + v0;
        } else {
            let v2 = BoughtRecord{
                id     : 0x2::object::new(arg2),
                who    : 0x2::tx_context::sender(arg2),
                bought : v0,
            };
            0x2::object_table::add<address, BoughtRecord>(&mut arg0.bought, 0x2::tx_context::sender(arg2), v2);
        };
        let v3 = if (is_whitelist(&arg0.whitelist, 0x2::tx_context::sender(arg2))) {
            (v0 as u128) * 1000000000 / (8000000 as u128)
        } else {
            (v0 as u128) * 1000000000 / (8500000 as u128)
        };
        arg0.total_betta_sold = arg0.total_betta_sold + (v3 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.conv_betta, (v3 as u64), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xee49cf058aeb87d455466657c62e61015e158b3f401e5a00a7318a6f6972bd9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_betta<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= 6000000000000000, 10003);
        let v0 = BettaStorage<T0>{
            id               : 0x2::object::new(arg2),
            whitelist        : 0x1::vector::empty<address>(),
            bought           : 0x2::object_table::new<address, BoughtRecord>(arg2),
            conv_betta       : arg1,
            total_betta_sold : 0,
        };
        0x2::transfer::share_object<BettaStorage<T0>>(v0);
    }

    fun is_whitelist(arg0: &vector<address>, arg1: address) : bool {
        0x1::vector::contains<address>(arg0, &arg1)
    }

    public entry fun remove_whitelist<T0>(arg0: &AdminCap, arg1: &mut BettaStorage<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg1.whitelist, 0x1::vector::borrow<address>(&arg2, v0));
            if (v1 == true) {
                0x1::vector::remove<address>(&mut arg1.whitelist, v2);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun withdraw_remain_betta<T0>(arg0: &AdminCap, arg1: &mut BettaStorage<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.conv_betta, 0x2::coin::value<T0>(&arg1.conv_betta), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

