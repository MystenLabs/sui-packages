module 0xe0f7dbe60a54b6dd26201bdc7f14f52eaa64056c39ba9671df5d6e7eac40beba::skill_tthm {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InstructorCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        categoria: 0x1::string::String,
        grupo: u8,
    }

    struct OperatorProfile has store, key {
        id: 0x2::object::UID,
        owner: address,
        nombre_hash: 0x1::string::String,
        rut_hash: u8,
        cargo_actual: 0x1::string::String,
        area: u8,
        grupo: u8,
    }

    struct SkillBadge has store, key {
        id: 0x2::object::UID,
        skill: 0x1::string::String,
        level: u64,
        evidence_hash: 0x2::vec_map::VecMap<u8, 0x1::string::String>,
        issuer: address,
        operator: address,
        area: u8,
        stage: u8,
        transferable: bool,
        issued_at_epoch: u64,
    }

    struct InstructorRegistered has copy, drop {
        instructor: address,
        categoria: 0x1::string::String,
        grupo: u8,
    }

    struct OperatorRegistered has copy, drop {
        operator: address,
        area: u8,
        grupo: u8,
    }

    struct BadgeMinted has copy, drop {
        badge_id: 0x2::object::ID,
        operator: address,
        instructor: address,
        skill: 0x1::string::String,
        level: u64,
        area: u8,
        stage: u8,
    }

    struct BadgeRevoked has copy, drop {
        badge_id: 0x2::object::ID,
        by: address,
    }

    struct EvaluationRecorded has store, key {
        id: 0x2::object::UID,
        operator: address,
        instructor: address,
        skill: 0x1::string::String,
        evaluation: u8,
        result: u8,
        notes: 0x1::string::String,
    }

    struct GapClosed has store, key {
        id: 0x2::object::UID,
        operator: address,
        instructor: address,
        skill: 0x1::string::String,
        notes: 0x1::string::String,
    }

    struct InstructorFeedback has store, key {
        id: 0x2::object::UID,
        operator: address,
        instructor: address,
        rating: u8,
        notes: 0x1::string::String,
    }

    public fun before_transfer(arg0: &SkillBadge, arg1: &mut 0x2::tx_context::TxContext) {
        if (!arg0.transferable) {
            abort 1
        };
    }

    public fun close_gap(arg0: &InstructorCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GapClosed{
            id         : 0x2::object::new(arg4),
            operator   : arg1,
            instructor : arg0.owner,
            skill      : arg2,
            notes      : arg3,
        };
        0x2::transfer::transfer<GapClosed>(v0, arg1);
    }

    public fun create_adminCap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_badge_by_instructor(arg0: &InstructorCap, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::vec_map::VecMap<u8, 0x1::string::String>, arg5: u8, arg6: u8, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = SkillBadge{
            id              : 0x2::object::new(arg9),
            skill           : arg2,
            level           : arg3,
            evidence_hash   : arg4,
            issuer          : arg0.owner,
            operator        : arg1,
            area            : arg5,
            stage           : arg6,
            transferable    : arg7,
            issued_at_epoch : arg8,
        };
        0x2::transfer::transfer<SkillBadge>(v0, arg1);
    }

    public entry fun rate_instructor(arg0: &OperatorProfile, arg1: address, arg2: u8, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = InstructorFeedback{
            id         : 0x2::object::new(arg4),
            operator   : arg0.owner,
            instructor : arg1,
            rating     : arg2,
            notes      : arg3,
        };
        0x2::transfer::transfer<InstructorFeedback>(v0, arg1);
    }

    public fun record_evaluation(arg0: &InstructorCap, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = EvaluationRecorded{
            id         : 0x2::object::new(arg6),
            operator   : arg1,
            instructor : arg0.owner,
            skill      : arg2,
            evaluation : arg3,
            result     : arg4,
            notes      : arg5,
        };
        0x2::transfer::transfer<EvaluationRecorded>(v0, arg1);
    }

    public fun register_instructor(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = InstructorCap{
            id        : 0x2::object::new(arg4),
            owner     : arg1,
            categoria : arg2,
            grupo     : arg3,
        };
        0x2::transfer::transfer<InstructorCap>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun register_operator(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorProfile{
            id           : 0x2::object::new(arg7),
            owner        : arg1,
            nombre_hash  : arg2,
            rut_hash     : arg3,
            cargo_actual : arg4,
            area         : arg5,
            grupo        : arg6,
        };
        0x2::transfer::transfer<OperatorProfile>(v0, arg1);
    }

    public fun revoke_badge(arg0: &InstructorCap, arg1: SkillBadge, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::object::id<SkillBadge>(&arg1);
        let SkillBadge {
            id              : v0,
            skill           : _,
            level           : _,
            evidence_hash   : _,
            issuer          : _,
            operator        : _,
            area            : _,
            stage           : _,
            transferable    : _,
            issued_at_epoch : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

