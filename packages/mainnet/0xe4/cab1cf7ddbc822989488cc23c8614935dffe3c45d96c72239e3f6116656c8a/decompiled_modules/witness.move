module 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x95ec929b172b54e869bfbe96f777b983eadb2bcbf00ffbb03864bedf6760fe53, @0xec7aecc74cce4b023b3b4f09ef3253ca6312832d3769ef3749d1638aa3cb6a6, @0xbc803f9c6a465ed476086142f51729f0c9643efcebebd0423944fe625918dd73, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x95ec929b172b54e869bfbe96f777b983eadb2bcbf00ffbb03864bedf6760fe53, @0xec7aecc74cce4b023b3b4f09ef3253ca6312832d3769ef3749d1638aa3cb6a6, @0xbc803f9c6a465ed476086142f51729f0c9643efcebebd0423944fe625918dd73, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922]
    }

    // decompiled from Move bytecode v6
}

