module 0x61952f894dd7c301a0b95aa7e456ff21a2927f49316b2a853ac35adbe2da1e49::sec2 {
    struct SEC2 has drop {
        dummy_field: bool,
    }

    struct BurnVault has key {
        id: 0x2::object::UID,
        internal_pool: 0x2::balance::Balance<SEC2>,
        last_ts: u64,
        boost_end_ts: u64,
        end_ts: u64,
        boost_rate: u64,
        normal_rate: u64,
        initialized: bool,
    }

    struct BurnAuthority has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SEC2>,
    }

    fun init(arg0: SEC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEC2>(arg0, 9, b"2SEC", b"TwoSecondBurn", b"Deflationary token with phased burn schedule", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://github.com/2SECSUI/TwoSecondBurn-Time-based-deflation/blob/main/2secLogo.png?raw=true")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SEC2>>(0x2::coin::mint<SEC2>(&mut v2, 50000000000000000, arg1), @0x4d200af9d690805434f74a1e855261cda9765725324aeebb464f1379a1c8e8bc);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEC2>>(0x2::coin::mint<SEC2>(&mut v2, 50000000000000000, arg1), @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEC2>>(0x2::coin::mint<SEC2>(&mut v2, 50000000000000000, arg1), @0x36d2a3e849e75f7e860d19de46c6fc50420b85a293d66d177628de3ead61fba);
        let v3 = BurnVault{
            id            : 0x2::object::new(arg1),
            internal_pool : 0x2::coin::into_balance<SEC2>(0x2::coin::mint<SEC2>(&mut v2, 850000000000000000, arg1)),
            last_ts       : 0,
            boost_end_ts  : 0,
            end_ts        : 0,
            boost_rate    : 15,
            normal_rate   : 2,
            initialized   : false,
        };
        0x2::transfer::share_object<BurnVault>(v3);
        let v4 = BurnAuthority{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<BurnAuthority>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEC2>>(v1);
    }

    entry fun interact(arg0: &mut BurnVault, arg1: &mut BurnAuthority, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (!arg0.initialized) {
            arg0.last_ts = v0;
            arg0.boost_end_ts = v0 + 17280000;
            arg0.end_ts = v0 + 315360000;
            arg0.initialized = true;
            return
        };
        if (v0 <= arg0.last_ts || arg0.last_ts >= arg0.end_ts) {
            return
        };
        let v1 = if (v0 > arg0.end_ts) {
            arg0.end_ts
        } else {
            v0
        };
        let v2 = if (arg0.last_ts < arg0.boost_end_ts && v1 <= arg0.boost_end_ts) {
            (v1 - arg0.last_ts) * arg0.boost_rate * 1000000000
        } else if (arg0.last_ts >= arg0.boost_end_ts) {
            (v1 - arg0.last_ts) * arg0.normal_rate * 1000000000
        } else {
            (arg0.boost_end_ts - arg0.last_ts) * arg0.boost_rate * 1000000000 + (v1 - arg0.boost_end_ts) * arg0.normal_rate * 1000000000
        };
        let v3 = 0x2::balance::value<SEC2>(&arg0.internal_pool);
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        if (v4 > 0) {
            0x2::coin::burn<SEC2>(&mut arg1.cap, 0x2::coin::from_balance<SEC2>(0x2::balance::split<SEC2>(&mut arg0.internal_pool, v4), arg3));
        };
        arg0.last_ts = v1;
    }

    // decompiled from Move bytecode v6
}

