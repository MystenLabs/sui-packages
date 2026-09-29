module 0x35a486b91c15dfedb30ede97b92b0c2908aa009890c735731f36f44a10aa78ea::probe {
    struct Probe has key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct Ping has copy, drop {
        tag: u64,
        wallet: address,
        host: u8,
    }

    struct Hit has copy, drop {
        probe: 0x2::object::ID,
        tag: u64,
        wallet: address,
        host: u8,
        seq_before: u64,
    }

    entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Probe{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::share_object<Probe>(v0);
    }

    entry fun destroy(arg0: Probe) {
        let Probe {
            id      : v0,
            counter : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun hit(arg0: &mut Probe, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.counter;
        arg0.counter = v0 + 1;
        let v1 = Hit{
            probe      : 0x2::object::id<Probe>(arg0),
            tag        : arg1,
            wallet     : 0x2::tx_context::sender(arg3),
            host       : arg2,
            seq_before : v0,
        };
        0x2::event::emit<Hit>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Probe{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::share_object<Probe>(v0);
    }

    entry fun ping(arg0: u64, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        let v0 = Ping{
            tag    : arg0,
            wallet : 0x2::tx_context::sender(arg2),
            host   : arg1,
        };
        0x2::event::emit<Ping>(v0);
    }

    // decompiled from Move bytecode v7
}

