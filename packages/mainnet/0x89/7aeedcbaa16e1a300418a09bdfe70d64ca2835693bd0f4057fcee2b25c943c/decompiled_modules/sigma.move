module 0x897aeedcbaa16e1a300418a09bdfe70d64ca2835693bd0f4057fcee2b25c943c::sigma {
    struct Payer has store, key {
        id: 0x2::object::UID,
        ratePerSec: u64,
        lastUpdate: u64,
        balance: u64,
    }

    struct Receiver has store, key {
        id: 0x2::object::UID,
        ratePerSec: u64,
        lastUpdate: u64,
        balance: u64,
    }

    public entry fun createPayer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Payer{
            id         : 0x2::object::new(arg1),
            ratePerSec : 0,
            lastUpdate : 0,
            balance    : 0,
        };
        0x2::transfer::public_transfer<Payer>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun createStream(arg0: &mut Payer, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Receiver{
            id         : 0x2::object::new(arg4),
            ratePerSec : arg2,
            lastUpdate : 0,
            balance    : 0,
        };
        0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<Receiver>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

