module 0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw {
    struct Commission has drop, store {
        commission: u64,
        commission_beneficiary: address,
    }

    struct OrderbookRaw<phantom T0: store + key> has store {
        id: 0x2::object::UID,
    }

    struct Listing<T0: store + key> has store {
        object: T0,
        price: u64,
        owner: address,
        commission: 0x1::option::Option<Commission>,
    }

    struct ListingKey has copy, drop, store {
        object_id: 0x2::object::ID,
    }

    struct BalanceKey has copy, drop, store {
        beneficiary: address,
    }

    public(friend) fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : OrderbookRaw<T0> {
        OrderbookRaw<T0>{id: 0x2::object::new(arg0)}
    }

    public(friend) fun assert_listed<T0: store + key>(arg0: &OrderbookRaw<T0>, arg1: 0x2::object::ID) {
        assert!(is_listed<T0>(arg0, arg1), 1);
    }

    fun assert_owner(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0, 2);
    }

    public(friend) fun buy<T0: store + key>(arg0: &mut OrderbookRaw<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>) : (T0, 0x2::balance::Balance<0x2::sui::SUI>, address, u64) {
        assert_listed<T0>(arg0, arg1);
        let v0 = ListingKey{object_id: arg1};
        let Listing {
            object     : v1,
            price      : v2,
            owner      : v3,
            commission : v4,
        } = 0x2::dynamic_field::remove<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        let v5 = v4;
        let v6 = 0x2::balance::split<0x2::sui::SUI>(arg2, v2);
        if (0x1::option::is_some<Commission>(&v5)) {
            let Commission {
                commission             : v7,
                commission_beneficiary : v8,
            } = 0x1::option::destroy_some<Commission>(v5);
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&v6);
            let v10 = if (v9 < v7) {
                0x2::balance::split<0x2::sui::SUI>(&mut v6, v9)
            } else {
                0x2::balance::split<0x2::sui::SUI>(&mut v6, v7)
            };
            let v11 = BalanceKey{beneficiary: v8};
            if (0x2::dynamic_field::exists_<BalanceKey>(&mut arg0.id, v11)) {
                0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v11), v10);
            } else {
                0x2::dynamic_field::add<BalanceKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v11, v10);
            };
        };
        (v1, v6, v3, v2)
    }

    public(friend) fun claim<T0: store + key>(arg0: &mut OrderbookRaw<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = BalanceKey{beneficiary: 0x2::tx_context::sender(arg1)};
        0x2::dynamic_field::remove<BalanceKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v0)
    }

    public(friend) fun delist<T0: store + key>(arg0: &mut OrderbookRaw<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert_listed<T0>(arg0, arg1);
        let v0 = ListingKey{object_id: arg1};
        let Listing {
            object     : v1,
            price      : _,
            owner      : v3,
            commission : _,
        } = 0x2::dynamic_field::remove<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        assert_owner(v3, arg2);
        v1
    }

    public(friend) fun get_commission(arg0: &Commission) : &u64 {
        &arg0.commission
    }

    public(friend) fun get_commission_beneficiary(arg0: &Commission) : &address {
        &arg0.commission_beneficiary
    }

    public(friend) fun is_listed<T0: store + key>(arg0: &OrderbookRaw<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = ListingKey{object_id: arg1};
        0x2::dynamic_field::exists_<ListingKey>(&arg0.id, v0)
    }

    public(friend) fun list<T0: store + key>(arg0: &mut OrderbookRaw<T0>, arg1: 0x2::object::ID, arg2: T0, arg3: u64, arg4: 0x1::option::Option<Commission>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingKey{object_id: arg1};
        let v1 = Listing<T0>{
            object     : arg2,
            price      : arg3,
            owner      : 0x2::tx_context::sender(arg5),
            commission : arg4,
        };
        0x2::dynamic_field::add<ListingKey, Listing<T0>>(&mut arg0.id, v0, v1);
    }

    public(friend) fun modify<T0: store + key>(arg0: &mut OrderbookRaw<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<Commission>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_listed<T0>(arg0, arg1);
        let v0 = ListingKey{object_id: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        assert_owner(v1.owner, arg4);
        v1.price = arg2;
        v1.commission = arg3;
    }

    public(friend) fun new_commission(arg0: u64, arg1: address) : Commission {
        Commission{
            commission             : arg0,
            commission_beneficiary : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

