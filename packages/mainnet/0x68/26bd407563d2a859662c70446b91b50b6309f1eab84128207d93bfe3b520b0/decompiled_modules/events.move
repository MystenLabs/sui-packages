module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events {
    struct CreatedPriceFeedStorage has copy, drop {
        price_feed_storage_obj_id: 0x2::object::ID,
        storage_id: u32,
        symbol: 0x1::string::String,
    }

    struct CreatedSource has copy, drop {
        source_id: u16,
        source_object_id: 0x2::object::ID,
    }

    struct AddedAuthorization has copy, drop {
        source_id: u16,
    }

    struct RemovedAuthorization has copy, drop {
        source_id: u16,
    }

    struct CreatedPriceFeed has copy, drop {
        storage_id: u32,
        source_id: u16,
        price: u128,
        timestamp_ms: u64,
    }

    struct RemovedPriceFeed has copy, drop {
        storage_id: u32,
        source_id: u16,
    }

    struct UpdatedPriceFeed has copy, drop {
        storage_id: u32,
        source_id: u16,
        old_price: u128,
        old_timestamp_ms: u64,
        old_twap_price: u128,
        new_price: u128,
        new_timestamp_ms: u64,
        new_twap_price: u128,
    }

    struct UpdatedTwapPeriodMs has copy, drop {
        storage_id: u32,
        source_id: u16,
        old_twap_period_ms: u64,
        new_twap_period_ms: u64,
    }

    public(friend) fun emit_added_authorization(arg0: u16) {
        let v0 = AddedAuthorization{source_id: arg0};
        0x2::event::emit<AddedAuthorization>(v0);
    }

    public(friend) fun emit_created_price_feed(arg0: u32, arg1: u16, arg2: u128, arg3: u64) {
        let v0 = CreatedPriceFeed{
            storage_id   : arg0,
            source_id    : arg1,
            price        : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<CreatedPriceFeed>(v0);
    }

    public(friend) fun emit_created_price_feed_storage(arg0: 0x2::object::ID, arg1: u32, arg2: 0x1::string::String) {
        let v0 = CreatedPriceFeedStorage{
            price_feed_storage_obj_id : arg0,
            storage_id                : arg1,
            symbol                    : arg2,
        };
        0x2::event::emit<CreatedPriceFeedStorage>(v0);
    }

    public(friend) fun emit_created_source(arg0: u16, arg1: 0x2::object::ID) {
        let v0 = CreatedSource{
            source_id        : arg0,
            source_object_id : arg1,
        };
        0x2::event::emit<CreatedSource>(v0);
    }

    public(friend) fun emit_removed_authorization(arg0: u16) {
        let v0 = RemovedAuthorization{source_id: arg0};
        0x2::event::emit<RemovedAuthorization>(v0);
    }

    public(friend) fun emit_removed_price_feed(arg0: u32, arg1: u16) {
        let v0 = RemovedPriceFeed{
            storage_id : arg0,
            source_id  : arg1,
        };
        0x2::event::emit<RemovedPriceFeed>(v0);
    }

    public(friend) fun emit_updated_price_feed(arg0: u32, arg1: u16, arg2: u128, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u128) {
        let v0 = UpdatedPriceFeed{
            storage_id       : arg0,
            source_id        : arg1,
            old_price        : arg2,
            old_timestamp_ms : arg3,
            old_twap_price   : arg4,
            new_price        : arg5,
            new_timestamp_ms : arg6,
            new_twap_price   : arg7,
        };
        0x2::event::emit<UpdatedPriceFeed>(v0);
    }

    public(friend) fun emit_updated_twap_period_ms(arg0: u32, arg1: u16, arg2: u64, arg3: u64) {
        let v0 = UpdatedTwapPeriodMs{
            storage_id         : arg0,
            source_id          : arg1,
            old_twap_period_ms : arg2,
            new_twap_period_ms : arg3,
        };
        0x2::event::emit<UpdatedTwapPeriodMs>(v0);
    }

    // decompiled from Move bytecode v7
}

