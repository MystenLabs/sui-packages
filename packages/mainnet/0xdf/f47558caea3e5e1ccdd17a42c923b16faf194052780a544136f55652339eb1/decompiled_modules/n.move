module 0xdff47558caea3e5e1ccdd17a42c923b16faf194052780a544136f55652339eb1::n {
    struct USDCbalance has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct SUIbalance has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public fun depositSUI(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = SUIbalance{
            id     : 0x2::object::new(arg1),
            amount : arg0,
        };
        0x2::transfer::share_object<SUIbalance>(v0);
    }

    public fun depositUSDC(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = USDCbalance{
            id     : 0x2::object::new(arg1),
            amount : arg0,
        };
        0x2::transfer::share_object<USDCbalance>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
        let v0 = USDCbalance{
            id     : 0x2::object::new(arg0),
            amount : 0,
        };
        0x2::transfer::share_object<USDCbalance>(v0);
        let v1 = SUIbalance{
            id     : 0x2::object::new(arg0),
            amount : 0,
        };
        0x2::transfer::share_object<SUIbalance>(v1);
    }

    public fun withdrawSUI(arg0: SUIbalance, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SUIbalance>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun withdrawUSDC(arg0: USDCbalance, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<USDCbalance>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

