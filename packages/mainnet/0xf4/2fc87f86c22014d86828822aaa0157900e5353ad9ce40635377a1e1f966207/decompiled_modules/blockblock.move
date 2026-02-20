module 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock {
    struct BlockBlockYonsei has key {
        id: 0x2::object::UID,
        founded_on: Date,
    }

    struct BlockBlockRegistry has key {
        id: 0x2::object::UID,
        blockblock_ys: 0x2::object::ID,
        current_term: u64,
        current_club: 0x2::object::ID,
        previous_term: u64,
        previous_club: 0x2::object::ID,
        current_president: address,
    }

    struct BlockBlockClub has store, key {
        id: 0x2::object::UID,
        blockblock_ys: 0x2::object::ID,
        term: u64,
        president: address,
        vice_president: 0x1::option::Option<address>,
        treasurer: 0x1::option::Option<address>,
        planning_team: vector<address>,
        marketing_team: vector<address>,
        project_leaders: vector<address>,
        senior_members: vector<address>,
        junior_members: vector<address>,
        attendance_sheets: vector<AttendanceSheet>,
        is_active: bool,
    }

    struct AttendanceSheet has store {
        date: Date,
        session: 0x1::string::String,
        attendees: vector<address>,
        late: vector<address>,
        absent: vector<address>,
        excused: vector<address>,
        is_minted: bool,
    }

    struct Date has store {
        year: u64,
        month: u64,
        day: u64,
    }

    struct PresidentWitness has drop {
        current_term: u64,
        member_address: address,
    }

    struct MemberWitness has drop {
        current_term: u64,
        member_address: address,
    }

    public(friend) fun assert_current_club(arg0: &BlockBlockRegistry, arg1: &BlockBlockClub) {
        assert!(arg0.current_club == 0x2::object::uid_to_inner(&arg1.id), 1);
        assert!(arg0.current_term == arg1.term, 2);
        assert!(arg0.current_president == arg1.president, 3);
    }

    public(friend) fun attendees_including_late(arg0: &AttendanceSheet) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &arg0.attendees;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v1, v2));
            v2 = v2 + 1;
        };
        let v3 = &arg0.late;
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v3)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v3, v4));
            v4 = v4 + 1;
        };
        v0
    }

    public(friend) fun borrow_attendance_sheet(arg0: &BlockBlockClub, arg1: u64) : &AttendanceSheet {
        0x1::vector::borrow<AttendanceSheet>(&arg0.attendance_sheets, arg1)
    }

    public(friend) fun borrow_junior_members(arg0: &BlockBlockClub) : &vector<address> {
        &arg0.junior_members
    }

    public(friend) fun borrow_mut_junior_members(arg0: &mut BlockBlockClub) : &mut vector<address> {
        &mut arg0.junior_members
    }

    public(friend) fun borrow_mut_senior_members(arg0: &mut BlockBlockClub) : &mut vector<address> {
        &mut arg0.senior_members
    }

    public(friend) fun borrow_senior_members(arg0: &BlockBlockClub) : &vector<address> {
        &arg0.senior_members
    }

    public(friend) fun create_attendance_sheet(arg0: Date, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<address>, arg4: vector<address>, arg5: vector<address>) : AttendanceSheet {
        AttendanceSheet{
            date      : arg0,
            session   : arg1,
            attendees : arg2,
            late      : arg3,
            absent    : arg4,
            excused   : arg5,
            is_minted : false,
        }
    }

    public(friend) fun create_blockblockclub(arg0: &BlockBlockYonsei, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : BlockBlockClub {
        BlockBlockClub{
            id                : 0x2::object::new(arg3),
            blockblock_ys     : 0x2::object::uid_to_inner(&arg0.id),
            term              : arg1,
            president         : arg2,
            vice_president    : 0x1::option::none<address>(),
            treasurer         : 0x1::option::none<address>(),
            planning_team     : 0x1::vector::empty<address>(),
            marketing_team    : 0x1::vector::empty<address>(),
            project_leaders   : 0x1::vector::empty<address>(),
            senior_members    : 0x1::vector::empty<address>(),
            junior_members    : 0x1::vector::empty<address>(),
            attendance_sheets : 0x1::vector::empty<AttendanceSheet>(),
            is_active         : true,
        }
    }

    public(friend) fun create_date(arg0: u64, arg1: u64, arg2: u64) : Date {
        Date{
            year  : arg0,
            month : arg1,
            day   : arg2,
        }
    }

    public fun create_member_witness(arg0: &BlockBlockYonsei, arg1: &BlockBlockRegistry, arg2: &BlockBlockClub, arg3: &0x2::tx_context::TxContext) : MemberWitness {
        assert!(arg1.blockblock_ys == 0x2::object::uid_to_inner(&arg0.id), 0);
        assert_current_club(arg1, arg2);
        is_member(arg2, 0x2::tx_context::sender(arg3));
        MemberWitness{
            current_term   : arg1.current_term,
            member_address : 0x2::tx_context::sender(arg3),
        }
    }

    public fun create_president_witness(arg0: &BlockBlockYonsei, arg1: &BlockBlockRegistry, arg2: &BlockBlockClub, arg3: &0x2::tx_context::TxContext) : PresidentWitness {
        assert!(arg1.blockblock_ys == 0x2::object::uid_to_inner(&arg0.id), 0);
        assert_current_club(arg1, arg2);
        assert!(arg2.president == 0x2::tx_context::sender(arg3), 3);
        PresidentWitness{
            current_term   : arg1.current_term,
            member_address : 0x2::tx_context::sender(arg3),
        }
    }

    public(friend) fun current_club(arg0: &BlockBlockRegistry) : 0x2::object::ID {
        arg0.current_club
    }

    public(friend) fun current_term(arg0: &BlockBlockRegistry) : u64 {
        arg0.current_term
    }

    public(friend) fun id(arg0: &BlockBlockClub) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Date{
            year  : 2022,
            month : 10,
            day   : 11,
        };
        let v1 = BlockBlockYonsei{
            id         : 0x2::object::new(arg0),
            founded_on : v0,
        };
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = create_blockblockclub(&v1, 1, v2, arg0);
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        let v5 = BlockBlockRegistry{
            id                : 0x2::object::new(arg0),
            blockblock_ys     : 0x2::object::uid_to_inner(&v1.id),
            current_term      : 1,
            current_club      : v4,
            previous_term     : 0,
            previous_club     : v4,
            current_president : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<BlockBlockYonsei>(v1);
        0x2::transfer::share_object<BlockBlockClub>(v3);
        0x2::transfer::share_object<BlockBlockRegistry>(v5);
    }

    public(friend) fun is_active(arg0: &BlockBlockClub) : bool {
        arg0.is_active
    }

    public(friend) fun is_member(arg0: &BlockBlockClub, arg1: address) : bool {
        if (0x1::vector::contains<address>(&arg0.senior_members, &arg1)) {
            return true
        };
        0x1::vector::contains<address>(&arg0.junior_members, &arg1)
    }

    public(friend) fun is_minted(arg0: &AttendanceSheet) : bool {
        arg0.is_minted
    }

    public(friend) fun member_address(arg0: &MemberWitness) : address {
        arg0.member_address
    }

    public(friend) fun president(arg0: &BlockBlockClub) : address {
        arg0.president
    }

    public fun register_marketing_team_member(arg0: PresidentWitness, arg1: &mut BlockBlockClub, arg2: address) {
        let v0 = if (arg1.president != arg2) {
            if (0x1::option::borrow<address>(&arg1.vice_president) != &arg2) {
                0x1::option::borrow<address>(&arg1.treasurer) != &arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(!0x1::vector::contains<address>(&arg1.planning_team, &arg2) && !0x1::vector::contains<address>(&arg1.marketing_team, &arg2), 13906834947437494271);
        0x1::vector::push_back<address>(&mut arg1.marketing_team, arg2);
    }

    public fun register_planning_team_member(arg0: PresidentWitness, arg1: &mut BlockBlockClub, arg2: address) {
        let v0 = if (arg1.president != arg2) {
            if (0x1::option::borrow<address>(&arg1.vice_president) != &arg2) {
                0x1::option::borrow<address>(&arg1.treasurer) != &arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(!0x1::vector::contains<address>(&arg1.planning_team, &arg2) && !0x1::vector::contains<address>(&arg1.marketing_team, &arg2), 13906834887307952127);
        0x1::vector::push_back<address>(&mut arg1.planning_team, arg2);
    }

    public fun register_treasurer(arg0: PresidentWitness, arg1: &mut BlockBlockClub, arg2: address) {
        assert!(0x1::option::is_none<address>(&arg1.treasurer), 4);
        arg1.treasurer = 0x1::option::some<address>(arg2);
    }

    public fun register_vice_president(arg0: PresidentWitness, arg1: &mut BlockBlockClub, arg2: address) {
        assert!(0x1::option::is_none<address>(&arg1.vice_president), 4);
        arg1.vice_president = 0x1::option::some<address>(arg2);
    }

    public(friend) fun session(arg0: &AttendanceSheet) : 0x1::string::String {
        arg0.session
    }

    public(friend) fun set_inactive(arg0: &mut BlockBlockClub) {
        arg0.is_active = false;
    }

    public fun store_attendance_sheet_to_blockblockclub(arg0: &mut BlockBlockClub, arg1: AttendanceSheet) {
        0x1::vector::push_back<AttendanceSheet>(&mut arg0.attendance_sheets, arg1);
    }

    public(friend) fun term(arg0: &BlockBlockClub) : u64 {
        arg0.term
    }

    public(friend) fun treasurer(arg0: &BlockBlockClub) : address {
        *0x1::option::borrow<address>(&arg0.treasurer)
    }

    public(friend) fun update_blockblock_registry_with_next_club(arg0: &mut BlockBlockRegistry, arg1: &BlockBlockClub, arg2: address) {
        let v0 = arg0.current_term;
        arg0.previous_term = v0;
        arg0.previous_club = arg0.current_club;
        arg0.current_term = v0 + 1;
        arg0.current_club = 0x2::object::uid_to_inner(&arg1.id);
        arg0.current_president = arg2;
    }

    public(friend) fun vice_president(arg0: &BlockBlockClub) : address {
        *0x1::option::borrow<address>(&arg0.vice_president)
    }

    // decompiled from Move bytecode v6
}

