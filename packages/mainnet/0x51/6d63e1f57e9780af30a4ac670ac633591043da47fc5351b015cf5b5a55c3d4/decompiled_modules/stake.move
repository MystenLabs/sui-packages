module 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::stake {
    struct StakeProofKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct StakeReward<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>> {
        let v0 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::borrow<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v0);
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&v1)) {
            let v2 = 0x1::vector::empty<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
            0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut v2, 0x1::option::destroy_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1));
            let (v3, v4) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::withdraw_all_buck(arg2, arg3, v2, arg4, arg5);
            add_reward<0x2::sui::SUI>(arg0, arg1, v4);
            return 0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v3)
        };
        0x1::option::destroy_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1);
        0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>()
    }

    public fun repay(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::borrow<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v0);
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&v1)) {
            let v2 = 0x1::vector::empty<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
            0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut v2, 0x1::option::destroy_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1));
            let (v3, v4) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::withdraw_all_buck(arg2, arg3, v2, arg5, arg6);
            let v5 = v3;
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v5, arg4);
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0x2::sui::SUI>(arg0, arg1, v4);
            let v6 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::repay<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v6, 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::deposit_buck(arg2, arg3, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v5, arg6), arg5, arg6));
        } else {
            0x1::option::destroy_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1);
            let v7 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::repay<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v7, 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::deposit_buck(arg2, arg3, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg4, arg6), arg5, arg6));
        };
    }

    public entry fun stake(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::SettlorCap, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::withdraw<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v0);
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&v1)) {
            let v2 = 0x1::vector::empty<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
            0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut v2, 0x1::option::destroy_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1));
            let (v3, v4) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::withdraw_all_buck(arg2, arg3, v2, arg5, arg6);
            let v5 = v3;
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v5, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg4));
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::deposit<0x2::sui::SUI>(arg0, arg1, v4);
            let v6 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::entrust<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v6, 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::deposit_buck(arg2, arg3, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v5, arg6), arg5, arg6));
        } else {
            0x1::option::destroy_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1);
            let v7 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::entrust<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v7, 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::deposit_buck(arg2, arg3, arg4, arg5, arg6));
        };
    }

    public(friend) fun add_reward<T0>(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: 0x2::balance::Balance<T0>) {
        let v0 = StakeReward<T0>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::borrow<StakeReward<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v0);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v1)) {
            let v2 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v1);
            0x2::balance::join<T0>(&mut v2, arg2);
            let v3 = StakeReward<T0>{dummy_field: false};
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::repay<StakeReward<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v3, v2);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v1);
            let v4 = StakeReward<T0>{dummy_field: false};
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::repay<StakeReward<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v4, arg2);
        };
    }

    public entry fun claim_reward(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::SettlorCap, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::withdraw<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v0);
        assert!(0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&v1), 0);
        let v2 = 0x1::option::destroy_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg3, arg2, &mut v2), arg4), 0x2::tx_context::sender(arg4));
        withdraw_reward<0x2::sui::SUI>(arg0, arg1, arg4);
        let v3 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::entrust<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v3, v2);
    }

    public entry fun from_reserve(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&v0)) {
            repay(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v0), arg4, arg5);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v0);
        };
    }

    public fun query(arg0: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg2: u64) : (u64, u64) {
        let v0 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        if (0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::exists_<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, v0)) {
            let v1 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
            let v2 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::query<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, v1);
            return (0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(v2), 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_reward_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg1, v2, arg2))
        };
        (0, 0)
    }

    public entry fun to_reserve(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x1::option::is_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&v0)) {
            0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x1::option::destroy_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v0));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v0);
        };
    }

    public entry fun unstake(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::SettlorCap, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::withdraw<StakeProofKey<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, arg1, v0);
        assert!(0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&v1), 0);
        let v2 = 0x1::vector::empty<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
        0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut v2, 0x1::option::destroy_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v1));
        let (v3, v4) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::withdraw_all_buck(arg2, arg3, v2, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg5), 0x2::tx_context::sender(arg5));
        withdraw_reward<0x2::sui::SUI>(arg0, arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v3, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun withdraw_reward<T0>(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::SettlorCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeReward<T0>{dummy_field: false};
        let v1 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::withdraw<StakeReward<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v0);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::destroy_some<0x2::balance::Balance<T0>>(v1), arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

