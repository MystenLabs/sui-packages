module 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::mint {
    public fun add_xp<T0>(arg0: &0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::PACKAGE, T0>, arg2: &mut 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress, arg3: u64, arg4: address) {
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::assert_minter_cap<T0>(0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::borrow_uid(arg0), arg1);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::add_xp(arg2, arg3);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::events::emit_update_progress(arg4, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::xp(arg2), 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::level(arg2), 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::achievement_count(arg2));
    }

    public fun ensure_user_progress<T0>(arg0: &mut 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::PACKAGE, T0>, arg2: 0x1::option::Option<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress {
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::assert_minter_cap<T0>(0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::borrow_uid(arg0), arg1);
        if (0x1::option::is_some<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>(&arg2)) {
            0x1::option::destroy_some<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>(arg2)
        } else {
            0x1::option::destroy_none<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>(arg2);
            assert!(!0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::has_progress(arg0, arg3), 13835058420354383873);
            let v1 = 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::new(arg4);
            0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::record_progress_id(arg0, arg3, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::id(&v1));
            v1
        }
    }

    public fun mint_achievement<T0>(arg0: &mut 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::PACKAGE, T0>, arg2: 0x1::option::Option<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress {
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::assert_minter_cap<T0>(0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::borrow_uid(arg0), arg1);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::assert_enabled(arg0, arg4);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::assert_not_unlocked(arg0, arg3, arg4);
        let v0 = 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::borrow_definition(arg0, arg4);
        let v1 = 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::definition::points_reward_hint(v0);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::mark_unlocked(arg0, arg3, arg4);
        let v2 = if (0x1::option::is_some<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>(&arg2)) {
            0x1::option::destroy_some<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>(arg2)
        } else {
            0x1::option::destroy_none<0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress>(arg2);
            assert!(!0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::has_progress(arg0, arg3), 13835058274325495809);
            let v3 = 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::new(arg6);
            0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::record_progress_id(arg0, arg3, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::id(&v3));
            v3
        };
        let v4 = v2;
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::add_xp(&mut v4, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::definition::xp_reward(v0));
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::bump_achievement_count(&mut v4);
        if (v1 > 0) {
            0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::add_points_mirror(&mut v4, v1);
        };
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::events::emit_mint_achievement(arg3, arg4, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::instance::mint_to(arg3, arg4, arg5, arg6));
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::events::emit_update_progress(arg3, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::xp(&v4), 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::level(&v4), 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::achievement_count(&v4));
        v4
    }

    public fun transfer_progress(arg0: 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::UserProgress, arg1: address) {
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress::transfer_to(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

