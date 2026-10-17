module 0x70d5c0da707049a26d2a7a90553a67075aa06512f6860c70e9ebd516abf83ee8::library {
    struct Library has key {
        id: 0x2::object::UID,
        owner: address,
        devices: 0x2::vec_set::VecSet<address>,
        header: vector<u8>,
        header_revision: u64,
        revision: u64,
        entry_count: u64,
        object_count: u64,
    }

    struct EntryKey has copy, drop, store {
        id: vector<u8>,
    }

    struct Entry has drop, store {
        revision: u64,
        data: vector<u8>,
    }

    struct ObjectKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct LibraryCreated has copy, drop {
        library: 0x2::object::ID,
        owner: address,
    }

    struct EntryChanged has copy, drop {
        library: 0x2::object::ID,
        entry: vector<u8>,
        revision: u64,
        deleted: bool,
        by: address,
    }

    struct HeaderChanged has copy, drop {
        library: 0x2::object::ID,
        header_revision: u64,
        by: address,
    }

    struct DeviceChanged has copy, drop {
        library: 0x2::object::ID,
        device: address,
        added: bool,
    }

    struct ObjectChanged has copy, drop {
        library: 0x2::object::ID,
        object: 0x2::object::ID,
        held: bool,
        by: address,
    }

    struct Recoveries has key {
        id: 0x2::object::UID,
        libraries: 0x2::table::Table<0x2::object::ID, Recovery>,
    }

    struct Recovery has store {
        public_key: vector<u8>,
        delay_ms: u64,
        nonce: u64,
        request: 0x1::option::Option<RecoveryRequest>,
    }

    struct RecoveryRequest has copy, drop, store {
        new_owner: address,
        requested_ms: u64,
        ready_ms: u64,
    }

    struct RecoverySet has copy, drop {
        library: 0x2::object::ID,
        delay_ms: u64,
    }

    struct RecoveryRequested has copy, drop {
        library: 0x2::object::ID,
        new_owner: address,
        ready_ms: u64,
    }

    struct RecoveryCancelled has copy, drop {
        library: 0x2::object::ID,
        by: address,
    }

    struct RecoveryCompleted has copy, drop {
        library: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    public fun add_device(arg0: &mut Library, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        if (!0x2::vec_set::contains<address>(&arg0.devices, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.devices, arg1);
        };
        let v0 = DeviceChanged{
            library : 0x2::object::id<Library>(arg0),
            device  : arg1,
            added   : true,
        };
        0x2::event::emit<DeviceChanged>(v0);
    }

    fun assert_device(arg0: &Library, arg1: address) {
        assert!(arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.devices, &arg1), 1);
    }

    fun assert_owner(arg0: &Library, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun cancel_recovery(arg0: &mut Recoveries, arg1: &Library, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Library>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.libraries, v0), 8);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, v0);
        assert!(0x1::option::is_some<RecoveryRequest>(&v1.request), 11);
        if (0x2::tx_context::sender(arg2) == 0x1::option::borrow<RecoveryRequest>(&v1.request).new_owner) {
            v1.request = 0x1::option::none<RecoveryRequest>();
            let v2 = RecoveryCancelled{
                library : v0,
                by      : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<RecoveryCancelled>(v2);
            return
        } else {
            abort if (0x2::tx_context::sender(arg2) == arg1.owner) {
                16
            } else {
                0
            }
        };
    }

    public fun cancel_recovery_signed(arg0: &mut Recoveries, arg1: &Library, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg3);
        let v0 = 0x2::object::id<Library>(arg1);
        check_owner_signature(arg0, v0, 3, b"", &arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, v0);
        assert!(0x1::option::is_some<RecoveryRequest>(&v1.request), 11);
        v1.request = 0x1::option::none<RecoveryRequest>();
        let v2 = RecoveryCancelled{
            library : v0,
            by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RecoveryCancelled>(v2);
    }

    fun check_header(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0 && 0x1::vector::length<u8>(arg0) <= 2048, 5);
    }

    fun check_owner_signature(arg0: &mut Recoveries, arg1: 0x2::object::ID, arg2: u8, arg3: vector<u8>, arg4: &vector<u8>) {
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.libraries, arg1), 8);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, arg1);
        let v1 = owner_message(arg1, arg2, arg3, v0.nonce);
        assert!(0x2::ed25519::ed25519_verify(arg4, &v0.public_key, &v1), 15);
        v0.nonce = v0.nonce + 1;
    }

    public fun complete_recovery(arg0: &mut Recoveries, arg1: &mut Library, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Library>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.libraries, v0), 8);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, v0);
        assert!(0x1::option::is_some<RecoveryRequest>(&v1.request), 11);
        let v2 = *0x1::option::borrow<RecoveryRequest>(&v1.request);
        assert!(0x2::tx_context::sender(arg3) == v2.new_owner, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.ready_ms, 12);
        v1.request = 0x1::option::none<RecoveryRequest>();
        let v3 = arg1.owner;
        if (0x2::vec_set::contains<address>(&arg1.devices, &v3)) {
            0x2::vec_set::remove<address>(&mut arg1.devices, &v3);
        };
        if (!0x2::vec_set::contains<address>(&arg1.devices, &v2.new_owner)) {
            0x2::vec_set::insert<address>(&mut arg1.devices, v2.new_owner);
        };
        arg1.owner = v2.new_owner;
        let v4 = DeviceChanged{
            library : v0,
            device  : v3,
            added   : false,
        };
        0x2::event::emit<DeviceChanged>(v4);
        let v5 = RecoveryCompleted{
            library   : v0,
            old_owner : v3,
            new_owner : v2.new_owner,
        };
        0x2::event::emit<RecoveryCompleted>(v5);
    }

    public fun create_library(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        share_library(new_library(arg0, arg1));
    }

    public fun create_recoveries(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Recoveries{
            id        : 0x2::object::new(arg0),
            libraries : 0x2::table::new<0x2::object::ID, Recovery>(arg0),
        };
        0x2::transfer::share_object<Recoveries>(v0);
    }

    public fun delete_entry(arg0: &mut Library, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg3));
        let v0 = EntryKey{id: arg1};
        assert!(0x2::dynamic_field::exists<EntryKey>(&arg0.id, v0), 6);
        let Entry {
            revision : v1,
            data     : _,
        } = 0x2::dynamic_field::remove<EntryKey, Entry>(&mut arg0.id, v0);
        assert!(v1 == arg2, 2);
        arg0.revision = arg0.revision + 1;
        arg0.entry_count = arg0.entry_count - 1;
        let v3 = EntryChanged{
            library  : 0x2::object::id<Library>(arg0),
            entry    : arg1,
            revision : arg0.revision,
            deleted  : true,
            by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EntryChanged>(v3);
    }

    public fun entry_count(arg0: &Library) : u64 {
        arg0.entry_count
    }

    public fun entry_revision(arg0: &Library, arg1: vector<u8>) : u64 {
        let v0 = EntryKey{id: arg1};
        if (!0x2::dynamic_field::exists<EntryKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<EntryKey, Entry>(&arg0.id, v0).revision
    }

    public fun header(arg0: &Library) : vector<u8> {
        arg0.header
    }

    public fun header_revision(arg0: &Library) : u64 {
        arg0.header_revision
    }

    public fun hold<T0: store + key>(arg0: &mut Library, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = ObjectKey{id: v0};
        0x2::dynamic_object_field::add<ObjectKey, T0>(&mut arg0.id, v1, arg1);
        arg0.object_count = arg0.object_count + 1;
        let v2 = ObjectChanged{
            library : 0x2::object::id<Library>(arg0),
            object  : v0,
            held    : true,
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ObjectChanged>(v2);
    }

    public fun holds(arg0: &Library, arg1: 0x2::object::ID) : bool {
        let v0 = ObjectKey{id: arg1};
        0x2::dynamic_object_field::exists<ObjectKey>(&arg0.id, v0)
    }

    public fun is_device(arg0: &Library, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.devices, &arg1)
    }

    public fun new_library(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Library {
        check_header(&arg0);
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg1));
        let v1 = Library{
            id              : 0x2::object::new(arg1),
            owner           : 0x2::tx_context::sender(arg1),
            devices         : v0,
            header          : arg0,
            header_revision : 1,
            revision        : 0,
            entry_count     : 0,
            object_count    : 0,
        };
        let v2 = LibraryCreated{
            library : 0x2::object::id<Library>(&v1),
            owner   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<LibraryCreated>(v2);
        v1
    }

    public fun object_count(arg0: &Library) : u64 {
        arg0.object_count
    }

    public fun owner(arg0: &Library) : address {
        arg0.owner
    }

    public fun owner_message(arg0: 0x2::object::ID, arg1: u8, arg2: vector<u8>, arg3: u64) : vector<u8> {
        let v0 = b"suinote-owner-v1";
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    public fun put_entry(arg0: &mut Library, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x1::vector::length<u8>(&arg1) == 16, 4);
        assert!(0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg3) <= 15000, 3);
        let v0 = EntryKey{id: arg1};
        arg0.revision = arg0.revision + 1;
        let v1 = arg0.revision;
        if (0x2::dynamic_field::exists<EntryKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<EntryKey, Entry>(&mut arg0.id, v0);
            assert!(v2.revision == arg2, 2);
            v2.revision = v1;
            v2.data = arg3;
        } else {
            assert!(arg2 == 0, 2);
            let v3 = Entry{
                revision : v1,
                data     : arg3,
            };
            0x2::dynamic_field::add<EntryKey, Entry>(&mut arg0.id, v0, v3);
            arg0.entry_count = arg0.entry_count + 1;
        };
        let v4 = EntryChanged{
            library  : 0x2::object::id<Library>(arg0),
            entry    : arg1,
            revision : v1,
            deleted  : false,
            by       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EntryChanged>(v4);
    }

    public fun recovery_message(arg0: 0x2::object::ID, arg1: address, arg2: u64) : vector<u8> {
        let v0 = b"suinote-recovery-v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun remove_device(arg0: &mut Library, arg1: address, arg2: &0x2::tx_context::TxContext) {
        abort 16
    }

    public fun remove_device_signed(arg0: &mut Recoveries, arg1: &mut Library, arg2: address, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg4);
        check_owner_signature(arg0, 0x2::object::id<Library>(arg1), 2, 0x2::bcs::to_bytes<address>(&arg2), &arg3);
        if (0x2::vec_set::contains<address>(&arg1.devices, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.devices, &arg2);
        };
        let v0 = DeviceChanged{
            library : 0x2::object::id<Library>(arg1),
            device  : arg2,
            added   : false,
        };
        0x2::event::emit<DeviceChanged>(v0);
    }

    public fun request_recovery(arg0: &mut Recoveries, arg1: &Library, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Library>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.libraries, v0), 8);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, v0);
        assert!(0x1::option::is_none<RecoveryRequest>(&v1.request), 9);
        let v2 = recovery_message(v0, 0x2::tx_context::sender(arg4), v1.nonce);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v1.public_key, &v2), 10);
        start_request(v1, v0, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3));
    }

    public fun revision(arg0: &Library) : u64 {
        arg0.revision
    }

    public fun rotate_recovery_key(arg0: &mut Recoveries, arg1: &Library, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13);
        let v0 = 0x2::object::id<Library>(arg1);
        check_owner_signature(arg0, v0, 5, 0x2::bcs::to_bytes<vector<u8>>(&arg2), &arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, v0);
        v1.public_key = arg2;
        let v2 = RecoverySet{
            library  : v0,
            delay_ms : v1.delay_ms,
        };
        0x2::event::emit<RecoverySet>(v2);
    }

    public fun set_header(arg0: &mut Library, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg3));
        check_header(&arg2);
        assert!(arg0.header_revision == arg1, 2);
        arg0.header = arg2;
        arg0.header_revision = arg0.header_revision + 1;
        arg0.revision = arg0.revision + 1;
        let v0 = HeaderChanged{
            library         : 0x2::object::id<Library>(arg0),
            header_revision : arg0.header_revision,
            by              : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<HeaderChanged>(v0);
    }

    public fun set_recovery(arg0: &mut Recoveries, arg1: &Library, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg4);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13);
        assert!(arg3 >= 60000 && arg3 <= 2592000000, 14);
        let v0 = 0x2::object::id<Library>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, Recovery>(&arg0.libraries, v0), 16);
        let v1 = Recovery{
            public_key : arg2,
            delay_ms   : arg3,
            nonce      : 0,
            request    : 0x1::option::none<RecoveryRequest>(),
        };
        0x2::table::add<0x2::object::ID, Recovery>(&mut arg0.libraries, v0, v1);
        let v2 = RecoverySet{
            library  : v0,
            delay_ms : arg3,
        };
        0x2::event::emit<RecoverySet>(v2);
    }

    public fun set_recovery_delay(arg0: &mut Recoveries, arg1: &Library, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg4);
        assert!(arg2 >= 60000 && arg2 <= 2592000000, 14);
        let v0 = 0x2::object::id<Library>(arg1);
        check_owner_signature(arg0, v0, 4, 0x2::bcs::to_bytes<u64>(&arg2), &arg3);
        0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.libraries, v0).delay_ms = arg2;
        let v1 = RecoverySet{
            library  : v0,
            delay_ms : arg2,
        };
        0x2::event::emit<RecoverySet>(v1);
    }

    public fun share_library(arg0: Library) {
        0x2::transfer::share_object<Library>(arg0);
    }

    fun start_request(arg0: &mut Recovery, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        arg0.nonce = arg0.nonce + 1;
        let v0 = arg3 + arg0.delay_ms;
        let v1 = RecoveryRequest{
            new_owner    : arg2,
            requested_ms : arg3,
            ready_ms     : v0,
        };
        arg0.request = 0x1::option::some<RecoveryRequest>(v1);
        let v2 = RecoveryRequested{
            library   : arg1,
            new_owner : arg2,
            ready_ms  : v0,
        };
        0x2::event::emit<RecoveryRequested>(v2);
    }

    public fun take<T0: store + key>(arg0: &mut Library, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_device(arg0, 0x2::tx_context::sender(arg2));
        let v0 = ObjectKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<ObjectKey, T0>(&arg0.id, v0), 7);
        arg0.object_count = arg0.object_count - 1;
        let v1 = ObjectChanged{
            library : 0x2::object::id<Library>(arg0),
            object  : arg1,
            held    : false,
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ObjectChanged>(v1);
        0x2::dynamic_object_field::remove<ObjectKey, T0>(&mut arg0.id, v0)
    }

    public fun transfer_owner(arg0: &mut Library, arg1: address, arg2: &0x2::tx_context::TxContext) {
        abort 16
    }

    public fun transfer_owner_signed(arg0: &mut Recoveries, arg1: &mut Library, arg2: address, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg4);
        check_owner_signature(arg0, 0x2::object::id<Library>(arg1), 1, 0x2::bcs::to_bytes<address>(&arg2), &arg3);
        arg1.owner = arg2;
    }

    // decompiled from Move bytecode v7
}

