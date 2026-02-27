module 0x2ca7e2a2429e86cefcc08335742310fd5adfd77ccf21308f5baef3316dcea3f7::margin_competition {
    struct MarginCompetitionRegistry has key {
        id: 0x2::object::UID,
        participants: 0x2::table::Table<address, bool>,
    }

    struct ParticipantEnrolled has copy, drop {
        participant: address,
        timestamp: u64,
    }

    public fun enroll(arg0: &mut MarginCompetitionRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 < 1773248400000, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.participants, v0), 0);
        0x2::table::add<address, bool>(&mut arg0.participants, v0, true);
        let v2 = ParticipantEnrolled{
            participant : v0,
            timestamp   : v1,
        };
        0x2::event::emit<ParticipantEnrolled>(v2);
    }

    public fun enrollment_end_timestamp_ms() : u64 {
        1773248400000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarginCompetitionRegistry{
            id           : 0x2::object::new(arg0),
            participants : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<MarginCompetitionRegistry>(v0);
    }

    public fun is_enrolled(arg0: &MarginCompetitionRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.participants, arg1)
    }

    public fun participants_count(arg0: &MarginCompetitionRegistry) : u64 {
        0x2::table::length<address, bool>(&arg0.participants)
    }

    // decompiled from Move bytecode v6
}

