module 0x96c9bed5a312b888603f462f22084e470cc8555a275ef61cc12dd83ecf23a04::utils {
    public fun register(arg0: &mut 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::move_registry::MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap {
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::move_registry::register(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

