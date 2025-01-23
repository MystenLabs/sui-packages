module 0xf78d1240991ddc223cc96f76642f7ff415549f50a496a7660ca94f8e803f11ac::people_champion {
    struct PEOPLE_CHAMPION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct VoterMintCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VoteData has store, key {
        id: 0x2::object::UID,
        athlete_uid: 0x1::string::String,
        sender: address,
        prev_voted_athlete: 0x1::string::String,
    }

    struct VoterId has key {
        id: 0x2::object::UID,
    }

    struct AthleteProfile has drop, store {
        athlete_uid: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        votes: u64,
        is_disqualified: bool,
    }

    struct OneFcEvent has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        event_id: 0x1::string::String,
        athletes: 0x2::table::Table<0x1::string::String, AthleteProfile>,
        start_timestamp: u64,
        end_timestamp: u64,
        winning_amount: u64,
        unique_id_list: vector<0x1::string::String>,
        winner_athlete_uid: vector<0x1::string::String>,
        winner_athlete_address: vector<address>,
        voters_detail: 0x2::table::Table<address, 0x1::string::String>,
        vote_change_limit: u64,
        removed_athlete_list: vector<0x1::string::String>,
        total_votes: u64,
        is_voting_paused: bool,
    }

    struct UserVoteLogs has store {
        event_id: 0x1::string::String,
        athlete_uid: 0x1::string::String,
        vote_change_count: u64,
    }

    struct CreateEvent has copy, drop {
        event_id: 0x1::string::String,
        event_obj_id: 0x2::object::ID,
    }

    struct EndEvent has copy, drop {
        event_id: 0x1::string::String,
        event_obj_id: 0x2::object::ID,
    }

    struct UpdateVoteChangeLimitEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        new_vote_change_limit: u64,
    }

    struct UpdateStartTimestampEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        new_start_timestamp: u64,
    }

    struct UpdateEndTimestampEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        new_end_timestamp: u64,
    }

    struct VotePauseEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        is_voting_paused: bool,
    }

    struct VoteResumeEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        is_voting_paused: bool,
    }

    struct AddAthleteEvent has copy, drop {
        athlete_uid: 0x1::string::String,
        event_obj_id: 0x2::object::ID,
    }

    struct RemoveAthleteEvent has copy, drop {
        athlete_uid: 0x1::string::String,
        event_obj_id: 0x2::object::ID,
    }

    struct MintVoterIDEvent has copy, drop {
        recipient: address,
        voter_id: 0x2::object::ID,
    }

    struct VoteEvent has copy, drop {
        athlete_uid: 0x1::string::String,
        event_obj_id: 0x2::object::ID,
        voter_id: 0x2::object::ID,
        vote_data_id: 0x2::object::ID,
    }

    struct ReceiveVoteDataEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        athlete_uid: 0x1::string::String,
        voter: address,
    }

    struct UpdateWinningAmountEvent has copy, drop {
        event_obj_id: 0x2::object::ID,
        new_amount: u64,
    }

    struct UpdateWinnerAddressEvent has copy, drop {
        athlete_address: vector<address>,
        event_obj_id: 0x2::object::ID,
    }

    struct DisqualifyAthleteEvent has copy, drop {
        athlete_uid: 0x1::string::String,
        event_obj_id: 0x2::object::ID,
    }

    struct VoterMintCapEvent has copy, drop {
        voter_mint_cap_id: 0x2::object::ID,
        recipient: address,
    }

    public fun add_athlete(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        assert!(arg2.end_timestamp >= 0x2::clock::timestamp_ms(arg6), 9223373832151629833);
        let v0 = AthleteProfile{
            athlete_uid     : arg5,
            name            : arg3,
            description     : arg4,
            votes           : 0,
            is_disqualified : false,
        };
        0x2::table::add<0x1::string::String, AthleteProfile>(&mut arg2.athletes, arg5, v0);
        0x1::vector::push_back<0x1::string::String>(&mut arg2.unique_id_list, arg5);
        let v1 = AddAthleteEvent{
            athlete_uid  : arg5,
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
        };
        0x2::event::emit<AddAthleteEvent>(v1);
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 9223374935958093831);
    }

    public fun create_event(arg0: &AdminCap, arg1: &Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &0x2::clock::Clock, arg9: &mut 0x1::option::Option<u64>, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == 0x1::vector::length<0x1::string::String>(&arg6) && 0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 9223373127776468993);
        if (0x1::option::is_some<u64>(arg9)) {
            assert!(*0x1::option::borrow<u64>(arg9) > 0x2::clock::timestamp_ms(arg8), 9223373144956469251);
        } else {
            0x1::option::fill<u64>(arg9, 0x2::clock::timestamp_ms(arg8));
        };
        assert!(arg10 > *0x1::option::borrow<u64>(arg9), 9223373162136469509);
        let v0 = 0x2::table::new<0x1::string::String, AthleteProfile>(arg13);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg5)) {
            let v2 = AthleteProfile{
                athlete_uid     : *0x1::vector::borrow<0x1::string::String>(&arg7, v1),
                name            : *0x1::vector::borrow<0x1::string::String>(&arg5, v1),
                description     : *0x1::vector::borrow<0x1::string::String>(&arg6, v1),
                votes           : 0,
                is_disqualified : false,
            };
            0x2::table::add<0x1::string::String, AthleteProfile>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg7, v1), v2);
            v1 = v1 + 1;
        };
        let v3 = OneFcEvent{
            id                     : 0x2::object::new(arg13),
            name                   : arg2,
            description            : arg3,
            event_id               : arg4,
            athletes               : v0,
            start_timestamp        : *0x1::option::borrow<u64>(arg9),
            end_timestamp          : arg10,
            winning_amount         : arg11,
            unique_id_list         : arg7,
            winner_athlete_uid     : 0x1::vector::empty<0x1::string::String>(),
            winner_athlete_address : 0x1::vector::empty<address>(),
            voters_detail          : 0x2::table::new<address, 0x1::string::String>(arg13),
            vote_change_limit      : arg12,
            removed_athlete_list   : 0x1::vector::empty<0x1::string::String>(),
            total_votes            : 0,
            is_voting_paused       : false,
        };
        let v4 = CreateEvent{
            event_id     : arg4,
            event_obj_id : 0x2::object::id<OneFcEvent>(&v3),
        };
        0x2::event::emit<CreateEvent>(v4);
        0x2::transfer::share_object<OneFcEvent>(v3);
    }

    public fun disqualify_athlete(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: 0x1::string::String) {
        checkVersion(arg1, 1);
        0x2::table::borrow_mut<0x1::string::String, AthleteProfile>(&mut arg2.athletes, arg3).is_disqualified = true;
        let v0 = DisqualifyAthleteEvent{
            athlete_uid  : arg3,
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
        };
        0x2::event::emit<DisqualifyAthleteEvent>(v0);
    }

    public fun end_event(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent) {
        checkVersion(arg1, 1);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = arg2.unique_id_list;
        0x1::vector::reverse<0x1::string::String>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x1::string::String>(&mut v2);
            let v5 = 0x2::table::borrow<0x1::string::String, AthleteProfile>(&arg2.athletes, v4);
            if (!v5.is_disqualified) {
                let v6 = v5.votes;
                if (v6 > v0) {
                    v1 = 0x1::vector::empty<0x1::string::String>();
                    0x1::vector::push_back<0x1::string::String>(&mut v1, v4);
                } else if (v6 == v0) {
                    0x1::vector::push_back<0x1::string::String>(&mut v1, v4);
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v2);
        arg2.winner_athlete_uid = v1;
        let v7 = EndEvent{
            event_id     : arg2.event_id,
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
        };
        0x2::event::emit<EndEvent>(v7);
    }

    fun init(arg0: PEOPLE_CHAMPION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PEOPLE_CHAMPION>(arg0, arg1);
        let v1 = 0x2::display::new<VoterId>(&v0, arg1);
        0x2::display::add<VoterId>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"ONE People's Champion Vote"));
        0x2::display::add<VoterId>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This is a user's vote ID when they vote on The People's Champion format in ONE Pick Em."));
        0x2::display::add<VoterId>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://res.cloudinary.com/onefc/image/upload/v1737616447/pickem/ONEPickem_logo_square.png"));
        0x2::display::update_version<VoterId>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<VoterId>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Version>(v3);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 9223373024697647111);
        arg1.version = arg2;
    }

    public fun mint_voter_id(arg0: &VoterMintCap, arg1: &Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        let v0 = VoterId{id: 0x2::object::new(arg3)};
        let v1 = MintVoterIDEvent{
            recipient : arg2,
            voter_id  : 0x2::object::id<VoterId>(&v0),
        };
        0x2::event::emit<MintVoterIDEvent>(v1);
        0x2::transfer::transfer<VoterId>(v0, arg2);
    }

    public fun mint_voter_mint_cap(arg0: &AdminCap, arg1: &Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        let v0 = VoterMintCap{id: 0x2::object::new(arg3)};
        let v1 = VoterMintCapEvent{
            voter_mint_cap_id : 0x2::object::id<VoterMintCap>(&v0),
            recipient         : arg2,
        };
        0x2::event::emit<VoterMintCapEvent>(v1);
        0x2::transfer::transfer<VoterMintCap>(v0, arg2);
    }

    public fun pause_voting(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        assert!(arg2.end_timestamp >= 0x2::clock::timestamp_ms(arg3), 9223373660352937993);
        assert!(arg2.is_voting_paused == false, 9223373664648822807);
        arg2.is_voting_paused = true;
        let v0 = VotePauseEvent{
            event_obj_id     : 0x2::object::id<OneFcEvent>(arg2),
            is_voting_paused : true,
        };
        0x2::event::emit<VotePauseEvent>(v0);
    }

    public fun receive_vote_data(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: 0x2::transfer::Receiving<VoteData>) {
        checkVersion(arg1, 1);
        let VoteData {
            id                 : v0,
            athlete_uid        : v1,
            sender             : v2,
            prev_voted_athlete : v3,
        } = 0x2::transfer::public_receive<VoteData>(&mut arg2.id, arg3);
        let v4 = v3;
        if (v4 != 0x1::string::utf8(b"None")) {
            if (!0x1::vector::contains<0x1::string::String>(&arg2.removed_athlete_list, &v4)) {
                let v5 = 0x2::table::borrow_mut<0x1::string::String, AthleteProfile>(&mut arg2.athletes, v4);
                v5.votes = v5.votes - 1;
            };
            *0x2::table::borrow_mut<address, 0x1::string::String>(&mut arg2.voters_detail, v2) = v1;
        } else {
            arg2.total_votes = arg2.total_votes + 1;
            0x2::table::add<address, 0x1::string::String>(&mut arg2.voters_detail, v2, v1);
        };
        let v6 = 0x2::table::borrow_mut<0x1::string::String, AthleteProfile>(&mut arg2.athletes, v1);
        v6.votes = v6.votes + 1;
        let v7 = ReceiveVoteDataEvent{
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
            athlete_uid  : v1,
            voter        : v2,
        };
        0x2::event::emit<ReceiveVoteDataEvent>(v7);
        0x2::object::delete(v0);
    }

    public fun remove_athlete(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        assert!(arg2.end_timestamp >= 0x2::clock::timestamp_ms(arg4), 9223373965295616009);
        0x2::table::remove<0x1::string::String, AthleteProfile>(&mut arg2.athletes, arg3);
        let (_, v1) = 0x1::vector::index_of<0x1::string::String>(&arg2.unique_id_list, &arg3);
        0x1::vector::remove<0x1::string::String>(&mut arg2.unique_id_list, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg2.removed_athlete_list, arg3);
        let v2 = RemoveAthleteEvent{
            athlete_uid  : arg3,
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
        };
        0x2::event::emit<RemoveAthleteEvent>(v2);
    }

    public fun resume_voting(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        assert!(arg2.end_timestamp >= 0x2::clock::timestamp_ms(arg3), 9223373737662349321);
        assert!(arg2.is_voting_paused == true, 9223373741958365209);
        arg2.is_voting_paused = false;
        let v0 = VoteResumeEvent{
            event_obj_id     : 0x2::object::id<OneFcEvent>(arg2),
            is_voting_paused : false,
        };
        0x2::event::emit<VoteResumeEvent>(v0);
    }

    public fun update_end_timestamp(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: u64, arg4: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        assert!(arg3 > arg2.start_timestamp, 9223373578748297221);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 9223373583043264517);
        arg2.end_timestamp = arg3;
        let v0 = UpdateEndTimestampEvent{
            event_obj_id      : 0x2::object::id<OneFcEvent>(arg2),
            new_end_timestamp : arg3,
        };
        0x2::event::emit<UpdateEndTimestampEvent>(v0);
    }

    public fun update_start_timestamp(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: &mut 0x1::option::Option<u64>, arg4: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        if (0x1::option::is_some<u64>(arg3)) {
            assert!(*0x1::option::borrow<u64>(arg3) > 0x2::clock::timestamp_ms(arg4), 9223373479963918339);
        } else {
            0x1::option::fill<u64>(arg3, 0x2::clock::timestamp_ms(arg4));
        };
        assert!(arg2.end_timestamp > *0x1::option::borrow<u64>(arg3), 9223373497143787523);
        arg2.start_timestamp = *0x1::option::borrow<u64>(arg3);
        let v0 = UpdateStartTimestampEvent{
            event_obj_id        : 0x2::object::id<OneFcEvent>(arg2),
            new_start_timestamp : *0x1::option::borrow<u64>(arg3),
        };
        0x2::event::emit<UpdateStartTimestampEvent>(v0);
    }

    public fun update_vote_change_limit(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: u64, arg4: &0x2::clock::Clock) {
        checkVersion(arg1, 1);
        assert!(arg2.end_timestamp > 0x2::clock::timestamp_ms(arg4), 9223373389769998345);
        arg2.vote_change_limit = arg3;
        let v0 = UpdateVoteChangeLimitEvent{
            event_obj_id          : 0x2::object::id<OneFcEvent>(arg2),
            new_vote_change_limit : arg3,
        };
        0x2::event::emit<UpdateVoteChangeLimitEvent>(v0);
    }

    public fun update_wining_amount(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: u64) {
        checkVersion(arg1, 1);
        arg2.winning_amount = arg3;
        let v0 = UpdateWinningAmountEvent{
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
            new_amount   : arg3,
        };
        0x2::event::emit<UpdateWinningAmountEvent>(v0);
    }

    public fun update_winner_address(arg0: &AdminCap, arg1: &Version, arg2: &mut OneFcEvent, arg3: vector<address>) {
        checkVersion(arg1, 1);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg2.winner_athlete_uid), 9223374819994632209);
        arg2.winner_athlete_address = arg3;
        let v0 = UpdateWinnerAddressEvent{
            athlete_address : arg3,
            event_obj_id    : 0x2::object::id<OneFcEvent>(arg2),
        };
        0x2::event::emit<UpdateWinnerAddressEvent>(v0);
    }

    public fun vote(arg0: &Version, arg1: &mut VoterId, arg2: &OneFcEvent, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VoteData {
        checkVersion(arg0, 1);
        assert!(!arg2.is_voting_paused, 9223374149979340811);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg2.start_timestamp, 9223374162864373773);
        assert!(arg2.end_timestamp >= v0, 9223374167159078921);
        assert!(!0x1::vector::contains<0x1::string::String>(&arg2.removed_athlete_list, &arg3), 9223374171454832661);
        let v1 = VoteData{
            id                 : 0x2::object::new(arg5),
            athlete_uid        : arg3,
            sender             : 0x2::tx_context::sender(arg5),
            prev_voted_athlete : 0x1::string::utf8(b"None"),
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, arg2.event_id)) {
            let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, UserVoteLogs>(&mut arg1.id, arg2.event_id);
            let v3 = v2.athlete_uid;
            assert!(v3 != arg3, 9223374231584243731);
            let v4 = v2.vote_change_count + 1;
            let v5 = v4;
            if (!0x1::vector::contains<0x1::string::String>(&arg2.removed_athlete_list, &v3)) {
                if (0x2::table::borrow<0x1::string::String, AthleteProfile>(&arg2.athletes, v3).is_disqualified) {
                    v5 = v4 - 1;
                } else {
                    assert!(v4 <= arg2.vote_change_limit, 9223374283123589135);
                };
            } else {
                v5 = v4 - 1;
            };
            v2.athlete_uid = arg3;
            v2.vote_change_count = v5;
            v1.prev_voted_athlete = v3;
        } else {
            let v6 = UserVoteLogs{
                event_id          : arg2.event_id,
                athlete_uid       : arg3,
                vote_change_count : 0,
            };
            0x2::dynamic_field::add<0x1::string::String, UserVoteLogs>(&mut arg1.id, arg2.event_id, v6);
        };
        let v7 = VoteEvent{
            athlete_uid  : arg3,
            event_obj_id : 0x2::object::id<OneFcEvent>(arg2),
            voter_id     : 0x2::object::id<VoterId>(arg1),
            vote_data_id : 0x2::object::id<VoteData>(&v1),
        };
        0x2::event::emit<VoteEvent>(v7);
        v1
    }

    // decompiled from Move bytecode v6
}

