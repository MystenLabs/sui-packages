module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager {
    struct SetReferrer<phantom T0> has copy, drop {
        referrer: address,
        referee: address,
        is_from_open: bool,
    }

    struct ReferralManager has key {
        id: 0x2::object::UID,
        referrer_map: 0x2::table::Table<address, address>,
        referral_scores: 0x2::table::Table<address, u64>,
    }

    public fun get_referral_score(arg0: &ReferralManager, arg1: address) : u64 {
        let v0 = &arg0.referral_scores;
        if (0x2::table::contains<address, u64>(v0, arg1)) {
            *0x2::table::borrow<address, u64>(v0, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralManager{
            id              : 0x2::object::new(arg0),
            referrer_map    : 0x2::table::new<address, address>(arg0),
            referral_scores : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ReferralManager>(v0);
    }

    public(friend) fun set_referrer<T0>(arg0: &mut ReferralManager, arg1: address, arg2: address, arg3: bool) {
        if (arg1 == arg2) {
            return
        };
        let v0 = &mut arg0.referrer_map;
        if (0x2::table::contains<address, address>(v0, arg1)) {
            return
        };
        0x2::table::add<address, address>(v0, arg1, arg2);
        let v1 = &mut arg0.referral_scores;
        if (!0x2::table::contains<address, u64>(v1, arg2)) {
            0x2::table::add<address, u64>(v1, arg2, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(v1, arg2);
        *v2 = *v2 + 1;
        let v3 = SetReferrer<T0>{
            referrer     : arg2,
            referee      : arg1,
            is_from_open : arg3,
        };
        0x2::event::emit<SetReferrer<T0>>(v3);
    }

    public fun try_get_referrer(arg0: &ReferralManager, arg1: address) : 0x1::option::Option<address> {
        let v0 = &arg0.referrer_map;
        if (0x2::table::contains<address, address>(v0, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(v0, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    // decompiled from Move bytecode v6
}

