module 0xee0c9b078e14da0ec9e6d4026e1c39189ab3ec536ca5fc33125d262458cfb0e6::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x48d3daabc09550916c9a9b043130a4b019d910e4b7b1511786cd2a942edea58a, @0xfb2e3af00c510c2814f59d60349a9d5a20785583a3f6410122a0783a4fc3695b];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x48d3daabc09550916c9a9b043130a4b019d910e4b7b1511786cd2a942edea58a, @0xfb2e3af00c510c2814f59d60349a9d5a20785583a3f6410122a0783a4fc3695b]
    }

    // decompiled from Move bytecode v6
}

