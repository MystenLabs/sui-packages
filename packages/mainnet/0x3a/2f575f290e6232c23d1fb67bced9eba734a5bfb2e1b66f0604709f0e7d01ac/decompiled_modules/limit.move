module 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::limit {
    struct Limits has store, key {
        id: 0x2::object::UID,
        special_user_limit: 0x2::vec_map::VecMap<address, SpecialUserLimit>,
    }

    struct SpecialUserLimit has drop, store {
        times: u64,
        is_limit: bool,
    }

    struct ModifyLimit has copy, drop {
        address: address,
        times: u64,
        is_limit: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Limits{
            id                 : 0x2::object::new(arg0),
            special_user_limit : 0x2::vec_map::empty<address, SpecialUserLimit>(),
        };
        0x2::transfer::public_share_object<Limits>(v0);
    }

    public(friend) fun modify(arg0: &mut Limits, arg1: address, arg2: u64, arg3: bool) {
        if (0x2::vec_map::contains<address, SpecialUserLimit>(&arg0.special_user_limit, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, SpecialUserLimit>(&mut arg0.special_user_limit, &arg1);
            v0.times = arg2;
            v0.is_limit = arg3;
        } else {
            let v1 = SpecialUserLimit{
                times    : arg2,
                is_limit : arg3,
            };
            0x2::vec_map::insert<address, SpecialUserLimit>(&mut arg0.special_user_limit, arg1, v1);
        };
        let v2 = ModifyLimit{
            address  : arg1,
            times    : arg2,
            is_limit : arg3,
        };
        0x2::event::emit<ModifyLimit>(v2);
    }

    public fun special_limit_remaining_claim_times(arg0: &Limits, arg1: &address, arg2: u64, arg3: u64) : u64 {
        if (0x2::vec_map::contains<address, SpecialUserLimit>(&arg0.special_user_limit, arg1)) {
            let v1 = 0x2::vec_map::get<address, SpecialUserLimit>(&arg0.special_user_limit, arg1);
            if (v1.is_limit) {
                if (v1.times > arg3) {
                    v1.times - arg3
                } else {
                    0
                }
            } else if (arg2 > arg3) {
                arg2 - arg3
            } else {
                0
            }
        } else if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        }
    }

    public fun special_user_limit(arg0: &Limits, arg1: address) : (u64, bool) {
        if (0x2::vec_map::contains<address, SpecialUserLimit>(&arg0.special_user_limit, &arg1)) {
            let v2 = 0x2::vec_map::get<address, SpecialUserLimit>(&arg0.special_user_limit, &arg1);
            (v2.times, v2.is_limit)
        } else {
            (0, false)
        }
    }

    public fun uid(arg0: &Limits) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v6
}

