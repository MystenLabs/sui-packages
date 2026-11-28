module 0x70ef396f90534f577634efb6c94380c3c6e465a588fd4824c369a04d24585baf::readers {
    struct Readers has key {
        id: 0x2::object::UID,
        version: u64,
        writer: address,
        accounts: 0x2::vec_set::VecSet<address>,
        members: 0x2::vec_set::VecSet<address>,
        files: 0x2::table::Table<vector<u8>, 0x2::vec_set::VecSet<address>>,
        viewers: 0x2::vec_map::VecMap<address, Viewer>,
    }

    struct Viewer has copy, drop, store {
        added_by: address,
        expires_ms: u64,
    }

    struct ReadersCreated has copy, drop {
        readers_id: 0x2::object::ID,
        account: address,
        writer: address,
    }

    struct AccountAdded has copy, drop {
        readers_id: 0x2::object::ID,
        account: address,
    }

    struct MemberAdded has copy, drop {
        readers_id: 0x2::object::ID,
        member: address,
    }

    struct MemberRemoved has copy, drop {
        readers_id: 0x2::object::ID,
        member: address,
    }

    struct FileReaderAdded has copy, drop {
        readers_id: 0x2::object::ID,
        sha256: vector<u8>,
        reader: address,
    }

    struct FileReaderRemoved has copy, drop {
        readers_id: 0x2::object::ID,
        sha256: vector<u8>,
        reader: address,
    }

    struct FileForgotten has copy, drop {
        readers_id: 0x2::object::ID,
        sha256: vector<u8>,
    }

    struct WriterChanged has copy, drop {
        readers_id: 0x2::object::ID,
        writer: address,
    }

    struct ViewerAdded has copy, drop {
        readers_id: 0x2::object::ID,
        viewer: address,
        added_by: address,
        expires_ms: u64,
    }

    struct ViewerRemoved has copy, drop {
        readers_id: 0x2::object::ID,
        viewer: address,
        by: address,
    }

    public fun add_account(arg0: &mut Readers, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg2);
        if (0x2::vec_set::contains<address>(&arg0.accounts, &arg1)) {
            return
        };
        assert!(0x2::vec_set::length<address>(&arg0.accounts) < 32, 4);
        0x2::vec_set::insert<address>(&mut arg0.accounts, arg1);
        let v0 = AccountAdded{
            readers_id : 0x2::object::id<Readers>(arg0),
            account    : arg1,
        };
        0x2::event::emit<AccountAdded>(v0);
    }

    public fun add_file_reader(arg0: &mut Readers, arg1: vector<u8>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg3);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.files, arg1)) {
            0x2::table::add<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.files, arg1, 0x2::vec_set::empty<address>());
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.files, arg1);
        if (0x2::vec_set::contains<address>(v0, &arg2)) {
            return
        };
        assert!(0x2::vec_set::length<address>(v0) < 32, 4);
        0x2::vec_set::insert<address>(v0, arg2);
        let v1 = FileReaderAdded{
            readers_id : 0x2::object::id<Readers>(arg0),
            sha256     : arg1,
            reader     : arg2,
        };
        0x2::event::emit<FileReaderAdded>(v1);
    }

    public fun add_member(arg0: &mut Readers, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg2);
        add_member_inner(arg0, arg1);
    }

    fun add_member_inner(arg0: &mut Readers, arg1: address) {
        if (0x2::vec_set::contains<address>(&arg0.members, &arg1)) {
            return
        };
        assert!(0x2::vec_set::length<address>(&arg0.members) < 32, 4);
        0x2::vec_set::insert<address>(&mut arg0.members, arg1);
        let v0 = MemberAdded{
            readers_id : 0x2::object::id<Readers>(arg0),
            member     : arg1,
        };
        0x2::event::emit<MemberAdded>(v0);
    }

    public fun add_viewer(arg0: &mut Readers, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > v1 && arg2 <= v1 + 2678400000, 6);
        if (0x2::vec_map::contains<address, Viewer>(&arg0.viewers, &arg1)) {
            let v2 = Viewer{
                added_by   : v0,
                expires_ms : arg2,
            };
            *0x2::vec_map::get_mut<address, Viewer>(&mut arg0.viewers, &arg1) = v2;
        } else {
            assert!(0x2::vec_map::length<address, Viewer>(&arg0.viewers) < 32, 4);
            let v3 = Viewer{
                added_by   : v0,
                expires_ms : arg2,
            };
            0x2::vec_map::insert<address, Viewer>(&mut arg0.viewers, arg1, v3);
        };
        let v4 = ViewerAdded{
            readers_id : 0x2::object::id<Readers>(arg0),
            viewer     : arg1,
            added_by   : v0,
            expires_ms : arg2,
        };
        0x2::event::emit<ViewerAdded>(v4);
    }

    public fun can_open_as_preparer(arg0: &Readers, arg1: vector<u8>, arg2: address) : bool {
        0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.files, arg1) && 0x2::vec_set::contains<address>(0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.files, arg1), &arg2)
    }

    fun check_identity(arg0: &vector<u8>, arg1: &Readers) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 65, 0);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 1, 0);
        let v0 = 0x2::object::id<Readers>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0;
        while (v2 < 32) {
            assert!(*0x1::vector::borrow<u8>(arg0, 1 + v2) == *0x1::vector::borrow<u8>(&v1, v2), 0);
            v2 = v2 + 1;
        };
        let v3 = b"";
        let v4 = 33;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg0, v4));
            v4 = v4 + 1;
        };
        v3
    }

    fun check_writer(arg0: &Readers, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.writer, 1);
    }

    public fun create(arg0: address, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Readers{
            id       : 0x2::object::new(arg2),
            version  : 1,
            writer   : 0x2::tx_context::sender(arg2),
            accounts : 0x2::vec_set::singleton<address>(arg0),
            members  : 0x2::vec_set::empty<address>(),
            files    : 0x2::table::new<vector<u8>, 0x2::vec_set::VecSet<address>>(arg2),
            viewers  : 0x2::vec_map::empty<address, Viewer>(),
        };
        let v1 = 0x2::object::id<Readers>(&v0);
        let v2 = ReadersCreated{
            readers_id : v1,
            account    : arg0,
            writer     : v0.writer,
        };
        0x2::event::emit<ReadersCreated>(v2);
        0x1::vector::reverse<address>(&mut arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            let v4 = &mut v0;
            add_member_inner(v4, 0x1::vector::pop_back<address>(&mut arg1));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        0x2::transfer::share_object<Readers>(v0);
        v1
    }

    public fun forget_file(arg0: &mut Readers, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg2);
        if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.files, arg1)) {
            return
        };
        0x2::table::remove<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.files, arg1);
        let v0 = FileForgotten{
            readers_id : 0x2::object::id<Readers>(arg0),
            sha256     : arg1,
        };
        0x2::event::emit<FileForgotten>(v0);
    }

    public fun has_account(arg0: &Readers, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.accounts, &arg1)
    }

    public fun identity(arg0: &Readers, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        let v1 = 0x2::object::id<Readers>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    public fun is_member(arg0: &Readers, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun migrate(arg0: &mut Readers, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.writer, 1);
        assert!(arg0.version < 1, 2);
        arg0.version = 1;
    }

    public fun remove_file_reader(arg0: &mut Readers, arg1: vector<u8>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg3);
        if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.files, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.files, arg1);
        if (!0x2::vec_set::contains<address>(v0, &arg2)) {
            return
        };
        0x2::vec_set::remove<address>(v0, &arg2);
        let v1 = FileReaderRemoved{
            readers_id : 0x2::object::id<Readers>(arg0),
            sha256     : arg1,
            reader     : arg2,
        };
        0x2::event::emit<FileReaderRemoved>(v1);
    }

    public fun remove_member(arg0: &mut Readers, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg2);
        if (!0x2::vec_set::contains<address>(&arg0.members, &arg1)) {
            return
        };
        0x2::vec_set::remove<address>(&mut arg0.members, &arg1);
        let v0 = MemberRemoved{
            readers_id : 0x2::object::id<Readers>(arg0),
            member     : arg1,
        };
        0x2::event::emit<MemberRemoved>(v0);
    }

    public fun remove_viewer(arg0: &mut Readers, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (0x2::vec_set::contains<address>(&arg0.members, &v0)) {
            true
        } else if (v0 == arg0.writer) {
            true
        } else {
            v0 == arg1
        };
        assert!(v1, 5);
        if (!0x2::vec_map::contains<address, Viewer>(&arg0.viewers, &arg1)) {
            return
        };
        let (_, _) = 0x2::vec_map::remove<address, Viewer>(&mut arg0.viewers, &arg1);
        let v4 = ViewerRemoved{
            readers_id : 0x2::object::id<Readers>(arg0),
            viewer     : arg1,
            by         : v0,
        };
        0x2::event::emit<ViewerRemoved>(v4);
    }

    entry fun seal_approve_member(arg0: vector<u8>, arg1: &Readers, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        check_identity(&arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v0), 0);
    }

    entry fun seal_approve_preparer(arg0: vector<u8>, arg1: &Readers, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        let v0 = check_identity(&arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::agent(arg2) == v1, 0);
        assert!(!0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::revoked(arg2), 0);
        let v2 = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::owner(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.accounts, &v2), 0);
        assert!(0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.files, v0), 0);
        assert!(0x2::vec_set::contains<address>(0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.files, v0), &v1), 0);
    }

    entry fun seal_approve_viewer(arg0: vector<u8>, arg1: &Readers, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        check_identity(&arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_map::contains<address, Viewer>(&arg1.viewers, &v0), 0);
        let v1 = *0x2::vec_map::get<address, Viewer>(&arg1.viewers, &v0);
        assert!(0x2::clock::timestamp_ms(arg2) < v1.expires_ms, 0);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v1.added_by), 0);
    }

    public fun set_writer(arg0: &mut Readers, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_writer(arg0, arg2);
        arg0.writer = arg1;
        let v0 = WriterChanged{
            readers_id : 0x2::object::id<Readers>(arg0),
            writer     : arg1,
        };
        0x2::event::emit<WriterChanged>(v0);
    }

    public fun version(arg0: &Readers) : u64 {
        arg0.version
    }

    public fun viewer_expires_ms(arg0: &Readers, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, Viewer>(&arg0.viewers, &arg1)) {
            0x2::vec_map::get<address, Viewer>(&arg0.viewers, &arg1).expires_ms
        } else {
            0
        }
    }

    public fun writer(arg0: &Readers) : address {
        arg0.writer
    }

    // decompiled from Move bytecode v7
}

