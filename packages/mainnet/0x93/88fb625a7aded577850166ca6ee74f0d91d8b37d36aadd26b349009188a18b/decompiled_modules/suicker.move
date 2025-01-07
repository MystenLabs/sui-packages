module 0x9388fb625a7aded577850166ca6ee74f0d91d8b37d36aadd26b349009188a18b::suicker {
    struct Locked<T0: store + key> has key {
        id: 0x2::object::UID,
        obj: T0,
        locked_until_ms: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        splits: vector<u64>,
        price_per_split: vector<u64>,
        locked_objects_total: u64,
    }

    struct LockedEvent<phantom T0> has copy, drop {
        locked_object_id: address,
        locked_until_ms: u64,
    }

    struct UnlockedEvent<phantom T0> has copy, drop {
        locked_object_id: address,
    }

    fun calculate_price(arg0: u64, arg1: &Config) : u64 {
        if (arg0 < *0x1::vector::borrow<u64>(&arg1.splits, 0)) {
            return *0x1::vector::borrow<u64>(&arg1.price_per_split, 0)
        };
        let v0 = 0x1::vector::length<u64>(&arg1.splits) - 1;
        while (v0 >= 0) {
            if (arg0 >= *0x1::vector::borrow<u64>(&arg1.splits, v0)) {
                return *0x1::vector::borrow<u64>(&arg1.price_per_split, v0)
            };
            v0 = v0 - 1;
        };
        *0x1::vector::borrow<u64>(&arg1.price_per_split, 0)
    }

    public fun change_config(arg0: &mut Config, arg1: vector<u64>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(0x1::vector::length<u64>(&arg1) > 0, 4);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 4);
        arg0.price_per_split = arg2;
        arg0.splits = arg1;
    }

    public fun change_owner(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.owner = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            splits               : vector[60000, 120000, 210000, 345000, 547500, 851250, 1306875, 1990312, 3015468, 4553202, 6859803, 10319705, 15509558, 23294338, 34971508, 52487263, 70760896, 86400000],
            price_per_split      : vector[1000000000, 947058823, 894117647, 841176470, 788235294, 735294117, 682352941, 629411764, 576470588, 523529411, 470588235, 417647058, 364705882, 311764705, 258823529, 205882352, 152941176, 100000000],
            locked_objects_total : 0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_price(arg1, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 2);
        let v1 = Locked<T0>{
            id              : 0x2::object::new(arg5),
            obj             : arg0,
            locked_until_ms : 0x2::clock::timestamp_ms(arg4) + arg1,
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        };
        let v2 = LockedEvent<T0>{
            locked_object_id : 0x2::object::uid_to_address(&v1.id),
            locked_until_ms  : v1.locked_until_ms,
        };
        0x2::event::emit<LockedEvent<T0>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg5), arg3.owner);
        0x2::transfer::transfer<Locked<T0>>(v1, 0x2::tx_context::sender(arg5));
        arg3.locked_objects_total = arg3.locked_objects_total + 1;
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.locked_until_ms <= 0x2::clock::timestamp_ms(arg1), 3);
        let Locked {
            id              : v0,
            obj             : v1,
            locked_until_ms : _,
        } = arg0;
        let v3 = v0;
        let v4 = UnlockedEvent<T0>{locked_object_id: 0x2::object::uid_to_address(&v3)};
        0x2::event::emit<UnlockedEvent<T0>>(v4);
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<T0>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

