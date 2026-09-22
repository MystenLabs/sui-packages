module 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::mint {
    public fun add_xp<T0>(arg0: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::PACKAGE, T0>, arg2: &mut 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress, arg3: u64, arg4: address) {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::assert_minter_cap<T0>(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), arg1);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::add_xp(arg2, arg3);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::events::emit_update_progress(arg4, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::xp(arg2), 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::level(arg2), 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::achievement_count(arg2));
    }

    public fun ensure_user_progress<T0>(arg0: &mut 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::PACKAGE, T0>, arg2: 0x1::option::Option<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::assert_minter_cap<T0>(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), arg1);
        if (0x1::option::is_some<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(&arg2)) {
            0x1::option::destroy_some<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(arg2)
        } else {
            0x1::option::destroy_none<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(arg2);
            assert!(!0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::has_progress(arg0, arg3), 13835058562088304641);
            let v1 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::new(arg4);
            0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::record_progress_id(arg0, arg3, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::id(&v1));
            v1
        }
    }

    public fun mint_achievement<T0>(arg0: &mut 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::PACKAGE, T0>, arg2: 0x1::option::Option<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::assert_minter_cap<T0>(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), arg1);
        mint_achievement_for(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun mint_achievement_for(arg0: &mut 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: 0x1::option::Option<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::assert_enabled(arg0, arg3);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::assert_not_unlocked(arg0, arg2, arg3);
        let v0 = if (0x1::option::is_some<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(&arg1)) {
            let v1 = 0x1::option::destroy_some<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(arg1);
            assert!(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::has_progress(arg0, arg2) && 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::id(&v1) == 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::progress_id(arg0, arg2), 13835339813726846979);
            v1
        } else {
            0x1::option::destroy_none<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(arg1);
            assert!(!0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::has_progress(arg0, arg2), 13835058360224841729);
            let v2 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::new(arg5);
            0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::record_progress_id(arg0, arg2, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::id(&v2));
            v2
        };
        let v3 = v0;
        let v4 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_definition(arg0, arg3);
        let v5 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::definition::points_reward_hint(v4);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::mark_unlocked(arg0, arg2, arg3);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::add_xp(&mut v3, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::definition::xp_reward(v4));
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::bump_achievement_count(&mut v3);
        if (v5 > 0) {
            0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::add_points_mirror(&mut v3, v5);
        };
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::events::emit_mint_achievement(arg2, arg3, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::mint_to(arg2, arg3, arg4, arg5));
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::events::emit_update_progress(arg2, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::xp(&v3), 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::level(&v3), 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::achievement_count(&v3));
        v3
    }

    public fun transfer_progress(arg0: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress, arg2: address) {
        assert!(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::has_progress(arg0, arg2) && 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::id(&arg1) == 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::progress_id(arg0, arg2), 13835340200273903619);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::transfer_to(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

