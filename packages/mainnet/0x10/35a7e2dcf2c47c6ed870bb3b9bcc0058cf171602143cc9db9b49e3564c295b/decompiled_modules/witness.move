module 0x1035a7e2dcf2c47c6ed870bb3b9bcc0058cf171602143cc9db9b49e3564c295b::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x9eaa6b5300c2e174a4f8a9e7131e26e0609202f80eb4378ccc43f4991a1b39d2];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x9eaa6b5300c2e174a4f8a9e7131e26e0609202f80eb4378ccc43f4991a1b39d2]
    }

    // decompiled from Move bytecode v6
}

