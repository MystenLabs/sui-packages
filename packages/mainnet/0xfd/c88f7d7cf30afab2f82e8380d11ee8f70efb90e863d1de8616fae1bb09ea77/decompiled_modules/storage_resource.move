module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource {
    struct Storage has store, key {
        id: 0x2::object::UID,
        start_epoch: u32,
        end_epoch: u32,
        storage_size: u64,
    }

    public(friend) fun create_storage(arg0: u32, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Storage {
        assert!(arg0 < arg1, 3);
        Storage{
            id           : 0x2::object::new(arg3),
            start_epoch  : arg0,
            end_epoch    : arg1,
            storage_size : arg2,
        }
    }

    public fun destroy(arg0: Storage) {
        let Storage {
            id           : v0,
            start_epoch  : _,
            end_epoch    : _,
            storage_size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun end_epoch(arg0: &Storage) : u32 {
        arg0.end_epoch
    }

    public(friend) fun extend_end_epoch(arg0: &mut Storage, arg1: u32) {
        arg0.end_epoch = arg0.end_epoch + arg1;
    }

    public fun fuse(arg0: &mut Storage, arg1: Storage) {
        if (arg0.start_epoch == arg1.start_epoch) {
            fuse_amount(arg0, arg1);
        } else {
            fuse_periods(arg0, arg1);
        };
    }

    public fun fuse_amount(arg0: &mut Storage, arg1: Storage) {
        let Storage {
            id           : v0,
            start_epoch  : v1,
            end_epoch    : v2,
            storage_size : v3,
        } = arg1;
        0x2::object::delete(v0);
        assert!(arg0.start_epoch == v1 && arg0.end_epoch == v2, 1);
        arg0.storage_size = arg0.storage_size + v3;
    }

    public fun fuse_periods(arg0: &mut Storage, arg1: Storage) {
        let Storage {
            id           : v0,
            start_epoch  : v1,
            end_epoch    : v2,
            storage_size : v3,
        } = arg1;
        0x2::object::delete(v0);
        assert!(arg0.storage_size == v3, 2);
        if (arg0.end_epoch == v1) {
            arg0.end_epoch = v2;
        } else {
            assert!(arg0.start_epoch == v2, 1);
            arg0.start_epoch = v1;
        };
    }

    public fun size(arg0: &Storage) : u64 {
        arg0.storage_size
    }

    public fun split_by_epoch(arg0: &mut Storage, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Storage {
        assert!(arg1 > arg0.start_epoch && arg1 < arg0.end_epoch, 0);
        arg0.end_epoch = arg1;
        Storage{
            id           : 0x2::object::new(arg2),
            start_epoch  : arg1,
            end_epoch    : arg0.end_epoch,
            storage_size : arg0.storage_size,
        }
    }

    public fun split_by_size(arg0: &mut Storage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Storage {
        assert!(arg0.storage_size >= arg1, 2);
        arg0.storage_size = arg1;
        Storage{
            id           : 0x2::object::new(arg2),
            start_epoch  : arg0.start_epoch,
            end_epoch    : arg0.end_epoch,
            storage_size : arg0.storage_size - arg1,
        }
    }

    public fun start_epoch(arg0: &Storage) : u32 {
        arg0.start_epoch
    }

    // decompiled from Move bytecode v6
}

