module 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::composition_royalty_pool_plugin {
    fun execute_receive_and_deposit<T0, T1>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>) {
        let (v0, v1) = 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::borrow_as_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::Witness>(arg0, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::new());
        let v2 = v0;
        0xa0650377763e4d1f355e88399c4542a2c8891207f94af38f03a006b22051287b::composition_royalty_pool::receive_and_deposit<T0, T1>(arg1, &v2, arg2, arg3);
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::put_back<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg0, v2, v1);
    }

    fun execute_redeem_all_and_deposit<T0, T1>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: &0x2::accumulator::AccumulatorRoot) {
        let (v0, v1) = 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::borrow_as_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::Witness>(arg0, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::new());
        let v2 = v0;
        0xa0650377763e4d1f355e88399c4542a2c8891207f94af38f03a006b22051287b::composition_royalty_pool::redeem_all_and_deposit<T0, T1>(arg1, &v2, arg2, arg3);
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::put_back<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg0, v2, v1);
    }

    public fun install<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>, arg1: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::VaultAdminCap<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>) {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::authorize_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::Witness>(arg0, arg1, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::new());
    }

    public fun is_installed<T0>(arg0: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>) : bool {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::is_plugin_authorized<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::Witness>(arg0)
    }

    entry fun receive_and_deposit<T0, T1>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>) {
        execute_receive_and_deposit<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun redeem_all_and_deposit<T0, T1>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: &0x2::accumulator::AccumulatorRoot) {
        execute_redeem_all_and_deposit<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun uninstall<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>, arg1: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::VaultAdminCap<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>) {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::revoke_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, 0xd0c23da1e75b96eb8e9159ea6b038b7954850ead0188704297ba8c1009b03a1::witness::Witness>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

