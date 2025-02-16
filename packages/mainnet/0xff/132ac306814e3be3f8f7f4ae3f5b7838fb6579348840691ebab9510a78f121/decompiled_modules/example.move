module 0xff132ac306814e3be3f8f7f4ae3f5b7838fb6579348840691ebab9510a78f121::example {
    public entry fun f1(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0;
        while (v0 < 100) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun f2(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0;
        while (v0 < 20) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun f3(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0;
        while (v0 < 40) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun f4(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0;
        while (v0 < 60) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun f5(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0;
        while (v0 < 80) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun f6(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0;
        while (v0 < 100) {
            v0 = v0 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

