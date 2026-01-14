module 0x846edd3cb5dd1acc21e85d12debf8933d4d689784fb08948dcb0700f2b8e7985::bulldog {
    struct BULLDOG has drop {
        dummy_field: bool,
    }

    struct BurnVault has key {
        id: 0x2::object::UID,
        internal_pool: 0x2::balance::Balance<BULLDOG>,
        treasury_cap: 0x2::coin::TreasuryCap<BULLDOG>,
        last_interaction: u64,
        end_timestamp: u64,
        is_initialized: bool,
    }

    fun init(arg0: BULLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLDOG>(arg0, 9, b"BULLDOG", b"Bulldog", b"2 Tokens/Sec Burn", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLDOG>>(0x2::coin::mint<BULLDOG>(&mut v2, 50000000000000000, arg1), @0x4d200af9d690805434f74a1e855261cda9765725324aeebb464f1379a1c8e8bc);
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLDOG>>(0x2::coin::mint<BULLDOG>(&mut v2, 50000000000000000, arg1), @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a);
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLDOG>>(0x2::coin::mint<BULLDOG>(&mut v2, 50000000000000000, arg1), @0x36d2a3e849e75f7e860d19de46c6fc50420b85a293d66d177628de3ead61fba);
        let v3 = BurnVault{
            id               : 0x2::object::new(arg1),
            internal_pool    : 0x2::coin::into_balance<BULLDOG>(0x2::coin::mint<BULLDOG>(&mut v2, 850000000000000000, arg1)),
            treasury_cap     : v2,
            last_interaction : 0,
            end_timestamp    : 0,
            is_initialized   : false,
        };
        0x2::transfer::share_object<BurnVault>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLDOG>>(v1);
    }

    entry fun interact(arg0: &mut BurnVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (!arg0.is_initialized) {
            arg0.last_interaction = v0;
            arg0.end_timestamp = v0 + 315360000000;
            arg0.is_initialized = true;
            return
        };
        if (v0 > arg0.last_interaction && arg0.last_interaction < arg0.end_timestamp) {
            let v1 = if (v0 > arg0.end_timestamp) {
                arg0.end_timestamp
            } else {
                v0
            };
            let v2 = (v1 - arg0.last_interaction) / 1000;
            if (v2 > 0) {
                let v3 = v2 * 2 * 1000000000;
                let v4 = 0x2::balance::value<BULLDOG>(&arg0.internal_pool);
                let v5 = if (v3 > v4) {
                    v4
                } else {
                    v3
                };
                if (v5 > 0) {
                    0x2::coin::burn<BULLDOG>(&mut arg0.treasury_cap, 0x2::coin::from_balance<BULLDOG>(0x2::balance::split<BULLDOG>(&mut arg0.internal_pool, v5), arg2));
                };
                arg0.last_interaction = v1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

