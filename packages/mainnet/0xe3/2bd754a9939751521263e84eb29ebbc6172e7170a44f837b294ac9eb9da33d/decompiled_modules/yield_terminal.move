module 0xe32bd754a9939751521263e84eb29ebbc6172e7170a44f837b294ac9eb9da33d::yield_terminal {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolAccount has key {
        id: 0x2::object::UID,
        poolId: u64,
        address: address,
        accessKey: 0x1::string::String,
    }

    struct ActionMessage has copy, drop, store {
        index: u64,
        action: u64,
        owner: address,
        dataJson: 0x1::string::String,
    }

    struct MessageQueue has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<u64, ActionMessage>,
        front: u64,
        back: u64,
    }

    public fun create_account(arg0: u64, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAccount{
            id        : 0x2::object::new(arg3),
            poolId    : arg0,
            address   : arg1,
            accessKey : arg2,
        };
        0x2::transfer::transfer<PoolAccount>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MessageQueue{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<u64, ActionMessage>(arg0),
            front : 0,
            back  : 0,
        };
        0x2::transfer::share_object<MessageQueue>(v1);
    }

    public fun peek_action(arg0: &mut MessageQueue, arg1: u64) : &ActionMessage {
        if (arg1 < arg0.front || arg1 >= arg0.back) {
            abort 0
        };
        0x2::table::borrow<u64, ActionMessage>(&arg0.table, arg1)
    }

    public fun peek_action_from(arg0: &MessageQueue, arg1: u64) : vector<ActionMessage> {
        let v0 = 0x1::vector::empty<ActionMessage>();
        while (arg1 < arg0.back) {
            0x1::vector::push_back<ActionMessage>(&mut v0, *0x2::table::borrow<u64, ActionMessage>(&arg0.table, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public entry fun push_action(arg0: &mut MessageQueue, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ActionMessage{
            index    : arg0.back,
            action   : arg1,
            owner    : 0x2::tx_context::sender(arg3),
            dataJson : arg2,
        };
        0x2::table::add<u64, ActionMessage>(&mut arg0.table, arg0.back, v0);
        arg0.back = arg0.back + 1;
    }

    public fun queue_back(arg0: &MessageQueue) : u64 {
        arg0.back
    }

    public fun queue_front(arg0: &MessageQueue) : u64 {
        arg0.front
    }

    public fun remove_account(arg0: PoolAccount) {
        let PoolAccount {
            id        : v0,
            poolId    : _,
            address   : _,
            accessKey : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun reset_queue_until(arg0: &AdminCap, arg1: &mut MessageQueue, arg2: u64) {
        let v0 = arg1.front;
        while (v0 < arg2) {
            0x2::table::remove<u64, ActionMessage>(&mut arg1.table, v0);
            v0 = v0 + 1;
        };
        arg1.front = arg2;
    }

    // decompiled from Move bytecode v6
}

