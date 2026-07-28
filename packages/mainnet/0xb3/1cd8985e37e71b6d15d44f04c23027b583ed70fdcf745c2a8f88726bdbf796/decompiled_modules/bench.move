module 0xb31cd8985e37e71b6d15d44f04c23027b583ed70fdcf745c2a8f88726bdbf796::bench {
    struct Root has key {
        id: 0x2::object::UID,
        code_version: u64,
        live_count: u64,
        rate: u128,
        total_units: u64,
        pot: u64,
        open_after_ms: u64,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        root_id: 0x2::object::ID,
    }

    struct Leaf has key {
        id: 0x2::object::UID,
        root_id: 0x2::object::ID,
        units: u64,
        mark: u128,
    }

    struct Slot has copy, drop, store {
        units: u64,
        mark: u128,
    }

    entry fun accrue(arg0: &mut Root, arg1: u64) {
        assert!(arg0.code_version == 1, 1);
        arg0.rate = arg0.rate + (arg1 as u128) * 1000000000000000000 / (arg0.total_units as u128);
        arg0.pot = arg0.pot + arg1;
    }

    entry fun create(arg0: vector<address>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 5);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == arg2, 4);
        let v3 = Root{
            id            : 0x2::object::new(arg4),
            code_version  : 1,
            live_count    : 0,
            rate          : 0,
            total_units   : arg2,
            pot           : 0,
            open_after_ms : arg3,
        };
        let v4 = 0x2::object::id<Root>(&v3);
        let v5 = Cap{
            id      : 0x2::object::new(arg4),
            root_id : v4,
        };
        0x2::transfer::transfer<Cap>(v5, 0x2::tx_context::sender(arg4));
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u64>(&arg1, v6);
            let v8 = Leaf{
                id      : 0x2::object::new(arg4),
                root_id : v4,
                units   : v7,
                mark    : 0,
            };
            let v9 = Slot{
                units : v7,
                mark  : 0,
            };
            0x2::dynamic_field::add<0x2::object::ID, Slot>(&mut v3.id, 0x2::object::id<Leaf>(&v8), v9);
            v3.live_count = v3.live_count + 1;
            0x2::transfer::party_transfer<Leaf>(v8, 0x2::party::single_owner(*0x1::vector::borrow<address>(&arg0, v6)));
            v6 = v6 + 1;
        };
        0x2::transfer::share_object<Root>(v3);
    }

    entry fun divide(arg0: &mut Root, arg1: &mut Leaf, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.code_version == 1, 1);
        assert!(arg1.root_id == 0x2::object::id<Root>(arg0), 1);
        present(arg0, 0x2::object::id<Leaf>(arg1));
        assert!(arg1.units > arg2 && arg2 > 0, 12);
        arg1.units = arg1.units - arg2;
        let v0 = arg1.mark;
        0x2::dynamic_field::borrow_mut<0x2::object::ID, Slot>(&mut arg0.id, 0x2::object::id<Leaf>(arg1)).units = arg1.units;
        let v1 = Leaf{
            id      : 0x2::object::new(arg4),
            root_id : arg1.root_id,
            units   : arg2,
            mark    : v0,
        };
        let v2 = Slot{
            units : arg2,
            mark  : v0,
        };
        0x2::dynamic_field::add<0x2::object::ID, Slot>(&mut arg0.id, 0x2::object::id<Leaf>(&v1), v2);
        arg0.live_count = arg0.live_count + 1;
        0x2::transfer::party_transfer<Leaf>(v1, 0x2::party::single_owner(arg3));
    }

    entry fun draw(arg0: &mut Root, arg1: &mut Leaf) {
        assert!(arg0.code_version == 1, 1);
        assert!(arg1.root_id == 0x2::object::id<Root>(arg0), 1);
        let v0 = 0x2::object::id<Leaf>(arg1);
        present(arg0, v0);
        let v1 = arg0.rate;
        arg0.pot = arg0.pot - (((arg1.units as u128) * (v1 - arg1.mark) / 1000000000000000000) as u64);
        arg1.mark = v1;
        0x2::dynamic_field::borrow_mut<0x2::object::ID, Slot>(&mut arg0.id, v0).mark = v1;
    }

    entry fun hand_on(arg0: &Root, arg1: Leaf, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg0.code_version == 1, 1);
        assert!(arg1.root_id == 0x2::object::id<Root>(arg0), 1);
        present(arg0, 0x2::object::id<Leaf>(&arg1));
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.open_after_ms, 3);
        0x2::transfer::party_transfer<Leaf>(arg1, 0x2::party::single_owner(arg2));
    }

    public fun live_count(arg0: &Root) : u64 {
        arg0.live_count
    }

    fun present(arg0: &Root, arg1: 0x2::object::ID) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 9);
    }

    entry fun reassign(arg0: &Cap, arg1: &mut Root, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.code_version == 1, 1);
        assert!(arg0.root_id == 0x2::object::id<Root>(arg1), 1);
        present(arg1, arg2);
        let v0 = 0x2::dynamic_field::remove<0x2::object::ID, Slot>(&mut arg1.id, arg2);
        let v1 = Leaf{
            id      : 0x2::object::new(arg4),
            root_id : 0x2::object::id<Root>(arg1),
            units   : v0.units,
            mark    : v0.mark,
        };
        let v2 = Slot{
            units : v0.units,
            mark  : v0.mark,
        };
        0x2::dynamic_field::add<0x2::object::ID, Slot>(&mut arg1.id, 0x2::object::id<Leaf>(&v1), v2);
        0x2::transfer::party_transfer<Leaf>(v1, 0x2::party::single_owner(arg3));
    }

    // decompiled from Move bytecode v7
}

