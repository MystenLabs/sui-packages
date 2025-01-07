module 0xdacfd7c1176a68137b38a875d76a2f65d277596d2c632881931d926b16de2698::subdomain_proxy {
    public fun edit_setup(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: bool, arg5: bool) {
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::edit_setup(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3, arg4, arg5);
    }

    public fun new(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration {
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun new_leaf(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new_leaf(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3, arg4, arg5);
    }

    public fun remove_leaf(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String) {
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3);
    }

    public fun set_target_address(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: 0x1::option::Option<address>, arg3: &0x2::clock::Clock) {
        0xf7854c81cf500d60a4437f4599f7ff3b89abd13f645ae08f62345c7a25317bee::direct_setup::set_target_address(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3);
    }

    public fun set_user_data(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xf7854c81cf500d60a4437f4599f7ff3b89abd13f645ae08f62345c7a25317bee::direct_setup::set_user_data(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3, arg4);
    }

    public fun unset_user_data(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        0xf7854c81cf500d60a4437f4599f7ff3b89abd13f645ae08f62345c7a25317bee::direct_setup::unset_user_data(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

