module 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::recording_royalty_pool_plugin {
    entry fun receive_and_deposit<T0, T1, T2>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>) {
        execute_receive_and_deposit<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    entry fun redeem_all_and_deposit<T0, T1, T2>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: &0x2::accumulator::AccumulatorRoot) {
        execute_redeem_all_and_deposit<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    fun execute_receive_and_deposit<T0, T1, T2>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>) {
        let (v0, v1) = 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::borrow_as_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::Witness>(arg0, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::new());
        let v2 = v0;
        0x2154a6cc26787e3c044a948000a899c0b06baa9cf20fdd366841078271e036b1::recording_royalty_pool::receive_and_deposit<T0, T1, T2>(arg1, &v2, arg2, arg3);
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::put_back<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg0, v2, v1);
    }

    fun execute_redeem_all_and_deposit<T0, T1, T2>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>, arg1: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: &0x2::accumulator::AccumulatorRoot) {
        let (v0, v1) = 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::borrow_as_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::Witness>(arg0, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::new());
        let v2 = v0;
        0x2154a6cc26787e3c044a948000a899c0b06baa9cf20fdd366841078271e036b1::recording_royalty_pool::redeem_all_and_deposit<T0, T1, T2>(arg1, &v2, arg2, arg3);
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::put_back<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg0, v2, v1);
    }

    public fun install<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>, arg1: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::VaultAdminCap<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>) {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::authorize_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::Witness>(arg0, arg1, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::new());
    }

    public fun is_installed<T0>(arg0: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>) : bool {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::is_plugin_authorized<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::Witness>(arg0)
    }

    public fun uninstall<T0>(arg0: &mut 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::Vault<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>, arg1: &0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::VaultAdminCap<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>) {
        0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault::revoke_plugin<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, 0xabf0ceecdcd85580460761aba30c66e05c26fb5d30c4e365c95f797cef8d1874::witness::Witness>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

