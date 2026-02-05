module 0xe6df87428ddb010d32d464ecf5ce678676004665f39c089ea58ce80e7a2740e7::auction {
    struct DecayListing<T0: store + key> has key {
        id: 0x2::object::UID,
        nft: T0,
        seller: address,
        start_price_mist: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    public entry fun buy<T0: store + key>(arg0: DecayListing<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time_ms, 3);
        assert!(v0 < arg0.end_time_ms, 4);
        let v1 = current_price_internal<T0>(&arg0, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 2);
        let DecayListing {
            id               : v2,
            nft              : v3,
            seller           : v4,
            start_price_mist : _,
            start_time_ms    : _,
            end_time_ms      : _,
        } = arg0;
        0x2::object::delete(v2);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3), v4);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg3));
    }

    public entry fun cancel<T0: store + key>(arg0: DecayListing<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg2), 5);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.start_time_ms + 86400000, 7);
        let DecayListing {
            id               : v0,
            nft              : v1,
            seller           : v2,
            start_price_mist : _,
            start_time_ms    : _,
            end_time_ms      : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v1, v2);
    }

    public fun create<T0: store + key>(arg0: T0, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DecayListing<T0> {
        assert!(arg2 >= 3600000 && arg2 <= 2592000000, 0);
        assert!(arg1 >= 1000000000, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        DecayListing<T0>{
            id               : 0x2::object::new(arg4),
            nft              : arg0,
            seller           : 0x2::tx_context::sender(arg4),
            start_price_mist : arg1,
            start_time_ms    : v0,
            end_time_ms      : v0 + arg2,
        }
    }

    public entry fun create_and_share<T0: store + key>(arg0: T0, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DecayListing<T0>>(create<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun current_price<T0: store + key>(arg0: &DecayListing<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time_ms) {
            return 0
        };
        if (v0 < arg0.start_time_ms) {
            return arg0.start_price_mist
        };
        current_price_internal<T0>(arg0, v0)
    }

    fun current_price_internal<T0: store + key>(arg0: &DecayListing<T0>, arg1: u64) : u64 {
        (((arg0.start_price_mist as u256) * pow_eight(((arg0.end_time_ms - arg1) as u256) * 1000000 / ((arg0.end_time_ms - arg0.start_time_ms) as u256)) / 1000000000000000000000000000000000000000000000000) as u64)
    }

    public fun end_time_ms<T0: store + key>(arg0: &DecayListing<T0>) : u64 {
        arg0.end_time_ms
    }

    public fun is_active<T0: store + key>(arg0: &DecayListing<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.start_time_ms && v0 < arg0.end_time_ms
    }

    public fun is_expired<T0: store + key>(arg0: &DecayListing<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms
    }

    fun pow_eight(arg0: u256) : u256 {
        let v0 = arg0 * arg0;
        let v1 = v0 * v0;
        v1 * v1
    }

    public entry fun reclaim_expired<T0: store + key>(arg0: DecayListing<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms, 6);
        let DecayListing {
            id               : v0,
            nft              : v1,
            seller           : v2,
            start_price_mist : _,
            start_time_ms    : _,
            end_time_ms      : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v1, v2);
    }

    public fun seller<T0: store + key>(arg0: &DecayListing<T0>) : address {
        arg0.seller
    }

    public fun start_price_mist<T0: store + key>(arg0: &DecayListing<T0>) : u64 {
        arg0.start_price_mist
    }

    public fun start_time_ms<T0: store + key>(arg0: &DecayListing<T0>) : u64 {
        arg0.start_time_ms
    }

    // decompiled from Move bytecode v6
}

