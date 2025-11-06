module 0x779cd9993eb1925ef4e93d8e0d6b631ed7dd31f0e4cca8da827576d6cb42b2a9::para {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BotConfig has store, key {
        id: 0x2::object::UID,
        bot: address,
    }

    struct ArbStartEvent has copy, drop, store {
        path: vector<u8>,
        amount_in: u64,
    }

    struct ArbFinishEvent has copy, drop, store {
        path: vector<u8>,
        profit_sui: u64,
    }

    public fun bootstrap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = BotConfig{
            id  : 0x2::object::new(arg0),
            bot : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<BotConfig>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun identity(arg0: u64) : u64 {
        arg0
    }

    public fun record_finish(arg0: &BotConfig, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = ArbFinishEvent{
            path       : arg1,
            profit_sui : arg2,
        };
        0x2::event::emit<ArbFinishEvent>(v0);
    }

    public fun record_start(arg0: &BotConfig, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = ArbStartEvent{
            path      : arg1,
            amount_in : arg2,
        };
        0x2::event::emit<ArbStartEvent>(v0);
    }

    public fun set_bot(arg0: &AdminCap, arg1: &mut BotConfig, arg2: address) {
        arg1.bot = arg2;
    }

    // decompiled from Move bytecode v6
}

