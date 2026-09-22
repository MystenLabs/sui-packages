module 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::claim {
    struct ClaimAllowlistMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct ClaimKey has copy, drop, store {
        owner: address,
        achievement_id: 0x1::string::String,
    }

    struct ClaimEntry has copy, drop, store {
        unlocked_at_ms: u64,
        claimed: bool,
    }

    struct ClaimAllowlist has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        entries: 0x2::table::Table<ClaimKey, ClaimEntry>,
    }

    fun assert_allowlist_for_registry(arg0: &ClaimAllowlist, arg1: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry) {
        assert!(arg0.registry_id == 0x2::object::id<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry>(arg1), 13835340384957497347);
    }

    public fun claim_achievement(arg0: &mut 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &mut ClaimAllowlist, arg2: 0x1::option::Option<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress {
        assert_allowlist_for_registry(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = ClaimKey{
            owner          : v0,
            achievement_id : arg3,
        };
        assert!(0x2::table::contains<ClaimKey, ClaimEntry>(&arg1.entries, v1), 13835621593646366725);
        let v2 = 0x2::table::borrow_mut<ClaimKey, ClaimEntry>(&mut arg1.entries, v1);
        assert!(!v2.claimed, 13835903081508110343);
        v2.claimed = true;
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::mint::mint_achievement_for(arg0, arg2, v0, arg3, v2.unlocked_at_ms, arg4)
    }

    public fun claim_allowlist_id(arg0: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry) : 0x2::object::ID {
        let v0 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0);
        let v1 = ClaimAllowlistMarker{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ClaimAllowlistMarker>(v0, v1), 13836184758348414985);
        let v2 = ClaimAllowlistMarker{dummy_field: false};
        *0x2::dynamic_field::borrow<ClaimAllowlistMarker, 0x2::object::ID>(v0, v2)
    }

    public fun create_claim_allowlist(arg0: &mut 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::assert_admin_cap(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), arg1);
        let v0 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid_mut(arg0);
        let v1 = ClaimAllowlistMarker{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ClaimAllowlistMarker>(v0, v1), 13835058368814776321);
        let v2 = ClaimAllowlist{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry>(arg0),
            entries     : 0x2::table::new<ClaimKey, ClaimEntry>(arg2),
        };
        let v3 = ClaimAllowlistMarker{dummy_field: false};
        0x2::dynamic_field::add<ClaimAllowlistMarker, 0x2::object::ID>(v0, v3, 0x2::object::id<ClaimAllowlist>(&v2));
        0x2::transfer::share_object<ClaimAllowlist>(v2);
    }

    public fun has_claim_allowlist(arg0: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry) : bool {
        let v0 = ClaimAllowlistMarker{dummy_field: false};
        0x2::dynamic_field::exists<ClaimAllowlistMarker>(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), v0)
    }

    public fun has_entry(arg0: &ClaimAllowlist, arg1: address, arg2: 0x1::string::String) : bool {
        let v0 = ClaimKey{
            owner          : arg1,
            achievement_id : arg2,
        };
        0x2::table::contains<ClaimKey, ClaimEntry>(&arg0.entries, v0)
    }

    public fun is_claimed(arg0: &ClaimAllowlist, arg1: address, arg2: 0x1::string::String) : bool {
        let v0 = ClaimKey{
            owner          : arg1,
            achievement_id : arg2,
        };
        !0x2::table::contains<ClaimKey, ClaimEntry>(&arg0.entries, v0) && false || 0x2::table::borrow<ClaimKey, ClaimEntry>(&arg0.entries, v0).claimed
    }

    public fun qualify_claim<T0>(arg0: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &mut ClaimAllowlist, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::PACKAGE, T0>, arg3: address, arg4: 0x1::string::String, arg5: u64) {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::assert_minter_cap<T0>(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), arg2);
        assert_allowlist_for_registry(arg1, arg0);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::assert_enabled(arg0, arg4);
        let v0 = ClaimKey{
            owner          : arg3,
            achievement_id : arg4,
        };
        if (0x2::table::contains<ClaimKey, ClaimEntry>(&arg1.entries, v0)) {
            return
        };
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::assert_not_unlocked(arg0, arg3, arg4);
        let v1 = ClaimEntry{
            unlocked_at_ms : arg5,
            claimed        : false,
        };
        0x2::table::add<ClaimKey, ClaimEntry>(&mut arg1.entries, v0, v1);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::events::emit_qualify_claim(arg3, arg4, arg5);
    }

    public fun registry_id(arg0: &ClaimAllowlist) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun unlocked_at_ms(arg0: &ClaimAllowlist, arg1: address, arg2: 0x1::string::String) : u64 {
        let v0 = ClaimKey{
            owner          : arg1,
            achievement_id : arg2,
        };
        0x2::table::borrow<ClaimKey, ClaimEntry>(&arg0.entries, v0).unlocked_at_ms
    }

    // decompiled from Move bytecode v7
}

