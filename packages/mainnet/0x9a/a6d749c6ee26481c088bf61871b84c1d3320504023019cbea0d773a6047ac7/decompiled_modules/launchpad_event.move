module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_event {
    struct SlingshotCreatedEvent has copy, drop {
        slingshot_id: 0x2::object::ID,
        admin: address,
        live: bool,
        market_fee: u64,
        sales: vector<0x2::object::ID>,
    }

    struct SaleCreatedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        launchpad_id: 0x2::object::ID,
        white_list: bool,
        start_time: u64,
        end_time: u64,
        price: u64,
    }

    struct SalesRemoveEvent has copy, drop {
        slingshot_id: 0x2::object::ID,
        sale_ids: vector<0x2::object::ID>,
        operator: address,
    }

    struct ActivityCreatedEvent has copy, drop {
        activity_id: 0x2::object::ID,
        sale_id: 0x2::object::ID,
        root: vector<u8>,
        url: 0x2::url::Url,
    }

    public fun activity_created_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: 0x2::url::Url) {
        let v0 = ActivityCreatedEvent{
            activity_id : arg0,
            sale_id     : arg1,
            root        : arg2,
            url         : arg3,
        };
        0x2::event::emit<ActivityCreatedEvent>(v0);
    }

    public fun sale_create_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SaleCreatedEvent{
            sale_id      : arg0,
            launchpad_id : arg1,
            white_list   : arg2,
            start_time   : arg3,
            end_time     : arg4,
            price        : arg5,
        };
        0x2::event::emit<SaleCreatedEvent>(v0);
    }

    public fun sale_remove_event(arg0: 0x2::object::ID, arg1: vector<0x2::object::ID>, arg2: address) {
        let v0 = SalesRemoveEvent{
            slingshot_id : arg0,
            sale_ids     : arg1,
            operator     : arg2,
        };
        0x2::event::emit<SalesRemoveEvent>(v0);
    }

    public fun slingshot_create_event(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: vector<0x2::object::ID>) {
        let v0 = SlingshotCreatedEvent{
            slingshot_id : arg0,
            admin        : arg1,
            live         : arg2,
            market_fee   : arg3,
            sales        : arg4,
        };
        0x2::event::emit<SlingshotCreatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

