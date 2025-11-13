module 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::upgrade_leverage {
    struct LeverageUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun authorize_leverage_upgrade(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<LeverageUpgradeWish>(&v0, arg1), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        let LeverageUpgradeWish {
            policy : v1,
            digest : v2,
        } = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<LeverageUpgradeWish>(v0);
        0x2::package::authorize_upgrade(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::leverage_package_upgrade_cap(arg0), v1, v2)
    }

    public fun commit_leverage_upgrade(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::leverage_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_leverage_upgrade(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = LeverageUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<LeverageUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<LeverageUpgradeWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<LeverageUpgradeWish>(v0, arg3, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

