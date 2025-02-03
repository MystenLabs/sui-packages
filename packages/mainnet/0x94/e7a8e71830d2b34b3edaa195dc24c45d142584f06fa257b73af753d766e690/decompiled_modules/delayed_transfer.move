module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer {
    struct DelayedTransferAddedEvent has copy, drop {
        id: vector<u8>,
    }

    struct DelayedTransferExecutedEvent has copy, drop {
        id: vector<u8>,
        receiver: address,
        coin_id: 0x1::string::String,
        amt: u64,
    }

    struct DelayPeriodUpdatedEvent has copy, drop {
        period: u64,
    }

    struct DelayInfo has drop, store {
        blk_ts: u64,
        receiver: address,
        coin_id: 0x1::string::String,
        amt: u64,
    }

    struct DelayedTransferState has key {
        id: 0x2::object::UID,
        delay_period: u64,
        delay_map: 0x2::table::Table<vector<u8>, DelayInfo>,
    }

    public(friend) fun add_delayed_transfer(arg0: vector<u8>, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut DelayedTransferState, arg5: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, DelayInfo>(&arg4.delay_map, arg0) == false, 4006);
        let v0 = DelayInfo{
            blk_ts   : 0x2::clock::timestamp_ms(arg5) / 1000,
            receiver : arg2,
            coin_id  : arg1,
            amt      : arg3,
        };
        0x2::table::add<vector<u8>, DelayInfo>(&mut arg4.delay_map, arg0, v0);
        let v1 = DelayedTransferAddedEvent{id: arg0};
        0x2::event::emit<DelayedTransferAddedEvent>(v1);
    }

    public(friend) fun execute_delayed_transfer(arg0: vector<u8>, arg1: &mut DelayedTransferState, arg2: &0x2::clock::Clock) : (address, 0x1::string::String, u64) {
        assert!(0x2::table::contains<vector<u8>, DelayInfo>(&arg1.delay_map, arg0), 4001);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 > 0x2::table::borrow<vector<u8>, DelayInfo>(&arg1.delay_map, arg0).blk_ts + arg1.delay_period, 4005);
        let v0 = 0x2::table::remove<vector<u8>, DelayInfo>(&mut arg1.delay_map, arg0);
        let v1 = DelayedTransferExecutedEvent{
            id       : arg0,
            receiver : v0.receiver,
            coin_id  : v0.coin_id,
            amt      : v0.amt,
        };
        0x2::event::emit<DelayedTransferExecutedEvent>(v1);
        (v0.receiver, v0.coin_id, v0.amt)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DelayedTransferState{
            id           : 0x2::object::new(arg0),
            delay_period : 1800,
            delay_map    : 0x2::table::new<vector<u8>, DelayInfo>(arg0),
        };
        0x2::transfer::share_object<DelayedTransferState>(v0);
    }

    public entry fun update_delay_period(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: u64, arg2: &mut DelayedTransferState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_governor(0x2::tx_context::sender(arg3), arg0), 4004);
        arg2.delay_period = arg1;
        let v0 = DelayPeriodUpdatedEvent{period: arg1};
        0x2::event::emit<DelayPeriodUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

