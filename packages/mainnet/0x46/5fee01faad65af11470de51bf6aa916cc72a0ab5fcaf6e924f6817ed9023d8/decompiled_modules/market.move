module 0x465fee01faad65af11470de51bf6aa916cc72a0ab5fcaf6e924f6817ed9023d8::market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store<T0: store + key> has store {
        obj: T0,
        price: u64,
        owner: address,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
        fee_rate: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun buy<T0: store + key>(arg0: &mut Global, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.vault, arg1), 1);
        let Store {
            obj   : v0,
            price : v1,
            owner : v2,
        } = 0x2::bag::remove<0x2::object::ID, Store<T0>>(&mut arg0.vault, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 4);
        let v3 = (((v1 as u128) * (arg0.fee_rate as u128) / 1000000000) as u64);
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg3)));
        };
        let v4 = v1 - v3;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg3), v2);
        };
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
        arg2
    }

    public fun change_fee_rate(arg0: &mut Global, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 1000000000, 3);
        arg0.fee_rate = arg1;
    }

    public fun delist<T0: store + key>(arg0: &mut Global, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.vault, arg1), 1);
        let Store {
            obj   : v0,
            price : _,
            owner : v2,
        } = 0x2::bag::remove<0x2::object::ID, Store<T0>>(&mut arg0.vault, arg1);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(v2 == v3, 2);
        0x2::transfer::public_transfer<T0>(v0, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id       : 0x2::object::new(arg0),
            vault    : 0x2::bag::new(arg0),
            fee_rate : 0,
            fee      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Global>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun list<T0: store + key>(arg0: &mut Global, arg1: T0, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 5);
        let v0 = Store<T0>{
            obj   : arg1,
            price : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::bag::add<0x2::object::ID, Store<T0>>(&mut arg0.vault, 0x2::object::id<T0>(&arg1), v0);
    }

    // decompiled from Move bytecode v6
}

