module 0x76181d30b659764c7c55b795b0783b2f98a49782cadb61fd4daf722bfb6ff8f8::para {
    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct SwapReceipt<phantom T0, phantom T1, T2> {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun addAdminCapability(arg0: &AdminCapability, arg1: &mut 0x2::tx_context::TxContext, arg2: address) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCapability>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

