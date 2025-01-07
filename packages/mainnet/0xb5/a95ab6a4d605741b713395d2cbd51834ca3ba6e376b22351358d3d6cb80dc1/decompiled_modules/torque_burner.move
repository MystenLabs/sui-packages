module 0xb5a95ab6a4d605741b713395d2cbd51834ca3ba6e376b22351358d3d6cb80dc1::torque_burner {
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

    public entry fun batch_burn_coins<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 > 0 && v0 <= 100, 2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v2);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<T0>(arg1) >= v1, 1);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg2, v4);
            if (v5 > 0) {
                0x2::coin::burn<T0>(arg0, 0x2::coin::split<T0>(arg1, v5, arg3));
                0x1::vector::push_back<u64>(&mut v3, v5);
            };
            v4 = v4 + 1;
        };
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg0));
        let v7 = BatchBurnEvent{
            burner        : 0x2::tx_context::sender(arg3),
            coin_type_ids : v6,
            amounts       : v3,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BatchBurnEvent>(v7);
        0x1::vector::destroy_empty<u64>(v3);
    }

    public entry fun burn_coin<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 1);
        0x2::coin::burn<T0>(arg0, 0x2::coin::split<T0>(arg1, arg2, arg3));
        let v0 = BurnEvent{
            burner       : 0x2::tx_context::sender(arg3),
            coin_type_id : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg0),
            amount       : arg2,
            timestamp    : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BurnEvent>(v0);
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

