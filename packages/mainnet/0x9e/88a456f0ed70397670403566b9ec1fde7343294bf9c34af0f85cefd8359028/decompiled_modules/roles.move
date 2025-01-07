module 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::roles {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct QueueProcessorCap has key {
        id: 0x2::object::UID,
    }

    struct Safe has key {
        id: 0x2::object::UID,
        queue_processor_id: 0x2::object::ID,
        queue_created: bool,
        version: u64,
    }

    public fun check_queue_processor(arg0: &Safe, arg1: &QueueProcessorCap) {
        assert!(arg0.queue_processor_id == 0x2::object::uid_to_inner(&arg1.id), 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::errors::inactive_queue_processor());
    }

    public fun check_safe_version(arg0: &Safe) {
        assert!(arg0.version == 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::constants::get_version(), 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::errors::version_mismatch());
    }

    entry fun create_new_queue_processor(arg0: &AdminCap, arg1: &mut Safe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_safe_version(arg1);
        let v0 = QueueProcessorCap{id: 0x2::object::new(arg3)};
        arg1.queue_processor_id = 0x2::object::uid_to_inner(&v0.id);
        0x2::transfer::transfer<QueueProcessorCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = QueueProcessorCap{id: 0x2::object::new(arg0)};
        let v2 = Safe{
            id                 : 0x2::object::new(arg0),
            queue_processor_id : 0x2::object::uid_to_inner(&v1.id),
            queue_created      : false,
            version            : 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::constants::get_version(),
        };
        0x2::transfer::share_object<Safe>(v2);
        0x2::transfer::transfer<QueueProcessorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_queue_created(arg0: &Safe) : bool {
        arg0.queue_created
    }

    public(friend) fun queue_is_created(arg0: &mut Safe) {
        arg0.queue_created = true;
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun transfer_qprocessing_cap(arg0: QueueProcessorCap, arg1: &Safe, arg2: address) {
        check_safe_version(arg1);
        check_queue_processor(arg1, &arg0);
        0x2::transfer::transfer<QueueProcessorCap>(arg0, arg2);
    }

    entry fun update_version_for_safe(arg0: &AdminCap, arg1: &mut Safe) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

