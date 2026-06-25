module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::mm_registry {
    struct MMEntry has copy, drop, store {
        mm_address: address,
        permitted_markets: vector<vector<u8>>,
        max_notional_per_order: u64,
        registered_at: u64,
        expires_at: u64,
    }

    struct MMRegistry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<address, MMEntry>,
        mm_count: u64,
    }

    struct MMRegistered has copy, drop {
        mm_address: address,
        permitted_markets: vector<vector<u8>>,
        max_notional_per_order: u64,
        expires_at: u64,
    }

    struct MMRemoved has copy, drop {
        mm_address: address,
    }

    struct MMUpdated has copy, drop {
        mm_address: address,
        permitted_markets: vector<vector<u8>>,
        max_notional_per_order: u64,
        expires_at: u64,
    }

    struct MMRenewed has copy, drop {
        mm_address: address,
        old_expires_at: u64,
        new_expires_at: u64,
    }

    public fun assert_authorized_for_market(arg0: &MMRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert_whitelisted(arg0, arg1, arg3);
        assert!(vector_contains(&0x2::table::borrow<address, MMEntry>(&arg0.entries, arg1).permitted_markets, &arg2), 3);
    }

    public fun assert_whitelisted(arg0: &MMRegistry, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, MMEntry>(&arg0.entries, arg1), 1);
        assert!(0x2::clock::timestamp_ms(arg2) < 0x2::table::borrow<address, MMEntry>(&arg0.entries, arg1).expires_at, 2);
    }

    public fun assert_within_notional_limit(arg0: &MMRegistry, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, MMEntry>(&arg0.entries, arg1), 1);
        assert!(arg2 <= 0x2::table::borrow<address, MMEntry>(&arg0.entries, arg1).max_notional_per_order, 7);
    }

    public fun borrow_mm(arg0: &MMRegistry, arg1: address) : &MMEntry {
        assert!(0x2::table::contains<address, MMEntry>(&arg0.entries, arg1), 1);
        0x2::table::borrow<address, MMEntry>(&arg0.entries, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MMRegistry{
            id       : 0x2::object::new(arg0),
            entries  : 0x2::table::new<address, MMEntry>(arg0),
            mm_count : 0,
        };
        0x2::transfer::share_object<MMRegistry>(v0);
    }

    public fun is_authorized_for_market(arg0: &MMRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) : bool {
        if (!is_whitelisted(arg0, arg1, arg3)) {
            return false
        };
        vector_contains(&0x2::table::borrow<address, MMEntry>(&arg0.entries, arg1).permitted_markets, &arg2)
    }

    public fun is_registered(arg0: &MMRegistry, arg1: address) : bool {
        0x2::table::contains<address, MMEntry>(&arg0.entries, arg1)
    }

    public fun is_whitelisted(arg0: &MMRegistry, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, MMEntry>(&arg0.entries, arg1)) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) < 0x2::table::borrow<address, MMEntry>(&arg0.entries, arg1).expires_at
    }

    public fun mm_count(arg0: &MMRegistry) : u64 {
        arg0.mm_count
    }

    public fun mm_entry_address(arg0: &MMEntry) : address {
        arg0.mm_address
    }

    public fun mm_entry_expires_at(arg0: &MMEntry) : u64 {
        arg0.expires_at
    }

    public fun mm_entry_max_notional_per_order(arg0: &MMEntry) : u64 {
        arg0.max_notional_per_order
    }

    public fun mm_entry_permitted_markets(arg0: &MMEntry) : vector<vector<u8>> {
        arg0.permitted_markets
    }

    public fun mm_entry_registered_at(arg0: &MMEntry) : u64 {
        arg0.registered_at
    }

    public fun register_mm(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MMRegistry, arg2: address, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<address, MMEntry>(&arg1.entries, arg2), 0);
        assert!(arg4 > 0, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg3) > 0, 6);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6), 5);
        let v0 = MMEntry{
            mm_address             : arg2,
            permitted_markets      : arg3,
            max_notional_per_order : arg4,
            registered_at          : 0x2::clock::timestamp_ms(arg6),
            expires_at             : arg5,
        };
        0x2::table::add<address, MMEntry>(&mut arg1.entries, arg2, v0);
        arg1.mm_count = arg1.mm_count + 1;
        let v1 = MMRegistered{
            mm_address             : arg2,
            permitted_markets      : arg3,
            max_notional_per_order : arg4,
            expires_at             : arg5,
        };
        0x2::event::emit<MMRegistered>(v1);
    }

    public fun remove_mm(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MMRegistry, arg2: address) {
        assert!(0x2::table::contains<address, MMEntry>(&arg1.entries, arg2), 1);
        0x2::table::remove<address, MMEntry>(&mut arg1.entries, arg2);
        arg1.mm_count = arg1.mm_count - 1;
        let v0 = MMRemoved{mm_address: arg2};
        0x2::event::emit<MMRemoved>(v0);
    }

    public fun renew_mm(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MMRegistry, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, MMEntry>(&arg1.entries, arg2), 1);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 5);
        let v0 = 0x2::table::borrow_mut<address, MMEntry>(&mut arg1.entries, arg2);
        v0.expires_at = arg3;
        let v1 = MMRenewed{
            mm_address     : arg2,
            old_expires_at : v0.expires_at,
            new_expires_at : arg3,
        };
        0x2::event::emit<MMRenewed>(v1);
    }

    public fun update_mm(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MMRegistry, arg2: address, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, MMEntry>(&arg1.entries, arg2), 1);
        assert!(arg4 > 0, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg3) > 0, 6);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6), 5);
        let v0 = 0x2::table::borrow_mut<address, MMEntry>(&mut arg1.entries, arg2);
        v0.permitted_markets = arg3;
        v0.max_notional_per_order = arg4;
        v0.expires_at = arg5;
        let v1 = MMUpdated{
            mm_address             : arg2,
            permitted_markets      : arg3,
            max_notional_per_order : arg4,
            expires_at             : arg5,
        };
        0x2::event::emit<MMUpdated>(v1);
    }

    fun vector_contains(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (0x1::vector::borrow<vector<u8>>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v7
}

