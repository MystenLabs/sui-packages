module 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::slash_manager {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SlashEvidence has copy, drop, store {
        batch_id: u64,
        solution_id: vector<u8>,
        solver_address: address,
        severity: u8,
        reason_code: u8,
        reason_message: vector<u8>,
        failure_context: vector<u8>,
        attestation: vector<u8>,
        attestation_timestamp: u64,
        tee_measurement: vector<u8>,
    }

    struct SlashRecord has store, key {
        id: 0x2::object::UID,
        solver_address: address,
        batch_id: u64,
        solution_id: vector<u8>,
        severity: u8,
        reason: vector<u8>,
        slash_percentage_bps: u64,
        created_at: u64,
        appealed: bool,
        appeal_approved: bool,
    }

    struct Appeal has store, key {
        id: 0x2::object::UID,
        slash_id: 0x2::object::ID,
        solver_address: address,
        reason: vector<u8>,
        counter_evidence: vector<u8>,
        created_at: u64,
        status: u8,
    }

    struct SlashManager has key {
        id: 0x2::object::UID,
        solver_slashes: 0x2::table::Table<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>,
        appeals: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        total_slashes: u64,
        total_warnings_issued: u64,
        admin: address,
    }

    struct SlashIndex has copy, drop, store {
        severity: u8,
        created_at: u64,
        appealed: bool,
        appeal_approved: bool,
    }

    struct SLASH_MANAGER has drop {
        dummy_field: bool,
    }

    struct SlashCreated has copy, drop {
        slash_id: 0x2::object::ID,
        solver_address: address,
        batch_id: u64,
        solution_id: vector<u8>,
        severity: u8,
        reason: vector<u8>,
        slash_percentage_bps: u64,
        timestamp: u64,
    }

    struct AppealFiled has copy, drop {
        slash_id: 0x2::object::ID,
        appeal_id: 0x2::object::ID,
        solver_address: address,
        timestamp: u64,
    }

    struct AppealResolved has copy, drop {
        slash_id: 0x2::object::ID,
        appeal_id: 0x2::object::ID,
        solver_address: address,
        approved: bool,
        resolution_timestamp: u64,
    }

    struct WarningIssued has copy, drop {
        solver_address: address,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct SlashRecordLock has drop {
        dummy_field: bool,
    }

    fun calculate_slash_percentage(arg0: u8) : u64 {
        if (arg0 == 1) {
            500
        } else if (arg0 == 2) {
            2000
        } else {
            10000
        }
    }

    public fun calculate_total_slash_percentage(arg0: &SlashManager, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<0x2::object::ID, u8>(v0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&v2, v3);
            if (!is_slash_appealed_and_approved(arg0, v4)) {
                v1 = v1 + calculate_slash_percentage(*0x2::vec_map::get<0x2::object::ID, u8>(v0, &v4));
            };
            v3 = v3 + 1;
        };
        if (v1 > 10000) {
            10000
        } else {
            v1
        }
    }

    public fun file_appeal(arg0: &mut SlashManager, arg1: &mut SlashRecord, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg1.solver_address, 6001);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 < arg1.created_at + 86400000, 6006);
        assert!(!arg1.appealed, 6004);
        arg1.appealed = true;
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&arg1.id);
        let v4 = 0x2::object::uid_to_inner(&v2);
        let v5 = Appeal{
            id               : v2,
            slash_id         : v3,
            solver_address   : v0,
            reason           : arg2,
            counter_evidence : arg3,
            created_at       : v1,
            status           : 0,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.appeals, v3, v4);
        update_slash_index(arg0, v0, v3, arg1.severity, true, false);
        0x2::transfer::share_object<Appeal>(v5);
        let v6 = AppealFiled{
            slash_id       : v3,
            appeal_id      : v4,
            solver_address : v0,
            timestamp      : v1,
        };
        0x2::event::emit<AppealFiled>(v6);
    }

    public fun get_solver_slashes(arg0: &SlashManager, arg1: address) : 0x2::vec_map::VecMap<0x2::object::ID, u8> {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1)) {
            return 0x2::vec_map::empty<0x2::object::ID, u8>()
        };
        *0x2::table::borrow<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1)
    }

    public fun has_active_slashes(arg0: &SlashManager, arg1: address) : bool {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1)) {
            return false
        };
        !0x2::vec_map::is_empty<0x2::object::ID, u8>(0x2::table::borrow<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1))
    }

    fun init(arg0: SLASH_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = SlashManager{
            id                    : 0x2::object::new(arg1),
            solver_slashes        : 0x2::table::new<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(arg1),
            appeals               : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            total_slashes         : 0,
            total_warnings_issued : 0,
            admin                 : 0x2::tx_context::sender(arg1),
        };
        let v2 = 0x2::package::claim<SLASH_MANAGER>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"severity"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"reason"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"percentage"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"batch"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"created_at"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Intenus Slash #{severity}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"This represents a slashing penalty for {reason}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://intenus.io/assets/slash_{severity}.png"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{severity}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{reason}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{slash_percentage_bps} bps"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{batch_id}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{created_at}"));
        let v7 = 0x2::display::new_with_fields<SlashRecord>(&v2, v3, v5, arg1);
        0x2::display::update_version<SlashRecord>(&mut v7);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SlashRecord>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<SlashManager>(v1);
    }

    public fun is_slash_appealed_and_approved(arg0: &SlashManager, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.appeals, arg1)) {
            return false
        };
        false
    }

    fun issue_warning(arg0: &mut SlashManager, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        arg0.total_warnings_issued = arg0.total_warnings_issued + 1;
        let v0 = WarningIssued{
            solver_address : arg1,
            reason         : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WarningIssued>(v0);
    }

    fun register_slash(arg0: &mut SlashManager, arg1: address, arg2: 0x2::object::ID, arg3: u8) {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&mut arg0.solver_slashes, arg1, 0x2::vec_map::empty<0x2::object::ID, u8>());
        };
        0x2::vec_map::insert<0x2::object::ID, u8>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&mut arg0.solver_slashes, arg1), arg2, arg3);
    }

    public entry fun resolve_appeal(arg0: &AdminCap, arg1: &mut SlashManager, arg2: &mut SlashRecord, arg3: &mut Appeal, arg4: bool, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(arg3.slash_id == v0, 6005);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg1.appeals, v0), 6005);
        let v1 = if (arg4) {
            1
        } else {
            2
        };
        arg3.status = v1;
        arg2.appeal_approved = arg4;
        update_slash_index(arg1, arg2.solver_address, v0, arg2.severity, true, arg4);
        let v2 = AppealResolved{
            slash_id             : v0,
            appeal_id            : 0x2::object::uid_to_inner(&arg3.id),
            solver_address       : arg2.solver_address,
            approved             : arg4,
            resolution_timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AppealResolved>(v2);
    }

    public fun submit_slash(arg0: &mut SlashManager, arg1: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::tee_verifier::TeeVerifier, arg2: SlashEvidence, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        verify_tee_evidence(arg1, &arg2, arg3);
        let v0 = if (arg2.severity == 1) {
            true
        } else if (arg2.severity == 2) {
            true
        } else {
            arg2.severity == 3
        };
        assert!(v0, 6003);
        if (arg2.severity == 1 && !has_active_slashes(arg0, arg2.solver_address)) {
            issue_warning(arg0, arg2.solver_address, arg2.reason_message, arg3);
            return
        };
        let v1 = calculate_slash_percentage(arg2.severity);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0x2::object::new(arg4);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = SlashRecord{
            id                   : v3,
            solver_address       : arg2.solver_address,
            batch_id             : arg2.batch_id,
            solution_id          : arg2.solution_id,
            severity             : arg2.severity,
            reason               : arg2.reason_message,
            slash_percentage_bps : v1,
            created_at           : v2,
            appealed             : false,
            appeal_approved      : false,
        };
        register_slash(arg0, arg2.solver_address, v4, arg2.severity);
        0x2::transfer::transfer<SlashRecord>(v5, arg2.solver_address);
        arg0.total_slashes = arg0.total_slashes + 1;
        let v6 = SlashCreated{
            slash_id             : v4,
            solver_address       : arg2.solver_address,
            batch_id             : arg2.batch_id,
            solution_id          : arg2.solution_id,
            severity             : arg2.severity,
            reason               : arg2.reason_message,
            slash_percentage_bps : v1,
            timestamp            : v2,
        };
        0x2::event::emit<SlashCreated>(v6);
    }

    fun update_slash_index(arg0: &mut SlashManager, arg1: address, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: bool) {
        if (0x2::table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&arg0.solver_slashes, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x2::object::ID, u8>>(&mut arg0.solver_slashes, arg1);
            if (arg4 && arg5) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u8>(v0, &arg2);
            } else if (0x2::vec_map::contains<0x2::object::ID, u8>(v0, &arg2)) {
                *0x2::vec_map::get_mut<0x2::object::ID, u8>(v0, &arg2) = arg3;
            };
        };
    }

    fun verify_tee_evidence(arg0: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::tee_verifier::TeeVerifier, arg1: &SlashEvidence, arg2: &0x2::clock::Clock) {
        assert!(0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::tee_verifier::verify_measurement_match(arg0, &arg1.tee_measurement), 6009);
        assert!(0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::tee_verifier::check_timestamp_freshness(arg1.attestation_timestamp, arg2), 6009);
    }

    // decompiled from Move bytecode v6
}

