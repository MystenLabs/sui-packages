module 0x8307d9040d600ebc46b3b4bdb02d858df59ead708fc5c09e9676d5ef8e61e3c4::torque_burner {
    struct BurnRecordKey has copy, drop, store {
        coin_type: 0x2::object::ID,
    }

    struct BurnerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_burns: u64,
    }

    struct BurnRecord has copy, drop, store {
        amount: u64,
        last_burn_timestamp: u64,
    }

    struct BurnEvent has copy, drop {
        burner: address,
        coin_type_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct BatchBurnEvent has copy, drop {
        burner: address,
        coin_type_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
        timestamp: u64,
    }

    public entry fun batch_burn_coins<T0>(arg0: &mut BurnerCap, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 3);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 > 0 && v1 <= 100, 2);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<T0>(arg2) >= v2, 1);
        let v4 = 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg1);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        while (v6 < v1) {
            let v7 = *0x1::vector::borrow<u64>(&arg3, v6);
            if (v7 > 0) {
                0x2::coin::burn<T0>(arg1, 0x2::coin::split<T0>(arg2, v7, arg4));
                0x1::vector::push_back<u64>(&mut v5, v7);
            };
            v6 = v6 + 1;
        };
        let v8 = BurnRecordKey{coin_type: v4};
        let v9 = 0x2::tx_context::epoch(arg4);
        if (0x2::dynamic_field::exists_<BurnRecordKey>(&arg0.id, v8)) {
            let v10 = 0x2::dynamic_field::borrow_mut<BurnRecordKey, BurnRecord>(&mut arg0.id, v8);
            v10.amount = v10.amount + v2;
            v10.last_burn_timestamp = v9;
        } else {
            let v11 = BurnRecord{
                amount              : v2,
                last_burn_timestamp : v9,
            };
            0x2::dynamic_field::add<BurnRecordKey, BurnRecord>(&mut arg0.id, v8, v11);
        };
        arg0.total_burns = arg0.total_burns + v1;
        let v12 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v12, v4);
        let v13 = BatchBurnEvent{
            burner        : v0,
            coin_type_ids : v12,
            amounts       : v5,
            timestamp     : v9,
        };
        0x2::event::emit<BatchBurnEvent>(v13);
        0x1::vector::destroy_empty<u64>(v5);
    }

    public entry fun burn_coin<T0>(arg0: &mut BurnerCap, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 3);
        assert!(arg3 > 0, 4);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        0x2::coin::burn<T0>(arg1, 0x2::coin::split<T0>(arg2, arg3, arg4));
        let v1 = 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg1);
        let v2 = BurnRecordKey{coin_type: v1};
        if (0x2::dynamic_field::exists_<BurnRecordKey>(&arg0.id, v2)) {
            let v3 = 0x2::dynamic_field::borrow_mut<BurnRecordKey, BurnRecord>(&mut arg0.id, v2);
            v3.amount = v3.amount + arg3;
            v3.last_burn_timestamp = 0x2::tx_context::epoch(arg4);
        } else {
            let v4 = BurnRecord{
                amount              : arg3,
                last_burn_timestamp : 0x2::tx_context::epoch(arg4),
            };
            0x2::dynamic_field::add<BurnRecordKey, BurnRecord>(&mut arg0.id, v2, v4);
        };
        arg0.total_burns = arg0.total_burns + 1;
        let v5 = BurnEvent{
            burner       : v0,
            coin_type_id : v1,
            amount       : arg3,
            timestamp    : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BurnEvent>(v5);
    }

    public fun get_burn_record(arg0: &BurnerCap, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = BurnRecordKey{coin_type: arg1};
        if (0x2::dynamic_field::exists_<BurnRecordKey>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<BurnRecordKey, BurnRecord>(&arg0.id, v0);
            (v3.amount, v3.last_burn_timestamp)
        } else {
            (0, 0)
        }
    }

    public fun get_owner(arg0: &BurnerCap) : address {
        arg0.owner
    }

    public fun get_total_burns(arg0: &BurnerCap) : u64 {
        arg0.total_burns
    }

    public fun has_burn_record(arg0: &BurnerCap, arg1: 0x2::object::ID) : bool {
        let v0 = BurnRecordKey{coin_type: arg1};
        0x2::dynamic_field::exists_<BurnRecordKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnerCap{
            id          : 0x2::object::new(arg0),
            owner       : 0x2::tx_context::sender(arg0),
            total_burns : 0,
        };
        0x2::transfer::share_object<BurnerCap>(v0);
    }

    // decompiled from Move bytecode v6
}

