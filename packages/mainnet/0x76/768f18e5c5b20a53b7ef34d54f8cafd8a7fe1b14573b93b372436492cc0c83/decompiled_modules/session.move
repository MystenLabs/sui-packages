module 0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session {
    struct Session has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        members: 0x2::vec_set::VecSet<address>,
        shared_nodes: 0x2::vec_set::VecSet<vector<u8>>,
        head_blob: 0x1::string::String,
        head_version: u64,
        event_blob: 0x1::string::String,
        end_epoch: u64,
        revoked: 0x2::vec_set::VecSet<address>,
    }

    struct SessionCap has store, key {
        id: 0x2::object::UID,
        session: 0x2::object::ID,
    }

    struct SessionChanged has copy, drop {
        session: 0x2::object::ID,
        version: u64,
    }

    struct MemberChanged has copy, drop {
        session: 0x2::object::ID,
        member: address,
        added: bool,
    }

    public entry fun add_member(arg0: &SessionCap, arg1: &mut Session, arg2: address) {
        assert_cap(arg0, arg1);
        if (!0x2::vec_set::contains<address>(&arg1.members, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.members, arg2);
            if (0x2::vec_set::contains<address>(&arg1.revoked, &arg2)) {
                0x2::vec_set::remove<address>(&mut arg1.revoked, &arg2);
            };
            let v0 = MemberChanged{
                session : 0x2::object::id<Session>(arg1),
                member  : arg2,
                added   : true,
            };
            0x2::event::emit<MemberChanged>(v0);
        };
    }

    fun assert_cap(arg0: &SessionCap, arg1: &Session) {
        assert!(arg0.session == 0x2::object::id<Session>(arg1), 5);
    }

    public entry fun create_session(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = Session{
            id           : 0x2::object::new(arg2),
            name         : arg0,
            owner        : v0,
            members      : v1,
            shared_nodes : 0x2::vec_set::empty<vector<u8>>(),
            head_blob    : 0x1::string::utf8(b""),
            head_version : 0,
            event_blob   : 0x1::string::utf8(b""),
            end_epoch    : arg1,
            revoked      : 0x2::vec_set::empty<address>(),
        };
        let v3 = SessionCap{
            id      : 0x2::object::new(arg2),
            session : 0x2::object::id<Session>(&v2),
        };
        0x2::transfer::transfer<SessionCap>(v3, v0);
        0x2::transfer::share_object<Session>(v2);
    }

    public fun end_epoch(arg0: &Session) : u64 {
        arg0.end_epoch
    }

    public fun event_blob(arg0: &Session) : 0x1::string::String {
        arg0.event_blob
    }

    fun has_session_prefix(arg0: &Session, arg1: &vector<u8>) : bool {
        let v0 = 0x2::object::id<Session>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        if (0x1::vector::length<u8>(arg1) < 0x1::vector::length<u8>(&v1)) {
            return false
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(arg1, v2) != *0x1::vector::borrow<u8>(&v1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun head_blob(arg0: &Session) : 0x1::string::String {
        arg0.head_blob
    }

    public fun head_version(arg0: &Session) : u64 {
        arg0.head_version
    }

    public fun is_member(arg0: &Session, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun is_shared(arg0: &Session, arg1: vector<u8>) : bool {
        0x2::vec_set::contains<vector<u8>>(&arg0.shared_nodes, &arg1)
    }

    public fun member_count(arg0: &Session) : u64 {
        0x2::vec_set::length<address>(&arg0.members)
    }

    public entry fun remove_member(arg0: &SessionCap, arg1: &mut Session, arg2: address) {
        assert_cap(arg0, arg1);
        assert!(arg2 != arg1.owner, 1);
        if (0x2::vec_set::contains<address>(&arg1.members, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.members, &arg2);
            if (!0x2::vec_set::contains<address>(&arg1.revoked, &arg2)) {
                0x2::vec_set::insert<address>(&mut arg1.revoked, arg2);
            };
            let v0 = MemberChanged{
                session : 0x2::object::id<Session>(arg1),
                member  : arg2,
                added   : false,
            };
            0x2::event::emit<MemberChanged>(v0);
        };
    }

    public fun renew(arg0: &SessionCap, arg1: &mut Session, arg2: u64) {
        assert_cap(arg0, arg1);
        arg1.end_epoch = arg2;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Session, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v0), 1);
        assert!(has_session_prefix(arg1, &arg0), 3);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg1.shared_nodes, &arg0), 2);
    }

    public fun set_event_blob(arg0: &mut Session, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 1);
        arg0.event_blob = arg1;
    }

    public entry fun set_head(arg0: &mut Session, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 1);
        assert!(arg2 > arg0.head_version, 4);
        arg0.head_blob = arg1;
        arg0.head_version = arg2;
        let v1 = SessionChanged{
            session : 0x2::object::id<Session>(arg0),
            version : arg2,
        };
        0x2::event::emit<SessionChanged>(v1);
    }

    public entry fun share_node(arg0: &mut Session, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 1);
        assert!(has_session_prefix(arg0, &arg1), 3);
        if (!0x2::vec_set::contains<vector<u8>>(&arg0.shared_nodes, &arg1)) {
            0x2::vec_set::insert<vector<u8>>(&mut arg0.shared_nodes, arg1);
        };
    }

    public entry fun unshare_node(arg0: &SessionCap, arg1: &mut Session, arg2: vector<u8>) {
        assert_cap(arg0, arg1);
        if (0x2::vec_set::contains<vector<u8>>(&arg1.shared_nodes, &arg2)) {
            0x2::vec_set::remove<vector<u8>>(&mut arg1.shared_nodes, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

