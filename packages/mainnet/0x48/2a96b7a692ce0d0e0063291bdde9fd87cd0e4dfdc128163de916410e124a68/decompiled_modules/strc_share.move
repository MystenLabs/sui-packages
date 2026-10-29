module 0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_share {
    struct STRC_SHARE has key {
        id: 0x2::object::UID,
    }

    struct ShareVault has key {
        id: 0x2::object::UID,
        version: u64,
        registry: 0x2::object::ID,
        treasury: 0x2::coin::TreasuryCap<STRC_SHARE>,
        locked: 0x2::balance::Balance<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>,
        rate: u64,
        last_rate_clock_ms: u64,
        last_attest_ms: u64,
        last_strcx_price_e6: u64,
        rate_cap: 0x2::object::ID,
        nonce: u64,
        paused: bool,
        attest_cap: 0x2::object::ID,
        attested_strcx_units: u64,
        por_ref: vector<u8>,
        por_clock_ms: u64,
        por_nonce: u64,
        used_refs: 0x2::table::Table<vector<u8>, u64>,
        last_dividend_ref: vector<u8>,
    }

    struct AttestCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        holder: address,
    }

    struct AttestCapIssued has copy, drop {
        vault: 0x2::object::ID,
        cap: 0x2::object::ID,
        holder: address,
    }

    struct AttestCapRevoked has copy, drop {
        vault: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct ReserveAttested has copy, drop {
        vault: 0x2::object::ID,
        nonce: u64,
        strcx_units: u64,
        liabilities: u64,
        backing_bps: u64,
        por_ref: vector<u8>,
        under_backed: bool,
    }

    struct MigrateRefund has copy, drop {
        vault: 0x2::object::ID,
        units: u64,
    }

    struct RateCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct ShareVaultCreated has copy, drop {
        vault: 0x2::object::ID,
        registry: 0x2::object::ID,
        rate_cap: 0x2::object::ID,
    }

    struct RateProof has copy, drop {
        vault: 0x2::object::ID,
        nonce: u64,
        new_rate: u64,
        deposit: u64,
        dividend_ref: vector<u8>,
        proof: vector<u8>,
        flagged: bool,
    }

    struct Migrated has copy, drop {
        vault: 0x2::object::ID,
        shares: u64,
    }

    struct Exited has copy, drop {
        vault: 0x2::object::ID,
        shares: u64,
        units: u64,
    }

    struct RateCapRotated has copy, drop {
        vault: 0x2::object::ID,
        old_cap: 0x2::object::ID,
        new_cap: 0x2::object::ID,
    }

    struct PauseSet has copy, drop {
        vault: 0x2::object::ID,
        paused: bool,
    }

    fun assert_backed(arg0: &ShareVault, arg1: &0x2::clock::Clock) {
        assert!(arg0.por_clock_ms != 0 && 0x2::clock::timestamp_ms(arg1) <= arg0.por_clock_ms + 129600000, 218);
        assert!(arg0.attested_strcx_units >= liabilities(arg0), 217);
    }

    fun assert_invariant(arg0: &ShareVault) {
        assert!((0x2::coin::total_supply<STRC_SHARE>(&arg0.treasury) as u128) * (arg0.rate as u128) / (1000000000 as u128) <= (0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked) as u128), 211);
    }

    fun assert_live(arg0: &ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry) {
        assert!(arg0.version == 1, 209);
        assert!(0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) == arg0.registry, 201);
        assert!(!arg0.paused && !0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::is_halted(arg1), 213);
    }

    public fun attest_cap_holder(arg0: &AttestCap) : address {
        arg0.holder
    }

    public fun attest_cap_id(arg0: &ShareVault) : 0x2::object::ID {
        arg0.attest_cap
    }

    public fun attest_dividend(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &RateCap, arg3: 0x2::coin::Coin<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_live(arg0, arg1);
        assert!(arg2.vault == 0x2::object::id<ShareVault>(arg0) && arg0.rate_cap == 0x2::object::id<RateCap>(arg2), 201);
        assert!(0x2::tx_context::sender(arg9) == 0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::oracle_holder(arg1), 210);
        attest_inner(arg0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun attest_dividend_delegated(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &AttestCap, arg3: 0x2::coin::Coin<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_live(arg0, arg1);
        assert!(arg0.attest_cap != 0x2::object::id_from_address(@0x0), 220);
        assert!(arg2.vault == 0x2::object::id<ShareVault>(arg0) && arg0.attest_cap == 0x2::object::id<AttestCap>(arg2), 201);
        assert!(0x2::tx_context::sender(arg9) == arg2.holder, 221);
        attest_inner(arg0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun attest_inner(arg0: &mut ShareVault, arg1: 0x2::coin::Coin<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg1);
        let v1 = if (v0 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 202);
        assert!(valid_dividend_ref(&arg5), 216);
        let v2 = 0x2::coin::total_supply<STRC_SHARE>(&arg0.treasury);
        assert!(v2 > 0, 208);
        let v3 = 0x2::clock::timestamp_ms(arg6);
        let v4 = if (arg4 > arg0.last_attest_ms) {
            if (arg4 <= v3) {
                v3 - arg4 <= 3600000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 207);
        assert!(arg0.last_rate_clock_ms == 0 || v3 >= arg0.last_rate_clock_ms + 72000000, 205);
        let v5 = divergence_bps(arg2, arg3);
        assert!(v5 <= 618, 206);
        let v6 = arg0.rate;
        let v7 = ((((0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked) + v0) as u128) * (1000000000 as u128) / (v2 as u128)) as u64);
        assert!(v7 >= v6, 203);
        let v8 = v7 - v6;
        assert!(v8 > 0, 203);
        assert!((v8 as u128) * (10000 as u128) <= (v6 as u128) * (50 as u128), 204);
        let v9 = 0x2::object::id<ShareVault>(arg0);
        let v10 = 0x1::bcs::to_bytes<0x2::object::ID>(&v9);
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u64>(&arg0.nonce));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u64>(&v6));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<vector<u8>>(&arg5));
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.used_refs, arg5), 222);
        0x2::table::add<vector<u8>, u64>(&mut arg0.used_refs, arg5, arg0.nonce);
        arg0.last_dividend_ref = arg5;
        0x2::balance::join<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&mut arg0.locked, 0x2::coin::into_balance<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(arg1));
        arg0.rate = v7;
        arg0.last_rate_clock_ms = v3;
        arg0.last_attest_ms = arg4;
        arg0.last_strcx_price_e6 = arg3;
        let v11 = arg0.nonce;
        arg0.nonce = v11 + 1;
        assert_invariant(arg0);
        let v12 = RateProof{
            vault        : 0x2::object::id<ShareVault>(arg0),
            nonce        : v11,
            new_rate     : arg0.rate,
            deposit      : v0,
            dividend_ref : arg5,
            proof        : 0x1::hash::sha2_256(v10),
            flagged      : v5 > 236,
        };
        0x2::event::emit<RateProof>(v12);
    }

    public fun attest_reserve(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::AdminCap, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 209);
        assert!(0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::admin_cap_registry(arg2) == 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) && 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) == arg0.registry, 201);
        let v0 = 0x1::vector::length<u8>(&arg4);
        assert!(v0 > 0 && v0 <= 64, 219);
        arg0.attested_strcx_units = arg3;
        arg0.por_ref = arg4;
        arg0.por_clock_ms = 0x2::clock::timestamp_ms(arg5);
        let v1 = arg0.por_nonce;
        arg0.por_nonce = v1 + 1;
        let v2 = liabilities(arg0);
        let v3 = if (v2 == 0) {
            10000
        } else {
            (((arg3 as u128) * (10000 as u128) / (v2 as u128)) as u64)
        };
        let v4 = ReserveAttested{
            vault        : 0x2::object::id<ShareVault>(arg0),
            nonce        : v1,
            strcx_units  : arg3,
            liabilities  : v2,
            backing_bps  : v3,
            por_ref      : arg0.por_ref,
            under_backed : v3 < 10000,
        };
        0x2::event::emit<ReserveAttested>(v4);
    }

    public fun attested_strcx_units(arg0: &ShareVault) : u64 {
        arg0.attested_strcx_units
    }

    public fun backing_bps(arg0: &ShareVault) : u64 {
        let v0 = liabilities(arg0);
        if (v0 == 0) {
            10000
        } else {
            (((arg0.attested_strcx_units as u128) * (10000 as u128) / (v0 as u128)) as u64)
        }
    }

    public fun create(arg0: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::AdminCap, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::admin_cap_registry(arg1) == 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg0), 201);
        assert!(!0x2::coin_registry::exists<STRC_SHARE>(arg2), 212);
        let (v0, v1) = 0x2::coin_registry::new_currency<STRC_SHARE>(arg2, 6, 0x1::string::utf8(b"sSTRC"), 0x1::string::utf8(b"sSTRC"), 0x1::string::utf8(b"sSTRC, backed 1:1 by xStocks STRCX shares held in the Junction wallet, as attested by the issuer (self-attested). Issued by The Spice Melange. Not issued, backed or endorsed by Strategy."), 0x1::string::utf8(b""), arg3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<STRC_SHARE>>(0x2::coin_registry::finalize<STRC_SHARE>(v0, arg3), 0x2::tx_context::sender(arg3));
        let v2 = 0x2::object::new(arg3);
        let v3 = RateCap{
            id    : 0x2::object::new(arg3),
            vault : 0x2::object::uid_to_inner(&v2),
        };
        let v4 = 0x2::object::id<RateCap>(&v3);
        let v5 = ShareVaultCreated{
            vault    : 0x2::object::uid_to_inner(&v2),
            registry : 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg0),
            rate_cap : v4,
        };
        0x2::event::emit<ShareVaultCreated>(v5);
        let v6 = ShareVault{
            id                   : v2,
            version              : 1,
            registry             : 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg0),
            treasury             : v1,
            locked               : 0x2::balance::zero<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(),
            rate                 : 1000000000,
            last_rate_clock_ms   : 0,
            last_attest_ms       : 0,
            last_strcx_price_e6  : 0,
            rate_cap             : v4,
            nonce                : 0,
            paused               : false,
            attest_cap           : 0x2::object::id_from_address(@0x0),
            attested_strcx_units : 0,
            por_ref              : b"",
            por_clock_ms         : 0,
            por_nonce            : 0,
            used_refs            : 0x2::table::new<vector<u8>, u64>(arg3),
            last_dividend_ref    : b"",
        };
        0x2::transfer::share_object<ShareVault>(v6);
        0x2::transfer::transfer<RateCap>(v3, 0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::oracle_holder(arg0));
    }

    public fun divergence_bps(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = if (arg0 > arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        ((((v0 - v1) as u128) * (10000 as u128) / (v1 as u128)) as u64)
    }

    public fun dust_units(arg0: &ShareVault) : u64 {
        0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked) - 0x1::u64::min(liabilities(arg0), 0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked))
    }

    public fun exit(arg0: &mut ShareVault, arg1: 0x2::coin::Coin<STRC_SHARE>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN> {
        assert!(arg0.version == 1, 209);
        let v0 = 0x2::coin::value<STRC_SHARE>(&arg1);
        assert!(v0 > 0, 202);
        let v1 = (((v0 as u128) * (0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked) as u128) / (0x2::coin::total_supply<STRC_SHARE>(&arg0.treasury) as u128)) as u64);
        0x2::coin::burn<STRC_SHARE>(&mut arg0.treasury, arg1);
        let v2 = Exited{
            vault  : 0x2::object::id<ShareVault>(arg0),
            shares : v0,
            units  : v1,
        };
        0x2::event::emit<Exited>(v2);
        assert_invariant(arg0);
        0x2::coin::from_balance<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(0x2::balance::split<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&mut arg0.locked, v1), arg2)
    }

    public fun issue_attest_cap(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::AdminCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 209);
        assert!(0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::admin_cap_registry(arg2) == 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) && 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) == arg0.registry, 201);
        let v0 = AttestCap{
            id     : 0x2::object::new(arg4),
            vault  : 0x2::object::id<ShareVault>(arg0),
            holder : arg3,
        };
        if (arg0.attest_cap != 0x2::object::id_from_address(@0x0)) {
            let v1 = AttestCapRevoked{
                vault : 0x2::object::id<ShareVault>(arg0),
                cap   : arg0.attest_cap,
            };
            0x2::event::emit<AttestCapRevoked>(v1);
        };
        arg0.attest_cap = 0x2::object::id<AttestCap>(&v0);
        let v2 = AttestCapIssued{
            vault  : 0x2::object::id<ShareVault>(arg0),
            cap    : arg0.attest_cap,
            holder : arg3,
        };
        0x2::event::emit<AttestCapIssued>(v2);
        0x2::transfer::transfer<AttestCap>(v0, arg3);
    }

    public fun join_open(arg0: &ShareVault, arg1: &0x2::clock::Clock) : bool {
        arg0.last_rate_clock_ms == 0 || 0x2::clock::timestamp_ms(arg1) <= arg0.last_rate_clock_ms + 14400000
    }

    public fun last_dividend_ref(arg0: &ShareVault) : vector<u8> {
        arg0.last_dividend_ref
    }

    public fun last_strcx_price_e6(arg0: &ShareVault) : u64 {
        arg0.last_strcx_price_e6
    }

    fun liabilities(arg0: &ShareVault) : u64 {
        ((((0x2::coin::total_supply<STRC_SHARE>(&arg0.treasury) as u128) * (arg0.rate as u128) + (1000000000 as u128) - 1) / (1000000000 as u128)) as u64)
    }

    public fun locked_units(arg0: &ShareVault) : u64 {
        0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked)
    }

    public fun migrate(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: 0x2::coin::Coin<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STRC_SHARE> {
        assert_live(arg0, arg1);
        assert!(join_open(arg0, arg3), 214);
        let v0 = 0x2::coin::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg2);
        assert!(v0 > 0, 202);
        assert!(arg0.last_rate_clock_ms != 0 || 0x2::balance::value<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&arg0.locked) + v0 <= 100000000, 215);
        let v1 = (((v0 as u128) * (1000000000 as u128) / (arg0.rate as u128)) as u64);
        assert!(v1 > 0, 202);
        let v2 = ((((v1 as u128) * (arg0.rate as u128) + (1000000000 as u128) - 1) / (1000000000 as u128)) as u64);
        if (v2 < v0) {
            let v3 = MigrateRefund{
                vault : 0x2::object::id<ShareVault>(arg0),
                units : v0 - v2,
            };
            0x2::event::emit<MigrateRefund>(v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>>(0x2::coin::split<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&mut arg2, v0 - v2, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(&mut arg0.locked, 0x2::coin::into_balance<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc_coin::STRC_COIN>(arg2));
        let v4 = Migrated{
            vault  : 0x2::object::id<ShareVault>(arg0),
            shares : v1,
        };
        0x2::event::emit<Migrated>(v4);
        assert_invariant(arg0);
        assert_backed(arg0, arg3);
        0x2::coin::mint<STRC_SHARE>(&mut arg0.treasury, v1, arg4)
    }

    public fun nonce(arg0: &ShareVault) : u64 {
        arg0.nonce
    }

    public fun paused(arg0: &ShareVault) : bool {
        arg0.paused
    }

    public fun pre_attest_max_units() : u64 {
        100000000
    }

    public fun rate(arg0: &ShareVault) : u64 {
        arg0.rate
    }

    public fun ref_used(arg0: &ShareVault, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.used_refs, arg1)
    }

    public fun revoke_attest_cap(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::AdminCap) {
        assert!(arg0.version == 1, 209);
        assert!(0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::admin_cap_registry(arg2) == 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) && 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) == arg0.registry, 201);
        let v0 = AttestCapRevoked{
            vault : 0x2::object::id<ShareVault>(arg0),
            cap   : arg0.attest_cap,
        };
        0x2::event::emit<AttestCapRevoked>(v0);
        arg0.attest_cap = 0x2::object::id_from_address(@0x0);
    }

    public fun rotate_rate_cap(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 209);
        assert!(0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::admin_cap_registry(arg2) == 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) && 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) == arg0.registry, 201);
        let v0 = RateCap{
            id    : 0x2::object::new(arg3),
            vault : 0x2::object::id<ShareVault>(arg0),
        };
        arg0.rate_cap = 0x2::object::id<RateCap>(&v0);
        let v1 = RateCapRotated{
            vault   : 0x2::object::id<ShareVault>(arg0),
            old_cap : arg0.rate_cap,
            new_cap : arg0.rate_cap,
        };
        0x2::event::emit<RateCapRotated>(v1);
        0x2::transfer::transfer<RateCap>(v0, 0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::oracle_holder(arg1));
    }

    public fun scale() : u64 {
        1000000000
    }

    public fun set_paused(arg0: &mut ShareVault, arg1: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry, arg2: &0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::AdminCap, arg3: bool) {
        assert!(arg0.version == 1, 209);
        assert!(0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::admin_cap_registry(arg2) == 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) && 0x2::object::id<0xd9cf2b85f018b014c10871c0515eb82f08f0f4aa9cb051c8bc2a8508daa90d9d::strc::Registry>(arg1) == arg0.registry, 201);
        arg0.paused = arg3;
        let v0 = PauseSet{
            vault  : 0x2::object::id<ShareVault>(arg0),
            paused : arg3,
        };
        0x2::event::emit<PauseSet>(v0);
    }

    public fun total_shares(arg0: &ShareVault) : u64 {
        0x2::coin::total_supply<STRC_SHARE>(&arg0.treasury)
    }

    public fun valid_dividend_ref(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 40) {
            return false
        };
        let v0 = 32;
        let v1 = vector[];
        while (v0 < 40) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            if (v2 < 48 || v2 > 57) {
                return false
            };
            0x1::vector::push_back<u64>(&mut v1, ((v2 - 48) as u64));
            v0 = v0 + 1;
        };
        let v3 = *0x1::vector::borrow<u64>(&v1, 0) * 1000 + *0x1::vector::borrow<u64>(&v1, 1) * 100 + *0x1::vector::borrow<u64>(&v1, 2) * 10 + *0x1::vector::borrow<u64>(&v1, 3);
        let v4 = *0x1::vector::borrow<u64>(&v1, 4) * 10 + *0x1::vector::borrow<u64>(&v1, 5);
        let v5 = *0x1::vector::borrow<u64>(&v1, 6) * 10 + *0x1::vector::borrow<u64>(&v1, 7);
        if (v3 >= 2000) {
            if (v3 <= 2099) {
                if (v4 >= 1) {
                    if (v4 <= 12) {
                        if (v5 >= 1) {
                            v5 <= 31
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun value_of(arg0: &ShareVault, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.rate as u128) / (1000000000 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

