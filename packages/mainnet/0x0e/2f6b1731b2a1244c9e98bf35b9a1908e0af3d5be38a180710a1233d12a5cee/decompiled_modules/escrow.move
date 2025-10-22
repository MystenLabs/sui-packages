module 0xe2f6b1731b2a1244c9e98bf35b9a1908e0af3d5be38a180710a1233d12a5cee::escrow {
    struct EscrowOrder has store, key {
        id: 0x2::object::UID,
        buyer: address,
        vendor: address,
        amount: u64,
        order_ref: 0x1::string::String,
        released: bool,
        refunded: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct OrderCreated has copy, drop {
        order_ref: 0x1::string::String,
        buyer: address,
        vendor: address,
        amount: u64,
    }

    struct Released has copy, drop {
        order_ref: 0x1::string::String,
        vendor: address,
        amount: u64,
        fee: u64,
    }

    struct Refunded has copy, drop {
        order_ref: 0x1::string::String,
        buyer: address,
        amount: u64,
    }

    public entry fun create_order(arg0: address, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderCreated{
            order_ref : arg3,
            buyer     : arg0,
            vendor    : arg1,
            amount    : arg2,
        };
        0x2::event::emit<OrderCreated>(v0);
        let v1 = EscrowOrder{
            id        : 0x2::object::new(arg4),
            buyer     : arg0,
            vendor    : arg1,
            amount    : arg2,
            order_ref : 0x1::string::utf8(b""),
            released  : false,
            refunded  : false,
        };
        0x2::transfer::public_transfer<EscrowOrder>(v1, arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            fee_bps       : 200,
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<Config>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun refund(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Refunded{
            order_ref : arg0,
            buyer     : 0x2::tx_context::sender(arg1),
            amount    : 0,
        };
        0x2::event::emit<Refunded>(v0);
    }

    public entry fun release(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Released{
            order_ref : arg0,
            vendor    : 0x2::tx_context::sender(arg1),
            amount    : 0,
            fee       : 0,
        };
        0x2::event::emit<Released>(v0);
    }

    // decompiled from Move bytecode v6
}

