module 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x278c5fc9b8cf4475153a6011b29a12fa7e19a660b2a71f3e357232b3867a091f, @0xc5d5e4120b4eeae9cf67f7e3b511bb25bbb88e35b0055c5dd153b26e8f1b5b4];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x278c5fc9b8cf4475153a6011b29a12fa7e19a660b2a71f3e357232b3867a091f, @0xc5d5e4120b4eeae9cf67f7e3b511bb25bbb88e35b0055c5dd153b26e8f1b5b4]
    }

    // decompiled from Move bytecode v6
}

