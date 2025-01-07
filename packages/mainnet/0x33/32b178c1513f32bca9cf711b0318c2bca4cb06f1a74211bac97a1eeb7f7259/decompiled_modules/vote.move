module 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote {
    struct VoteStatus has copy, drop, store {
        enable: bool,
        start_ts: u64,
        end_ts: u64,
        min_voting_count: u64,
        passing_threshold: u64,
    }

    struct Participant has copy, drop, store {
        addr: address,
        ts: u64,
        is_agree: bool,
    }

    struct VotingEvidence has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        creator: 0x1::string::String,
        is_agree: bool,
    }

    public(friend) fun empty_participants() : 0x2::vec_map::VecMap<address, Participant> {
        0x2::vec_map::empty<address, Participant>()
    }

    public(friend) fun empty_status() : VoteStatus {
        VoteStatus{
            enable            : false,
            start_ts          : 0,
            end_ts            : 0,
            min_voting_count  : 0,
            passing_threshold : 0,
        }
    }

    public(friend) fun is_voted(arg0: &0x2::vec_map::VecMap<address, Participant>, arg1: address) : bool {
        0x2::vec_map::contains<address, Participant>(arg0, &arg1)
    }

    public(friend) fun is_votestatus_enable(arg0: &VoteStatus) : bool {
        arg0.enable
    }

    public(friend) fun make_VotingEvidence(arg0: &mut 0x2::tx_context::TxContext, arg1: bool) : VotingEvidence {
        VotingEvidence{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"minting vote"),
            description : 0x1::string::utf8(b""),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://lumiwavelab.com/"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://innofile.blob.core.windows.net/inno/live/icon/LUMIWAVE_Primary_black.png"),
            creator     : 0x1::string::utf8(b""),
            is_agree    : arg1,
        }
    }

    public fun participant(arg0: &Participant) : (address, u64, bool) {
        (arg0.addr, arg0.ts, arg0.is_agree)
    }

    public(friend) fun vote_counting(arg0: &0x2::vec_map::VecMap<address, Participant>, arg1: &VoteStatus) : (u64, u64, u64, bool) {
        let (_, v1) = 0x2::vec_map::into_keys_values<address, Participant>(*arg0);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<Participant>(&v2)) {
            if (0x1::vector::borrow<Participant>(&v2, v3).is_agree == true) {
                v4 = v4 + 1;
            } else {
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        let v6 = v4 * 100 / v3 < arg1.passing_threshold && false || true;
        (v4, v5, v3, v6)
    }

    public(friend) fun votestatus_countable(arg0: &VoteStatus, arg1: &0x2::vec_map::VecMap<address, Participant>, arg2: &0x2::clock::Clock) : (bool, bool) {
        (arg0.end_ts < 0x2::clock::timestamp_ms(arg2), 0x2::vec_map::size<address, Participant>(arg1) >= arg0.min_voting_count)
    }

    public(friend) fun votestatus_enable(arg0: &mut VoteStatus, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg0.enable = arg1;
        arg0.start_ts = arg2;
        arg0.end_ts = arg3;
        arg0.min_voting_count = arg4;
        arg0.passing_threshold = arg5;
    }

    public(friend) fun votestatus_period_check(arg0: &VoteStatus, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.start_ts && v0 <= arg0.end_ts
    }

    public(friend) fun voting(arg0: &mut 0x2::vec_map::VecMap<address, Participant>, arg1: address, arg2: &0x2::clock::Clock, arg3: bool) {
        let v0 = Participant{
            addr     : arg1,
            ts       : 0x2::clock::timestamp_ms(arg2),
            is_agree : arg3,
        };
        0x2::vec_map::insert<address, Participant>(arg0, arg1, v0);
    }

    public fun voting_evidence_detail(arg0: &VotingEvidence) : (0x1::string::String, 0x1::string::String, 0x2::url::Url, 0x2::url::Url, 0x1::string::String, bool) {
        (arg0.name, arg0.description, arg0.project_url, arg0.image_url, arg0.creator, arg0.is_agree)
    }

    // decompiled from Move bytecode v6
}

