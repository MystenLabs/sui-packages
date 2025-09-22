module 0x55ab9896bd6a660fef5dc25287abc30a9640ec2c8a0250c2d1848f7eec16ffe9::events {
    struct CreatedPriceFeedStorage has copy, drop {
        price_feed_storage_id: 0x2::object::ID,
        symbol: 0x1::string::String,
    }

    struct AddedAuthorization has copy, drop {
        source_wrapper_id: 0x2::object::ID,
    }

    struct RemovedAuthorization has copy, drop {
        source_wrapper_id: 0x2::object::ID,
    }

    struct CreatedPriceFeed has copy, drop {
        price_feed_storage_id: 0x2::object::ID,
        source_wrapper_id: 0x2::object::ID,
        price: u256,
        timestamp: u64,
    }

    struct RemovedPriceFeed has copy, drop {
        price_feed_storage_id: 0x2::object::ID,
        source_wrapper_id: 0x2::object::ID,
    }

    struct UpdatedPriceFeed has copy, drop {
        price_feed_storage_id: 0x2::object::ID,
        source_wrapper_id: 0x2::object::ID,
        old_price: u256,
        old_timestamp: u64,
        new_price: u256,
        new_timestamp: u64,
    }

    public(friend) fun emit_added_authorization(arg0: 0x2::object::ID) {
        let v0 = AddedAuthorization{source_wrapper_id: arg0};
        0x2::event::emit<AddedAuthorization>(v0);
    }

    public(friend) fun emit_created_price_feed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: u64) {
        let v0 = CreatedPriceFeed{
            price_feed_storage_id : arg0,
            source_wrapper_id     : arg1,
            price                 : arg2,
            timestamp             : arg3,
        };
        0x2::event::emit<CreatedPriceFeed>(v0);
    }

    public(friend) fun emit_created_price_feed_storage(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = CreatedPriceFeedStorage{
            price_feed_storage_id : arg0,
            symbol                : arg1,
        };
        0x2::event::emit<CreatedPriceFeedStorage>(v0);
    }

    public(friend) fun emit_removed_authorization(arg0: 0x2::object::ID) {
        let v0 = RemovedAuthorization{source_wrapper_id: arg0};
        0x2::event::emit<RemovedAuthorization>(v0);
    }

    public(friend) fun emit_removed_price_feed(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = RemovedPriceFeed{
            price_feed_storage_id : arg0,
            source_wrapper_id     : arg1,
        };
        0x2::event::emit<RemovedPriceFeed>(v0);
    }

    public(friend) fun emit_updated_price_feed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: u64, arg4: u256, arg5: u64) {
        let v0 = UpdatedPriceFeed{
            price_feed_storage_id : arg0,
            source_wrapper_id     : arg1,
            old_price             : arg2,
            old_timestamp         : arg3,
            new_price             : arg4,
            new_timestamp         : arg5,
        };
        0x2::event::emit<UpdatedPriceFeed>(v0);
    }

    // decompiled from Move bytecode v6
}

