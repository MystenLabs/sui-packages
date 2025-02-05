module 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat {
    struct UserStatistics has store {
        inner: 0x2::table::Table<address, UserStatistic>,
    }

    struct UserStatistic has store, key {
        id: 0x2::object::UID,
        posts_count: u64,
        upvotes_received: u64,
        comments_count: u64,
        referrals: u64,
    }

    public fun new(arg0: &0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : UserStatistics {
        UserStatistics{inner: 0x2::table::new<address, UserStatistic>(arg1)}
    }

    public(friend) fun comments(arg0: &UserStatistic) : u64 {
        arg0.comments_count
    }

    fun get_or_create_user_stat(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &UserStatistic {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::StatV2, UserStatistics>(arg0);
        if (!0x2::table::contains<address, UserStatistic>(&v0.inner, arg1)) {
            let v1 = UserStatistic{
                id               : 0x2::object::new(arg2),
                posts_count      : 0,
                upvotes_received : 0,
                comments_count   : 0,
                referrals        : 0,
            };
            0x2::table::add<address, UserStatistic>(&mut v0.inner, arg1, v1);
        };
        0x2::table::borrow<address, UserStatistic>(&v0.inner, arg1)
    }

    fun get_or_create_user_stat_mut(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut UserStatistic {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::StatV2, UserStatistics>(arg0);
        if (!0x2::table::contains<address, UserStatistic>(&v0.inner, arg1)) {
            let v1 = UserStatistic{
                id               : 0x2::object::new(arg2),
                posts_count      : 0,
                upvotes_received : 0,
                comments_count   : 0,
                referrals        : 0,
            };
            0x2::table::add<address, UserStatistic>(&mut v0.inner, arg1, v1);
        };
        0x2::table::borrow_mut<address, UserStatistic>(&mut v0.inner, arg1)
    }

    public(friend) fun posts(arg0: &UserStatistic) : u64 {
        arg0.posts_count
    }

    public(friend) fun record_comment(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stat_mut(arg0, arg1, arg2);
        v0.comments_count = v0.comments_count + 1;
    }

    public(friend) fun record_post(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stat_mut(arg0, arg1, arg2);
        v0.posts_count = v0.posts_count + 1;
    }

    public(friend) fun record_referrals(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stat_mut(arg0, arg1, arg2);
        v0.referrals = v0.referrals + 1;
    }

    public(friend) fun record_removed_comment(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stat_mut(arg0, arg1, arg2);
        v0.comments_count = safe_subtraction(v0.comments_count, 1);
    }

    public(friend) fun record_removed_post(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stat_mut(arg0, arg1, arg3);
        v0.posts_count = safe_subtraction(v0.posts_count, 1);
        v0.upvotes_received = safe_subtraction(v0.upvotes_received, arg2);
    }

    public(friend) fun record_upvote(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stat_mut(arg0, arg1, arg2);
        v0.upvotes_received = v0.upvotes_received + 1;
    }

    public(friend) fun referrals(arg0: &UserStatistic) : u64 {
        arg0.referrals
    }

    fun safe_subtraction(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun upvotes(arg0: &UserStatistic) : u64 {
        arg0.upvotes_received
    }

    public fun user_stat(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &UserStatistic {
        get_or_create_user_stat(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

