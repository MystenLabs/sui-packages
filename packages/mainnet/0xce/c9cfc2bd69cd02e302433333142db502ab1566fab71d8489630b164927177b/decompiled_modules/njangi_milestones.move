module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones {
    struct MilestoneDataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Milestone has drop, store {
        milestone_type: u8,
        target_amount: 0x1::option::Option<u64>,
        target_duration: 0x1::option::Option<u64>,
        start_time: u64,
        deadline: u64,
        completed: bool,
        verified_by: 0x1::option::Option<address>,
        completion_time: 0x1::option::Option<u64>,
        description: 0x1::string::String,
        prerequisites: vector<u64>,
        verification_requirements: vector<u8>,
        verification_proofs: vector<vector<u8>>,
    }

    struct MilestoneData has store, key {
        id: 0x2::object::UID,
        circle_id: 0x2::object::ID,
        milestones: vector<Milestone>,
    }

    public fun add_monetary_milestone(arg0: &mut MilestoneData, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        let v0 = Milestone{
            milestone_type            : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::milestone_type_monetary(),
            target_amount             : 0x1::option::some<u64>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::to_decimals(arg1)),
            target_duration           : 0x1::option::none<u64>(),
            start_time                : arg6,
            deadline                  : arg2,
            completed                 : false,
            verified_by               : 0x1::option::none<address>(),
            completion_time           : 0x1::option::none<u64>(),
            description               : 0x1::string::utf8(arg3),
            prerequisites             : arg4,
            verification_requirements : arg5,
            verification_proofs       : 0x1::vector::empty<vector<u8>>(),
        };
        0x1::vector::push_back<Milestone>(&mut arg0.milestones, v0);
    }

    public fun add_time_milestone(arg0: &mut MilestoneData, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = Milestone{
            milestone_type            : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::milestone_type_time(),
            target_amount             : 0x1::option::none<u64>(),
            target_duration           : 0x1::option::some<u64>(arg1 * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day()),
            start_time                : arg4,
            deadline                  : arg2,
            completed                 : false,
            verified_by               : 0x1::option::none<address>(),
            completion_time           : 0x1::option::none<u64>(),
            description               : 0x1::string::utf8(arg3),
            prerequisites             : 0x1::vector::empty<u64>(),
            verification_requirements : 0x1::vector::empty<u8>(),
            verification_proofs       : 0x1::vector::empty<vector<u8>>(),
        };
        0x1::vector::push_back<Milestone>(&mut arg0.milestones, v0);
    }

    public fun delete_milestone_data(arg0: MilestoneData, arg1: &0x2::tx_context::TxContext) {
        let MilestoneData {
            id         : v0,
            circle_id  : _,
            milestones : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_milestone_count(arg0: &MilestoneData) : u64 {
        0x1::vector::length<Milestone>(&arg0.milestones)
    }

    public fun get_milestone_data(arg0: &MilestoneData) : (0x2::object::ID, &vector<Milestone>) {
        (arg0.circle_id, &arg0.milestones)
    }

    public fun get_milestone_info(arg0: &MilestoneData, arg1: u64) : (u8, 0x1::option::Option<u64>, 0x1::option::Option<u64>, u64, u64, bool, 0x1::option::Option<address>, 0x1::option::Option<u64>, 0x1::string::String) {
        assert!(arg1 < 0x1::vector::length<Milestone>(&arg0.milestones), 28);
        let v0 = 0x1::vector::borrow<Milestone>(&arg0.milestones, arg1);
        (v0.milestone_type, v0.target_amount, v0.target_duration, v0.start_time, v0.deadline, v0.completed, v0.verified_by, v0.completion_time, v0.description)
    }

    public fun get_milestone_verification_type(arg0: &MilestoneData, arg1: u64, arg2: u64) : u8 {
        assert!(arg1 < 0x1::vector::length<Milestone>(&arg0.milestones), 28);
        let v0 = 0x1::vector::borrow<Milestone>(&arg0.milestones, arg1);
        if (0x1::vector::length<u8>(&v0.verification_requirements) > arg2) {
            *0x1::vector::borrow<u8>(&v0.verification_requirements, arg2)
        } else {
            0
        }
    }

    public fun get_verification_proofs_length(arg0: &MilestoneData, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Milestone>(&arg0.milestones), 28);
        0x1::vector::length<vector<u8>>(&0x1::vector::borrow<Milestone>(&arg0.milestones, arg1).verification_proofs)
    }

    public fun init_circle_milestones(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MilestoneData{
            id         : 0x2::object::new(arg1),
            circle_id  : arg0,
            milestones : 0x1::vector::empty<Milestone>(),
        };
        0x2::transfer::share_object<MilestoneData>(v0);
    }

    public fun is_milestone_completed(arg0: &MilestoneData, arg1: u64) : bool {
        if (arg1 >= 0x1::vector::length<Milestone>(&arg0.milestones)) {
            return false
        };
        0x1::vector::borrow<Milestone>(&arg0.milestones, arg1).completed
    }

    public fun submit_milestone_verification(arg0: &mut MilestoneData, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: address) {
        assert!(arg1 < 0x1::vector::length<Milestone>(&arg0.milestones), 28);
        let v0 = 0x1::vector::borrow_mut<Milestone>(&mut arg0.milestones, arg1);
        assert!(!v0.completed, 35);
        0x1::vector::push_back<vector<u8>>(&mut v0.verification_proofs, arg2);
    }

    public fun verify_milestone(arg0: &mut MilestoneData, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg2: u64, arg3: u64, arg4: address) {
        assert!(arg2 < 0x1::vector::length<Milestone>(&arg0.milestones), 28);
        let v0 = 0x1::vector::borrow_mut<Milestone>(&mut arg0.milestones, arg2);
        assert!(!v0.completed, 35);
        assert!(arg3 <= v0.deadline, 34);
        if (v0.milestone_type == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::milestone_type_monetary()) {
        } else {
            assert!(v0.milestone_type == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::milestone_type_time(), 31);
            assert!(arg3 - v0.start_time >= *0x1::option::borrow<u64>(&v0.target_duration), 32);
        };
        assert!(0x1::vector::length<vector<u8>>(&v0.verification_proofs) >= 0x1::vector::length<u8>(&v0.verification_requirements), 33);
        v0.completed = true;
        v0.verified_by = 0x1::option::some<address>(arg4);
        v0.completion_time = 0x1::option::some<u64>(arg3);
    }

    // decompiled from Move bytecode v6
}

