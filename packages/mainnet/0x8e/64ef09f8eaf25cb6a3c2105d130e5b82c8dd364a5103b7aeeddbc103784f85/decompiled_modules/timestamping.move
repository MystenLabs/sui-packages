module 0x8e64ef09f8eaf25cb6a3c2105d130e5b82c8dd364a5103b7aeeddbc103784f85::timestamping {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WorkerCap has store, key {
        id: 0x2::object::UID,
    }

    struct WorkerRegistry has key {
        id: 0x2::object::UID,
        authorized_workers: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct FileTimestamping has store, key {
        id: 0x2::object::UID,
        timestamping_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        hash_algorithm: 0x1::string::String,
        timestamp: u64,
    }

    struct TimestampCreated has copy, drop {
        timestamping_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        hash_algorithm: 0x1::string::String,
        timestamp: u64,
        object_id: 0x2::object::ID,
    }

    struct AuthorizationChanged has copy, drop {
        worker: address,
        status: bool,
    }

    public fun authorize_worker(arg0: &AdminCap, arg1: &mut WorkerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerCap{id: 0x2::object::new(arg3)};
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.authorized_workers, arg2, 0x2::object::id<WorkerCap>(&v0));
        0x2::transfer::transfer<WorkerCap>(v0, arg2);
        let v1 = AuthorizationChanged{
            worker : arg2,
            status : true,
        };
        0x2::event::emit<AuthorizationChanged>(v1);
    }

    public fun contains_worker(arg0: &WorkerRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.authorized_workers, arg1)
    }

    public fun create_timestamping(arg0: &WorkerCap, arg1: &WorkerRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.authorized_workers, v0), 3);
        assert!(0x2::object::id<WorkerCap>(arg0) == *0x2::table::borrow<address, 0x2::object::ID>(&arg1.authorized_workers, v0), 4);
        let v1 = 0x1::string::length(&arg2);
        assert!(v1 > 0, 2);
        assert!(v1 <= 256, 1);
        let v2 = 0x1::string::length(&arg3);
        assert!(v2 > 0, 0);
        assert!(v2 <= 256, 1);
        assert!(0x1::string::length(&arg4) <= 256, 1);
        let v3 = FileTimestamping{
            id              : 0x2::object::new(arg6),
            timestamping_id : arg2,
            file_hash       : arg3,
            hash_algorithm  : arg4,
            timestamp       : arg5,
        };
        let v4 = TimestampCreated{
            timestamping_id : v3.timestamping_id,
            file_hash       : v3.file_hash,
            hash_algorithm  : v3.hash_algorithm,
            timestamp       : v3.timestamp,
            object_id       : 0x2::object::id<FileTimestamping>(&v3),
        };
        0x2::event::emit<TimestampCreated>(v4);
        0x2::transfer::transfer<FileTimestamping>(v3, v0);
    }

    public fun destroy_revoked_cap(arg0: WorkerCap, arg1: &WorkerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.authorized_workers, v0) || *0x2::table::borrow<address, 0x2::object::ID>(&arg1.authorized_workers, v0) != 0x2::object::id<WorkerCap>(&arg0), 5);
        let WorkerCap { id: v1 } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_file_hash(arg0: &FileTimestamping) : 0x1::string::String {
        arg0.file_hash
    }

    public fun get_registered_cap_id(arg0: &WorkerRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.authorized_workers, arg1)
    }

    public fun get_timestamp(arg0: &FileTimestamping) : u64 {
        arg0.timestamp
    }

    public fun get_timestamping_id(arg0: &FileTimestamping) : 0x1::string::String {
        arg0.timestamping_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = WorkerRegistry{
            id                 : 0x2::object::new(arg0),
            authorized_workers : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<WorkerRegistry>(v1);
    }

    public fun revoke_worker(arg0: &AdminCap, arg1: &mut WorkerRegistry, arg2: address) {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.authorized_workers, arg2), 3);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg1.authorized_workers, arg2);
        let v0 = AuthorizationChanged{
            worker : arg2,
            status : false,
        };
        0x2::event::emit<AuthorizationChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

