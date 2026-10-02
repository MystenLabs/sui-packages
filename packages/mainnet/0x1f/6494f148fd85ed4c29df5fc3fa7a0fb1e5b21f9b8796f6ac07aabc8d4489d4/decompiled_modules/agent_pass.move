module 0xf3d59d484f7353f8caf6d20ada8e99e51f21728d65318fc74b73b52ee8417e1d::agent_pass {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct YearSlot has copy, drop, store {
        pass: 0x2::object::ID,
        expires_ms: u64,
    }

    struct Service has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        admin: 0x2::object::ID,
        pay_to: address,
        quote_key: vector<u8>,
        calls_per_day: u64,
        max_year: u64,
        year_slots: vector<YearSlot>,
        used_nonces: 0x2::table::Table<u64, bool>,
        sold: u64,
    }

    struct AgentPass has key {
        id: 0x2::object::UID,
        serial: u64,
        tier: u8,
        minted_ms: u64,
        expires_ms: u64,
        calls_per_day: u64,
        renewal_usd_cents: u64,
    }

    struct PassBought has copy, drop {
        pass: 0x2::object::ID,
        buyer: address,
        tier: u8,
        coin: 0x1::ascii::String,
        amount: u64,
        expires_ms: u64,
        nonce: u64,
    }

    struct PassRenewed has copy, drop {
        pass: 0x2::object::ID,
        buyer: address,
        coin: 0x1::ascii::String,
        amount: u64,
        expires_ms: u64,
        nonce: u64,
    }

    struct ConfigChanged has copy, drop {
        what: vector<u8>,
        by_cap: 0x2::object::ID,
    }

    public fun active_year_passes(arg0: &Service, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<YearSlot>(&arg0.year_slots)) {
            if (0x1::vector::borrow<YearSlot>(&arg0.year_slots, v1).expires_ms >= 0x2::clock::timestamp_ms(arg1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun admin_check(arg0: &Service, arg1: &AdminCap) {
        assert!(arg0.version == 2, 13906834706920308752);
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin, 13906834711215538196);
    }

    public fun buy<T0>(arg0: &mut Service, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        live_check(arg0);
        let v0 = duration(arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        check_quote<T0>(arg0, 0, arg1, v1, arg3, arg4, arg5, 0, arg6, arg7);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = 0x2::object::new(arg7);
        let v4 = 0x2::object::uid_to_inner(&v3);
        if (arg1 == 3) {
            prune(arg0, v2);
            assert!(0x1::vector::length<YearSlot>(&arg0.year_slots) < arg0.max_year, 13906834956029460512);
            let v5 = YearSlot{
                pass       : v4,
                expires_ms : v2 + v0,
            };
            0x1::vector::push_back<YearSlot>(&mut arg0.year_slots, v5);
        };
        arg0.sold = arg0.sold + 1;
        let v6 = if (arg1 == 3) {
            29000
        } else {
            0
        };
        let v7 = AgentPass{
            id                : v3,
            serial            : arg0.sold,
            tier              : arg1,
            minted_ms         : v2,
            expires_ms        : v2 + v0,
            calls_per_day     : arg0.calls_per_day,
            renewal_usd_cents : v6,
        };
        let v8 = PassBought{
            pass       : v4,
            buyer      : 0x2::tx_context::sender(arg7),
            tier       : arg1,
            coin       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount     : v1,
            expires_ms : v2 + v0,
            nonce      : arg4,
        };
        0x2::event::emit<PassBought>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.pay_to);
        0x2::transfer::transfer<AgentPass>(v7, 0x2::tx_context::sender(arg7));
    }

    fun check_quote<T0>(arg0: &mut Service, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(0x1::vector::length<u8>(&arg0.quote_key) == 32, 13906834797116325930);
        assert!(v0 <= arg4, 13906834801410113560);
        assert!(arg4 - v0 <= 900000, 13906834805705211930);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_nonces, arg5), 13906834810000441374);
        let v1 = quote_message<T0>(arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg9), arg7);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.quote_key, &v1), 13906834818590244892);
        0x2::table::add<u64, bool>(&mut arg0.used_nonces, arg5, true);
    }

    fun duration(arg0: u8) : u64 {
        if (arg0 == 1) {
            86400000
        } else if (arg0 == 2) {
            604800000
        } else if (arg0 == 3) {
            31536000000
        } else {
            assert!(arg0 == 4, 13906834887309328406);
            2592000000
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Service{
            id            : 0x2::object::new(arg0),
            version       : 2,
            paused        : true,
            admin         : 0x2::object::id<AdminCap>(&v0),
            pay_to        : 0x2::tx_context::sender(arg0),
            quote_key     : b"",
            calls_per_day : 100,
            max_year      : 20,
            year_slots    : 0x1::vector::empty<YearSlot>(),
            used_nonces   : 0x2::table::new<u64, bool>(arg0),
            sold          : 0,
        };
        0x2::transfer::share_object<Service>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun live_check(arg0: &Service) {
        assert!(arg0.version == 2, 13906834689740439568);
        assert!(!arg0.paused, 13906834694035537938);
    }

    public fun max_year(arg0: &Service) : u64 {
        arg0.max_year
    }

    public fun migrate(arg0: &mut Service, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin, 13906835222316646420);
        assert!(arg0.version < 2, 13906835226612924456);
        arg0.version = 2;
        let v0 = ConfigChanged{
            what   : b"version",
            by_cap : 0x2::object::id<AdminCap>(arg1),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun pass_calls_per_day(arg0: &AgentPass) : u64 {
        arg0.calls_per_day
    }

    public fun pass_expires_ms(arg0: &AgentPass) : u64 {
        arg0.expires_ms
    }

    public fun pass_renewal_usd_cents(arg0: &AgentPass) : u64 {
        arg0.renewal_usd_cents
    }

    public fun pass_serial(arg0: &AgentPass) : u64 {
        arg0.serial
    }

    public fun pass_tier(arg0: &AgentPass) : u8 {
        arg0.tier
    }

    public fun paused(arg0: &Service) : bool {
        arg0.paused
    }

    public fun pay_to(arg0: &Service) : address {
        arg0.pay_to
    }

    fun prune(arg0: &mut Service, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<YearSlot>(&arg0.year_slots)) {
            if (0x1::vector::borrow<YearSlot>(&arg0.year_slots, v0).expires_ms < arg1) {
                0x1::vector::swap_remove<YearSlot>(&mut arg0.year_slots, v0);
                continue
            };
            v0 = v0 + 1;
        };
    }

    public fun quote_message<T0>(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64) : vector<u8> {
        let v0 = b"TRACKRECORD-AGENT-PASS-V1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg1));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        v0
    }

    public fun renew<T0>(arg0: &mut Service, arg1: &mut AgentPass, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        live_check(arg0);
        assert!(arg1.tier == 3, 13906835033339002914);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg1.expires_ms, 13906835041929068580);
        let v0 = 0x2::coin::value<T0>(&arg2);
        check_quote<T0>(arg0, 1, 3, v0, arg3, arg4, arg5, arg1.serial, arg6, arg7);
        arg1.expires_ms = arg1.expires_ms + 31536000000;
        let v1 = 0x2::object::id<AgentPass>(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<YearSlot>(&arg0.year_slots)) {
            if (0x1::vector::borrow<YearSlot>(&arg0.year_slots, v2).pass == v1) {
                0x1::vector::borrow_mut<YearSlot>(&mut arg0.year_slots, v2).expires_ms = arg1.expires_ms;
            };
            v2 = v2 + 1;
        };
        let v3 = PassRenewed{
            pass       : v1,
            buyer      : 0x2::tx_context::sender(arg7),
            coin       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount     : v0,
            expires_ms : arg1.expires_ms,
            nonce      : arg4,
        };
        0x2::event::emit<PassRenewed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.pay_to);
    }

    public fun rotate_admin(arg0: &mut Service, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        admin_check(arg0, &arg1);
        let AdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        arg0.admin = 0x2::object::id<AdminCap>(&v1);
        let v2 = ConfigChanged{
            what   : b"admin",
            by_cap : 0x2::object::id<AdminCap>(&v1),
        };
        0x2::event::emit<ConfigChanged>(v2);
        v1
    }

    public fun set_calls_per_day(arg0: &mut Service, arg1: &AdminCap, arg2: u64) {
        admin_check(arg0, arg1);
        arg0.calls_per_day = arg2;
        let v0 = ConfigChanged{
            what   : b"calls_per_day",
            by_cap : 0x2::object::id<AdminCap>(arg1),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_max_year(arg0: &mut Service, arg1: &AdminCap, arg2: u64) {
        admin_check(arg0, arg1);
        arg0.max_year = arg2;
        let v0 = ConfigChanged{
            what   : b"max_year",
            by_cap : 0x2::object::id<AdminCap>(arg1),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_paused(arg0: &mut Service, arg1: &AdminCap, arg2: bool) {
        admin_check(arg0, arg1);
        arg0.paused = arg2;
        let v0 = ConfigChanged{
            what   : b"paused",
            by_cap : 0x2::object::id<AdminCap>(arg1),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_pay_to(arg0: &mut Service, arg1: &AdminCap, arg2: address) {
        admin_check(arg0, arg1);
        arg0.pay_to = arg2;
        let v0 = ConfigChanged{
            what   : b"pay_to",
            by_cap : 0x2::object::id<AdminCap>(arg1),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_quote_key(arg0: &mut Service, arg1: &AdminCap, arg2: vector<u8>) {
        admin_check(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835114943643686);
        arg0.quote_key = arg2;
        let v0 = ConfigChanged{
            what   : b"quote_key",
            by_cap : 0x2::object::id<AdminCap>(arg1),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

