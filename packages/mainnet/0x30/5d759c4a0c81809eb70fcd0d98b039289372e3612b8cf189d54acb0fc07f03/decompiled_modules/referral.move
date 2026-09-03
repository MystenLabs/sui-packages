module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral {
    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        bindings: 0x2::table::Table<address, address>,
        counts: 0x2::table::Table<address, u64>,
        total_bound: u64,
    }

    public fun bind(arg0: &mut ReferralRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 != v0, 0);
        resolve_and_bind(arg0, v0, 0x1::option::some<address>(arg1), arg2);
    }

    public fun has_referrer(arg0: &ReferralRegistry, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.bindings, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRegistry{
            id          : 0x2::object::new(arg0),
            bindings    : 0x2::table::new<address, address>(arg0),
            counts      : 0x2::table::new<address, u64>(arg0),
            total_bound : 0,
        };
        0x2::transfer::share_object<ReferralRegistry>(v0);
    }

    public fun referral_count(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.counts, arg1)
        } else {
            0
        }
    }

    public fun referrer_of(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.bindings, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.bindings, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun resolve_and_bind(arg0: &mut ReferralRegistry, arg1: address, arg2: 0x1::option::Option<address>, arg3: &0x2::clock::Clock) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.bindings, arg1)) {
            return 0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.bindings, arg1))
        };
        if (0x1::option::is_none<address>(&arg2)) {
            return 0x1::option::none<address>()
        };
        let v0 = *0x1::option::borrow<address>(&arg2);
        if (v0 == arg1 || v0 == @0x0) {
            return 0x1::option::none<address>()
        };
        0x2::table::add<address, address>(&mut arg0.bindings, arg1, v0);
        if (0x2::table::contains<address, u64>(&arg0.counts, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.counts, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.counts, v0, 1);
        };
        arg0.total_bound = arg0.total_bound + 1;
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::referral_bound(arg1, v0, 0x2::clock::timestamp_ms(arg3));
        0x1::option::some<address>(v0)
    }

    public fun total_bound(arg0: &ReferralRegistry) : u64 {
        arg0.total_bound
    }

    // decompiled from Move bytecode v7
}

