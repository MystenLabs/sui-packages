module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::shared_blob {
    struct SharedBlob has store, key {
        id: 0x2::object::UID,
        blob: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob,
        funds: 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>,
    }

    public fun new(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedBlob{
            id    : 0x2::object::new(arg1),
            blob  : arg0,
            funds : 0x2::balance::zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(),
        };
        0x2::transfer::share_object<SharedBlob>(v0);
    }

    public fun blob(arg0: &SharedBlob) : &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob {
        &arg0.blob
    }

    public fun extend(arg0: &mut SharedBlob, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0x2::balance::withdraw_all<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds), arg3);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::extend_blob(arg1, &mut arg0.blob, arg2, &mut v0);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v0));
    }

    public fun fund(arg0: &mut SharedBlob, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>) {
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1));
    }

    public fun funds(arg0: &SharedBlob) : &0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        &arg0.funds
    }

    public fun new_funded(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedBlob{
            id    : 0x2::object::new(arg2),
            blob  : arg0,
            funds : 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1),
        };
        0x2::transfer::share_object<SharedBlob>(v0);
    }

    // decompiled from Move bytecode v6
}

