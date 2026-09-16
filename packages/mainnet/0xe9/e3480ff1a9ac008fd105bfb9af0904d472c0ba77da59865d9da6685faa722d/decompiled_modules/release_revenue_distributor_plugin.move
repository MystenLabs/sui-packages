module 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::release_revenue_distributor_plugin {
    entry fun receive_and_distribute<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) {
        execute_receive_and_distribute<T0>(arg0, arg1, arg2);
    }

    entry fun redeem_all_and_distribute<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg2: &0x2::accumulator::AccumulatorRoot) {
        execute_redeem_all_and_distribute<T0>(arg0, arg1, arg2);
    }

    fun execute_receive_and_distribute<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) {
        let (v0, v1) = 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::borrow_as_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::Witness>(arg0, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::new());
        let v2 = v0;
        0x6ef20e184e16d91b8cc123b06e779cb89028dfa6b89d79ce7df3b3f7aca0217f::release_revenue_distributor::receive_and_distribute<T0>(arg1, &v2, arg2);
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::put_back<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg0, v2, v1);
    }

    fun execute_redeem_all_and_distribute<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg2: &0x2::accumulator::AccumulatorRoot) {
        let (v0, v1) = 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::borrow_as_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::Witness>(arg0, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::new());
        let v2 = v0;
        0x6ef20e184e16d91b8cc123b06e779cb89028dfa6b89d79ce7df3b3f7aca0217f::release_revenue_distributor::redeem_all_and_distribute<T0>(arg1, &v2, arg2);
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::put_back<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg0, v2, v1);
    }

    public fun install(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>, arg1: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::VaultAdminCap<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>) {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::authorize_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::Witness>(arg0, arg1, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::new());
    }

    public fun is_installed(arg0: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>) : bool {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::is_plugin_authorized<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::Witness>(arg0)
    }

    public fun uninstall(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>, arg1: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::VaultAdminCap<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>) {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::revoke_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, 0xe9e3480ff1a9ac008fd105bfb9af0904d472c0ba77da59865d9da6685faa722d::witness::Witness>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

