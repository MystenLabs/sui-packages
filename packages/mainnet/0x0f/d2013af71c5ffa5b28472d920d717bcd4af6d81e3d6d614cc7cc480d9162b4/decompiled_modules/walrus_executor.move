module 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::walrus_executor {
    struct ExecutorConfig has key {
        id: 0x2::object::UID,
        relayer: address,
        executed_intents: 0x2::table::Table<vector<u8>, bool>,
    }

    struct StorageReceipt has store, key {
        id: 0x2::object::UID,
        intent_id: vector<u8>,
        walrus_blob_id: u256,
        end_epoch: u32,
        sender: address,
    }

    struct StorageExecuted has copy, drop {
        intent_id: vector<u8>,
        walrus_blob_id: u256,
        end_epoch: u32,
        executor: address,
    }

    struct ConfigCreated has copy, drop {
        config_id: address,
        relayer: address,
    }

    public fun execute_store(arg0: &mut ExecutorConfig, arg1: vector<u8>, arg2: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob, arg3: u64, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.relayer, 0);
        assert!(0x1::option::is_some<u32>(0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::certified_epoch(&arg2)), 1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.executed_intents, arg1), 2);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.executed_intents, arg1, true);
        let v0 = 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::blob_id(&arg2);
        let v1 = 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::end_epoch(&arg2);
        let v2 = StorageExecuted{
            intent_id      : arg1,
            walrus_blob_id : v0,
            end_epoch      : v1,
            executor       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<StorageExecuted>(v2);
        let v3 = StorageReceipt{
            id             : 0x2::object::new(arg6),
            intent_id      : arg1,
            walrus_blob_id : v0,
            end_epoch      : v1,
            sender         : arg5,
        };
        0x2::transfer::public_transfer<0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::blob::Blob>(arg2, arg5);
        0x2::transfer::transfer<StorageReceipt>(v3, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutorConfig{
            id               : 0x2::object::new(arg0),
            relayer          : 0x2::tx_context::sender(arg0),
            executed_intents : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<ExecutorConfig>(v0);
        let v1 = ConfigCreated{
            config_id : 0x2::object::uid_to_address(&v0.id),
            relayer   : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<ConfigCreated>(v1);
    }

    public fun is_executed(arg0: &ExecutorConfig, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.executed_intents, arg1)
    }

    public fun update_relayer(arg0: &mut ExecutorConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.relayer, 0);
        arg0.relayer = arg1;
    }

    // decompiled from Move bytecode v7
}

