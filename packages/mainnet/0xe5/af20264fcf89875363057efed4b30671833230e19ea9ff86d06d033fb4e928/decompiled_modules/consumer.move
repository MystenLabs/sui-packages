module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::consumer {
    struct Consumer has store, key {
        id: 0x2::object::UID,
        consumer_id: address,
        description: vector<u8>,
        reputation: u32,
        registered_ts: u64,
        last_update_ts: u64,
        deals: 0x2::vec_map::VecMap<0x2::object::ID, u128>,
        active_deals: 0x2::vec_map::VecMap<0x2::object::ID, u128>,
    }

    struct ConsumerRegistry has store, key {
        id: 0x2::object::UID,
        consumers: 0x2::table::Table<address, 0x2::object::ID>,
        total_consumers: u64,
    }

    struct ConsumerRegistered has copy, drop {
        consumer_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    public(friend) fun add_active_deal(arg0: &mut Consumer, arg1: 0x2::object::ID, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        0x2::vec_map::insert<0x2::object::ID, u128>(&mut arg0.active_deals, arg1, arg2);
        arg0.last_update_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public(friend) fun complete_deal(arg0: &mut Consumer, arg1: 0x2::object::ID, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<0x2::object::ID, u128>(&arg0.active_deals, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u128>(&mut arg0.active_deals, &arg1);
        };
        0x2::vec_map::insert<0x2::object::ID, u128>(&mut arg0.deals, arg1, arg2);
        arg0.last_update_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public fun get_active_deals_count(arg0: &Consumer) : u64 {
        0x2::vec_map::length<0x2::object::ID, u128>(&arg0.active_deals)
    }

    public fun get_deal_storage(arg0: &Consumer, arg1: &0x2::object::ID) : u128 {
        if (0x2::vec_map::contains<0x2::object::ID, u128>(&arg0.active_deals, arg1)) {
            *0x2::vec_map::get<0x2::object::ID, u128>(&arg0.active_deals, arg1)
        } else if (0x2::vec_map::contains<0x2::object::ID, u128>(&arg0.deals, arg1)) {
            *0x2::vec_map::get<0x2::object::ID, u128>(&arg0.deals, arg1)
        } else {
            0
        }
    }

    public fun get_reputation(arg0: &Consumer) : u32 {
        arg0.reputation
    }

    public fun get_total_deals_count(arg0: &Consumer) : u64 {
        0x2::vec_map::length<0x2::object::ID, u128>(&arg0.deals)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConsumerRegistry{
            id              : 0x2::object::new(arg0),
            consumers       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_consumers : 0,
        };
        0x2::transfer::share_object<ConsumerRegistry>(v0);
    }

    public(friend) fun register_or_get_consumer(arg0: &mut ConsumerRegistry, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.consumers, arg1)) {
            *0x2::table::borrow<address, 0x2::object::ID>(&arg0.consumers, arg1)
        } else {
            let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
            let v2 = Consumer{
                id             : 0x2::object::new(arg3),
                consumer_id    : arg1,
                description    : arg2,
                reputation     : 99,
                registered_ts  : v1,
                last_update_ts : v1,
                deals          : 0x2::vec_map::empty<0x2::object::ID, u128>(),
                active_deals   : 0x2::vec_map::empty<0x2::object::ID, u128>(),
            };
            let v3 = 0x2::object::uid_to_inner(&v2.id);
            let v4 = ConsumerRegistered{
                consumer_id : v3,
                owner       : arg1,
                timestamp   : v1,
            };
            0x2::event::emit<ConsumerRegistered>(v4);
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.consumers, arg1, v3);
            arg0.total_consumers = arg0.total_consumers + 1;
            0x2::transfer::share_object<Consumer>(v2);
            v3
        }
    }

    public(friend) fun update_deal_storage(arg0: &mut Consumer, arg1: 0x2::object::ID, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<0x2::object::ID, u128>(&arg0.active_deals, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u128>(&mut arg0.active_deals, &arg1);
            0x2::vec_map::insert<0x2::object::ID, u128>(&mut arg0.active_deals, arg1, arg2);
        };
        arg0.last_update_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public(friend) fun update_reputation(arg0: &mut Consumer, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 100, 0);
        arg0.reputation = arg1;
        arg0.last_update_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

