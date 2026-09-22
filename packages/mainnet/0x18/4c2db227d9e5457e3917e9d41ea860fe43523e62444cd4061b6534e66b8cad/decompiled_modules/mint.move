module 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::mint {
    public fun add_xp<T0>(arg0: &0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, T0>, arg2: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress, arg3: u64, arg4: address) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_minter_cap<T0>(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::add_xp(arg2, arg3);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::events::emit_update_progress(arg4, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::xp(arg2), 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::level(arg2), 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::achievement_count(arg2));
    }

    public fun ensure_user_progress<T0>(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, T0>, arg2: 0x1::option::Option<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_minter_cap<T0>(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        if (0x1::option::is_some<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>(&arg2)) {
            0x1::option::destroy_some<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>(arg2)
        } else {
            0x1::option::destroy_none<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>(arg2);
            assert!(!0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::has_progress(arg0, arg3), 13835058506253729793);
            let v1 = 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::new(arg4);
            0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::record_progress_id(arg0, arg3, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::id(&v1));
            v1
        }
    }

    public fun mint_achievement<T0>(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, T0>, arg2: 0x1::option::Option<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_minter_cap<T0>(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        mint_achievement_for(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun mint_achievement_for(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: 0x1::option::Option<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::assert_enabled(arg0, arg3);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::assert_not_unlocked(arg0, arg2, arg3);
        let v0 = 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_definition(arg0, arg3);
        let v1 = 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::points_reward_hint(v0);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::mark_unlocked(arg0, arg2, arg3);
        let v2 = if (0x1::option::is_some<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>(&arg1)) {
            0x1::option::destroy_some<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>(arg1)
        } else {
            0x1::option::destroy_none<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress>(arg1);
            assert!(!0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::has_progress(arg0, arg2), 13835058360224841729);
            let v3 = 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::new(arg5);
            0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::record_progress_id(arg0, arg2, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::id(&v3));
            v3
        };
        let v4 = v2;
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::add_xp(&mut v4, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::xp_reward(v0));
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::bump_achievement_count(&mut v4);
        if (v1 > 0) {
            0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::add_points_mirror(&mut v4, v1);
        };
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::events::emit_mint_achievement(arg2, arg3, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::instance::mint_to(arg2, arg3, arg4, arg5));
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::events::emit_update_progress(arg2, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::xp(&v4), 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::level(&v4), 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::achievement_count(&v4));
        v4
    }

    public fun transfer_progress(arg0: 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::UserProgress, arg1: address) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::progress::transfer_to(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

