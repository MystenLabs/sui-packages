module 0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::cast {
    struct Cast has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        vessel_tier: u8,
        hook: vector<u8>,
        content_blob: vector<u8>,
        media_blob: 0x1::option::Option<vector<u8>>,
        mode: u8,
        recipient: address,
        state: u8,
        created_at: u64,
        expires_at: u64,
        read_count: u64,
        tide_1_count: u64,
        tide_2_count: u64,
        tide_3_count: u64,
        current_tide: u8,
        is_lighthouse: bool,
        fee_paid: u64,
        author: address,
        max_claims: u64,
        claims_used: u64,
        dock_upgrade_fee_paid: u64,
        dock_description: vector<u8>,
    }

    struct CastSounded has copy, drop {
        cast_id: address,
        hook: vector<u8>,
        mode: u8,
        duration: u8,
        created_at: u64,
        expires_at: u64,
    }

    struct CastRead has copy, drop {
        cast_id: address,
        read_count: u64,
        read_at: u64,
    }

    struct CastBurned has copy, drop {
        cast_id: address,
        mode: u8,
        burned_at: u64,
    }

    struct TideSurvived has copy, drop {
        cast_id: address,
        tide: u8,
        read_count: u64,
        survived_at: u64,
    }

    struct LighthouseBorn has copy, drop {
        cast_id: address,
        read_count: u64,
        born_at: u64,
    }

    struct DockOpened has copy, drop {
        cast_id: address,
        max_claims: u64,
        upgrade_fee_paid: u64,
        opened_at: u64,
    }

    struct DockClaimed has copy, drop {
        cast_id: address,
        claimant: address,
        claims_used: u64,
        max_claims: u64,
        claimed_at: u64,
    }

    public fun author(arg0: &Cast) : address {
        arg0.author
    }

    fun become_lighthouse(arg0: &mut Cast, arg1: u64) {
        arg0.is_lighthouse = true;
        arg0.expires_at = arg1 + 3153600000000;
        let v0 = 0x2::object::id<Cast>(arg0);
        let v1 = LighthouseBorn{
            cast_id    : 0x2::object::id_to_address(&v0),
            read_count : arg0.read_count,
            born_at    : arg1,
        };
        0x2::event::emit<LighthouseBorn>(v1);
    }

    fun check_tide(arg0: &mut Cast, arg1: &0x2::clock::Clock) {
        if (arg0.is_lighthouse) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 - arg0.created_at;
        if (v1 <= 86400000 && arg0.read_count >= 1000000) {
            become_lighthouse(arg0, v0);
            return
        };
        if (arg0.current_tide == 1) {
            if (arg0.read_count >= 500000 && v1 <= 86400000) {
                arg0.tide_1_count = arg0.read_count;
                arg0.current_tide = 2;
                arg0.expires_at = arg0.created_at + 86400000 * 2;
                let v2 = 0x2::object::id<Cast>(arg0);
                let v3 = TideSurvived{
                    cast_id     : 0x2::object::id_to_address(&v2),
                    tide        : 1,
                    read_count  : arg0.tide_1_count,
                    survived_at : v0,
                };
                0x2::event::emit<TideSurvived>(v3);
            };
        } else if (arg0.current_tide == 2) {
            let v4 = arg0.read_count - arg0.tide_1_count;
            if (v4 >= 500000) {
                arg0.tide_2_count = v4;
                arg0.current_tide = 3;
                arg0.expires_at = arg0.created_at + 86400000 * 3;
                let v5 = 0x2::object::id<Cast>(arg0);
                let v6 = TideSurvived{
                    cast_id     : 0x2::object::id_to_address(&v5),
                    tide        : 2,
                    read_count  : arg0.tide_2_count,
                    survived_at : v0,
                };
                0x2::event::emit<TideSurvived>(v6);
            };
        } else if (arg0.current_tide == 3) {
            let v7 = arg0.read_count - arg0.tide_1_count - arg0.tide_2_count;
            if (v7 >= 500000) {
                arg0.tide_3_count = v7;
                become_lighthouse(arg0, v0);
            };
        };
    }

    public fun claims_remaining(arg0: &Cast) : u64 {
        if (arg0.claims_used >= arg0.max_claims) {
            0
        } else {
            arg0.max_claims - arg0.claims_used
        }
    }

    public fun claims_used(arg0: &Cast) : u64 {
        arg0.claims_used
    }

    public fun current_tide(arg0: &Cast) : u8 {
        arg0.current_tide
    }

    public fun dock_description(arg0: &Cast) : vector<u8> {
        arg0.dock_description
    }

    public fun dock_upgrade_fee_paid(arg0: &Cast) : u64 {
        arg0.dock_upgrade_fee_paid
    }

    public fun expires_at(arg0: &Cast) : u64 {
        arg0.expires_at
    }

    public fun hook(arg0: &Cast) : vector<u8> {
        arg0.hook
    }

    public fun is_dock_full(arg0: &Cast) : bool {
        arg0.claims_used >= arg0.max_claims
    }

    public fun is_lighthouse(arg0: &Cast) : bool {
        arg0.is_lighthouse
    }

    public fun max_claims(arg0: &Cast) : u64 {
        arg0.max_claims
    }

    public fun mode(arg0: &Cast) : u8 {
        arg0.mode
    }

    public fun mode_eyes_only() : u8 {
        2
    }

    public fun mode_ghost() : u8 {
        3
    }

    public fun mode_open() : u8 {
        0
    }

    public fun mode_sealed() : u8 {
        1
    }

    public fun read(arg0: &mut Cast, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::abyss::Abyss, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.state == 0, 3);
        assert!(arg0.is_lighthouse || v0 < arg0.expires_at, 1);
        if (arg0.mode == 2) {
            assert!(arg0.claims_used < arg0.max_claims, 5);
            arg0.claims_used = arg0.claims_used + 1;
            let v1 = 0x2::object::id<Cast>(arg0);
            let v2 = DockClaimed{
                cast_id     : 0x2::object::id_to_address(&v1),
                claimant    : arg3,
                claims_used : arg0.claims_used,
                max_claims  : arg0.max_claims,
                claimed_at  : v0,
            };
            0x2::event::emit<DockClaimed>(v2);
        } else if (arg0.mode == 1) {
            assert!(arg3 == arg0.recipient, 2);
        };
        let v3 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        if (arg0.fee_paid == 0) {
            0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::abyss::receive_read(arg2, arg1, arg4, arg5);
        } else {
            assert!(v3 >= 100000, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1, v3 * 97 / 100, arg5), arg0.author);
            0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::abyss::receive_read(arg2, arg1, arg4, arg5);
        };
        arg0.read_count = arg0.read_count + 1;
        let v4 = 0x2::object::id<Cast>(arg0);
        let v5 = CastRead{
            cast_id    : 0x2::object::id_to_address(&v4),
            read_count : arg0.read_count,
            read_at    : v0,
        };
        0x2::event::emit<CastRead>(v5);
        if (arg0.mode == 3 || arg0.mode == 2) {
            if (arg0.mode == 3 || arg0.claims_used >= arg0.max_claims) {
                arg0.state = 1;
                arg0.content_blob = 0x1::vector::empty<u8>();
                arg0.media_blob = 0x1::option::none<vector<u8>>();
                let v6 = 0x2::object::id<Cast>(arg0);
                let v7 = CastBurned{
                    cast_id   : 0x2::object::id_to_address(&v6),
                    mode      : arg0.mode,
                    burned_at : v0,
                };
                0x2::event::emit<CastBurned>(v7);
            };
            return
        };
        if (arg0.mode == 0) {
            check_tide(arg0, arg4);
        };
    }

    public fun read_count(arg0: &Cast) : u64 {
        arg0.read_count
    }

    public fun sound(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::abyss::Abyss, arg2: 0x2::object::ID, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::option::Option<vector<u8>>, arg7: u8, arg8: address, arg9: u8, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 1 && arg11 <= 10000, 6);
        let v0 = (arg11 - 1) * 10000;
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        assert!(v1 >= v0, 7);
        if (arg7 == 2) {
            assert!(v1 >= 10000 + v0, 8);
        };
        let v2 = 0x2::clock::timestamp_ms(arg13);
        let v3 = if (arg9 == 1) {
            86400000
        } else if (arg9 == 2) {
            86400000 * 2
        } else if (arg9 == 3) {
            86400000 * 3
        } else {
            86400000 * 7
        };
        0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::abyss::receive_cast(arg1, arg0, arg13, arg14);
        let v4 = Cast{
            id                    : 0x2::object::new(arg14),
            vessel_id             : arg2,
            vessel_tier           : arg3,
            hook                  : arg4,
            content_blob          : arg5,
            media_blob            : arg6,
            mode                  : arg7,
            recipient             : arg8,
            state                 : 0,
            created_at            : v2,
            expires_at            : v2 + v3,
            read_count            : 0,
            tide_1_count          : 0,
            tide_2_count          : 0,
            tide_3_count          : 0,
            current_tide          : 1,
            is_lighthouse         : false,
            fee_paid              : arg10,
            author                : 0x2::tx_context::sender(arg14),
            max_claims            : arg11,
            claims_used           : 0,
            dock_upgrade_fee_paid : v0,
            dock_description      : arg12,
        };
        let v5 = 0x2::object::id<Cast>(&v4);
        let v6 = 0x2::object::id_to_address(&v5);
        let v7 = CastSounded{
            cast_id    : v6,
            hook       : v4.hook,
            mode       : arg7,
            duration   : arg9,
            created_at : v2,
            expires_at : v2 + v3,
        };
        0x2::event::emit<CastSounded>(v7);
        if (arg11 > 1) {
            let v8 = DockOpened{
                cast_id          : v6,
                max_claims       : arg11,
                upgrade_fee_paid : v0,
                opened_at        : v2,
            };
            0x2::event::emit<DockOpened>(v8);
        };
        0x2::transfer::share_object<Cast>(v4);
    }

    public fun state(arg0: &Cast) : u8 {
        arg0.state
    }

    public fun vessel_id(arg0: &Cast) : 0x2::object::ID {
        arg0.vessel_id
    }

    // decompiled from Move bytecode v7
}

