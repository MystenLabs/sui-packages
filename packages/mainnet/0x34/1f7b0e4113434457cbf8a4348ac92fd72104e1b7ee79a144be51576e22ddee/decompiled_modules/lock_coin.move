module 0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::lock_coin {
    struct DemandCap has key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
    }

    struct Lock has key {
        id: 0x2::object::UID,
        total_lock: u64,
        total_unlock: u64,
        lock_coin: 0x2::coin::Coin<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>,
        start_time: u64,
    }

    struct TGE has store, key {
        id: 0x2::object::UID,
        percentage: u8,
    }

    struct Vesting has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        linear_day: u16,
    }

    struct Demand has store, key {
        id: 0x2::object::UID,
        amount: vector<u64>,
        start_time: vector<u64>,
    }

    struct TokenomicCap has key {
        id: 0x2::object::UID,
        initialize: bool,
    }

    struct ClaimTokenomicEvent has copy, drop {
        receiver: address,
        amount: u64,
    }

    struct LOCK_COIN has drop {
        dummy_field: bool,
    }

    public fun add_demand(arg0: &mut Lock, arg1: &mut DemandCap, arg2: u64, arg3: u64) {
        assert!(arg1.item_id == 0x2::object::uid_to_inner(&arg0.id), 405);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Demand>(&mut arg0.id, b"Demand");
        0x1::vector::push_back<u64>(&mut v0.amount, arg2);
        0x1::vector::push_back<u64>(&mut v0.start_time, arg3);
    }

    fun add_demand_dof(arg0: &mut Lock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Demand{
            id         : 0x2::object::new(arg1),
            amount     : 0x1::vector::empty<u64>(),
            start_time : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, Demand>(&mut arg0.id, b"Demand", v0);
    }

    public fun add_tge(arg0: &mut Lock, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TGE{
            id         : 0x2::object::new(arg2),
            percentage : arg1,
        };
        0x2::dynamic_object_field::add<vector<u8>, TGE>(&mut arg0.id, b"TGE", v0);
    }

    public fun add_vesting(arg0: &mut Lock, arg1: u64, arg2: u64, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Vesting{
            id         : 0x2::object::new(arg4),
            start_time : arg1,
            end_time   : arg2,
            linear_day : arg3,
        };
        0x2::dynamic_object_field::add<vector<u8>, Vesting>(&mut arg0.id, b"Vesting", v0);
    }

    public fun calculate_maximum_earn(arg0: &Lock, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0.total_lock;
        let v3 = arg0.total_lock;
        let v4 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"TGE")) {
            let v5 = 0x2::dynamic_object_field::borrow<vector<u8>, TGE>(&arg0.id, b"TGE");
            if (v5.percentage > 0) {
                v1 = v0 + v2 * (v5.percentage as u64) / 100;
                v3 = v2 * (100 - (v5.percentage as u64)) / 100;
            };
        };
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"Demand")) {
            let v6 = 0x2::dynamic_object_field::borrow<vector<u8>, Demand>(&arg0.id, b"Demand");
            let v7 = v6.amount;
            let v8 = v6.start_time;
            while (!0x1::vector::is_empty<u64>(&v7)) {
                let v9 = 0x1::vector::pop_back<u64>(&mut v7);
                if (v4 >= 0x1::vector::pop_back<u64>(&mut v8)) {
                    v1 = v1 + v9;
                    v3 = v3 - v9;
                };
            };
        };
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"Vesting")) {
            let v10 = 0x2::dynamic_object_field::borrow<vector<u8>, Vesting>(&arg0.id, b"Vesting");
            if (v4 >= v10.end_time) {
                v1 = v1 + v3;
            };
            if (v4 < v10.end_time) {
                v1 = v1 + v3 * (v4 - v10.start_time) / (v10.linear_day as u64) * 86400000 / (v10.end_time - v10.start_time) / (v10.linear_day as u64) * 86400000;
            };
        };
        v1 - arg0.total_unlock
    }

    public entry fun claim(arg0: &mut Lock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_maximum_earn(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>>(0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&mut arg0.lock_coin, v0, arg2), 0x2::tx_context::sender(arg2));
        arg0.total_unlock = arg0.total_unlock + v0;
        let v1 = ClaimTokenomicEvent{
            receiver : 0x2::tx_context::sender(arg2),
            amount   : v0,
        };
        0x2::event::emit<ClaimTokenomicEvent>(v1);
    }

    fun create_lock_coin(arg0: 0x2::coin::Coin<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Lock {
        let v0 = Lock{
            id           : 0x2::object::new(arg2),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&arg0),
            total_unlock : 0,
            lock_coin    : arg0,
            start_time   : arg1,
        };
        let v1 = Demand{
            id         : 0x2::object::new(arg2),
            amount     : 0x1::vector::empty<u64>(),
            start_time : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, Demand>(&mut v0.id, b"Demand", v1);
        v0
    }

    fun init(arg0: LOCK_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenomicCap{
            id         : 0x2::object::new(arg1),
            initialize : false,
        };
        0x2::transfer::transfer<TokenomicCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<LOCK_COIN>(arg0, arg1);
    }

    public entry fun init_tokenomic(arg0: &mut TokenomicCap, arg1: &mut 0x2::coin::Coin<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>, arg2: &0x2::coin::CoinMetadata<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialize == false, 403);
        let v0 = 0x2::coin::get_decimals<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg2);
        let v1 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 78000000 * 0x2::math::pow(10, v0), arg3);
        let v2 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v1),
            total_unlock : 0,
            lock_coin    : v1,
            start_time   : 1682874000000,
        };
        let v3 = &mut v2;
        add_vesting(v3, 1746032400000, 1777568400000, 7, arg3);
        0x2::transfer::transfer<Lock>(v2, @0x1);
        let v4 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 126000000 * 0x2::math::pow(10, v0), arg3);
        let v5 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v4),
            total_unlock : 0,
            lock_coin    : v4,
            start_time   : 1682874000000,
        };
        let v6 = DemandCap{
            id      : 0x2::object::new(arg3),
            item_id : 0x2::object::id<Lock>(&v5),
        };
        0x2::transfer::transfer<DemandCap>(v6, @0x2);
        let v7 = &mut v5;
        add_tge(v7, 50, arg3);
        let v8 = &mut v5;
        add_demand_dof(v8, arg3);
        0x2::transfer::transfer<Lock>(v5, @0x2);
        let v9 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 144000000 * 0x2::math::pow(10, v0), arg3);
        let v10 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v9),
            total_unlock : 0,
            lock_coin    : v9,
            start_time   : 1682874000000,
        };
        let v11 = DemandCap{
            id      : 0x2::object::new(arg3),
            item_id : 0x2::object::id<Lock>(&v10),
        };
        0x2::transfer::transfer<DemandCap>(v11, @0xb6e3526267d88cdddece265b6d94b5612dc813ec7f116715c535eab4bfba8692);
        let v12 = &mut v10;
        add_demand_dof(v12, arg3);
        0x2::transfer::transfer<Lock>(v10, @0x3);
        let v13 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 66000000 * 0x2::math::pow(10, v0), arg3);
        let v14 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v13),
            total_unlock : 0,
            lock_coin    : v13,
            start_time   : 1682874000000,
        };
        let v15 = DemandCap{
            id      : 0x2::object::new(arg3),
            item_id : 0x2::object::id<Lock>(&v14),
        };
        0x2::transfer::transfer<DemandCap>(v15, @0xb6e3526267d88cdddece265b6d94b5612dc813ec7f116715c535eab4bfba8692);
        let v16 = &mut v14;
        add_demand_dof(v16, arg3);
        0x2::transfer::transfer<Lock>(v14, @0x4);
        let v17 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 42000000 * 0x2::math::pow(10, v0), arg3);
        let v18 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v17),
            total_unlock : 0,
            lock_coin    : v17,
            start_time   : 1682874000000,
        };
        let v19 = &mut v18;
        add_vesting(v19, 1725123600000, 1756659600000, 7, arg3);
        0x2::transfer::transfer<Lock>(v18, @0x6);
        let v20 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 48000000 * 0x2::math::pow(10, v0), arg3);
        let v21 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v20),
            total_unlock : 0,
            lock_coin    : v20,
            start_time   : 1682874000000,
        };
        let v22 = &mut v21;
        add_tge(v22, 50, arg3);
        let v23 = &mut v21;
        add_vesting(v23, 1682874000000, 1685552400000, 7, arg3);
        0x2::transfer::transfer<Lock>(v21, @0x7);
        let v24 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 36000000 * 0x2::math::pow(10, v0), arg3);
        let v25 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v24),
            total_unlock : 0,
            lock_coin    : v24,
            start_time   : 1682874000000,
        };
        let v26 = &mut v25;
        add_tge(v26, 100, arg3);
        0x2::transfer::transfer<Lock>(v25, @0x8);
        let v27 = 0x2::coin::split<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(arg1, 60000000 * 0x2::math::pow(10, v0), arg3);
        let v28 = Lock{
            id           : 0x2::object::new(arg3),
            total_lock   : 0x2::coin::value<0x341f7b0e4113434457cbf8a4348ac92fd72104e1b7ee79a144be51576e22ddee::gruu::GRUU>(&v27),
            total_unlock : 0,
            lock_coin    : v27,
            start_time   : 1682874000000,
        };
        let v29 = &mut v28;
        add_tge(v29, 100, arg3);
        0x2::transfer::transfer<Lock>(v28, @0x4);
        arg0.initialize = true;
    }

    // decompiled from Move bytecode v6
}

