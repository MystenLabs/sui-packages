module 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::pictor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
    }

    struct JobRecord has drop, store {
        owner: address,
        guid: 0x1::string::String,
        user_id: 0x1::string::String,
        job_type_id: u64,
        time_out: u64,
        status: u64,
        estimated_cost: u64,
    }

    struct ItemCreated has copy, drop {
        item: 0x2::object::ID,
        created_at: u64,
    }

    struct WorkerRecord has drop, store {
        owner: address,
        content: 0x1::string::String,
        user_id: 0x1::string::String,
        mac_address: 0x1::string::String,
        status: u64,
        created_at: u64,
    }

    struct CheckerRecord has drop, store {
        owner: address,
        content: 0x1::string::String,
        device_id: 0x1::string::String,
        user_id: u64,
        status: u64,
        created_at: u64,
    }

    struct UserRecord has drop, store {
        owner: address,
        full_name: 0x1::string::String,
        email_address: 0x1::string::String,
        user_role: 0x1::string::String,
        phone_number: 0x1::string::String,
        address: 0x1::string::String,
    }

    struct UserAssetRecord has drop, store {
        owner: address,
        walrus_blob_id: 0x1::string::String,
        user_id: 0x1::string::String,
        file_path: 0x1::string::String,
        file_type: 0x1::string::String,
        file_size: u64,
    }

    struct PICTOR has drop {
        dummy_field: bool,
    }

    struct Service has store, key {
        id: 0x2::object::UID,
        users: 0x2::object_table::ObjectTable<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::User>,
        jobs: 0x2::object_table::ObjectTable<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>,
        workers: 0x2::object_table::ObjectTable<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>,
        checkers: 0x2::object_table::ObjectTable<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>,
        user_assets: 0x2::object_table::ObjectTable<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::UserAsset>,
        name: 0x1::string::String,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PICTOR>, arg1: 0x2::coin::Coin<PICTOR>) {
        0x2::coin::burn<PICTOR>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PICTOR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PICTOR>>(0x2::coin::mint<PICTOR>(arg0, arg1, arg3), arg2);
    }

    public fun get_estimated_cost(arg0: &mut Service, arg1: 0x2::object::ID) : u64 {
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_estimated_cost(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg0.jobs, arg1))
    }

    public fun update_job(arg0: &mut Service, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&arg0.jobs, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::update_job(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg0.jobs, arg1), arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, JobRecord>(&mut arg0.id, arg1);
        v0.user_id = arg2;
        v0.job_type_id = arg3;
        v0.time_out = arg4;
        v0.status = arg5;
        v0.estimated_cost = arg6;
    }

    fun add_checker(arg0: &mut Service, arg1: 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker, arg2: address) {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_id(&arg1);
        0x2::object_table::add<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&mut arg0.checkers, v0, arg1);
        let v1 = CheckerRecord{
            owner      : arg2,
            content    : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_content(&arg1),
            device_id  : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_device_id(&arg1),
            user_id    : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_user_id(&arg1),
            status     : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_status(&arg1),
            created_at : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_created_at(&arg1),
        };
        0x2::dynamic_field::add<0x2::object::ID, CheckerRecord>(&mut arg0.id, v0, v1);
    }

    fun add_job(arg0: &mut Service, arg1: 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job, arg2: address) {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_id(&arg1);
        0x2::object_table::add<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg0.jobs, v0, arg1);
        let v1 = JobRecord{
            owner          : arg2,
            guid           : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_guid(&arg1),
            user_id        : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_user_id(&arg1),
            job_type_id    : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_job_type_id(&arg1),
            time_out       : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_time_out(&arg1),
            status         : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_status(&arg1),
            estimated_cost : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_estimated_cost(&arg1),
        };
        0x2::dynamic_field::add<0x2::object::ID, JobRecord>(&mut arg0.id, v0, v1);
    }

    fun add_user(arg0: &mut Service, arg1: 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::User, arg2: address) {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_id(&arg1);
        0x2::object_table::add<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::User>(&mut arg0.users, v0, arg1);
        let v1 = UserRecord{
            owner         : arg2,
            full_name     : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_user_full_name(&arg1),
            email_address : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_user_email_address(&arg1),
            user_role     : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_user_role(&arg1),
            phone_number  : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_user_phone_number(&arg1),
            address       : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_user_address(&arg1),
        };
        0x2::dynamic_field::add<0x2::object::ID, UserRecord>(&mut arg0.id, v0, v1);
    }

    fun add_user_asset(arg0: &mut Service, arg1: 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::UserAsset, arg2: address) {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_id(&arg1);
        0x2::object_table::add<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::UserAsset>(&mut arg0.user_assets, v0, arg1);
        let v1 = UserAssetRecord{
            owner          : arg2,
            walrus_blob_id : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_walrus_blob_id(&arg1),
            user_id        : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_user_id(&arg1),
            file_path      : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_file_path(&arg1),
            file_type      : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_file_type(&arg1),
            file_size      : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_file_size(&arg1),
        };
        0x2::dynamic_field::add<0x2::object::ID, UserAssetRecord>(&mut arg0.id, v0, v1);
    }

    fun add_worker(arg0: &mut Service, arg1: 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker, arg2: address) {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_id(&arg1);
        0x2::object_table::add<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&mut arg0.workers, v0, arg1);
        let v1 = WorkerRecord{
            owner       : arg2,
            content     : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_content(&arg1),
            user_id     : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_user_id(&arg1),
            mac_address : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_mac_address(&arg1),
            status      : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_status(&arg1),
            created_at  : 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_created_at(&arg1),
        };
        0x2::dynamic_field::add<0x2::object::ID, WorkerRecord>(&mut arg0.id, v0, v1);
    }

    public fun create_new_checker(arg0: &mut Service, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::new(arg1, arg2, arg4, arg3, arg5);
        let v1 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_id(&v0);
        add_checker(arg0, v0, arg1);
        let v2 = ItemCreated{
            item       : v1,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<ItemCreated>(v2);
        v1
    }

    public fun create_new_job(arg0: &mut Service, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::new_job(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_id(&v0);
        add_job(arg0, v0, arg1);
        let v2 = ItemCreated{
            item       : v1,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::event::emit<ItemCreated>(v2);
        v1
    }

    public fun create_new_user(arg0: &mut Service, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::new_user(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::get_id(&v0);
        add_user(arg0, v0, arg1);
        let v2 = ItemCreated{
            item       : v1,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::event::emit<ItemCreated>(v2);
        v1
    }

    public fun create_new_user_asset(arg0: &mut Service, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::new_user_asset(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::get_id(&v0);
        add_user_asset(arg0, v0, arg1);
        let v2 = ItemCreated{
            item       : v1,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::event::emit<ItemCreated>(v2);
        v1
    }

    public fun create_new_worker(arg0: &mut Service, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::new(arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_id(&v0);
        add_worker(arg0, v0, arg1);
        let v2 = ItemCreated{
            item       : v1,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<ItemCreated>(v2);
        v1
    }

    public fun create_service(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Service{
            id          : v0,
            users       : 0x2::object_table::new<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user::User>(arg1),
            jobs        : 0x2::object_table::new<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(arg1),
            workers     : 0x2::object_table::new<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(arg1),
            checkers    : 0x2::object_table::new<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(arg1),
            user_assets : 0x2::object_table::new<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::UserAsset>(arg1),
            name        : arg0,
        };
        let v3 = AdminCap{
            id         : 0x2::object::new(arg1),
            service_id : v1,
        };
        0x2::transfer::transfer<Service>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        v1
    }

    public fun get_checker_status(arg0: &mut Service, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::get_status(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&mut arg0.checkers, arg1))
    }

    public fun get_job(arg0: &mut Service, arg1: 0x2::object::ID) : &JobRecord {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x2::dynamic_field::borrow<0x2::object::ID, JobRecord>(&arg0.id, arg1)
    }

    public fun get_job_status(arg0: &mut Service, arg1: 0x2::object::ID) : u64 {
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::get_status(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg0.jobs, arg1))
    }

    public fun get_service_id(arg0: &Service) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_service_name(arg0: &Service) : 0x1::string::String {
        arg0.name
    }

    public fun get_worker(arg0: &mut Service, arg1: 0x2::object::ID) : &mut WorkerRecord {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, WorkerRecord>(&mut arg0.id, arg1)
    }

    public fun get_worker_status(arg0: &mut Service, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::get_status(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&mut arg0.workers, arg1))
    }

    fun init(arg0: PICTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICTOR>(arg0, 6, b"PICTOR", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICTOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICTOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_checker_exists(arg0: &Service, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&arg0.checkers, arg1)
    }

    public fun is_job_exists(arg0: &Service, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&arg0.jobs, arg1)
    }

    public fun is_worker_exists(arg0: &Service, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&arg0.workers, arg1)
    }

    public fun remove_asset(arg0: &AdminCap, arg1: &mut Service, arg2: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::UserAsset>(&arg1.user_assets, arg2), 3);
        0x2::dynamic_field::remove<0x2::object::ID, UserAssetRecord>(&mut arg1.id, arg2);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::delete_asset(0x2::object_table::remove<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset::UserAsset>(&mut arg1.user_assets, arg2));
    }

    public fun remove_checker(arg0: &AdminCap, arg1: &mut Service, arg2: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&arg1.checkers, arg2), 3);
        0x2::dynamic_field::remove<0x2::object::ID, CheckerRecord>(&mut arg1.id, arg2);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::delete(0x2::object_table::remove<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&mut arg1.checkers, arg2));
    }

    public fun remove_job(arg0: &AdminCap, arg1: &mut Service, arg2: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&arg1.jobs, arg2), 3);
        0x2::dynamic_field::remove<0x2::object::ID, JobRecord>(&mut arg1.id, arg2);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::delete_job(0x2::object_table::remove<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg1.jobs, arg2));
    }

    public fun remove_worker(arg0: &AdminCap, arg1: &mut Service, arg2: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&arg1.workers, arg2), 3);
        0x2::dynamic_field::remove<0x2::object::ID, WorkerRecord>(&mut arg1.id, arg2);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::delete(0x2::object_table::remove<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&mut arg1.workers, arg2));
    }

    public fun set_checker_status(arg0: &mut Service, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&arg0.checkers, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::update_status(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&mut arg0.checkers, arg1), arg2);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, CheckerRecord>(&mut arg0.id, arg1).status = arg2;
    }

    public fun set_estimated_cost(arg0: &mut Service, arg1: 0x2::object::ID, arg2: u64) {
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::update_job_estimated_cost(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg0.jobs, arg1), arg2);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, JobRecord>(&mut arg0.id, arg1).estimated_cost = arg2;
    }

    public fun set_job_status(arg0: &mut Service, arg1: 0x2::object::ID, arg2: u64) {
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::update_job_status(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job::Job>(&mut arg0.jobs, arg1), arg2);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, JobRecord>(&mut arg0.id, arg1).status = arg2;
    }

    public fun set_worker_status(arg0: &mut Service, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&arg0.workers, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::update_status(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&mut arg0.workers, arg1), arg2);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, WorkerRecord>(&mut arg0.id, arg1).status = arg2;
    }

    public fun update_checker(arg0: &mut Service, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&arg0.checkers, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::update(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::checker::Checker>(&mut arg0.checkers, arg1), arg4, arg2, arg3, arg5);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, CheckerRecord>(&mut arg0.id, arg1);
        v0.user_id = arg4;
        v0.content = arg2;
        v0.device_id = arg3;
        v0.status = arg5;
    }

    public fun update_worker(arg0: &mut Service, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&arg0.workers, arg1), 3);
        0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::update(0x2::object_table::borrow_mut<0x2::object::ID, 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::worker::Worker>(&mut arg0.workers, arg1), arg4, arg2, arg3, arg5);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, WorkerRecord>(&mut arg0.id, arg1);
        v0.user_id = arg4;
        v0.content = arg2;
        v0.mac_address = arg3;
        v0.status = arg5;
    }

    // decompiled from Move bytecode v6
}

