module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills {
    struct SkillSlot has copy, drop, store {
        blob_object_id: 0x2::object::ID,
        is_public: bool,
        deleted: bool,
        created_at_ms: u64,
    }

    struct SoulSkills has key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        skills: 0x2::table::Table<0x1::string::String, vector<SkillSlot>>,
        skill_count: u64,
    }

    struct SkillBlobKey has copy, drop, store {
        skill_name: 0x1::string::String,
        version_index: u64,
    }

    struct SoulSkillsCreated has copy, drop {
        skills_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct SkillVersionAppended has copy, drop {
        skills_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        skill_name: 0x1::string::String,
        version_index: u64,
        is_public: bool,
        created_at_ms: u64,
        blob_object_id: 0x2::object::ID,
    }

    struct SkillVersionDeleted has copy, drop {
        skills_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        skill_name: 0x1::string::String,
        version_index: u64,
        deleted_by: address,
    }

    public(friend) fun append_initial_version(arg0: &mut SoulSkills, arg1: 0x1::string::String, arg2: bool, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        append_version_impl(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun append_version_as_granted_agent(arg0: &mut SoulSkills, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg3: 0x1::string::String, arg4: bool, arg5: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_skills_matches_state(arg0, arg1);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg2, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_skills(), arg6, arg7);
        append_version_impl(arg0, arg3, arg4, arg5, arg6, arg7)
    }

    public fun append_version_as_owner(arg0: &mut SoulSkills, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: bool, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg6));
        assert_skills_matches_state(arg0, arg1);
        append_version_impl(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    fun append_version_impl(arg0: &mut SoulSkills, arg1: 0x1::string::String, arg2: bool, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::string::is_empty(&arg1), 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::object_id(&arg3);
        let v2 = SkillSlot{
            blob_object_id : v1,
            is_public      : arg2,
            deleted        : false,
            created_at_ms  : v0,
        };
        let v3 = if (0x2::table::contains<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1)) {
            let v4 = 0x2::table::borrow_mut<0x1::string::String, vector<SkillSlot>>(&mut arg0.skills, arg1);
            0x1::vector::push_back<SkillSlot>(v4, v2);
            0x1::vector::length<SkillSlot>(v4)
        } else {
            let v5 = 0x1::vector::empty<SkillSlot>();
            0x1::vector::push_back<SkillSlot>(&mut v5, v2);
            0x2::table::add<0x1::string::String, vector<SkillSlot>>(&mut arg0.skills, arg1, v5);
            arg0.skill_count = arg0.skill_count + 1;
            0
        };
        let v6 = SkillBlobKey{
            skill_name    : arg1,
            version_index : v3,
        };
        0x2::dynamic_object_field::add<SkillBlobKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.id, v6, arg3);
        let v7 = SkillVersionAppended{
            skills_id      : 0x2::object::id<SoulSkills>(arg0),
            soul_id        : arg0.soul_id,
            skill_name     : arg1,
            version_index  : v3,
            is_public      : arg2,
            created_at_ms  : v0,
            blob_object_id : v1,
        };
        0x2::event::emit<SkillVersionAppended>(v7);
        v3
    }

    fun assert_matching_document_id(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) {
        let v0 = b"soul-skill:";
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0x2::object::id_to_bytes(&arg1);
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = 0x1::string::as_bytes(&arg2);
        let v5 = 0x1::vector::length<u8>(v4);
        assert!(0x1::vector::length<u8>(&arg0) == v1 + 1 + v3 + v5 + 1 + 8 + 16, 0);
        let v6 = 0;
        while (v6 < v1) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v6) == *0x1::vector::borrow<u8>(&v0, v6), 1);
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v1) == 1, 1);
        let v7 = v1 + 1;
        v6 = 0;
        while (v6 < v3) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v7 + v6) == *0x1::vector::borrow<u8>(&v2, v6), 1);
            v6 = v6 + 1;
        };
        let v8 = v7 + v3;
        v6 = 0;
        while (v6 < v5) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v8 + v6) == *0x1::vector::borrow<u8>(v4, v6), 1);
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v8 + v5) == 0, 1);
        assert_u64_segment(&arg0, v8 + v5 + 1, arg3);
    }

    fun assert_skills_matches_state(arg0: &SoulSkills, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState) {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 2);
    }

    fun assert_u64_segment(arg0: &vector<u8>, arg1: u64, arg2: u64) {
        let v0 = 56;
        let v1 = 0;
        while (v1 < 8) {
            assert!(*0x1::vector::borrow<u8>(arg0, arg1 + v1) == ((arg2 >> v0 & 255) as u8), 1);
            let v2 = if (v0 >= 8) {
                v0 - 8
            } else {
                0
            };
            v0 = v2;
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_valid_skill_seal_request(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &SoulSkills, arg3: 0x1::string::String, arg4: u64) {
        assert_matching_document_id(arg0, 0x2::object::id<SoulSkills>(arg2), arg3, arg4);
        assert_skills_matches_state(arg2, arg1);
        assert!(!borrow_slot(arg2, arg3, arg4).deleted, 4);
    }

    public fun blob_object_id_for(arg0: &SoulSkills, arg1: 0x1::string::String, arg2: u64) : 0x2::object::ID {
        borrow_slot(arg0, arg1, arg2).blob_object_id
    }

    fun borrow_slot(arg0: &SoulSkills, arg1: 0x1::string::String, arg2: u64) : &SkillSlot {
        assert!(0x2::table::contains<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1), 3);
        let v0 = 0x2::table::borrow<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1);
        assert!(arg2 < 0x1::vector::length<SkillSlot>(v0), 3);
        0x1::vector::borrow<SkillSlot>(v0, arg2)
    }

    fun borrow_slot_mut(arg0: &mut SoulSkills, arg1: 0x1::string::String, arg2: u64) : &mut SkillSlot {
        assert!(0x2::table::contains<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<SkillSlot>>(&mut arg0.skills, arg1);
        assert!(arg2 < 0x1::vector::length<SkillSlot>(v0), 3);
        0x1::vector::borrow_mut<SkillSlot>(v0, arg2)
    }

    public fun contains_skill(arg0: &SoulSkills, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1)
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : SoulSkills {
        let v0 = SoulSkills{
            id          : 0x2::object::new(arg1),
            soul_id     : arg0,
            skills      : 0x2::table::new<0x1::string::String, vector<SkillSlot>>(arg1),
            skill_count : 0,
        };
        let v1 = SoulSkillsCreated{
            skills_id : 0x2::object::id<SoulSkills>(&v0),
            soul_id   : arg0,
        };
        0x2::event::emit<SoulSkillsCreated>(v1);
        v0
    }

    public fun delete_version_as_granted_agent(arg0: &mut SoulSkills, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: u64, arg4: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_skills_matches_state(arg0, arg1);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg4, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_skills(), arg5, arg6);
        let v0 = borrow_slot_mut(arg0, arg2, arg3);
        assert!(!v0.deleted, 4);
        v0.deleted = true;
        let v1 = SkillVersionDeleted{
            skills_id     : 0x2::object::id<SoulSkills>(arg0),
            soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1),
            skill_name    : arg2,
            version_index : arg3,
            deleted_by    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SkillVersionDeleted>(v1);
    }

    public fun delete_version_as_owner(arg0: &mut SoulSkills, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg4));
        assert_skills_matches_state(arg0, arg1);
        let v0 = borrow_slot_mut(arg0, arg2, arg3);
        assert!(!v0.deleted, 4);
        v0.deleted = true;
        let v1 = SkillVersionDeleted{
            skills_id     : 0x2::object::id<SoulSkills>(arg0),
            soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1),
            skill_name    : arg2,
            version_index : arg3,
            deleted_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SkillVersionDeleted>(v1);
    }

    entry fun seal_approve_private_read_granted_agent(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &SoulSkills, arg3: 0x1::string::String, arg4: u64, arg5: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_matching_document_id(arg0, 0x2::object::id<SoulSkills>(arg2), arg3, arg4);
        assert_skills_matches_state(arg2, arg1);
        assert!(!borrow_slot(arg2, arg3, arg4).deleted, 4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg5, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_skills(), arg6, arg7);
    }

    entry fun seal_approve_private_read_owner(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &SoulSkills, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_matching_document_id(arg0, 0x2::object::id<SoulSkills>(arg2), arg3, arg4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg5));
        assert_skills_matches_state(arg2, arg1);
        assert!(!borrow_slot(arg2, arg3, arg4).deleted, 4);
    }

    public(friend) fun share_skills(arg0: SoulSkills) {
        0x2::transfer::share_object<SoulSkills>(arg0);
    }

    public fun skill_count(arg0: &SoulSkills) : u64 {
        arg0.skill_count
    }

    public fun skills_id(arg0: &SoulSkills) : 0x2::object::ID {
        0x2::object::id<SoulSkills>(arg0)
    }

    public fun soul_id(arg0: &SoulSkills) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun version_count(arg0: &SoulSkills, arg1: 0x1::string::String) : u64 {
        if (!0x2::table::contains<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1)) {
            return 0
        };
        0x1::vector::length<SkillSlot>(0x2::table::borrow<0x1::string::String, vector<SkillSlot>>(&arg0.skills, arg1))
    }

    public fun version_created_at_ms(arg0: &SoulSkills, arg1: 0x1::string::String, arg2: u64) : u64 {
        borrow_slot(arg0, arg1, arg2).created_at_ms
    }

    public fun version_is_deleted(arg0: &SoulSkills, arg1: 0x1::string::String, arg2: u64) : bool {
        borrow_slot(arg0, arg1, arg2).deleted
    }

    public fun version_is_public(arg0: &SoulSkills, arg1: 0x1::string::String, arg2: u64) : bool {
        borrow_slot(arg0, arg1, arg2).is_public
    }

    // decompiled from Move bytecode v7
}

