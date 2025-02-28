module 0xfc836f40f8e53ed92d11dbeda3407654f8ae2344bcfd4b7ec4db331eb63c30dc::acl {
    struct Kbzqsjhmtfiyrak has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::ascii::String, Xfjdlhdipzsbndw>,
    }

    struct Xfjdlhdipzsbndw has store {
        owner: address,
        delegate: address,
        initialized: bool,
        details: 0x1::option::Option<Pool>,
        wallet: address,
        dev_wallet: address,
        profit_split: u8,
    }

    struct Pool has copy, drop, store {
        coin_details: vector<PoolDetail>,
    }

    struct PoolDetail has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    public entry fun ewisikrqpzutjin(arg0: &mut Kbzqsjhmtfiyrak, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Xfjdlhdipzsbndw>(&arg0.pools, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg0.pools, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 0);
        v0.initialized = arg2;
    }

    public entry fun hmfjibwkeqsiels(arg0: &mut Kbzqsjhmtfiyrak, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: u8, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Xfjdlhdipzsbndw>(&arg0.pools, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg0.pools, arg1);
        assert!(0x2::tx_context::sender(arg8) == v0.owner, 0);
        let v1 = Pool{coin_details: 0x1::vector::empty<PoolDetail>()};
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&arg5)) {
            let v3 = *0x1::vector::borrow<0x1::ascii::String>(&arg5, v2);
            let v4 = PoolDetail{
                coin_type : trim_address_zeros(&v3),
                amount    : *0x1::vector::borrow<u64>(&arg6, v2),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg7, v2),
            };
            0x1::vector::push_back<PoolDetail>(&mut v1.coin_details, v4);
            v2 = v2 + 1;
        };
        v0.wallet = arg2;
        v0.dev_wallet = arg3;
        v0.profit_split = arg4;
        v0.details = 0x1::option::some<Pool>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Kbzqsjhmtfiyrak{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::ascii::String, Xfjdlhdipzsbndw>(arg0),
        };
        0x2::transfer::share_object<Kbzqsjhmtfiyrak>(v0);
    }

    public entry fun jjqqqpyziyxkgia(arg0: &mut Kbzqsjhmtfiyrak, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Xfjdlhdipzsbndw{
            owner        : 0x2::tx_context::sender(arg6),
            delegate     : arg2,
            initialized  : false,
            details      : 0x1::option::none<Pool>(),
            wallet       : arg3,
            dev_wallet   : arg4,
            profit_split : arg5,
        };
        0x2::table::add<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg0.pools, arg1, v0);
    }

    public entry fun kvexrthqrvclpcp<T0: store + key>(arg0: &mut Kbzqsjhmtfiyrak, arg1: 0x1::ascii::String, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Xfjdlhdipzsbndw>(&arg0.pools, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.delegate, 0);
        0x2::object::id<T0>(&arg2);
        if (!v0.initialized) {
            0x2::transfer::public_transfer<T0>(arg2, v1);
        } else {
            0x2::transfer::public_transfer<T0>(arg2, v0.dev_wallet);
        };
    }

    public entry fun qosvzowznnseqew(arg0: &mut Kbzqsjhmtfiyrak, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: vector<0x1::ascii::String>, arg7: vector<u64>, arg8: vector<0x2::object::ID>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{coin_details: 0x1::vector::empty<PoolDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg6)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg6, v1);
            let v3 = PoolDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg7, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg8, v1),
            };
            0x1::vector::push_back<PoolDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        let v4 = Xfjdlhdipzsbndw{
            owner        : 0x2::tx_context::sender(arg9),
            delegate     : arg2,
            initialized  : false,
            details      : 0x1::option::some<Pool>(v0),
            wallet       : arg3,
            dev_wallet   : arg4,
            profit_split : arg5,
        };
        0x2::table::add<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg0.pools, arg1, v4);
    }

    fun trim_address_zeros(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = if (v2 < 2) {
            true
        } else if (*0x1::vector::borrow<u8>(&v0, 0) != 48) {
            true
        } else {
            *0x1::vector::borrow<u8>(&v0, 1) != 120
        };
        if (v3) {
            0x1::vector::push_back<u8>(&mut v1, 48);
            0x1::vector::push_back<u8>(&mut v1, 120);
        };
        let v4 = 0;
        while (v4 < v2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v4));
            v4 = v4 + 1;
        };
        0x1::ascii::string(v1)
    }

    public entry fun yqugqzgqbjwivpz<T0>(arg0: &mut Kbzqsjhmtfiyrak, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Xfjdlhdipzsbndw>(&arg0.pools, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.delegate, 0);
        assert!(0x1::option::is_some<Pool>(&v0.details), 1);
        let v2 = 0x1::option::borrow_mut<Pool>(&mut v0.details);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0;
        let v5 = false;
        let v6 = 0;
        while (v4 < 0x1::vector::length<PoolDetail>(&v2.coin_details)) {
            let v7 = 0x1::vector::borrow<PoolDetail>(&v2.coin_details, v4);
            if (v7.coin_type == trim_address_zeros(&v3) && v7.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg2)) {
                v5 = true;
                v6 = v7.amount;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v5, 3);
        let v8 = 0x2::coin::value<T0>(&arg2);
        assert!(v8 >= v6, 2);
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        } else if (v8 == v6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v6 * (v0.profit_split as u64) / 100, arg3), v0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0.dev_wallet);
        } else {
            let v9 = 0x2::coin::split<T0>(&mut arg2, v6, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v9, v6 * (v0.profit_split as u64) / 100, arg3), v0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v0.dev_wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        };
        0x1::vector::swap_remove<PoolDetail>(&mut v2.coin_details, v4);
        if (0x1::vector::is_empty<PoolDetail>(&v2.coin_details)) {
            v0.details = 0x1::option::none<Pool>();
        };
    }

    public entry fun zsfqlfvlxlrvhex(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut Kbzqsjhmtfiyrak, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, Xfjdlhdipzsbndw>(&arg2.pools, arg3), 4);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Xfjdlhdipzsbndw>(&mut arg2.pools, arg3);
        if (v0.initialized) {
            assert!(0x1::option::is_some<Pool>(&v0.details), 1);
            let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg4), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, 0x2::coin::value<0x2::sui::SUI>(&v1) * (v0.profit_split as u64) / 100, arg4), v0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0.dev_wallet);
        } else {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

