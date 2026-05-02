module 0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_thread {
    struct ThreadAdminCap has store, key {
        id: 0x2::object::UID,
        thread_id: 0x2::object::ID,
    }

    struct ThreadParticipantCap has store, key {
        id: 0x2::object::UID,
        thread_id: 0x2::object::ID,
        participant: 0x1::string::String,
    }

    struct ThreadState has key {
        id: 0x2::object::UID,
        thread_id: 0x1::string::String,
        workspace_id: 0x1::string::String,
        topic: 0x1::string::String,
        creator: address,
        status: u8,
        message_count: u64,
        last_message_digest: vector<u8>,
        last_walrus_blob_id: 0x1::string::String,
        participants: vector<0x1::string::String>,
        created_at: u64,
        updated_at: u64,
    }

    struct ThreadCreated has copy, drop {
        thread_obj_id: 0x2::object::ID,
        thread_id: 0x1::string::String,
        workspace_id: 0x1::string::String,
        topic: 0x1::string::String,
        creator: address,
        created_at: u64,
    }

    struct MessageRecorded has copy, drop {
        thread_obj_id: 0x2::object::ID,
        thread_id: 0x1::string::String,
        sequence: u64,
        source_kind: u8,
        sender_id: 0x1::string::String,
        digest: vector<u8>,
        walrus_blob_id: 0x1::string::String,
        tag: 0x1::string::String,
        recorded_by: address,
        recorded_at: u64,
    }

    struct ThreadTransitioned has copy, drop {
        thread_obj_id: 0x2::object::ID,
        thread_id: 0x1::string::String,
        from_status: u8,
        to_status: u8,
        reason_digest: vector<u8>,
        transitioned_by: address,
        transitioned_at: u64,
    }

    struct ParticipantChanged has copy, drop {
        thread_obj_id: 0x2::object::ID,
        thread_id: 0x1::string::String,
        participant: 0x1::string::String,
        joined: bool,
        changed_by: address,
        changed_at: u64,
    }

    entry fun add_participant(arg0: &ThreadAdminCap, arg1: &mut ThreadState, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<ThreadParticipantCap>(create_participant_cap(arg0, arg1, arg2, arg4, arg5), arg3);
    }

    fun assert_admin_for_thread(arg0: &ThreadState, arg1: &ThreadAdminCap) {
        assert!(arg1.thread_id == 0x2::object::id<ThreadState>(arg0), 700);
    }

    fun assert_live(arg0: &ThreadState) {
        assert!(arg0.status != 6 && arg0.status != 5, 701);
    }

    fun assert_participant_for_thread(arg0: &ThreadState, arg1: &ThreadParticipantCap) {
        assert!(arg1.thread_id == 0x2::object::id<ThreadState>(arg0), 700);
        assert!(contains_participant(arg0, &arg1.participant), 700);
    }

    fun assert_participant_message_allowed(arg0: &ThreadParticipantCap, arg1: u8, arg2: &0x1::string::String) {
        assert!(arg1 == 1 || arg1 == 2, 708);
        assert!(*arg2 == arg0.participant, 707);
    }

    fun contains_participant(arg0: &ThreadState, arg1: &0x1::string::String) : bool {
        let (v0, _) = index_of_participant(arg0, arg1);
        v0
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (ThreadState, ThreadAdminCap) {
        assert!(!0x1::string::is_empty(&arg2), 706);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = ThreadState{
            id                  : 0x2::object::new(arg4),
            thread_id           : arg0,
            workspace_id        : arg1,
            topic               : arg2,
            creator             : v0,
            status              : 1,
            message_count       : 0,
            last_message_digest : b"",
            last_walrus_blob_id : 0x1::string::utf8(b""),
            participants        : 0x1::vector::empty<0x1::string::String>(),
            created_at          : v1,
            updated_at          : v1,
        };
        let v3 = ThreadAdminCap{
            id        : 0x2::object::new(arg4),
            thread_id : 0x2::object::id<ThreadState>(&v2),
        };
        let v4 = ThreadCreated{
            thread_obj_id : 0x2::object::id<ThreadState>(&v2),
            thread_id     : v2.thread_id,
            workspace_id  : v2.workspace_id,
            topic         : v2.topic,
            creator       : v0,
            created_at    : v1,
        };
        0x2::event::emit<ThreadCreated>(v4);
        (v2, v3)
    }

    public fun create_participant_cap(arg0: &ThreadAdminCap, arg1: &mut ThreadState, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ThreadParticipantCap {
        assert_admin_for_thread(arg1, arg0);
        assert_live(arg1);
        assert!(!contains_participant(arg1, &arg2), 704);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.participants, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.updated_at = v0;
        let v1 = ThreadParticipantCap{
            id          : 0x2::object::new(arg4),
            thread_id   : 0x2::object::id<ThreadState>(arg1),
            participant : *0x1::vector::borrow<0x1::string::String>(&arg1.participants, 0x1::vector::length<0x1::string::String>(&arg1.participants) - 1),
        };
        let v2 = ParticipantChanged{
            thread_obj_id : 0x2::object::id<ThreadState>(arg1),
            thread_id     : arg1.thread_id,
            participant   : v1.participant,
            joined        : true,
            changed_by    : 0x2::tx_context::sender(arg4),
            changed_at    : v0,
        };
        0x2::event::emit<ParticipantChanged>(v2);
        v1
    }

    entry fun create_shared(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = create(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<ThreadState>(v1);
        0x2::transfer::transfer<ThreadAdminCap>(v2, v0);
    }

    public fun created_at(arg0: &ThreadState) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &ThreadState) : address {
        arg0.creator
    }

    fun do_record_message(arg0: &mut ThreadState, arg1: u8, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else if (arg1 == 3) {
            true
        } else {
            arg1 == 4
        };
        assert!(v0, 702);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        arg0.message_count = arg0.message_count + 1;
        arg0.last_message_digest = arg3;
        arg0.last_walrus_blob_id = arg4;
        arg0.updated_at = v1;
        if (arg0.status == 1) {
            arg0.status = 2;
            let v2 = ThreadTransitioned{
                thread_obj_id   : 0x2::object::id<ThreadState>(arg0),
                thread_id       : arg0.thread_id,
                from_status     : arg0.status,
                to_status       : 2,
                reason_digest   : b"",
                transitioned_by : 0x2::tx_context::sender(arg7),
                transitioned_at : v1,
            };
            0x2::event::emit<ThreadTransitioned>(v2);
        };
        let v3 = MessageRecorded{
            thread_obj_id  : 0x2::object::id<ThreadState>(arg0),
            thread_id      : arg0.thread_id,
            sequence       : arg0.message_count,
            source_kind    : arg1,
            sender_id      : arg2,
            digest         : arg0.last_message_digest,
            walrus_blob_id : arg0.last_walrus_blob_id,
            tag            : arg5,
            recorded_by    : 0x2::tx_context::sender(arg7),
            recorded_at    : v1,
        };
        0x2::event::emit<MessageRecorded>(v3);
    }

    fun do_transition(arg0: &mut ThreadState, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(is_valid_status(arg1), 702);
        assert!(arg0.status != 6, 701);
        assert!(is_valid_transition(arg0.status, arg1), 703);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.status = arg1;
        arg0.updated_at = v0;
        let v1 = ThreadTransitioned{
            thread_obj_id   : 0x2::object::id<ThreadState>(arg0),
            thread_id       : arg0.thread_id,
            from_status     : arg0.status,
            to_status       : arg1,
            reason_digest   : arg2,
            transitioned_by : 0x2::tx_context::sender(arg4),
            transitioned_at : v0,
        };
        0x2::event::emit<ThreadTransitioned>(v1);
    }

    fun index_of_participant(arg0: &ThreadState, arg1: &0x1::string::String) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.participants)) {
            if (0x1::vector::borrow<0x1::string::String>(&arg0.participants, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun is_valid_status(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        }
    }

    fun is_valid_transition(arg0: u8, arg1: u8) : bool {
        if (arg0 == arg1) {
            return false
        };
        if (arg0 == 6) {
            return false
        };
        if (arg0 == 5) {
            return arg1 == 6 || arg1 == 2
        };
        true
    }

    public fun last_message_digest(arg0: &ThreadState) : vector<u8> {
        arg0.last_message_digest
    }

    public fun last_walrus_blob_id(arg0: &ThreadState) : 0x1::string::String {
        arg0.last_walrus_blob_id
    }

    public fun message_count(arg0: &ThreadState) : u64 {
        arg0.message_count
    }

    public fun participants(arg0: &ThreadState) : vector<0x1::string::String> {
        arg0.participants
    }

    entry fun record_message(arg0: &ThreadAdminCap, arg1: &mut ThreadState, arg2: u8, arg3: 0x1::string::String, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_admin_for_thread(arg1, arg0);
        do_record_message(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun record_message_as_participant(arg0: &ThreadParticipantCap, arg1: &mut ThreadState, arg2: u8, arg3: 0x1::string::String, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_participant_for_thread(arg1, arg0);
        assert_participant_message_allowed(arg0, arg2, &arg3);
        do_record_message(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun remove_participant(arg0: &ThreadAdminCap, arg1: &mut ThreadState, arg2: ThreadParticipantCap, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin_for_thread(arg1, arg0);
        assert_live(arg1);
        let ThreadParticipantCap {
            id          : v0,
            thread_id   : v1,
            participant : v2,
        } = arg2;
        let v3 = v2;
        assert!(v1 == 0x2::object::id<ThreadState>(arg1), 700);
        let (v4, v5) = index_of_participant(arg1, &v3);
        assert!(v4, 705);
        let v6 = 0x1::vector::remove<0x1::string::String>(&mut arg1.participants, v5);
        assert!(v6 == v3, 700);
        0x2::object::delete(v0);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        arg1.updated_at = v7;
        let v8 = ParticipantChanged{
            thread_obj_id : 0x2::object::id<ThreadState>(arg1),
            thread_id     : arg1.thread_id,
            participant   : v6,
            joined        : false,
            changed_by    : 0x2::tx_context::sender(arg4),
            changed_at    : v7,
        };
        0x2::event::emit<ParticipantChanged>(v8);
    }

    public fun status(arg0: &ThreadState) : u8 {
        arg0.status
    }

    public fun thread_id(arg0: &ThreadState) : 0x1::string::String {
        arg0.thread_id
    }

    public fun topic(arg0: &ThreadState) : 0x1::string::String {
        arg0.topic
    }

    entry fun transition(arg0: &ThreadAdminCap, arg1: &mut ThreadState, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_admin_for_thread(arg1, arg0);
        do_transition(arg1, arg2, arg3, arg4, arg5);
    }

    entry fun transition_as_participant(arg0: &ThreadParticipantCap, arg1: &mut ThreadState, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_participant_for_thread(arg1, arg0);
        do_transition(arg1, arg2, arg3, arg4, arg5);
    }

    public fun updated_at(arg0: &ThreadState) : u64 {
        arg0.updated_at
    }

    public fun workspace_id(arg0: &ThreadState) : 0x1::string::String {
        arg0.workspace_id
    }

    // decompiled from Move bytecode v7
}

