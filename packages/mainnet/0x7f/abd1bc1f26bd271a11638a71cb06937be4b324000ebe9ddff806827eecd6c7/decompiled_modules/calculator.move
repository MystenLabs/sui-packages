module 0x7fabd1bc1f26bd271a11638a71cb06937be4b324000ebe9ddff806827eecd6c7::calculator {
    struct Output has store, key {
        id: 0x2::object::UID,
        result: u64,
    }

    public entry fun add(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{
            id     : 0x2::object::new(arg2),
            result : arg0 + arg1,
        };
        0x2::transfer::public_transfer<Output>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun div(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 0) {
            0
        } else {
            arg0 / arg1
        };
        let v1 = Output{
            id     : 0x2::object::new(arg2),
            result : v0,
        };
        0x2::transfer::public_transfer<Output>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun mul(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{
            id     : 0x2::object::new(arg2),
            result : arg0 * arg1,
        };
        0x2::transfer::public_transfer<Output>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun start(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{
            id     : 0x2::object::new(arg0),
            result : 0,
        };
        0x2::transfer::public_transfer<Output>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sub(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{
            id     : 0x2::object::new(arg2),
            result : arg0 - arg1,
        };
        0x2::transfer::public_transfer<Output>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

