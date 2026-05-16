module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions {
    struct Session has store, key {
        id: 0x2::object::UID,
        creator: address,
        metadata_blob_id: u256,
        title: 0x1::string::String,
        template_kind: u8,
        form_ids: vector<0x2::object::ID>,
        poll_ids: vector<0x2::object::ID>,
        co_organizers: vector<address>,
        start_at: u64,
        end_at: u64,
        attendance_count: u64,
        is_live: bool,
        archived: bool,
        created_at: u64,
    }

    struct SessionCreated has copy, drop {
        session_id: 0x2::object::ID,
        creator: address,
        template_kind: u8,
    }

    struct SessionUpdated has copy, drop {
        session_id: 0x2::object::ID,
    }

    struct OrganizerAdded has copy, drop {
        session_id: 0x2::object::ID,
        organizer: address,
    }

    struct OrganizerRemoved has copy, drop {
        session_id: 0x2::object::ID,
        organizer: address,
    }

    struct SessionLiveToggled has copy, drop {
        session_id: 0x2::object::ID,
        is_live: bool,
    }

    struct SessionArchived has copy, drop {
        session_id: 0x2::object::ID,
    }

    struct FormAttachedToSession has copy, drop {
        session_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
    }

    struct PollAttachedToSession has copy, drop {
        session_id: 0x2::object::ID,
        poll_id: 0x2::object::ID,
    }

    public fun add_organizer(arg0: &mut Session, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        assert!(!is_organizer_of(arg0, arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.co_organizers, arg1);
        let v0 = OrganizerAdded{
            session_id : 0x2::object::id<Session>(arg0),
            organizer  : arg1,
        };
        0x2::event::emit<OrganizerAdded>(v0);
    }

    public fun archive(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        arg0.archived = true;
        arg0.is_live = false;
        let v0 = SessionArchived{session_id: 0x2::object::id<Session>(arg0)};
        0x2::event::emit<SessionArchived>(v0);
    }

    public fun assert_can_admin(arg0: &Session, arg1: address) {
        assert!(can_admin(arg0, arg1), 1);
    }

    public(friend) fun attach_form(arg0: &mut Session, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.form_ids, arg1);
        let v0 = FormAttachedToSession{
            session_id : 0x2::object::id<Session>(arg0),
            form_id    : arg1,
        };
        0x2::event::emit<FormAttachedToSession>(v0);
    }

    public(friend) fun attach_poll(arg0: &mut Session, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.poll_ids, arg1);
        let v0 = PollAttachedToSession{
            session_id : 0x2::object::id<Session>(arg0),
            poll_id    : arg1,
        };
        0x2::event::emit<PollAttachedToSession>(v0);
    }

    public fun attendance_count(arg0: &Session) : u64 {
        arg0.attendance_count
    }

    public(friend) fun bump_attendance(arg0: &mut Session) {
        arg0.attendance_count = arg0.attendance_count + 1;
    }

    public fun can_admin(arg0: &Session, arg1: address) : bool {
        arg1 == arg0.creator || is_organizer_of(arg0, arg1)
    }

    public fun co_organizers(arg0: &Session) : &vector<address> {
        &arg0.co_organizers
    }

    public fun create(arg0: 0x1::string::String, arg1: u256, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Session {
        let v0 = Session{
            id               : 0x2::object::new(arg6),
            creator          : 0x2::tx_context::sender(arg6),
            metadata_blob_id : arg1,
            title            : arg0,
            template_kind    : arg2,
            form_ids         : 0x1::vector::empty<0x2::object::ID>(),
            poll_ids         : 0x1::vector::empty<0x2::object::ID>(),
            co_organizers    : 0x1::vector::empty<address>(),
            start_at         : arg3,
            end_at           : arg4,
            attendance_count : 0,
            is_live          : false,
            archived         : false,
            created_at       : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = SessionCreated{
            session_id    : 0x2::object::id<Session>(&v0),
            creator       : 0x2::tx_context::sender(arg6),
            template_kind : arg2,
        };
        0x2::event::emit<SessionCreated>(v1);
        v0
    }

    public fun create_and_share(arg0: 0x1::string::String, arg1: u256, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Session>(create(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun creator(arg0: &Session) : address {
        arg0.creator
    }

    public fun form_ids(arg0: &Session) : &vector<0x2::object::ID> {
        &arg0.form_ids
    }

    public fun is_archived(arg0: &Session) : bool {
        arg0.archived
    }

    public fun is_live(arg0: &Session) : bool {
        arg0.is_live
    }

    public fun is_organizer_of(arg0: &Session, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.co_organizers, &arg1)
    }

    public fun poll_ids(arg0: &Session) : &vector<0x2::object::ID> {
        &arg0.poll_ids
    }

    public fun remove_organizer(arg0: &mut Session, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.co_organizers, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.co_organizers, v1);
        let v2 = OrganizerRemoved{
            session_id : 0x2::object::id<Session>(arg0),
            organizer  : arg1,
        };
        0x2::event::emit<OrganizerRemoved>(v2);
    }

    public fun set_live(arg0: &mut Session, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(can_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(!arg0.archived, 4);
        arg0.is_live = arg1;
        let v0 = SessionLiveToggled{
            session_id : 0x2::object::id<Session>(arg0),
            is_live    : arg1,
        };
        0x2::event::emit<SessionLiveToggled>(v0);
    }

    public fun template_ama() : u8 {
        4
    }

    public fun template_conference() : u8 {
        2
    }

    public fun template_course() : u8 {
        6
    }

    public fun template_custom() : u8 {
        0
    }

    public fun template_dao() : u8 {
        5
    }

    public fun template_hackathon() : u8 {
        1
    }

    public fun template_kind(arg0: &Session) : u8 {
        arg0.template_kind
    }

    public fun template_workshop() : u8 {
        3
    }

    public fun title(arg0: &Session) : &0x1::string::String {
        &arg0.title
    }

    public fun update_metadata(arg0: &mut Session, arg1: u256, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(can_admin(arg0, 0x2::tx_context::sender(arg3)), 1);
        arg0.metadata_blob_id = arg1;
        arg0.title = arg2;
        let v0 = SessionUpdated{session_id: 0x2::object::id<Session>(arg0)};
        0x2::event::emit<SessionUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

