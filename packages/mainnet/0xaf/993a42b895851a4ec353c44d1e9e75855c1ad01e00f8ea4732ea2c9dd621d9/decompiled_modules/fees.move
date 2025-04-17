module 0xaf993a42b895851a4ec353c44d1e9e75855c1ad01e00f8ea4732ea2c9dd621d9::fees {
    struct Fees has key {
        id: 0x2::object::UID,
        amount: u64,
        recipient: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun amount(arg0: &Fees) : u64 {
        arg0.amount
    }

    public(friend) fun collect(arg0: &Fees, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.amount, arg2), arg0.recipient);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Fees{
            id        : 0x2::object::new(arg0),
            amount    : 1000000000,
            recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Fees>(v1);
    }

    public fun recipient(arg0: &Fees) : address {
        arg0.recipient
    }

    public fun set_amount(arg0: &AdminCap, arg1: &mut Fees, arg2: u64) {
        arg1.amount = arg2;
    }

    public fun set_recipient(arg0: &AdminCap, arg1: &mut Fees, arg2: address) {
        arg1.recipient = arg2;
    }

    // decompiled from Move bytecode v6
}

